vertica_home = node['vertica']['home']
install_script = File.join(vertica_home, "/sbin/install_vertica")
license_url = node['vertica']['license']
license = "CE"

unless license_url.empty?
  license = "~/license.key"
  remote_file license do
    source license_url
  end
end

nodes = node['vertica']['nodes'].flatten.join(",")

execute "vertica create cluster" do
  command "#{install_script} -s #{nodes} -L #{license} -T --dba-user-password-disabled -i #{node['vertica']['keypair']} --accept-eula --data-dir #{node['vertica']['data']}"
  timeout 60 * 30
end