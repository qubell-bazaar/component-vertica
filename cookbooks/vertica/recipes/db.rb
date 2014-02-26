vertica_home = node['vertica']['home']
nodes = node['vertica']['nodes'].flatten.join(",")

execute "stop vertica" do
  command "/opt/vertica/bin/admintools -t stop_host -s #{nodes}"
  user "dbadmin"
end


execute "create db" do
  command "#{vertica_home}/bin/admintools -t create_db -s #{nodes} -d #{node['vertica']['db']['name']} -p #{node['vertica']['db']['password']}"
  user "dbadmin"
end