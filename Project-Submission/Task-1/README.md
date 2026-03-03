# Server Setup & SSH Configuration

## What I Did

I set up an Ubuntu server and configured SSH so I could log in without typing a password every time. The main steps were: install OpenSSH, generate an SSH key pair on my laptop, copy the public key to the server, and then turn off password login so only key-based auth works.

## Commands Used

**On the Ubuntu server (or during initial setup):**

```bash
# Update packages
sudo apt update

# Install OpenSSH server
sudo apt install openssh-server -y

# Make sure the service is running
sudo systemctl start ssh
sudo systemctl enable ssh

# Check status
sudo systemctl status ssh
```

**On my local machine (where I connect from):**

```bash
# Generate SSH key pair (press Enter for default path, optionally set a passphrase)
ssh-keygen -t ed25519 -C "my-email@example.com"

# Copy public key to the server (replace user and server_ip with your details)
ssh-copy-id username@server_ip
```

If `ssh-copy-id` isn't available:

```bash
cat ~/.ssh/id_ed25519.pub | ssh username@server_ip "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
```

**On the server again – lock down to key-only (optional but recommended):**

```bash
sudo nano /etc/ssh/sshd_config
```

Set or uncomment:

```
PasswordAuthentication no
PubkeyAuthentication yes
```

Then restart SSH:

```bash
sudo systemctl restart ssh
```

## How I Verified Passwordless Login

1. From my laptop I ran: `ssh username@server_ip`
2. I did not get asked for a password and landed straight in a shell on the server.
3. I also tested from another machine that doesn’t have my private key – the connection was refused or asked for a password (which fails if you disabled it), so only the machine with the key can log in.

That’s how I confirmed key-based login works and that password login is no longer used.
