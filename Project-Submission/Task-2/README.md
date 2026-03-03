# Docker Installation & Web App Deployment

## What I Did

I installed Docker on Ubuntu, wrote a simple HTML page, put it in a Dockerfile that uses nginx, built the image, and ran the container so the app is reachable at server_ip:8000 in the browser.

## Dockerfile

The Dockerfile uses the nginx Alpine image, copies our index.html into the default nginx web root, and runs nginx. Nginx listens on 80 inside the container; we map that to 8000 on the host when we run the container.

See the `Dockerfile` file in this folder for the full content.

## index.html

A basic HTML page that shows a title and a short message so we can confirm the app is serving. It lives in the same folder as the Dockerfile and gets copied into the image. See `index.html` in this folder.

## Commands Used

**Install Docker on Ubuntu:**

```bash
sudo apt update
sudo apt install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release 2>/dev/null || . /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker $USER
# Log out and back in (or newgrp docker) so docker runs without sudo
```

*(If the above repo setup fails, the official Docker docs for "Install on Ubuntu" have the exact lines for your Ubuntu version.)*

**Build and run (from the folder that has Dockerfile and index.html):**

```bash
# Build the image
docker build -t my-nginx-app .

# Run the container, map host port 8000 to container port 80
docker run -d -p 8000:80 --name webapp my-nginx-app
```

**Check it’s running:**

```bash
docker ps
```

Then open a browser and go to `http://server_ip:8000`. You should see the index.html page.

## Summary

Docker is installed, the custom index.html is in the image, the Dockerfile uses nginx, and the container is started with port 8000 on the server pointing to the app. So the app is accessible at server_ip:8000.
