## Connect with Me

- **YouTube**: [Watch and Learn on YouTube](https://www.youtube.com/watch?v=6xsKwaMETAQ)  
- **LinkedIn**: [Connect with me on LinkedIn](https://www.linkedin.com/in/ashokkumar-devops13/)  
- **TopMate**: [Support or Consult on TopMate](https://topmate.io/ashok_kumar)  

## Support This Project

If you find this content helpful:
- **Like** the [YouTube video](https://www.youtube.com/watch?v=6xsKwaMETAQ) for more such tutorials.
- **Like** the [YouTube video](https://www.youtube.com/watch?v=rxb9YWyL8kE) for more such tutorials.
- **Star** this GitHub repository to get the latest updates.




# Git

### **1. Setup and Configuration**

### **git init**

Initializes a new Git repository in your project folder.

```bash

git init

```

### **git config**

Sets configuration values like username, email, etc.

```bash

# Set global username
git config --global user.name "Your Name"

# Set global email
git config --global user.email "your.email@example.com"

# View all configuration
git config --list

```

---

### **2. Working with Repositories**

### **git clone**

Clones a remote repository to your local machine.

```bash

git clone https://github.com/username/repository.git

```

### **git remote**

Manages remote repository references.

```bash

# View all remotes
git remote -v

# Add a new remote repository
git remote add origin https://github.com/username/repository.git

# Remove a remote
git remote remove origin

```

---

### **3. Basic Git Workflow**

### **git status**

Shows the current state of the working directory and staging area.

```bash

git status

```

### **git add**

Stages changes (adds them to the staging area) for the next commit.

```bash

# Add a specific file to staging
git add file_name.txt

# Add all changed files
git add .

```

### **git commit**

Commits the staged changes with a message.

```bash

# Commit staged changes with a message
git commit -m "Commit message here"

```

### **git log**

Displays the commit history.

```bash
# View all commits
git log

# View a simplified one-line log
git log --oneline

```

### **git push**

Pushes the committed changes to the remote repository.

```bash

# Push to the default remote (origin) and branch
git push origin main

```

### **git pull**

Fetches and integrates changes from the remote repository to your local branch.

```bash

git pull origin main

```

---

### **4. Branching and Merging**

### **git branch**

Manages branches in the repository.

```bash

# List all branches
git branch

# Create a new branch
git branch new_feature

# Switch to a branch
git checkout new_feature

# Create and switch to a new branch
git checkout -b new_feature

```

### **git merge**

Merges one branch into the current branch.

```bash
# Merge the 'new_feature' branch into the current branch
git merge new_feature

```

### **git checkout**

Switches branches or restores files.

```bash

# Switch to an existing branch
git checkout main

# Restore a file to its last committed state
git checkout -- file_name.txt

```

### **git rebase**

Reapplies commits on top of another base branch (linear history).

```bash

# Rebase your feature branch onto the main branch
git checkout new_feature
git rebase main

```

---

### **5. Undoing Changes**

### **git reset**

Resets your working directory to a previous commit or state.

```bash

# Unstage changes but keep the changes in your working directory
git reset HEAD file_name.txt

# Reset to a previous commit (hard reset will lose changes)
git reset --hard commit_hash

```

### **git revert**

Creates a new commit that reverses the changes from a previous commit.

```bash

# Revert a specific commit
git revert commit_hash

```

---

### **6. Stashing Changes**

### **git stash**

Temporarily saves your work without committing.

```bash

# Save your current changes
git stash

# View stash list
git stash list

# Apply the most recent stash
git stash apply

# Drop (delete) the most recent stash
git stash drop

# Apply and drop stash in one command
git stash pop

```

---

### **7. Collaboration and Sharing**

### **git fetch**

Downloads commits, files, and refs from a remote repository.

```bash

# Fetch from the origin (but don't merge)
git fetch origin

```

### **git push**

Uploads your changes to a remote repository.

```bash

# Push to the remote repository 'origin' on branch 'main'
git push origin main

```

### **git pull**

Fetches from the remote repository and merges the changes into the current branch.

```bash

git pull origin main

```

### **git remote**

Manages remote repository connections.

```bash

# Add a remote repository
git remote add origin https://github.com/username/repo.git

# Remove a remote repository
git remote remove origin

```

---

---

### **9. Git Logs and Diff**

### **git log**

Displays commit logs.

```bash

# View commit history
git log

# View a simplified commit log
git log --oneline

```

### **git diff**

Shows differences between commits, branches, or the working directory.

```bash

# Show changes between working directory and staging area
git diff

# Show changes between commits
git diff commit1 commit2

# Show changes between branches
git diff branch1 branch2

```

---

### **10. Cleaning Up**

### **git clean**

Removes untracked files from the working directory.

```bash

# Remove untracked files (dry run)
git clean -n

# Remove untracked files (actual removal)
git clean -f

```

---

### **11. Advanced Commands**

### **git cherry-pick**

Apply the changes from one or more existing commits onto the current branch.

```bash
# Cherry-pick a commit
git cherry-pick commit_hash

```

### **git rebase**

Reapply commits on top of another base branch.

```bash

# Rebase your current branch onto another branch
git rebase main

```

---

### **Common Workflows**

### **Creating a new repository**

1. Initialize a repository locally:
    
    ```bash
    
    git init
    git add .
    git commit -m "Initial commit"
    
    ```
    
2. Link the remote repository and push:
    
    ```bash
    
    git remote add origin https://github.com/username/repo.git
    git push -u origin main
    
    ```
    

### **Forking a repository and making changes**

1. Fork a repository from GitHub.
2. Clone your fork:
    
    ```bash
    
    git clone https://github.com/your-username/repository.git
    
    ```
    
3. Make changes, commit, and push:
 ```bash
git add .
git commit -m "Made some changes"
git push origin main
    
    ```