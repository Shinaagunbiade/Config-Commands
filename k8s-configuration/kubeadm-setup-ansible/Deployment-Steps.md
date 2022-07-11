- Create your working directory (kube-cluster) and cd into it
- Update your hosts file and create your ansible.cfg file (if need be or use as-is)
- Install Docker with the Ansible script - ansible-playbook-docker-ubuntu.yaml (or through any other convenient measure) on all servers
- Add Ubuntu user to list of sudoers by running the script initial.yml
- Install Kubernetes dependencies - kube-dependencies.yml (Kubeadm, kubelet, kubectl). Note that Kubectl is only installed on the master control plane
- Set up the master node by running the playbook master.yml
    If you have issues, follow the steps below:
    If you see the error: Some fatal errors occurred: [ERROR CRI]: container runtime is not running
        - SSH into your control plane (sometimes you may be required to vi into all worker nodes)
        - vi into the file /etc/containerd/config.toml and comment out disabled_plugins = ["cri"]. 
        - Run sudo systemctl restart containerd; then 
        - Run the ansible script again or do kubeadm init (may need sudo) again from master
    If you encounter error: Source /etc/kubernetes/admin.conf not found
        - SSH into your control plane
        - run the kubeadm init with sudo right (i.e. kubeadm init --pod-network-cidr=10.244.0.0/16)
        - run the ansible script again
- Verify that your control node has been set up by sshing into the control plan and enter command kubectl get nodes.
- Worker nodes can then be set to join the control plane - workers.yml. 
- You can now ssh into the master plane and run your kubectl commands (kubectl get nodes - all nodes MUST show ready, if not follow steps below)
    - If you do a kubectl describe nodes and see the error: node not ready problem 
        # reference page: https://github.com/kubernetes/kubernetes/issues/48798
    - vi into /var/lib/kubelet/kubeadm-flags.env
    - Comment out the line KUBELET_KUBEADM_ARGS="--network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:3.2"; and issue should be solved
- Deploy a test container (Nginx by running the below commands)
    kubectl create deployment nginx --image=nginx
    kubectl expose deploy nginx --port 80 --target-port 80 --type NodePort
    kubectl get services
  You can get the external port to access the application from the ports section. 
  You can also run the mongo k8s deployment scripts to be sure it's all good.