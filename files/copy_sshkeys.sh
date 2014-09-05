sudo su cloudera
<<EOF
ssh-copy-id -i ~/.ssh/id_rsa.pub cloudera@tyconet01.tyco.com
ssh-copy-id -i ~/.ssh/id_rsa.pub cloudera@tyconet02.tyco.com
ssh-copy-id -i ~/.ssh/id_rsa.pub cloudera@tyconet03.tyco.com
ssh-copy-id -i ~/.ssh/id_rsa.pub cloudera@tyconet04.tyco.com
ssh-copy-id -i ~/.ssh/id_rsa.pub cloudera@tyconet05.tyco.com
ssh-copy-id -i ~/.ssh/id_rsa.pub cloudera@tyconet06.tyco.com
exit
EOF
