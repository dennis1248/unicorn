#!/usr/bin/env bash
#
#
### Pre-run checks ###
#
# Quit if not using SUID
ub_quit_if_no_suid () {
	if (( $EUID != 0 )); then
		ub_l2_err_quit 'This script has to be run as root'
	fi
}

# Quit if using SUID
ub_quit_if_suid () {
	if (( $EUID == 0 )); then
		ub_l2_err_quit 'This script has to be run as a non-SUID user'
	fi
}

# Warn if not using SUID
ub_warn_if_no_suid () {
	if (( $EUID != 0 )); then
		ub_l2_warn 'This script should be run as root'
	fi
}

# Warn if using SUID
ub_warn_if_suid () {
	if (( $EUID == 0 )); then
		ub_l2_warn 'This script should not be run as a non-SUID user'
	fi
}

### Loggin, output and errors ###
#
# Each level increases the visibility of the error
#
# L0 = No chars just message
# L1 = 2 char notice followed by message
# L2 = 3 char notice followed by message
#
## Errors
ub_l1_err () {
	printf "\e[31m#>\e[0m $*\n"
}

ub_l1_err_await () {
	printf "\e[31m#>\e[0m $*"
}

ub_l1_err_replace () {
	printf "\r\e[31m#>\e[0m $*\n"
}

ub_l2_err () {
	printf "\e[31m<#>\e[0m $*\n"
}

ub_l2_err_await () {
	printf "\e[31m<#>\e[0m $*"
}

ub_l2_err_replace () {
	printf "\r\e[31m<#>\e[0m $*\n"
}

## Warings
ub_l1_warn () {
	printf "\e[1;33m!>\e[0m $*\n"
}

ub_l1_warn_await () {
	printf "\e[1;33m!>\e[0m $*"
}

ub_l1_warn_replace () {
	printf "\r\e[1;33m!>\e[0m $*\n"
}

ub_l2_warn () {
	printf "\e[1;33m<!>\e[0m $*\n"
}

ub_l2_warn_await () {
	printf "\e[1;33m<!>\e[0m $*"
}

ub_l2_warn_replace () {
	printf "\r\e[1;33m<!>\e[0m $*\n"
}

## Confirmations
ub_l1_conf () {
	printf "\e[32m>>\e[0m $*\n"
}

ub_l1_conf_await () {
	printf "\e[32m>>\e[0m $*"
}

ub_l1_conf_replace () {
	printf "\r\e[33m>>\e[0m $*\n"
}

ub_l2_conf () {
	printf "\e[32m>>>\e[0m $*\n"
}

ub_l2_conf_await () {
	printf "\e[32m>>>\e[0m $*"
}

ub_l2_conf_replace () {
	printf "\r\e[32m>>>\e[0m $*\n"
}

## Generic logging
ub_l1_info () {
	printf "\e[34m->\e[0m $*\n"
}

ub_l1_info_await () {
	printf "\e[34m->\e[0m $*"
}

ub_l1_info_replace () {
	printf "\r\e[34m->\e[0m $*\n"
}

ub_l2_info () {
	printf "\e[34m-->\e[0m $*\n"
}

ub_l2_info_await () {
	printf "\e[34m-->\e[0m $*"
}

ub_l2_info_replace () {
	printf "\r\e[34m-->\e[0m $*\n"
}

## Plain text
ub_l0_await () {
	printf "$*"
}

ub_l0_end () {
	printf "$*\n"
}

### Error handeling ###
#
# level 1 print error $* and quit program
# $2 is optional exit code
ub_l1_err_quit () {
	ub_l1_err $1

	if [[ -n $2 ]]; then
		exit $2
	else
		exit 1
	fi
}

# level 2 print error $* and quit program
# $2 is optional exit code
ub_l2_err_quit () {
	ub_l2_err $1

	if [[ -n $2 ]]; then
		exit $2
	else
		exit 1
	fi
}

### Text styling options ###
#
# Reset text back to default, will also undo color and bgcolor
ub_text_reset () {
	printf '\e[0m'
}

# Make text bold
ub_text_bold () {
	printf '\e[1m'
}

# Make text dim
ub_text_dim () {
	printf '\e[2m'
}

# Make text italic
ub_text_italic () {
	printf '\e[3m'
}

# Make text underlined
ub_text_underline () {
	printf '\e[4m'
}

# Make text blink
ub_text_blink () {
	printf '\e[5m'
}

# Make text color inverted
ub_text_invert () {
	printf '\e[7m'
}

# Make text hidden
ub_text_hidden () {
	printf '\e[8m'
}

