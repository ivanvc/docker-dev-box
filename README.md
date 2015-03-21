Docker dev machine, based on nitrous'.

To run:

```
docker build -t ivan/dev-machine:latest .
docker run -i -t -d -e GITHUB_USERNAME=<your github username> ivan/dev-machine:latest
docker ps <CID>
ssh -p <port> dev@<ip>
```
