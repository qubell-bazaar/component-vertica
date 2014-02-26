mc_url = node['vertica']['mc']
file_name = File.basename(mc_url)

remote_file "/tmp/#{file_name}" do
  source mc_url
  not_if { ::File.exist?("/tmp/#{file_name}") }
end

execute "vertica-mc install" do
  command "rpm -ivh /tmp/#{file_name}"
  not_if { ::File.exist?("/etc/init.d/vertica-consoled") }
end