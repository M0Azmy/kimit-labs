<!doctype html>
<html>
<head>
<meta charset="utf-8"/>
<title>dockerlab4.4 — Colorized</title>
<style>
  body { font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, "Roboto Mono", "Courier New", monospace; background: #0f0f11; color: #e6eef3; padding: 24px; }
  .task { color: #69d2ff; font-weight: 700; margin-top: 1.2em; }
  .section { color: #7bd389; font-weight: 700; }
  .cmd { color: #a7f3a5; }            /* commands and prompts */
  .output { color: #ffd86b; }         /* command output, results */
  .id { color: #f28bdc; }             /* container/network/hashes */
  .dim { color: #8b99a6; }            /* file paths and listings */
  pre { white-space: pre-wrap; word-break: break-word; background: #071018; padding: 12px; border-radius: 6px; border: 1px solid #112; }
  .stars { color:#69d2ff; font-weight:700; }
  .explain { color:#ffd86b; font-style: italic; }
  .tableheader { color:#ffd86b; font-weight:700; }
</style>
</head>
<body>

<div class="task">Task 1 :</div>

<div class="section">1-</div>
<pre><span class="stars">***********Output of the docker network ls and docker network inspect assignment-bridge commands.**********</span>
</pre>

<pre><span class="cmd">$ docker network create assignment-bridge</span>
<span class="id">fc100f9f96ac19f387297a95bbaa5c501d0c1f387c3725eea5f670264581cf8b</span>
</pre>

<div class="section">2-</div>
<pre><span class="dim">~/kimit/kimit-labs/dockerlab4.4$</span> <span class="cmd">docker inspect assignment-bridge</span>
[
    ...
    "Subnet": <span class="output">"172.19.0.0/16"</span>,
    "Gateway": <span class="output">"172.19.0.1"</span>
]
</pre>

<div class="task">Task 2 :</div>

<div class="section">1-</div>
<pre><span class="cmd">$ docker run -d --rm --network assignment-bridge  nginx:alpine</span>
<span class="id">ed0a6253103c5ef8ded5d80e85602c7a25b85b86d84705c3adc138aba8c7d50a</span>
<span class="dim">hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$</span> <span class="cmd">docker ps</span>
<span class="tableheader">CONTAINER ID   IMAGE                        COMMAND                  CREATED         STATUS         PORTS                                       NAMES</span>
<span class="output">ed0a6253103c   nginx:alpine                 "/docker-entrypoint.Â€¦"   9 seconds ago   Up 8 seconds   80/tcp                                      recursing_hypatia</span>
</pre>

<pre><span class="cmd">docker run -d --rm --network assignment-bridge  busybox:latest sleep 3600</span>
<span class="id">3b62eda83a05555fc9f0aea1d616aaf7d7452478929c93820192a8b0a5aefee3</span>
<span class="dim">hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$</span> <span class="cmd">docker ps</span>
<span class="tableheader">CONTAINER ID   IMAGE                        COMMAND                  CREATED              STATUS              PORTS                                       NAMES</span>
<span class="output">3b62eda83a05   busybox:latest               "sleep 3600"             6 seconds ago        Up 5 seconds                                                    practical_volhard</span>
</pre>

<span class="stars">****************************** Ping results between containers for Task 3 ********************************</span>

<div class="task">Task 3:</div>
<pre><span class="cmd">$ docker exec -it practical_volhard ping recursing_hypatia</span>
<span class="output">PING recursing_hypatia (172.19.0.2): 56 data bytes
64 bytes from 172.19.0.2: seq=0 ttl=64 time=0.080 ms
64 bytes from 172.19.0.2: seq=1 ttl=64 time=0.062 ms
64 bytes from 172.19.0.2: seq=2 ttl=64 time=0.061 ms
64 bytes from 172.19.0.2: seq=3 ttl=64 time=0.079 ms</span>
</pre>

<div class="task">Task 4:</div>
<div class="section">1-</div>
<pre><span class="cmd">$ docker run -d --rm --name contaier3 nginx:alpine</span>
<span class="id">b9a4bb4f653218e5b927e461044160377fa6939711b898407a2b7d5a2a5a0958</span>

<span class="dim">$ docker ps</span>
<span class="tableheader">CONTAINER ID   IMAGE                        COMMAND                  CREATED          STATUS          PORTS                                       NAMES</span>
<span class="output">b9a4bb4f6532   nginx:alpine                 "/docker-entrypoint.Â€¦"   21 seconds ago   Up 21 seconds   80/tcp                                      contaier3</span>
</pre>

<div class="section">2-</div>
<pre><span class="cmd">$ docker exec -it contaier3 ping practical_volhard</span>
<span class="output">ping: bad address 'practical_volhard'</span>
</pre>

<div class="explain">****************************** Explanation for the behavior observed in Task 4.******************************</div>
<pre><span class="explain">It failed because they are on a different network, and no DNS in default network</span>
</pre>

<div class="task">Task 5:</div>
<div class="section">1-</div>
<pre><span class="cmd">$ docker network connect assignment-bridge contaier3</span>
</pre>

<span class="stars">****************************** Ping results between containers for Task 5. ********************************</span>
<pre><span class="cmd">$ docker exec -it contaier3 ping practical_volhard</span>
<span class="output">PING practical_volhard (172.19.0.4): 56 data bytes
64 bytes from 172.19.0.4: seq=0 ttl=64 time=0.079 ms
64 bytes from 172.19.0.4: seq=1 ttl=64 time=0.058 ms
64 bytes from 172.19.0.4: seq=2 ttl=64 time=0.092 ms</span>
</pre>

<div class="section">2-</div>
<pre><span class="cmd">$ docker network disconnect assignment-bridge contaier3</span>
<span class="dim">hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$</span> <span class="cmd">docker exec -it contaier3 ping practical_volhard</span>
<span class="output">ping: bad address 'practical_volhard'</span>
</pre>

<div class="task">Task 6:</div>
<div class="section">1-</div>
<pre><span class="cmd">$ docker stop contaier3 practical_volhard recursing_hypatia</span>
<span class="output">contaier3
practical_volhard
recursing_hypatia</span>
<span class="dim">hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$ docker ps</span>
<span class="tableheader">CONTAINER ID   IMAGE                        COMMAND                  CREATED         STATUS      PORTS                                       NAMES</span>
</pre>

<div class="section">2-</div>
<pre><span class="cmd">$ docker network rm assignment-bridge</span>
<span class="id">assignment-bridge</span>
</pre>

<hr/>
<pre><span class="stars">**********************************************************</span>
<span class="stars">**********************************************************</span>
<span class="stars">********************************************************** Bonus Task **********************************************************</span>
</pre>

<pre><span class="dim">~/kimit/kimit-labs/dockerlab4.4$</span> <span class="cmd">docker exec -it</span>
<span class="dim">dockerlab44-nginx-1    dockerlab44-sleeper-1  it-tools</span>
<span class="dim">hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$</span> <span class="cmd">docker exec -it dockerlab44-sleeper-1 sh</span>
/ # <span class="cmd">ping</span>
<span class="dim">.dockerenv  dev/        home/       lib64/      root/       tmp/        var/
bin/        etc/        lib/        proc/       sys/        usr/</span>
/ # <span class="cmd">ping dockerlab44-nginx-1</span>
<span class="output">PING dockerlab44-nginx-1 (172.19.0.3): 56 data bytes
64 bytes from 172.19.0.3: seq=0 ttl=64 time=0.145 ms
64 bytes from 172.19.0.3: seq=1 ttl=64 time=0.077 ms
64 bytes from 172.19.0.3: seq=2 ttl=64 time=0.075 ms
64 bytes from 172.19.0.3: seq=3 ttl=64 time=0.072 ms</span>
</pre>

<pre><span class="dim">:~/kimit/kimit-labs/dockerlab4.4$ docker ps</span>
<span class="tableheader">CONTAINER ID   IMAGE                        COMMAND                  CREATED         STATUS         PORTS                                       NAMES</span>
<span class="output">23d44d563911   nginx:alpine                 "/docker-entrypoint.Â€¦"   2 minutes ago   Up 2 minutes   80/tcp                                      dockerlab44-nginx-1
3405ac9afa95   busybox                      "sleep 3600"             2 minutes ago   Up 2 minutes                                               dockerlab44-sleeper-1
32ae37dbe769   corentinth/it-tools:latest   "/docker-entrypoint.Â€¦"   13 months ago   Up 6 days      0.0.0.0:30030->80/tcp, [::]:30030->80/tcp   it-tools</span>
</pre>

<pre><span class="cmd">hol@hol-Virtual-Machine:~/kimit/kimit-labs/dockerlab4.4$ docker network ls</span>
<span class="tableheader">NETWORK ID     NAME                             DRIVER    SCOPE</span>
<span class="output">1a8332e5859d   bridge                           bridge    local
d9745dcfb96a   dockerlab44_assignment-network   bridge    local</span>
</pre>

<div class="section">**** Docker compose file ****</div>
<pre>
<span class="cmd">services:</span>
    <span class="cmd">nginx:</span>
        <span class="cmd">image: nginx:alpine</span>
        <span class="cmd">networks:</span>
            - <span class="cmd">assignment-network</span>
    
    <span class="cmd">sleeper:</span>
        <span class="cmd">image: busybox</span>
        <span class="cmd">command: ["sleep", "3600"]</span>
        <span class="cmd">networks:</span>
            - <span class="cmd">assignment-network</span>
<span class="cmd">networks:</span>
    <span class="cmd">assignment-network:</span>
        <span class="cmd">driver: bridge</span>
</pre>

</body>
</html>