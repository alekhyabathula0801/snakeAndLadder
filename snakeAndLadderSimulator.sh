#!/bin/bash -x
#constants
MOVE_FORWARD=1
MOVE_BACKWARD=2
NO_PLAY=0
GOAL=100
START_POSITION=0
#variable
playNextTurn=1
declare -A positionOfPlayer

read -p "Enter num of players " numOfPlayers
function initialiseStartingPositionOfPlayers(){
	for (( player=1; player<=$numOfPlayers; player++ ))
	do
		positionOfPlayer[$player]=$START_POSITION
	done
}

function findPositionOfPlayer(){
	dieNumber=$((RANDOM%6+1))
	random=$((RANDOM%3))
	case $random in
		$MOVE_FORWARD)
			positionOfPlayer[$player]=$((${positionOfPlayer[$player]}+$dieNumber))
                       	if [ ${positionOfPlayer[$player]} -gt $GOAL ]
                       	then
                               	positionOfPlayer[$player]=$((${positionOfPlayer[$player]}-$dieNumber))
                       	fi
		;;
       		$MOVE_BACKWARD)
               		positionOfPlayer[$player]=$((${positionOfPlayer[$player]}-$dieNumber))
       			if [ ${positionOfPlayer[$player]} -lt $START_POSITION ]
			then
				positionOfPlayer[$player]=$START_POSITION
			fi
		;;
		$NO_PLAY)
                        positionOfPlayer[$player]=$((${positionOfPlayer[$player]}+0))
                ;;
	esac
}

function findWinnerAmongPlayers(){
	initialiseStartingPositionOfPlayers
	while [ $playNextTurn = 1 ]
	do
		for (( player=1; player<=$numOfPlayers; player++ ))
		do
			#calling function to find position of players
			findPositionOfPlayer
			if [ ${positionOfPlayer[$player]} -eq $GOAL ]
			then
				winner=$player
				playNextTurn=0
				break;
			fi
		done
	done
}
# calling function to find winner
findWinnerAmongPlayers
echo Winner is player $winner
