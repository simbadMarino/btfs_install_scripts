#!/bin/bash
clear
#DECISION = ""
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

BTFS INSTALLATION WIZARD FOR RASPBERRY PI                                
by SimbadMarino                  
"
read -p "Select the desired installation method: 
	 1) External drive -Full install(Golang + BTFS + Clean BTFS repo)
	 2) External drive -BTFS Only(BTFS + Clean BTFS repo)
	"  i_method
case "$i_method" in
   "1") read -p "Installing on External drive (Full install). Proceed?(y/n)" DECISION
	if [ $DECISION = "y" ]
	then
		echo ""	
		echo "Creating temp folder for go install..."
		cd ${HOME}
		mkdir _temp_golang
		cd _temp_golang
		echo ""
		echo "Downloading Golang(arm64)...."
		wget https://golang.org/dl/go1.14.5.linux-armv6l.tar.gz
		echo "Extracting and moving binary file..."
		sudo tar -C /usr/local -xzf go1.14.5.linux-armv6l.tar.gz
		echo "Cleaning temp install files..."
		cd ..
		rm -r _temp_golang
		cd ${HOME}
		echo "Adding PATH to .profile..."
		echo "PATH=$PATH:/usr/local/go/bin" >> .profile
		echo "GOPATH=$HOME/golang" >> .profile 
		source ~/.profile
		echo ""
		echo "Testing  our install..."
		which go	#you should get /usr/local/go/bin/go
		go version	#you should get go version go1.14.4 linux/arm
		cd /media/$USER
		OUTPUT="$(ls -1)"
		cd ${HOME}
		echo "${OUTPUT}" >> listOfMedia.txt
		readarray -t mediaList < listOfMedia.txt
		rm listOfMedia.txt
		ITER=0
		echo ""
		echo "AVAILABLE EXTERNAL DRIVES: --->"
		for drive in "${mediaList[@]}"
		do	
			echo "$ITER) $drive"
			((ITER=ITER+1))
		done
		read -p "Select your external drive: " driveSelect
		echo "Installing btfs repo on ${mediaList[$driveSelect]}..."
		#cd /media/$USER/${mediaList[$driveSelect]}
		
		echo "BTFS binary will be installed in:"
		btfsPath=${HOME}/btfs/bin
		echo ${btfsPath}
		echo "BTFS repo will be installed in:"
		dotBtfsPath=/media/$USER/${mediaList[$driveSelect]}/.btfs
		echo ${dotBtfsPath}
		echo ""
		if [[ -d "${btfsPath}" ]];then
    			echo "BTFS binary already exists, cleaning up!..."
    			sudo rm -rf ${btfsPath}
			#sudo rm -rf ${dotBtfsPath}
    			echo "BTFS folder deleted!"
		fi
		#Creating a clean folder for the new binary file
		mkdir btfs
		cd btfs
		mkdir bin
		cd bin
		#BTFS repo folder check 
		if [[ -d "${dotBtfsPath}" ]];then
			read -p "BTFS repo data found in external drive, do you want to erase ALL data?(y/n)" DECISION
			if [ $DECISION = "y" ]
			then
				echo "Cleaning up!..."
	    			#sudo rm -rf ${btfsPath}
				sudo rm -rf ${dotBtfsPath}
	    			echo "BTFS folder deleted!"
			else
				echo "Not touching BTFS data on external drive..."
			fi
		fi
			
		
		#Downloading latest btfs binary files..
		echo Downloading latest arm btfs binary file... 			
		wget https://github.com/TRON-US/go-btfs/releases/latest/download/btfs-linux-arm.tar
		tar -xf btfs-linux-arm.tar
		cp config_linux_arm.yaml config.yaml
		cp btfs-linux-arm btfs
		rm config_linux_arm.yaml
		rm btfs-linux-arm
		rm btfs-linux-arm.tar
		#chmod +x btfs
		echo ""
		echo "Adding PATH and BTFS_PATH ..."
		cd ${HOME}
		
		#export PATH=${btfsPath}:$PATH
		export BTFS_PATH=${dotBtfsPath} #BTFS repo PATH
		echo export 'PATH=${PATH}:${HOME}/btfs/bin #BTFS binary file PATH' >> .bashrc # BTFS binary PATH
		source ~/.bashrc
		echo ""
		echo "Creating BTFS Repository..."
		btfs init
		btfs config profile apply storage-host
		echo ""
		echo "-----END OF SCRIPT. ENJOY :)-----"
	else
		echo "Installation aborted by user"
	fi	
   ;;
   "2") read -p "Installing on External drive (BTFS Only) Proceed?(y/n)" DECISION
	if [ $DECISION = "y" ]
	then
		
		echo "Testing our GO install..."
		which go	#you should get /usr/local/go/bin/go
		go version	#you should get go version go1.14.4 linux/arm
		cd /media/$USER
		OUTPUT="$(ls -1)"
		cd ${HOME}
		echo "${OUTPUT}" >> listOfMedia.txt
		readarray -t mediaList < listOfMedia.txt
		rm listOfMedia.txt
		ITER=0
		echo ""
		echo "AVAILABLE EXTERNAL DRIVES: --->"
		for drive in "${mediaList[@]}"
		do	
			echo "$ITER) $drive"
			((ITER=ITER+1))
		done
		read -p "Select your external drive: " driveSelect
		echo "Installing btfs repo on ${mediaList[$driveSelect]}..."
		#cd /media/$USER/${mediaList[$driveSelect]}
		
		echo "BTFS binary will be installed in:"
		btfsPath=${HOME}/btfs/bin
		echo ${btfsPath}
		echo "BTFS repo will be installed in:"
		dotBtfsPath=/media/$USER/${mediaList[$driveSelect]}/.btfs
		echo ${dotBtfsPath}
		echo ""
		if [[ -d "${btfsPath}" ]];then
    			echo "BTFS binary already exists, cleaning up!..."
    			sudo rm -rf ${btfsPath}
			#sudo rm -rf ${dotBtfsPath}
    			echo "BTFS folder deleted!"
		fi
		#Creating a clean folder for the new binary file
		mkdir btfs
		cd btfs
		mkdir bin
		cd bin
		#BTFS repo folder check 
		if [[ -d "${dotBtfsPath}" ]];then
			read -p "BTFS repo data found in external drive, do you want to erase ALL data?(y/n)" DECISION
			if [ $DECISION = "y" ]
			then
				echo "Cleaning up!..."
	    			#sudo rm -rf ${btfsPath}
				sudo rm -rf ${dotBtfsPath}
	    			echo "BTFS folder deleted!"
			else
				echo "Not touching BTFS data on external drive..."
			fi
		fi
			
		
		#Downloading latest btfs binary files..
		echo Downloading latest arm btfs binary file... 			
		wget https://github.com/TRON-US/go-btfs/releases/latest/download/btfs-linux-arm.tar
		tar -xf btfs-linux-arm.tar
		cp config_linux_arm.yaml config.yaml
		cp btfs-linux-arm btfs
		rm config_linux_arm.yaml
		rm btfs-linux-arm
		rm btfs-linux-arm.tar
		#chmod +x btfs
		echo ""
		echo "Adding PATH and BTFS_PATH ..."
		cd ${HOME}
		
		#export PATH=${btfsPath}:$PATH
		export BTFS_PATH=${dotBtfsPath} #BTFS repo PATH
		echo export 'PATH=${PATH}:${HOME}/btfs/bin #BTFS binary file PATH' >> .bashrc # BTFS binary PATH
		source ~/.bashrc
		echo ""
		echo "Creating BTFS Repository..."
		btfs init
		btfs config profile apply storage-host
		echo ""
		echo "-----END OF SCRIPT. ENJOY :)-----"
		
		

	else
		echo "You don't want to install"
	fi
   
esac

#read -p "You selected: $i_method"

