1. **Scenario 1: Undoing a Pushed Commit Without Affecting Other Users' History**
    
    You pushed a faulty commit to a shared branch. How can you fix the mistake without rewriting history?
    
    - Use `git revert` to create a new commit that negates the previous one.
    - **Example**:
        
        ```bash
        
        git revert <commit-hash>
        git push origin main
        
        ```
        
    - `git revert` creates a new commit that undoes the changes of the specified commit. This approach is safe for shared branches because it preserves the history.

---

**Scenario 2: Accidental Deletion of a Branch**

- You accidentally deleted a local branch. How do you recover it?
- If the branch has been pushed to the remote, you can fetch it. If not, find the commit hash in the reflog and recreate it.
- **Example**:
    
    ```bash
    
    git reflog
    git checkout -b recovered-branch <commit-hash>
    
    ```
    

---

**Scenario 3: Resolving a Conflict While Rebasing**

- During a rebase, you encounter conflicts. How do you resolve them and continue the rebase?
- 
    
    ```bash
    
    git status  # Shows conflicting files
    git add resolved-file.txt
    git rebase --continue
    
    ```
    

---

**Scenario 4: Squashing Commits in a Feature Branch**

- How would you squash multiple commits in a feature branch into a single commit before merging to `main`?
- Use interactive rebase:
    
    ```bash
    
    git checkout feature-branch
    git rebase -i main
    
    ```
    
- Mark commits as `squash` or `s` except for the first one.

---

**Scenario 5: Fixing a Commit Message After Pushing**

- How can you correct a commit message that was already pushed to the remote branch?
- 
    
    ```bash
    
    git commit --amend -m "Correct message"
    git push --force
    
    ```
    

---

### **Jenkins Scenario-Based Questions**

**Scenario 1: Restarting a Failed Build at a Specific Stage**

- How can you configure a pipeline to restart from the failed stage instead of starting from the beginning?
- Use **checkpointing** with `options { skipStagesAfterUnstable() }` or a **stage-level restartable flag**.
- **Declarative Example**:
    
    ```groovy
    
    pipeline {
        options {
            skipStagesAfterUnstable()
        }
        stages {
            stage('Build') {
                steps {
                    sh 'make build'
                }
            }
            stage('Test') {
                steps {
                    sh 'make test'
                }
            }
        }
    }
    
    ```
    

---

**Scenario 2: Automating Agent Selection for Specific Jobs**

- **Question**: How can you ensure that a build runs only on specific agents with certain labels?
- Use a `label` in the `agent` section.
- **Example**:
    
    ```groovy
    
    pipeline {
        agent { label 'linux-agent' }
        stages {
            stage('Build') {
                steps {
                    sh 'build.sh'
                }
            }
        }
    }
    
    ```
    

---

**Scenario 3: Handling Long-Running Builds with Timeouts**

- How can you ensure that a pipeline job automatically stops if it takes too long?
- Use the `timeout` step.
- **Example**:
    
    ```groovy
    
    timeout(time: 30, unit: 'MINUTES') {
        sh 'long_running_task.sh'
    }
    
    ```
    

---

**Scenario 4: Securely Managing Credentials in a Pipeline**

- How can you use credentials stored in Jenkins without exposing them?
- Use `withCredentials` to manage secrets.
- **Example**:
    
    ```groovy
    
    withCredentials([string(credentialsId: 'my-credential-id', variable: 'SECRET_KEY')]) {
        sh 'echo $SECRET_KEY'
    }
    
    ```
    

---

**Scenario 5: Triggering a Downstream Job with Parameters**

- How do you trigger another Jenkins job and pass parameters to it from a pipeline?
- Use `build` step.
- **Example**:
    
    ```groovy
    
    build job: 'downstream-job', parameters: [string(name: 'BRANCH', value: 'main')]
    
    ```
    

### **Git**

