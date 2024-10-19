# Github ssh access
- [Github ssh access](#github-ssh-access)
    - [Generate SSH Key](#generate-ssh-key)
- [Linking GitHub to a key](#linking-github-to-a-key)
    - [--\> On your Terminal Window](#---on-your-terminal-window)
    - [--\> Make a GitHub Repo](#---make-a-github-repo)
  - [Task: Re-create SSH setup to authenticate to GitHub](#task-re-create-ssh-setup-to-authenticate-to-github)
    - [Delete test repo and SSH key.](#delete-test-repo-and-ssh-key)
    - [Use a pre-existing repo, and switch it over to use SSH keys](#use-a-pre-existing-repo-and-switch-it-over-to-use-ssh-keys)
  

### Generate SSH Key
1. Run the following command to generate a new SSH key:
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```
2. When prompted for a file to save the key, press **Enter** to use the default location (`~/.ssh/id_rsa`).
3. Optionally, enter a **passphrase** for added security.

# Linking GitHub to a key
1. Generate a new SSH key.
2. Print the **public** key using `cat`. This will be given to GitHub.
3. Navigate to your **Settings** on GitHub.
   ![diagram](/images/github-settings.png)
4. Find **SSH Keys and GPG keys** and add **New SSH key**.
   ![diagram](/images/add-ssh-key.png)
5. Name the key appropriately.
6. Insert what you printed and save.
 
### --> On your Terminal Window


1. `eval ssh-agent -s` the ssh agent that gives us a pid (process id). The response will look like = `agent pid 764`
1. `ssh-add` your `private key`. This will add your identity.
2. **Test** your connection to GitHub using `ssh -T git@github.com`.
3. You will either get a prompt to then type `yes`, or it will say you're successfuly authenticated. This works **ANYWHERE** in your directory.
 
### --> Make a GitHub Repo
1. Once created, change quick setup option from **HTTPS** to **SSH**.
2. Follow the GitHub instructions on the page, ensuring that the GitHub link does **NOT** start with **HTTPS**.


![diagram](/images/Screenshot_github_ssh.png)


## Task: Re-create SSH setup to authenticate to GitHub
 
### Delete test repo and SSH key.
### Use a pre-existing repo, and switch it over to use SSH keys

1. Navigate to a current active github repo on the local machine already connected with the remote repo.
 
2. Run the `git remote -v` command to display the connection type of my Git repository. This command lists all configured remote repositories along with their URLs, which helps me see if my repository is connected via HTTPS or SSH. If the URL starts with `https://`, it’s using an HTTPS connection. If it starts with `git@` (e.g., git@github.com:username/repo.git), it’s using SSH.
 
```bash
git remote -v
```
 
7. Within the Github repo there is a **Code** drop down that proviides the SSH origin connection. Run the below command accompanied with the SSH connection to switch origin from HTTPS to SSH. *Note: The command must be ran in whilst within the local repo*.
 
```bash
git remote set-url origin git@github.com:raiyans/tech264-test-git.git
```