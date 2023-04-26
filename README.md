# 🦄 Unicorn
## What is Unicorn?!
Unicorn is a collection of functions and variables one can use to make your Bash script output super-duper-pretty!

![preview](/docs/img/preview.png)

## Project goals and vision
Unicorn is build upon three pillars of foundation;

1. Thou shall K.I.S.S.
1. Thou shall aim to be as easy to use as possible
1. Thou shall not pollute thy environment

Anything breaking these rules are an automatic; nope!

## Examples
### Logging very fancy script status
#### The script
```bash
#!/bin/bash
#
source unicorn.sh

genrand_and_divise () {
	num=$RANDOM

	sleep 3

	if [[ $((num % 2)) -eq 0 ]]; then
		echo '1'
	else
		echo '0'
	fi
}

ub_l1_info 'I am going to do something really cool now!'
ub_l1_conf_await 'Checking if random number is divisable by two... '

return=$(genrand_and_divise)

if [[ $return -eq 1 ]]; then
	ub_l0_end 'Done'
else
	ub_l0_end ''
	ub_l2_warn_replace 'Something has gone terribly wrong!'
fi
```

#### Output
While it is still "processing".
```bash
-> I am going to do something really cool now!
>> Checking if random number is divisable by two...
```

When the random number is divisable by two.
```bash
-> I am going to do something really cool now!
>> Checking if random number is divisable by two... Done
```

When the random number is not divisable by two.
```bash
-> I am going to do something really cool now!
<!> Something has gone terribly wrong!
```

## Usage
### logging
The main purpose of Unicorn is to provide pretty logging.

Logs are divided in to levels;
- Level 0 `l0` is exclusively used for making minor alterations to printed lines, it does not insert any additional characters.
- Level 1 `l1` and level 2 `l2` are functionally identical, levels are used to visually show a relationship between parent and child elements. For example the starting character of `ub_l1_err` is a `#>` and for `ub_l2_err` it is a `<#>`.

All log items follow the same naming convention, ub-_level_-_type_-_variant_, the plain type being a semi-exception for it is empty and not explicitely defined.

There are four types of logs; plain, info `info`, warning `warn` and error `err`.

A plain type is always level 0, it does not alter the provided text in any way. `ub_l0_await` and `ub_l0_end` being two examples.

Info, warning and error types are always available in both level 1 and level 2 variants. Some examples being `ub_l1_info_await`, `ub_l2_err_replace` and `ub_l1_conf`.

#### Variants
Here is a list of available variants;

| Variant | About |
| --- | --- |
| _undefined_ | Functions for which no variant is defined will print a full line and insert a new line |
| `_await` | Functions of the await variant will not insert a new line, instead awaiting a manual termination by another program or build-in |
| `_replace` | Functions of the replace variant will replace the previous line and insert a new line, do not forget to terminate `_await` variants before replacing them |
| `_end` | Functions of the end variant are exclusively found in level 0, they print a full line and insert a new line, usefull as a shortcut for terminating `_await` |

#### Examples
> **Note** The examples are all nicely formated using quotes, however you are not required to do so. Feel free to use `ub_l1_info Hello, World!` for this is also syntactically valid.
```bash
ub_l1_info 'Hello, World!'

### This would output
# -> Hello, World!
```

```bash
ub_l2_warn_await 'Done in a few moments... '
sleep 10
ub_l0_end 'Done'

### This would initially output
# <!> Done in a few monents...
#
### And a few seconds later one the sleep is done
# <!> Done in a few monents... Done
```

```bash
ub_l2_info_await 'Done in a few moments... '
sleep 10

if [[ $? -eq 0 ]]; then
    ub_l0_end ''
    ub_l2_err_replace 'I overslept!'
else
    ub_l0_end 'Done'
fi

### Initially it will output this
# --> Done in a few moments...
#
# But once it hits the if block this will be overwritten to this
# <#> I overslept!
```

### Actions
There are a hand full of commonly performed actions available, such as checking if the user is root with `ub_quit_if_no_suid`.

Actions all follow the `ub_quit` and `ub_warn` pattern.

### Variables
Variables are not loaded in by default to avoid poluting the environment, they have to be requested using a `ub_set` command.

For example `ub_set_color` to set the default bash text colors as enviroment variables.

These are the available colors for `ub_set_color`.

```
UB_COLOR_BLACK='\e[30m'
UB_COLOR_RED='\e[31m'
UB_COLOR_GREEN='\e[32m'
UB_COLOR_YELLOW='\e[33m'
UB_COLOR_BLUE='\e[34m'
UB_COLOR_PURPLE='\e[35m'
UB_COLOR_CYAN='\e[36m'
UB_COLOR_GRAY='\e[37m'
```

`ub_set_bgcolor` follows the same pattern

```
UB_BGCOLOR_BLACK='\e[40m'
UB_BGCOLOR_RED='\e[41m'
UB_BGCOLOR_GREEN='\e[42m'
UB_BGCOLOR_YELLOW='\e[43m'
UB_BGCOLOR_BLUE='\e[44m'
UB_BGCOLOR_PURPLE='\e[45m'
UB_BGCOLOR_CYAN='\e[46m'
UB_BGCOLOR_GRAY='\e[47m'
```

Colors can be unset using the `ub_unset` command, for example `ub_unset_color`. The unset command is only available after having enabled the variables and it will be unset again after having been unset.
