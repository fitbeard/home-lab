#!/bin/bash
# Name: intel-amt-kvm.sh
# Purpose : Control remote server/laptop/desktop using KVM and VNC client

# Intel AMT IP address
xIP=$1

# Intel AMT credentials
xUSER='admin'
xPASSWORD='P@ssw0rd'

# Must be exactly *8 characters long* and contain at least one of each:
#   [ lower case, upper case, number, special character ]

xVNC_PWD='P@ssw0rd'
xVNC_PORT='5900'

# Enable KVM
wsman put http://intel.com/wbem/wscim/1/ips-schema/1/IPS_KVMRedirectionSettingData -h $xIP -P 16992 -u admin -p "${xPASSWORD}" -k RFBPassword="${xVNC_PWD}"
# Enable KVM redirection to port 5900
wsman put http://intel.com/wbem/wscim/1/ips-schema/1/IPS_KVMRedirectionSettingData -h $xIP -P 16992 -u admin -p "${xPASSWORD}" -k Is5900PortEnabled=true
# Disable opt-in policy
wsman put http://intel.com/wbem/wscim/1/ips-schema/1/IPS_KVMRedirectionSettingData -h $xIP -P 16992 -u admin -p "${xPASSWORD}" -k OptInPolicy=false
# Disable session timeout
wsman put http://intel.com/wbem/wscim/1/ips-schema/1/IPS_KVMRedirectionSettingData -h $xIP -P 16992 -u admin -p "${xPASSWORD}" -k SessionTimeout=0
# Enable KVM
wsman invoke -a RequestStateChange http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_KVMRedirectionSAP -h "${xIP}" -P 16992 -u "${xUSER}" -p "${xPASSWORD}" -k RequestedState=2

echo "Open Linux vnc client. Use \"$xIP:$xVNC_PORT\" as host and when promoted enter \"$xVNC_PWD\" as password"
