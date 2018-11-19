testapp_IP = 35.205.184.252
testapp_port = 9292

bastion_IP = 35.210.14.191
someinternalhost_IP = 10.132.0.3


# GidMaster_infra
GidMaster Infra repository

## Home assignment #3:
1. Get access to "someinternalhost" VM instance trough "`bastion`" from external host use one-liner connections string.
```
Username: gpc.syrovatsky;
Auth type: ssh-rsa;
Proxy host: bastion.
```
Answer:

Command: `ssh -t -i ~/.ssh/appuser -A appuser@bastion 'ssh someinternalhost'`  

Arguments:
* ssh - Open SSH session;
* -t - Force pseudo-terminal allocation to to execute arbitrary screen-based programs on	a remote machine;
* -i [`IDENTITY_FILE`] - Selects a file from which the identity (private key) for public key authentication	is read;
* -A - Enables forwarding	of the authentication agent connectionl
* [`USERNAME`]@[`HOST`] - username and host address for SSH connection;
* '[`COMMAND`]' - execute command on remote host. In our case open ssh connection to "`someinternalhost`";

2. Get access to "`someinternalhost`" VM instance from external host by command "ssh someinternalhost".
```
Username: gpc.syrovatsky;
Auth type: ssh-rsa;
Proxy host: bastion;
Extra conditions: External machine's public key already palced on "bastion" and "someinternalhost" VM instances.
```
Ansewer:

We should make/change "`~/.ssh/config`" file to use "bastion" as proxy.

Minimal configuration should look:

"`cat ~/.ssh/config`"
```
Host someinternalhost
    ForwardAgent yes
    User appuser
    ProxyCommand ssh -v -t -i ~/.ssh/appuser -A appuser@bastion nc %h %p
```
Where:
* "ForwardAgent yes" - Specifies whether the connection to the authentication agent (if any) will be forwarded to the remote machine.
* "User appuser" - current user for connection
* "ProxyCommand" - Command that should be executed to get access to remote machine.
*     You can see that is a little diffirent from previous assignment. instead of "ssh someinternalhost" we use "nc %h %p".

But I decided to modify "`~/.ssh/config`" to make it more useful for future use:

"`cat ~/.ssh/config`"
```
Host someinternalhost
    ForwardAgent yes
    User appuser
    ProxyCommand ssh -v bastion nc %h %p
Host bastion
    HostName [IP_ADDRESS_OF_BASTION]
    IdentityFile ~/.ssh/appuser
    User appuser
```

3. IP addresses for checking task with VPN-server:
```
bastion_IP = 35.210.14.191
someinternalhost_IP = 10.132.0.3    
URL_pritunl: "https://pritunl.35.210.14.191.sslip.io"
```

## Home assignment #4:

Additional tasks solution:

1. Make configuration for puma-server using gcloud CLI to run VM instance with startup script:
```
  sudo gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --metadata-from-file \
  startup-script=startup-script.sh \
  --restart-on-failure \
```  

2.  Make firewall rule default-puma-server for puma-server using gcloud CLI
```
  sudo gcloud compute firewall-rules create default-puma-server \
  --action allow \
  --source-ranges 0.0.0.0/0 \
  --target-tags puma-server \
  --rules tcp:9292 \
  --direction INGRESS \
```
## Home assignment #5:

1. Studied foundation of Packer usage.
2. Made 1st packer template "`packer\ubuntu16.json`" with testApp installation.
3. Deployed testApp from VM image based on Packer template, ehich created before.
4. Parameterized Packer template with help of "`packer\variables.json`".
5. Made "baked" VM image with help of Packer template "`packer\immutable.json`".
6. Made script for automatic VM instance creation from "baked" VM image.

## Home assigmnet #6:

1. Studied foundation of Terraform usage.
2. Installed Terraform on Host machine.
3. Made 1st Terraform resourse.
4. Applied new VM with help of Terraform.
5. Checked results of apply with help of "`terraform show`" and terraform output vars.
6. Made "`firewall`" resourse.
7. Made provisioners to prepare and run instance with alredy runned application.
8. Used input variables to protect sensetive data.
9. Made input varables for `SSH private key` and `zone`.
10. Formatted *.tf files with "`terraform fmt`".
11. Made task with *:
* Described ssh-keys multiply users in metadata;
* Added appuser_web through Web interface. As a consicvense we got "`configuration drift`"

## Home assignment #7:
1. Imported exeisting structure to terraform state file.
2. Studied something about external resourses and dependecies.
3. Made my first own structure of resourses.
4. Used modules instead of sturucture.
5. Parametrized modules.
6. Made prod and stage configuration with module's re-usage.
7. Studied abuot modles registry.
8. Made task with *:
* Configured storaging state file on remote backend. Checked by removing local state file. 
* Added provisioners into modules to run already deployed application with DB.

## Home assignment #8:
1. Studied base ansible. About modules, functions, inventory options, files structure.
2. Installed ansible on local machine.
3. Made base INI inventory file.
4. Made base YAML inventory file.
5. Configured "`ansible.cfg`" to use default settings. Sucj as inventory file, keys path, etc.
6. Worked with a different modules as "`ping`", "`shell`", "`command`", "`systemd`", "`service`". Looked on advanteges and disadventeges different modules.
7. Worked with group of hosts.
8. Made simple playbook and implemented. Cheked how it works. _Note_: If playbook changes state of host, we will see number of changes in reply.
9. Made task with *:
* To create dynamical inventory you should use a script file which returns JSON message. Inventory.py gets data about external IP's from terraform output and insert them into JSON message.

## Home assignment #9:
1. Studied about diffirent scenarious of implementation playbooks and plays. (One playbook one play. One playbook many plays, several playbooks) 
2. Studied about templates, modules and handlers.
3. Complited task with *. Used gce.py to create dynamic inventory. _created service account. Added credentials into *.ini file. Added gce.py int ansible.cfg as defaulr inventory file._
4. Integrated ansible configuration into packer configurations.
