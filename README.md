# A simple OpenWrt router management script.


-----------------------------------------------
   Main Management Script For Openwrt Router   
-----------------------------------------------
   use this script with router-status command  
-----------------------------------------------
1. Display Full Router Status     
2. Display Full Router Network    
3. Update Packages                
4. Update router-status Package   
5. Uninstall router-status Package
6. Exit                           
-----------------------------------------------


# Install :
```
sh <(wget -qO- https://raw.githubusercontent.com/saeedkefayati/example-openwrt/main/install.sh)
```
```
rm -f /tmp/install.sh && wget -O /tmp/install.sh https://raw.githubusercontent.com/saeedkefayati/example-openwrt/main/install.sh && chmod +x /tmp/install.sh && sh /tmp/install.sh
```

# Usage :
you can use it with this command
```
router-status
```

# Update :
```
cd /root/example-openwrt
git pull
```

# Uninstall :
```
sh <(wget -qO- https://raw.githubusercontent.com/saeedkefayati/example-openwrt/main/uninstall.sh)
```
```
rm -f /tmp/uninstall.sh && wget -O /tmp/uninstall.sh https://raw.githubusercontent.com/saeedkefayati/example-openwrt/main/uninstall.sh && chmod +x /tmp/uninstall.sh && sh /tmp/uninstall.sh
```

```text
  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
```
