# Firewall Configuration

## What I Did

I installed UFW, allowed SSH only from a specific IP, allowed HTTP (port 80) and port 8000, then enabled the firewall and checked that the rules were correct.

## Commands Used

Replace `YOUR_OFFICE_OR_HOME_IP` with the one IP you want to allow SSH from (e.g. your office or home public IP). If you lock SSH to one IP and you’re not on that IP, you’ll get locked out, so either do this from that IP or keep a console/serial access.

```bash
# Install UFW
sudo apt update
sudo apt install ufw -y

# Defaults
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH only from a specific IP
sudo ufw allow from YOUR_OFFICE_OR_HOME_IP to any port 22

# Allow HTTP and port 8000
sudo ufw allow 80/tcp
sudo ufw allow 8000/tcp

# Enable firewall
sudo ufw enable
```

## Verification

```bash
# Check status and rules
sudo ufw status verbose
# or
sudo ufw status numbered
```

You should see:

- SSH (22) allowed only from the IP you set.
- 80/tcp and 8000/tcp allowed.
- UFW active.

Test from another machine: SSH from the allowed IP should work; SSH from a different IP should be refused. Browsing to `http://server_ip:8000` and `http://server_ip:80` (if you use 80) should work.

## Note

If you’re testing from a changing IP (e.g. home broadband), you can temporarily allow your current IP for SSH, then add the permanent rule once you know the right IP, or use a VPN so you always come from one address. Just don’t enable UFW with only one SSH-allowed IP unless you’re sure you’re on that IP or have another way in.
