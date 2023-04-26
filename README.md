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
The script.
```bash
#!/bin/bash
#
source unicorn.sh

genrand_and_devise () {
	num=$RANDOM

	sleep 3

	if [[ $((num % 2)) -eq 0 ]]; then
		echo '1'
	else
		echo '0'
	fi
}

ub_l1_info 'I am going to do something really cool now!'
ub_l1_conf_await 'Checking if random number is devisable by two... '

return=$(genrand_and_devise)

if [[ $return -eq 1 ]]; then
	ub_l0_end 'Done'
else
	ub_l0_end ''
	ub_l2_err_replace 'Something has gone terribly wrong!'
fi
```
The output on run;
![alt text](/docs/img/run.png)

The output on success;
![alt text](/docs/img/done.png)

The output on fail;
![alt text](/docs/img/error.png)
