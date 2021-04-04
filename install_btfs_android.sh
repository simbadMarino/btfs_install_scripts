#!/bin/bash
clear
echo "

                  ||'|                      
              ||'|eB@Q97_||                 
             ,idQ@@@@@@@@Nyr|               
         |  |,zgQNS>';{DQ#e|-  |            
     |,\XMP/~|||.| |   |'||||;agqv:|        
 ||;{DQ@@@Q9\|             |,u#@@@@Nyr'     
 ~N@@@@Qa>'||                 |;{N@@@@Q=|   
 ^@@@@@@NSr'||               |;{DQ@@@@@u|   
 ;@@@He#@@@@No>|||      ||~LEQ@@@Q$X@@@F    
 ;@@@y||:zH@@@@Be|'| |-;u8@@@@gor.|r@@@F|   
 :N@@j|   |'|eB@@@QOFPQ@@@@RF;||   r@@Q||   
 ||:v>|       |?Z#@@@@@QkL,|       :u;-|    
 .,|||           |c@@@P'|           ||''    
 ^@Du_           |^@@@y|           '7$@j    
 ;@@@y           |^@@@u|           r@@@F    
 ;@@@y|          |^@@@u|           r@@@u    
 ;@@@Qdz;|        ^@@@u|      ||,L$Q@@@x|   
 |^aN@@@@F| |     ^@@@F| ||   |^@@@@Qk\.    
   ||:1K@e|||]1,||^@@@u||.rZr ||@8u^-|      
     |||',|||D@QD{x@@@Pc$Q@@z| '~||         
            |\H@@@@@@@@@@@QE:               
              |:c6Q@@@@8F;-|                
                 |'rv\,|                    
       ____  _______  ______  _____  
      |  _ \|__   __||  ____|/ ____| 
      | |_) |  | |   | |__  | (___   
      |  _ <   | |   |  __|  \___ \  
      | |_) |  | |   | |     ____) | 
      |____/   |_|   |_|    |_____/  

BTFS INSTALLATION SCRIPT FOR ANDROID                                
by SimbadMarino                  
"
echo "Installing dependencies: clang, wget,make & git"
pkg install clang -y
#pkg --fix broken install -y
pkg install make -y
pkg install git -y
pkg install lld -y
pkg install golang

git clone https://github.com/TRON-US/go-btfs
cd go-btfs
make install
cd ~
echo 'export PATH=${HOME}/go/bin:$PATH' >> .bashrc
source .bashrc
btfs init
btfs daemon
