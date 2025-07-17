//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
    {"", "echo ^c#98c379^ $USER@$HOSTNAME",        0,          0},
    {"", "echo ^c#CA578D^ Vol $(pamixer --get-volume)%",        1,          0},
	{"", "echo ^c#e5c07b^ $(free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g)",	30,		0},
	{"", "echo ^c#61afef^ $(date +'%I:%M %p %a %m/%d %Y' | awk 'NR=1')",	5,		         0},
    {"", "echo ^c#ABB2BF^ $(cat /sys/class/power_supply/BAT0/capacity)%", 30, 0}
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
