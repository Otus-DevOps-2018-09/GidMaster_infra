# GidMaster_infra
GidMaster Infra repository

Assignment on my own:
1. Get access to "someinternalhost" VM instance trough "bastion" from external host use one-liner connections string.
    Username: gpc.syrovatsky;
    Auth type: ssh-rsa;
    Proxy host: bastion.
Answer:
    ssh -t -i ~/.ssh/gcp.syrovatsky -A gcp.syrovatsky@bastion 'ssh someinternalhost'
    ssh - Open SSH session
        Argumants:
            -t - Force pseudo-terminal allocation to to execute arbitrary screen-based programs on	a remote machine;
            -i [IDENTITY_FILE] - Selects a file from which the identity (private key) for public key authentication	is read;
            -A - Enables forwarding	of the authentication agent connectionl
            [USERNAME]@[HOST] - username and host address for SSH connection;
            '[COMMAND]' - execute command on remote host. In our case open ssh connection to "someinternalhost";

2. Get access to "someinternalhost" VM instance from external host by command "ssh someinternalhost".
    Username: gpc.syrovatsky;
    Auth type: ssh-rsa;
    Proxy host: bastion;
    Extra conditions: External machine's public key already palced on "bastion" and "someinternalhost" VM instances.
Ansewer:
    We should make/change ~/.ssh/config file to use "bastion" as proxy.

    Minimal configuration should look:
    ~/.ssh/config

    Host someinternalhost
        ForwardAgent yes
        User gcp.syrovatsky
        ProxyCommand ssh -v -t -i ~/.ssh/gcp.syrovatsky -A gcp.syrovatsky@bastion nc %h %p

        Where:
            "ForwardAgent yes" - Specifies whether the connection to the authentication agent (if any) will be forwarded to the remote machine.
            "User gcp.syrovatsky" - current user for connection
            "ProxyCommand" - Command that should be executed to get access to remote machine.
                You can see that is a little diffirent from previous assignment. instead of "ssh someinternalhost" we use "nc %h %p".
        
    But I decided to modify ~/.ssh/config to make it more useful for future use:
    ~/.ssh/config

    Host someinternalhost
        ForwardAgent yes
        User gcp.syrovatsky
        ProxyCommand ssh -v bastion nc %h %p
    Host bastion
        HostName [IP_ADDRESS_OF_BASTION]
        IdentityFile ~/.ssh/gcp.syrovatsky
        User gcp.syrovatsky

