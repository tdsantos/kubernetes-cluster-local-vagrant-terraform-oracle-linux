Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", disabled: true

  (1..3).each do |i|
    config.vm.define "k8s-node-#{i}" do |node|
      node.vm.box = "oraclelinux/8"
      node.vm.box_url = "https://oracle.github.io/vagrant-projects/boxes/oraclelinux/8.json"
      node.vm.hostname = "k8s-node-#{i}"
      node.vm.network "private_network", type: "dhcp"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end
      node.vm.provision "shell", inline: <<-SHELL
        # Configurando o repositório do Docker
        sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

        # Instalando Docker
        sudo dnf install -y docker-ce docker-ce-cli containerd.io

        # Iniciando e habilitando o Docker
        sudo systemctl start docker
        sudo systemctl enable docker

        # Adicionando o repositório Kubernetes
        cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
        [kubernetes]
        name=Kubernetes
        baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
        enabled=1
        gpgcheck=1
        repo_gpgcheck=1
        gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
        EOF

        # Desabilitando o SELinux (recomendado para Kubernetes)
        sudo setenforce 0
        sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

        # Instalando pacotes do Kubernetes
        sudo dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

        # Iniciando e habilitando kubelet
        sudo systemctl enable kubelet
        sudo systemctl start kubelet
      SHELL
    end
  end
end
