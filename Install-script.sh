#!/usr/bin/env bash

# Install script to automate the install of twint
# Then automates pulling down my git repository with the Nest Scraper


echo "Some sort of text?"

#Installing the Pre-reqs
sudo apt install python3-pip -y

sudo apt install git -y

sudo apt install pipenv -y

sudo apt install lolcat -y

#Twint Install + Requirements
git clone --depth=1 https://github.com/twintproject/twint.git
cd twint
pip3 install . -r requirements.txt

pip3 install twint

pipenv install git+https://github.com/twintproject/twint.git#egg=twint

#Setting the python path (Used when you're on Kali)
export PATH=$PATH:/home/kali/.local/bin

#Cloning the repository for Nest Scraper
git clone https://github.com/themanc17/NestScraper

cd NestScraper

chmod +x ./MenuP.sh
chmod +x ./reqs.sh
chmod +x ./reload.sh

#Running the first page
bash reqs.sh