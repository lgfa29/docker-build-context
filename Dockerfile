FROM busybox

COPY hello.txt /
CMD ["cat", "/hello.txt"]
