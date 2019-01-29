#!/bin/sh

  # pkg install bash ca_root_nss git python36 sudo
  # git clone https://github.com/tprelog/iocage-amazon-dash.git /root/.iocage-amazon-dash
  # bash /root/.iocage-amazon-dash/post_install.sh standard

my_locale="en_US.UTF-8"
export LANG=${my_locale} && export LC_ALL=${my_locale}
printf "\nsetenv LANG ${my_locale}\nsetenv LC_ALL ${my_locale}\n" >> /root/.cshrc

python3.6 -m ensurepip
pip3 install --upgrade pip
pip3 install amazon-dash

# Scapy Issue #1793 (https://github.com/secdev/scapy/issues/1793) effects versions 2.4.1 and 2.4.2
# This should downgrade effected versions to scapy 2.4.0
check_scapy () {
  scapyVersion=$(pip3 show scapy | grep Version | cut -d " " -f2)                                                                                                                   
  if [ ${scapyVersion} = 2.4.1 ] || [ ${scapyVersion} = 2.4.2 ]; then                         
    echo; echo " Detected scapy version: ${scapyVersion}"
    echo " Scapy Issue #1793 (https://github.com/secdev/scapy/issues/1793)"
    echo " Downgrading to scapy to version 2.4.0"
    pip3 install scapy==2.4.0; echo
  else                                                                                        
    echo "scapy version ok: ${scapyVersion}"                                                  
  fi                                                                                          
}
check_scapy

cp /usr/local/lib/python3.6/site-packages/amazon_dash/install/amazon-dash.yml /etc/amazon-dash.yml.sample_default

if [ "$1" = "standard" ]; then
    repo=/root/.iocage-amazon-dash
    rcd=/usr/local/etc/rc.d
    if [ ! -d "${rcd}" ]; then
      mkdir -p "${rcd}"
    fi
    cp "${repo}/overlay/usr/local/etc/rc.d/amazon-dash" ""${rcd}"/amazon-dash"
    cp "${repo}/overlay/etc/motd" "/etc/motd"
    cp "${repo}/overlay/usr/local/etc/amazon-dash.yml" "/usr/local/etc/amazon-dash.yml"
fi

cp /usr/local/etc/amazon-dash.yml /etc/amazon-dash.yml
chmod +x /usr/local/etc/rc.d/amazon-dash

sysrc -f /etc/rc.conf amazondash_enable="YES"
service amazon-dash start 2>/dev/null
