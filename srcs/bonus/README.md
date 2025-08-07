# Bonus Part

This bonus extends P3 by migrating from GitHub to a local GitLab instance.

## Setup

1. Run the GitLab setup script:
   ```bash
   ./gitlab-setup.sh
   ```

2. Create a GitLab repository manually via the UI at `MachineIP:8082`

3. Migrate the GitHub repository to GitLab:
   ```bash
   ./update_repo.sh
   ```

## Usage

After setup, you can deploy changes by pushing to GitLab. ArgoCD will detect changes within ~3 minutes.

**Note:** Use `sudo` for git commands to utilize the `.netrc` file:

```bash
sudo git add .
sudo git commit -m "Update from GitHub repo"
sudo git push
```