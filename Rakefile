require 'json'

$nodes = JSON.parse(File.read("config_node.json"))

TAG = "iwag/buildstep"

task :build do
  sh "docker build -t #{TAG} ."
end

task :config do
	$nodes.each do |i|
    # setting gonyo gonyo ...
		id = `cat ./services/#{i}/config.sh | docker run -i -a stdin #{TAG} /bin/bash -c "/bin/bash"`.chomp
    #sh "docker attach #{id}"
    sh "docker wait #{id}"
    sh "docker stop #{id}"
    sh "docker commit #{id} #{TAG}:#{i}"
    # config on host
		id = `docker run -d #{TAG}:#{i} /usr/sbin/sshd -D`.chomp
		ip = `docker inspect --format='{{.NetworkSettings.IPAddress}}' #{id} `.chomp
    # sh "services/#{i}/config_host.sh" if config_host exists
    sh "docker stop #{id}"
    sh "docker commit #{id} #{TAG}:#{i}"
	end
end

task :run do
	$nodes.each do |i|
		id = `cat ./services/#{i}/Procfile | docker run -d #{TAG}:#{i} /bin/bash -c "/bin/bash"`.chomp
    sh "docker inspect --format='{{.NetworkSettings.IPAddress}}' #{id} "
	end
	sh "docker ps"
end
