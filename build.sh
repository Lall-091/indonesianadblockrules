#!/bin/bash

# Orderer and Preener
python tools/FOP.py

# render it and save it into
flrender -i abpindo=. abpindo.template subscriptions/abpindo.txt
flrender -i abpindo=. abpindo_hosts.template subscriptions/abpindo_hosts.txt
flrender -i abpindo=. abpindo_hosts_annoyance.template subscriptions/abpindo_hosts_annoyance.txt
flrender -i abpindo=. abpindo_noannoyance.template subscriptions/abpindo_noannoyance.txt
flrender -i abpindo=. abpindo_noelemhide.template subscriptions/abpindo_noelemhide.txt

adblock2hosts --ip 0.0.0.0 -o subscriptions/hosts.txt subscriptions/abpindo_hosts.txt
adblock2hosts --ip 0.0.0.0 -o subscriptions/hosts_annoyance.txt subscriptions/abpindo_hosts_annoyance.txt

adblock2hosts --ip "" -o subscriptions/domain.txt subscriptions/abpindo_hosts.txt
adblock2hosts --ip "" -o subscriptions/domain_annoyance.txt subscriptions/abpindo_hosts_annoyance.txt

python tools/domains_to_dnsmasq_address.py subscriptions/hosts.txt subscriptions/dnsmasq.txt
python tools/domains_to_dnsmasq_address.py subscriptions/hosts_annoyance.txt subscriptions/dnsmasq_annoyance.txt
python tools/domains_to_dnsmasq_server.py subscriptions/hosts.txt subscriptions/dnsmasq_server.txt
python tools/domains_to_dnsmasq_server.py subscriptions/hosts_annoyance.txt subscriptions/dnsmasq_annoyance_server.txt

python tools/domains_to_rpz.py subscriptions/hosts.txt subscriptions/rpz.txt
python tools/domains_to_rpz.py subscriptions/hosts_annoyance.txt subscriptions/rpz_annoyance.txt

#adblock2hosts -o subscriptions/domain.txt subscriptions/abpindo_hosts.txt
#adblock2hosts -o subscriptions/domain_annoyance.txt subscriptions/abpindo_hosts_annoyance.txt

read -p "Press any key to resume ..."