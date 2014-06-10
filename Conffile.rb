#!/usr/bin/ruby

Conf={
  roles:[
  {
    name:"api",
    repository:"api",
    build:"build.sh",
    nodes:["apifront","apimysql"]
  },
  {
    name:"mysql",
    nodes:["dbmysql"]
  }
  ],
  dockerdir:"./Dockerfiles"
}.freeze

def roles 
  Conf[:roles].map{|i| i[:name]}
end

def nodes
  Conf[:roles].map{|i| i[:nodes]}.flatten
end

def roleByNode(n)
  Conf[:roles].select{ |v| v[:nodes].any?{|u| u==n}}[0][:name]
end


