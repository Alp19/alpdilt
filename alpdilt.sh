#!/bin/bash

echo -e "\033[0;43;45mAlp Domain Info Lookup Tool\033[0m"
echo "----------------------------"

echo "1. Single Lookup - Tekli Tarama"
echo "2. Bulk Lookup - Toplu Tarama"
echo "Select an option - Bir seçenek seçin (1/2):"
read choice

if [ $choice -eq 1 ]; then
    echo "Enter a domain name - Bir alan adı girin (örn: example.com):"
    read domain
    
    whois_info=$(whois $domain)
    
    echo "Whois information:"
    echo "$whois_info"
    
    echo "Do you want to save the information to a file? (Y/N) - Bilgiyi dosyaya kaydetmek istiyor musunuz? (E/H):"
    read save_choice
    
    if [ "$save_choice" == "Y" ] || [ "$save_choice" == "y" ]; then
        echo "$whois_info" > alpdilt_report.txt
        echo "Whois information has been saved to 'alpdilt_report.txt'."
    else
        echo "Information not saved."
    fi
    
elif [ $choice -eq 2 ]; then
    echo "Enter the name of the txt file for bulk lookup - Toplu tarama için txt dosyasını girin (örn: domains.txt):"
    read filename
    
    while read domain; do
        echo "Getting Whois information for - Whois bilgisi alınıyor: $domain"
        whois_info=$(whois $domain)
        
        echo "Whois information:"
        echo "$whois_info"
        
        echo "Do you want to save the information to a file? (Y/N) - Bilgiyi dosyaya kaydetmek istiyor musunuz? (E/H):"
        read save_choice
        
        if [ "$save_choice" == "Y" ] || [ "$save_choice" == "y" ]; then
            echo "$whois_info" >> multireport_alpdilt_report.txt
            echo "Whois information has been appended to 'multireport_alpdilt_report.txt'."
        else
            echo "Information not saved."
        fi
        
    done < $filename
    
else
    echo "Invalid choice. Please enter 1 or 2 - Geçersiz seçim. Lütfen 1 veya 2 girin."
fi
