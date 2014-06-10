# Install 
#yum update -y && yum clean all && rm -rf /var/cache/yum/*
yum install -y wget curl zsh sudo git openssh-server passwd screen vim && yum clean all && rm -rf /var/cache/yum/*

# Install sshd
yum install -y openssh-server openssh-clients && \
    service sshd start && service sshd stop && \
    echo "NETWORKING=yes" > /etc/sysconfig/network && \
    sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# Setting time
echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock && \
    rm -f /etc/localtime && \
    ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime 

# Create user
export USER="docker"
echo 'root:docker' | chpasswd && useradd $USER && echo "$USER:$USER" | chpasswd && echo "$USER ALL=(ALL) ALL" >> /etc/sudoers && echo "$USER ALL=NOPASSWD: ALL" >> /etc/sudoers

# install supervisord
yum install -y python-setuptools && \
    easy_install pip && \
    pip install "pip>=1.4,<1.5" --upgrade && \
    pip install supervisor

# install ruby
export RUBY_VER=1.9
export RUBY_VER2=1.9.3
export RUBY_PATCH=p545
yum -y install gcc glibc-devel openssl-devel libyaml-devel libxslt-devel && yum clean all
#wget -q "http://cache.ruby-lang.org/pub/ruby/${RUBY_VER}/ruby-${RUBY_VER2}-${RUBY_PATCH}.tar.gz" -O /tmp/ruby.tar.gz  
#    cd /tmp/ 
#    tar -xf ruby.tar.gz 
#    cd "ruby-${RUBY_VER2}-${RUBY_PATCH}" 
#    ./configure --prefix=/usr/local && make &&  make install 
#    cd /tmp && rm -rf /tmp/ruby* 
#    gem install bundler --no-ri 


