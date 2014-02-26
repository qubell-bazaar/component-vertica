vertica_home = node['vertica']['home']
install_script = File.join(vertica_home, "/sbin/install_vertica")

unless File.exist?(install_script)
  url = node['vertica']['package']
  file_name = File.basename(url)

  remote_file "/tmp/#{file_name}" do
    source url
  end

  package "vertica" do
    source "/tmp/#{file_name}"
    action :install
  end

  package "tzdata" do
    action :upgrade
  end

  execute "tzdata set timezone" do
    command 'echo "export TZ=UTC" >> /etc/bashrc'
  end

  package "pstack"
  package "mcelog"
  package "sysstat"
  package "ntp"

  service "ntpd" do
    supports :restart => true, :status => true
    action :restart
  end

  if platform_family?('rhel')
    execute "stop iptables" do
      command "if [ -e '/sbin/iptables' ]; then bash -c '/etc/init.d/iptables stop'; else echo $?; fi"
    end
  end

  if platform_family?('debian')
    execute "stop iptables" do
      command "if [ -e '/sbin/iptables' ]; then bash -c ' iptables -F'; else echo $?; fi"
    end
  end

  execute "configure io scheduler" do
    command <<-EOH
      disks=`fdisk -l | grep "Disk /dev/" | cut -d' ' -f2 | cut -d'/' -f3 | tr -d ':'`

      for disk in $disks; do
        echo deadline > /sys/block/${disk}/queue/scheduler
        echo 'echo deadline > /sys/block/${disk}/queue/scheduler' >> /etc/rc.local

        /sbin/blockdev --setra 2048 /dev/${disk}
        echo '/sbin/blockdev --setra 2048 /dev/${disk}' >> /etc/rc.local
      done

      swap_status=`swapon -s | wc -l`
      if [ $swap_status -eq 1 ]; then
        dd if=/dev/zero of=/tmp/swapfile bs=1024 count=2097152
        mkswap /tmp/swapfile
        swapon /tmp/swapfile
        echo "/tmp/swapfile swap swap defaults 0 0" >> /etc/fstab
      fi
      EOH
  end

  execute "disabled slelinux" do
    command "setenforce 0"
  end
end

