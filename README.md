update at 4/15/2023 23:00 CST

[original repo](https://github.com/Significant-Gravitas/Auto-GPT)

# ATTENTION PLZ

**Exposing the public IP address and port of your server to the Internet is highly risky!**

# Auto-GPT-gotty: run Auto-GPT in docker

This repo just for usage by docker, and use gotty convert CLI into a web interface, allowing users to access and control command-line programs via a web browser on any device.

## Setting Step

1. Because the original repo is not stable, clone this repo to a specific commit ID
    ```shell
    $ git clone https://github.com/HRXWEB/Auto-GPT-gotty.git
    $ cd 'Auto-GPT-gotty'
    $ git checkout e986af5de0f1bd933f6c936c3674301c80f6c91f
    ```

2. update `.env.template`, set `OPENAI_API_KEY` and more **KEY**, which can be found in [original repo](https://github.com/Significant-Gravitas/Auto-GPT)

3. build this into a docker image and run it. User can access this service by typing <host_ip>:<host_port> in web broswer
    ```shell
    $ docker build -t autogpt .
    $ docker run -d --env-file=./.env -v $PWD/auto_gpt_workspace:/app/auto_gpt_workspace -p <host_port>:8080 autogpt
    ```