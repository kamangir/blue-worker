# blue-worker

`blue-worker` is an [ec2](https://aws.amazon.com/ec2/) cloud worker and an [`awesome-bash-cli`](https://github.com/kamangir/awesome-bash-cli) (`abcli`) [plugin](https://github.com/kamangir/blue-plugin).

![image](./assets/marquee.jpg)

---

To start a `blue-worker` open an `abcli` terminal and type in,

```bash
abcli instance from_image - - ssh
abcli cookie copy worker
abcli session start
```

## jobs

To submit a `<command-line>` as a job type in,

```bash
abcli job submit - "<command-line>"
```

Or, write a script in python or bash, and then submit it as a job, 

```bash
abcli select
abcli script [python]

# write the python or bash script in the editor that opens.

abcli script submit . [<tags>]
```

## works

`works` cover activities that occur regularly, such as maintenance, and are maintained in [`./.abcli/works/*.sh`](./.abcli/works/).