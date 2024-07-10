#!/bin/bash
# Token kingvpn77 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
    TOKEN="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"
    git clone https://github.com/king-vpn/next/root/ipvps/ &> /dev/null
    clear
    echo ""
    echo -e "${g}         LIST IP VPS          $NC"
    grep -E "^###" "/root/ipvps/ip" | cut -d ' ' -f 2-6 | column -t | sort | uniq
    grep -E "^#&"  "/root/ipvps/ip" | cut -d ' ' -f 2-6 | column -t | sort | uniq

    read -p "Input IP Address To Delete : " ipdel
    name=$(cat /root/ipvps/ip | grep $ipdel | awk '{print $2}')
    exp=$(cat /root/ipvps/ip | grep $ipdel | awk '{print $3}')
    if [[ ${exp} == 'Lifetime' ]]; then
    sed -i "/^#&   $name   $exp $ipdel/,/^},{/d" /root/ipvps/ip
    else
    sed -i "/^### $name $exp $ipdel/,/^},{/d" /root/ipvps/ip
    fi
    cd /root/ipvps
    git config --global user.email "kingvpn293@gmail.com" &> /dev/null
    git config --global user.name "kingvpn77" &> /dev/null
    rm -rf .git &> /dev/null
    git init &> /dev/null
    git add . &> /dev/null
    git commit -m register &> /dev/null
    git branch -M main &> /dev/null
    git remote add origin https://github.com/king-vpn/next
    git push -f https://${TOKEN}@github.com/king-vpn/permission.git &> /dev/null
    rm -rf /root/ipvps
    clear
    sleep 1
    echo "  Delete IP Address..."
    sleep 1
    echo "  Processing..."
    sleep 1
    echo "  Done!"
    sleep 1