1. **How do you resolve a merge conflict in Git?**
    - Identify conflicting files using `git status`. Edit the files to manually fix conflicts marked by `<<<<<<<`, `=======`, and `>>>>>>>`. Add resolved files with `git add` and complete the merge with `git commit`.
    - **Example**:
        
        ```bash
        
        git merge feature-branch
        # Edit conflicts in file
        git add resolved-file.txt
        git commit -m "Resolved merge conflict"
        
        ```
        
2. **Explain the difference between `git rebase` and `git merge`.**
    - `git merge` combines branches and retains all commits, while `git rebase` integrates changes from another branch by rewriting commit history.
    - **Example**:
        
        ```bash
        
        git checkout feature
        git rebase main
        ```
        
3. **What is `git cherry-pick`, and when would you use it?**
    - `git cherry-pick` applies a specific commit from another branch.
    - **Example**:
        
        ```bash
        
        git cherry-pick abc123
        
        ```
        
4. **Explain `git stash apply` vs `git stash pop`.**
    - `git stash apply` re-applies stashed changes but keeps them in the stash, while `git stash pop` applies and removes them from the stash.
5. **How do you remove a remote branch in Git?**
    - **Answer**: Use `git push <remote-name> --delete <branch-name>`.
    - **Example**:
        
        ```bash
        
        git push origin --delete feature-branch
        
        ```
        
6. **What is the difference between `git reset` and `git revert`?**
    - `git reset` moves the branch pointer and changes history, while `git revert` creates a new commit to undo changes.
7. **Explain shallow cloning in Git.**
    
     Shallow cloning (`-depth=1`) clones only the latest history.
    
    - **Example**:
        
        ```bash
        
        git clone --depth=1 https://github.com/repo.git
        
        ```
        
8. **How do you fix a commit with the wrong message after pushing?**
    - 
        
        ```bash
        
        git commit --amend -m "New message"
        git push --force
        
        ```
        
9. **What are Git hooks, and give an example?**
    - Git hooks are custom scripts triggered by Git actions. They allow you to automate tasks and enforce policies during the development process.
    - **Example**:
    - `pre-commit`: Runs before a commit is made.
    - `commit-msg`: Validates the commit message format.
    - `post-merge`: Runs after a merge operation.
10. **How do you squash commits using Git?**
    - Use interactive rebase with `git rebase -i HEAD~n` and mark commits as `squash`.

---

### **Jenkins**

1. **Explain the Jenkins pipeline syntax and difference between Declarative and Scripted pipelines.**
    - Declarative is simpler and structured (`pipeline {}`), while Scripted is flexible (`node {}`).
2. **How do you set up Jenkins for distributed builds?**
    - Configure **Jenkins agents** via SSH or JNLP.
3. **How to use `input` step in a pipeline for manual approval?**
    - **Example**:
        
        ```groovy
        
        input message: 'Deploy to production?', ok: 'Deploy'
        
        ```
        
4. **How do you secure Jenkins?**
    - Use role-based access, HTTPS, and credential management.
5. **Explain Blue Ocean in Jenkins.**
    - Blue Ocean provides a modern, visual pipeline UI for Jenkins.
6. **What are Jenkinsfile parameters? Give an example.**
    - **Example**:
        
        ```groovy
        
        parameters {
            string(name: 'BRANCH', defaultValue: 'main')
        }
        
        ```
        
7. **How do you store and retrieve credentials in Jenkins?**
    
    Use `withCredentials` in pipelines.
    
    - **Example**:
        
        ```groovy
        
        withCredentials([usernamePassword(credentialsId: 'cred-id')]) {}
        
        ```
        
8. **Explain a post-build action in Jenkins.**
    - Actions like notifications or artifact archiving.
9. **What is the use of `archiveArtifacts`?**
    - Saves files for later access.
    - **Example**:
        
        ```groovy
        
        archiveArtifacts 'target/*.jar'
        
        ```
        
10. **What is a Jenkins Shared Library?**
    - Centralized reusable pipeline code.