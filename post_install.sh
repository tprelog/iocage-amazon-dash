#!/bin/sh

my_locale="en_US.UTF-8"
export LANG=${my_locale} && export LC_ALL=${my_locale}
printf "\nsetenv LANG ${my_locale}\nsetenv LC_ALL ${my_locale}\n" >> /root/.cshrc

python3.6 -m ensurepip
pip3 install --upgrade pip
pip3 install amazon-dash

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
