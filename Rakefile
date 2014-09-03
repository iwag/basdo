require 'json'

$nodes =  JSON.parse(File.read(ENV['CONFIG'] || "config_node.json"))

# variable
TAG = "iwag/buildstep"
DNS_OPT=ENV['DNS_OPT'] || ''
USER_OPT=ENV['USER_OPT'] || ''

def nodes
  $nodes.keys
end

def docker
   "docker"
end

task :build do
  sh "#{docker} build -t #{TAG} ."
end

task :config do
  # like buildpack
	$nodes.map{ |node,conf| conf['service'] }.uniq.each do |i|
    # setting gonyo gonyo ...
    id = `cat ./services/#{i}/config.sh | #{docker} run #{USER_OPT} #{DNS_OPT} -i -a stdin #{TAG} /bin/bash `.chomp
    sh "#{docker} attach #{id}"
    sh "#{docker} wait #{id}"
    sh "#{docker} stop #{id}"
    sh "#{docker} commit #{id} #{i}"
    # config on host
    id = `#{docker} run -d #{i} /usr/sbin/sshd -D`.chomp
    ip = `#{docker} inspect --format='{{.NetworkSettings.IPAddress}}' #{id} `.chomp
    # sh "services/#{i}/config_host.sh" if config_host exists
    sh "#{docker} stop #{id}"
    sh "#{docker} commit #{id} #{i}:config"
	end
end

task :run do

	$nodes.each do |node,conf|
    port_opt = "" 
    port_opt = conf["port"].map{|i| "-p "+i["host"].to_s+":"+i["guest"].to_s}.join(" ") unless conf["port"].empty?
    cmd = %(cat ./services/#{node}/Procfile | #{docker} run #{USER_OPT} #{DNS_OPT} #{port_opt} --name _#{node} -d #{conf['service']}:config /bin/bash -c "/bin/bash")
    puts cmd
    id = `#{cmd}`.chomp
    sh "#{docker} inspect --format='{{.NetworkSettings.IPAddress}}' #{id} "
	end
	sh "#{docker} ps"
end

task :run_ssh do
	$nodes.each do |node,conf|
    port_opt = ""
    port_opt = conf["port"].map{|i| "-p "+i["host"].to_s+":"+i["guest"].to_s}.join(" ") unless conf["port"].empty?
    cmd = %(#{docker} run #{DNS_OPT} -u 0 #{port_opt} --name _#{node} -d #{conf['service']}:config /usr/sbin/sshd -D)
    puts cmd
    id = `#{cmd}`.chomp
#    sh "#{docker} inspect --format='{{.NetworkSettings.IPAddress}}' #{id} "
  end
	sh "#{docker} ps"
end

task :kill do
  nodes.each do |i|
    puts "stopping _#{i}"
    sh "#{docker} stop _#{i}"
    sh "#{docker} rm _#{i}"
  end
end

task :setup_portforward do
  $nodes.each do |k,v|
    v["port"].each do |p|
      hport = p["host"]
      sh %(VBoxManage modifyvm "boot2#{docker}-vm" --natpf1 "port#{hport} #{hport},tcp,,#{hport},,#{hport}")
    end
  end
end
