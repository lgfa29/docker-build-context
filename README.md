# docker-build-context

Exemplo de como buildar uma imagem Docker carregando um arquivo como contexto.

Sem carregar o contexto apropriado, o comando de build irá falhar:

```console
$ docker build .
[+] Building 0.9s (7/7) FINISHED
 => [internal] load build definition from Dockerfile                                                              0.0s
 => => transferring dockerfile: 36B                                                                               0.0s
 => [internal] load .dockerignore                                                                                 0.0s
 => => transferring context: 2B                                                                                   0.0s
 => [internal] load metadata for docker.io/library/busybox:latest                                                 0.7s
 => [auth] library/busybox:pull token for registry-1.docker.io                                                    0.0s
 => [internal] load build context                                                                                 0.0s
 => => transferring context: 2B                                                                                   0.0s
 => [1/2] FROM docker.io/library/busybox@sha256:5acba83a746c7608ed544dc1533b87c737a0b0fb730301639a0179f9344b1678  0.0s
 => ERROR [2/2] COPY hello.txt /                                                                                  0.0s
------
 > [2/2] COPY hello.txt /:
------
failed to compute cache key: "/hello.txt" not found: not found
```

Mas se carregarmos o arquivo de contexto o build funciona:

```console
$ docker build - < context.tar.gz
[+] Building 0.4s (6/6) FINISHED
 => CACHED [internal] load remote build context                                                                   0.0s
 => CACHED copy /context /                                                                                        0.0s
 => [internal] load metadata for docker.io/library/busybox:latest                                                 0.3s
 => [1/2] FROM docker.io/library/busybox@sha256:5acba83a746c7608ed544dc1533b87c737a0b0fb730301639a0179f9344b1678  0.0s
 => CACHED [2/2] COPY hello.txt /                                                                                 0.0s
 => exporting to image                                                                                            0.0s
 => => exporting layers                                                                                           0.0s
 => => writing image sha256:0d2eb96b643d5ede03c36c0d9039cdfe5e58559fb1c8ec7faace80aef8ced58f                      0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
```

Para listar o conteúdo do arquivo de contexto:

```console
$ tar -tzf context.tar.gz
Dockerfile
hello.txt
```
