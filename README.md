# 🦄 Unicorn
## What is Unicorn?!
Unicorn is a collection of functions and variables one can use to make your Bash script output super-duper-pretty!

## Project goals
Unicorn is build upon three pillars of foundation;

1. Thou shall K.I.S.S.
1. Thou shall aim to be as easy to use as possible
1. Thou shall not pollute thy environment

Anything breaking these rules are an automatic; nope!

## Examples
### Logging vewwy fancy script status :3
#### The script (Super fancy!)
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
	ub_l2_err_replace 'Something has gone terribly wrong!'
fi
```

#### Output (WOW!)
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
