#CanaryDeploy
Autodeploy script for OpenCanary (https://github.com/thinkst/opencanary)
#Overview
Tested on CentOS 7.0 and XUbuntu 16.04 LTS.

Useful documentation resides at http://www.opencanary.org/en/latest/

Uses .opencanary.conf generated in your home directory on first run.

After script completes, edit as necessary.

Set up a centralized correlator using the README at https://github.com/thinkst/opencanary-correlator

#Requirements - opencanary
<ul>
<li>Python 2.7</li>
<li>python-pip</li>
<li>python-devel (CentOS)</li>
<li>python-dev (Ubuntu)</li>
<li>python-virtualenv</li>
<li>[Optional] SNMP requires scapy</li>
<li>[Optional] RDP requires rdpy</li>
<li>[Optional] Samba module needs a working installation of samba</li>
<li>[Ubuntu dependencies (if using rdpy)]: build-essential libssl-dev libffi-dev python-dev</li>
</ul>

#Install - opencanary
First, we create our virtual environment:
<pre><code>$ virtualenv envname/ 
$ . envname/bin/activate</code></pre>

Next, we invoke this command to install:

<pre><code>$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/sk4ro/canarydeploy/master/deploy.sh)"</code></pre>

#To-Do:
<ul>
<li>Custom configs</li>
<li>More pretty colors</li>
</ul>