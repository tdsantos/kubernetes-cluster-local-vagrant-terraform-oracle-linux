
# Kubernetes Virtualized Environment with Terraform and Vagrant

## Overview

This project demonstrates how to set up a virtualized Kubernetes cluster using Oracle Linux 8 virtual machines managed by Vagrant and VirtualBox, and provisioned with Docker and Kubernetes tools. The environment is provisioned using Terraform and Vagrant, and it's ideal for local testing and development of Kubernetes clusters.

## Requirements

Before getting started, ensure you have the following software installed on your machine:

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads)
- [Terraform](https://www.terraform.io/downloads.html)

## Project Structure

```
kubernetes-virtualbox/
├── .gitignore             # Ignore unnecessary files for version control
├── main.tf                # Terraform configuration file
├── Vagrantfile            # Vagrant configuration file
├── README.md              # Project documentation (this file)
└── user_data              # User data script for VM provisioning
```

## Getting Started

### Step 1: Clone the Repository

```bash
git clone https://github.com/yourusername/kubernetes-virtualbox.git
cd kubernetes-virtualbox
```

### Step 2: Initialize Terraform

Terraform is used to manage and provision the virtual machines.

```bash
terraform init
```

### Step 3: Apply Terraform to Provision VMs

Run the following command to create the virtual machines using Terraform:

```bash
terraform apply
```

This command will create three virtual machines configured with Vagrant and VirtualBox.

### Step 4: Start the Vagrant Environment

After provisioning with Terraform, you can bring up the virtual machines with Vagrant.

```bash
vagrant up
```

### Step 5: Access the Virtual Machines

You can SSH into any of the nodes using Vagrant:

```bash
vagrant ssh k8s-node-1
```

### Step 6: Check Kubernetes Installation

Once inside a node, you can check if Docker and Kubernetes components are installed:

```bash
docker --version
kubelet --version
kubeadm --version
kubectl version --client
```

## Vagrantfile Configuration

The `Vagrantfile` is used to define and provision three Oracle Linux 8 VMs with Docker and Kubernetes pre-installed.

```ruby
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
        # Configuring Docker repo
        sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

        # Installing Docker
        sudo dnf install -y docker-ce docker-ce-cli containerd.io

        # Starting and enabling Docker
        sudo systemctl start docker
        sudo systemctl enable docker

        # Installing Kubernetes tools
        sudo dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

        # Enabling and starting kubelet
        sudo systemctl enable kubelet
        sudo systemctl start kubelet
      SHELL
    end
  end
end
```

## Troubleshooting

- Ensure that VirtualBox and Vagrant are installed and up to date.
- If you encounter errors while installing Docker or Kubernetes packages, make sure your system has access to the necessary repositories.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

