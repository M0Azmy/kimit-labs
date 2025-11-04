Task 1 :

1-
hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$ docker network create assignment-bridge
fc100f9f96ac19f387297a95bbaa5c501d0c1f387c3725eea5f670264581cf8b

2-
~/kimit/kimit-labs/dockerlab4.4$ docker inspect assignment-bridge 
[
    {
        "Name": "assignment-bridge",
        "Id": "fc100f9f96ac19f387297a95bbaa5c501d0c1f387c3725eea5f670264581cf8b",
        "Created": "2025-11-04T08:37:23.17276692+02:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {




                    "Subnet": "172.19.0.0/16",
                    "Gateway": "172.19.0.1"




                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]


Task 2 :

1-
$ docker run -d --rm --network assignment-bridge  nginx:alpine 
ed0a6253103c5ef8ded5d80e85602c7a25b85b86d84705c3adc138aba8c7d50a
hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$ docker ps
CONTAINER ID   IMAGE                        COMMAND                  CREATED         STATUS         PORTS                                       NAMES
ed0a6253103c   nginx:alpine                 "/docker-entrypoint.…"   9 seconds ago   Up 8 seconds   80/tcp                                      recursing_hypatia


 docker run -d --rm --network assignment-bridge  busybox:latest sleep 3600
3b62eda83a05555fc9f0aea1d616aaf7d7452478929c93820192a8b0a5aefee3
hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$ docker ps
CONTAINER ID   IMAGE                        COMMAND                  CREATED              STATUS              PORTS                                       NAMES
3b62eda83a05   busybox:latest               "sleep 3600"             6 seconds ago        Up 5 seconds                                                    practical_volhard

Task 3:
$ docker exec -it practical_volhard ping recursing_hypatia
PING recursing_hypatia (172.19.0.2): 56 data bytes
64 bytes from 172.19.0.2: seq=0 ttl=64 time=0.080 ms
64 bytes from 172.19.0.2: seq=1 ttl=64 time=0.062 ms
64 bytes from 172.19.0.2: seq=2 ttl=64 time=0.061 ms
64 bytes from 172.19.0.2: seq=3 ttl=64 time=0.079 ms


Task 4:
1-
$ docker run -d --rm --name contaier3 nginx:alpine 
b9a4bb4f653218e5b927e461044160377fa6939711b898407a2b7d5a2a5a0958

$ docker ps
CONTAINER ID   IMAGE                        COMMAND                  CREATED          STATUS          PORTS                                       NAMES
b9a4bb4f6532   nginx:alpine                 "/docker-entrypoint.…"   21 seconds ago   Up 21 seconds   80/tcp                                      contaier3

2-
$ docker exec -it contaier3 ping practical_volhard
ping: bad address 'practical_volhard'

It failed because they are on a different network, and no DNS in default network

Task 5:
1-
$ docker network connect assignment-bridge contaier3 

$ docker exec -it contaier3 ping practical_volhard
PING practical_volhard (172.19.0.4): 56 data bytes
64 bytes from 172.19.0.4: seq=0 ttl=64 time=0.079 ms
64 bytes from 172.19.0.4: seq=1 ttl=64 time=0.058 ms
64 bytes from 172.19.0.4: seq=2 ttl=64 time=0.092 ms


2-
$ docker network disconnect assignment-bridge contaier3 
hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$ docker exec -it contaier3 ping practical_volhard
ping: bad address 'practical_volhard'

Task 6:
1-
$ docker stop contaier3 practical_volhard recursing_hypatia
contaier3
practical_volhard
recursing_hypatia
hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$ docker ps
CONTAINER ID   IMAGE                        COMMAND                  CREATED         STATUS      PORTS                                       NAMES

2-
$ docker network rm assignment-bridge 
assignment-bridge

**********************************************************
**********************************************************

Bonus Task :

~/kimit/kimit-labs/dockerlab4.4$ docker exec -it 
dockerlab44-nginx-1    dockerlab44-sleeper-1  it-tools               
hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$ docker exec -it dockerlab44-sleeper-1 sh
/ # ping 
.dockerenv  dev/        home/       lib64/      root/       tmp/        var/
bin/        etc/        lib/        proc/       sys/        usr/
/ # ping dockerlab44-nginx-1
PING dockerlab44-nginx-1 (172.19.0.3): 56 data bytes
64 bytes from 172.19.0.3: seq=0 ttl=64 time=0.145 ms
64 bytes from 172.19.0.3: seq=1 ttl=64 time=0.077 ms
64 bytes from 172.19.0.3: seq=2 ttl=64 time=0.075 ms
64 bytes from 172.19.0.3: seq=3 ttl=64 time=0.072 ms


:~/kimit/kimit-labs/dockerlab4.4$ docker ps
CONTAINER ID   IMAGE                        COMMAND                  CREATED         STATUS         PORTS                                       NAMES
23d44d563911   nginx:alpine                 "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   80/tcp                                      dockerlab44-nginx-1
3405ac9afa95   busybox                      "sleep 3600"             2 minutes ago   Up 2 minutes                                               dockerlab44-sleeper-1
32ae37dbe769   corentinth/it-tools:latest   "/docker-entrypoint.…"   13 months ago   Up 6 days      0.0.0.0:30030->80/tcp, [::]:30030->80/tcp   it-tools
hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$ docker network ls
NETWORK ID     NAME                             DRIVER    SCOPE
1a8332e5859d   bridge                           bridge    local
d9745dcfb96a   dockerlab44_assignment-network   bridge    local


**** Docker compose file ****
services:
    nginx:
        image: nginx:alpine
        networks:
            - assignment-network
    
    sleeper:
        image: busybox
        command: ["sleep", "3600"]
        networks:
            - assignment-network    
networks:
    assignment-network:
        driver: bridge

