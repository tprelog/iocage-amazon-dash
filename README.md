# iocage-amazon-dash
Artifact file(s) for [Amazon Dash](http://docs.nekmo.org/amazon-dash/readme.html)

---
## iocage-plugin-amazon-dash

 - This script will by default create a plugin-jail for Amazon-dash on FreeNAS 11.2 

**Download plugin and install**

    wget -O /tmp/amazon-dash.json https://raw.githubusercontent.com/tprelog/iocage-amazon-dash/master/amazon-dash.json
    sudo iocage fetch -P dhcp=on vnet=on bpf=yes -n /tmp/amazon-dash.json --branch 'master'

---
---
### iocage-jail-amazon-dash

 - This scrpit can also be used to create a standard-jail for Amazon-dash 

**Download pkg-list and create a jail using it to install requirements**

    wget -O /tmp/pkglist.json https://raw.githubusercontent.com/tprelog/iocage-amazon-dash/master/pkg-list.json
    sudo iocage create -r 11.2-RELEASE boot=on dhcp=on bpf=yes vnet=on -p /tmp/pkglist.json -n amazon-dash

**Git script and install**

    sudo iocage exec amazon-dash git clone https://github.com/tprelog/iocage-amazon-dash /root/.iocage-amazon-dash
    sudo iocage exec amazon-dash sh /root/.iocage-amazon-dash/post_install.sh standard

---

###### To see a list of jails as well as their ip address

    sudo iocage list -l
    +-----+----------------+------+-------+----------+-----------------+---------------------+-----+----------+
    | JID |      NAME      | BOOT | STATE |   TYPE   |     RELEASE     |         IP4         | IP6 | TEMPLATE |
    +=====+================+======+=======+==========+=================+=====================+=====+==========+
    | 1   | amazon-dash    | on   | up    | jail     | 11.2-RELEASE-p4 | epair0b|192.0.1.61  | -   | -        |
    +-----+----------------+------+-------+----------+-----------------+---------------------+-----+----------+
    | 2   | amazon-dash_2  | on   | up    | pluginv2 | 11.2-RELEASE-p4 | epair0b|192.0.1.62  | -   | -        |
    +-----+----------------+------+-------+----------+-----------------+---------------------+-----+----------+


Tested on FreeNAS-11.2-RC2  
More information about [iocage plugins](https://doc.freenas.org/11.2/plugins.html) and [iocage jails](https://doc.freenas.org/11.2/jails.html) can be found in the [FreeNAS guide](https://doc.freenas.org/11.2/intro.html#introduction)  
This script should also still work with FreeNAS 11.1