### Common file manipulations ###
#
# Create directories $@
ub_run_mkdir () {
	ub_l1_info 'Creating directories...'

	for i in $@; do

		declare data=(${i//:/ })

		if [[ -e ${data[0]} ]]; then
			ub_l2_warn "Skipping ${data[0]} for it already exists"
		else
			ub_l2_conf_await "Creating ${data[0]}... "

			if [[ -n ${data[1]} ]]; then
				mkdir -p ${data[0]} -m ${data[1]} 2> /dev/null
			else
				mkdir -p ${data[0]} 2> /dev/null
			fi

			if [[ ! $? -eq 0 ]]; then
				ub_l2_err_replace "An error occured while trying to create ${data[0]}"
			else
				ub_l0_end 'Done'
			fi
		fi

	done
}

ub_run_touch () {
	ub_l1_info 'Creating files...'

	for i in $@; do

		declare data=(${i//:/ })

		if [[ -e ${data[0]} ]]; then
			ub_l2_warn "Skipping ${data[0]} for it already exists"
		else
			ub_l2_conf_await "Creating ${data[0]}... "

			if [[ -n ${data[1]} ]]; then
				install -m ${data[1]} /dev/null ${data[0]}
			else
				touch ${data[0]}
			fi

			if [[ ! $? -eq 0 ]]; then
				ub_l2_err_replace "An error occured while trying to create ${data[0]}"
			else
				ub_l0_end 'Done'
			fi
		fi

	done
}

ub_run_cp () {
	ub_l1_info 'Copying file...'

	if [[ -e $2 ]]; then
		ub_l2_warn "Skipping copy $1 to $2 for it already exists"
	else
		ub_l2_conf_await "Copying $1 to $2... "
		cp $1 $2

		if [[ ! $? -eq 0 ]]; then
			ub_l2_err_replace "An error occured while trying to copy $1 to $2"
		else
			ub_l0_end 'Done'
		fi
	fi

}

### Set useful environment variables ###
#
# Enable text styling variables
ub_set_text () {
	UB_TEXT_RESET='\e[0m'
	UB_TEXT_BOLD='\e[1m'
	UB_TEXT_DIM='\e[2m'
	UB_TEXT_ITALIC='\e[3m'
	UB_TEXT_UNDERLINE='\e[4m'
	UB_TEXT_BLINK='\e[5m'
	UB_TEXT_INVERT='\e[7m'
	UB_TEXT_HIDDEN='\e[8m'

	# This function will only be available after ub_set_text has be run
	ub_unset_text () {
		local text='UB_TEXT_RESET
		UB_TEXT_BOLD
		UB_TEXT_DIM
		UB_TEXT_ITALIC
		UB_TEXT_UNDERLINE
		UB_TEXT_BLINK
		UB_TEXT_INVERT
		UB_TEXT_HIDDEN'

		for i in $text; do
			unset $i
		done

		unset -f ${FUNCNAME[0]}
	}
}

# Enable color variables
ub_set_color () {
	UB_COLOR_BLACK='\e[30m'
	UB_COLOR_RED='\e[31m'
	UB_COLOR_GREEN='\e[32m'
	UB_COLOR_YELLOW='\e[33m'
	UB_COLOR_BLUE='\e[34m'
	UB_COLOR_PURPLE='\e[35m'
	UB_COLOR_CYAN='\e[36m'
	UB_COLOR_GRAY='\e[37m'

	ub_unset_color () {
		local color='UB_COLOR_BLACK
		UB_COLOR_RED
		UB_COLOR_GREEN
		UB_COLOR_YELLOW
		UB_COLOR_BLUE
		UB_COLOR_PURPLE
		UB_COLOR_CYAN
		UB_COLOR_GRAY'

		for i in $color; do
			unset $i
		done

		unset -f ${FUNCNAME[0]}
	}
}

# Enable background color variables
ub_set_bgcolor () {
	UB_BGCOLOR_BLACK='\e[40m'
	UB_BGCOLOR_RED='\e[41m'
	UB_BGCOLOR_GREEN='\e[42m'
	UB_BGCOLOR_YELLOW='\e[43m'
	UB_BGCOLOR_BLUE='\e[44m'
	UB_BGCOLOR_PURPLE='\e[45m'
	UB_BGCOLOR_CYAN='\e[46m'
	UB_BGCOLOR_GRAY='\e[47m'

	ub_unset_bgcolor () {
		local bgcolor='UB_BGCOLOR_BLACK
		UB_BGCOLOR_RED
		UB_BGCOLOR_GREEN
		B_BGCOLOR_YELLOW
		UB_BGCOLOR_BLUE
		UB_BGCOLOR_PURPLE
		UB_BGGCOLOR_CYAN
		UB_BGCOLOR_GRAY'

		for i in $bgcolor; do
			unset $i
		done

		unset -f ${FUNCNAME[0]}
	}
}
