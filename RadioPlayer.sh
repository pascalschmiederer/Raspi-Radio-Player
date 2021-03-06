#!/bin/bash
#Script Copy von tobias-gehle.de


# Switch on status led

gpio mode 26 output
gpio write 26 1

# Define GPIO pins

led01="4"
led02="7"
led03="21"
led04="24"
led05="29"
led06="28"

pin_button01="1"
pin_button02="3"
pin_button03="22"
pin_button04="23"
pin_button05="25"
pin_button06="27"
pin_button_prev="5"
pin_button_next="6"


# Set LED GPIO pins to output mode

gpio mode $led01 output
gpio mode $led02 output
gpio mode $led03 output
gpio mode $led04 output
gpio mode $led05 output
gpio mode $led06 output

# Set all GPIO pins to 0

gpio write $led01 0
gpio write $led02 0
gpio write $led03 0
gpio write $led04 0
gpio write $led05 0
gpio write $led06 0

gpio mode $pin_button01 output ; gpio write $pin_button01 0 ; gpio mode $pin_button01 input
gpio mode $pin_button02 output ; gpio write $pin_button02 0 ; gpio mode $pin_button02 input
gpio mode $pin_button03 output ; gpio write $pin_button03 0 ; gpio mode $pin_button03 input
gpio mode $pin_button04 output ; gpio write $pin_button04 0 ; gpio mode $pin_button04 input
gpio mode $pin_button05 output ; gpio write $pin_button05 0 ; gpio mode $pin_button05 input
gpio mode $pin_button06 output ; gpio write $pin_button06 0 ; gpio mode $pin_button06 input
gpio mode $pin_button_prev output ; gpio write $pin_button_prev 0 ; gpio mode $pin_button_prev input
gpio mode $pin_button_next output ; gpio write $pin_button_next 0 ; gpio mode $pin_button_next input


# Start loop

while true
do

# Read button states

button01=$(gpio read $pin_button01)
button02=$(gpio read $pin_button02)
button03=$(gpio read $pin_button03)
button04=$(gpio read $pin_button04)
button05=$(gpio read $pin_button05)
button06=$(gpio read $pin_button06)
button_prev=$(gpio read $pin_button_prev)
button_next=$(gpio read $pin_button_next)

# Read current track and position

status=$(mpc | grep "%)")

position=${status##*(}
position=${position%)}
eval position$active_playlist_nr=$position

track=${status##*#}
track=${track%%/*}
eval track$active_playlist_nr=$track

# Function play

play ()	{
	mpc clear
        mpc search filename $active_playlist_nr/ | mpc add
        mpc play $track_nr
	mpc seek $seek
        sleep 0.5
	}

# Button 1

if [ "$button01" = "1" ]
	then

       	gpio write $led02 0
        gpio write $led03 0
        gpio write $led04 0
        gpio write $led05 0
        gpio write $led06 0

	status_led01=$(gpio read $led01)

if [ "$status_led01" = "0" ]
	then
	gpio write $led01 1
fi

if [ "$active_playlist_nr" != "01" ]
	then
	active_playlist_nr=01
	track_nr=$track01
        seek=$position01
	play
	else
	mpc toggle
	sleep 0.5
fi


# Button 2

elif [ "$button02" = "1" ]
	then

        gpio write $led01 0
        gpio write $led03 0
        gpio write $led04 0
        gpio write $led05 0
        gpio write $led06 0

        status_led02=$(gpio read $led02)

if [ "$status_led02" = "0" ]
        then
        gpio write $led02 1
fi

if [ "$active_playlist_nr" != "02" ]
        then
        active_playlist_nr=02
        track_nr=$track02
        seek=$position02
        play
	else
	mpc toggle
	sleep 0.5
fi


# Button 3

elif [ "$button03" = "1" ]
        then

        gpio write $led01 0
        gpio write $led02 0
        gpio write $led04 0
        gpio write $led05 0
        gpio write $led06 0

        status_led03=$(gpio read $led03)

if [ "$status_led03" = "0" ]
        then
        gpio write $led03 1
fi

if [ "$active_playlist_nr" != "03" ]
        then
        active_playlist_nr=03
        track_nr=$track03
        seek=$position03
        play
        else
        mpc toggle
	sleep 0.5
fi


# Button 4

elif [ "$button04" = "1" ]
	then

	gpio write $led01 0
        gpio write $led02 0
        gpio write $led03 0
        gpio write $led05 0
        gpio write $led06 0

        status_led04=$(gpio read $led04)

if [ "$status_led04" = "0" ]
        then
        gpio write $led04 1
fi

if [ "$active_playlist_nr" != "04" ]
        then
        active_playlist_nr=04
        track_nr=$track04
        seek=$position04
        play
        else
        mpc toggle
	sleep 0.5
fi


# Button 5

elif [ "$button05" = "1" ]
        then

        gpio write $led01 0
        gpio write $led02 0
        gpio write $led03 0
        gpio write $led04 0
        gpio write $led06 0

        status_led05=$(gpio read $led05)

if [ "$status_led05" = "0" ]
        then
        gpio write $led05 1
fi

if [ "$active_playlist_nr" != "05" ]
        then
	active_playlist_nr=05
	mpc clear
        mpc load kiraka
	mpc play
	sleep 0.5
	else
        mpc toggle
	sleep 0.5
fi


# Button 6

elif [ "$button06" = "1" ]
        then

        gpio write $led01 0
        gpio write $led02 0
        gpio write $led03 0
        gpio write $led04 0
        gpio write $led05 0

        status_led06=$(gpio read $led06)

if [ "$status_led06" = "0" ]
        then
        gpio write $led06 1
fi

if [ "$active_playlist_nr" != "06" ]
        then
        active_playlist_nr=06
        track_nr=$track06
        seek=$position06
        play
        else
        mpc toggle
	sleep 0.5
fi


# Button previous title

elif [ "$button_prev" = "1" ]
	then
	mpc prev
	sleep 0.5


# Button next title

elif [ "$button_next" = "1" ]
	then
	mpc next
	sleep 0.5
fi

done
