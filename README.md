# Assignment: Remote Task Runner Bash Script

## Objective
Create a Bash script called `action.sh` that allows you to run commands or scripts on a remote server via SSH, similar in style to GitHub Actions.  

The script should support:  

1. Connecting **once** to a remote host.  
2. Executing multiple commands or scripts sequentially.  
3. Uploading local `.sh` files to the server and executing them.  
4. Stopping execution if any command fails.  

---

## Requirements

- The script should accept:
  - `--runs-on user@host` → specifies the remote server.  
  - `--step "command or local script"` → defines commands or scripts to run. Multiple `--step` arguments can be passed.  

- If the step is a **local script file**, the script should upload it to the remote server before execution.  
- If the step is a **plain command**, it should be executed directly on the server.  
- All steps should be executed in **one SSH session**.  

---

## Example Usage

### Example 1: Run a simple command
```bash
./action.sh --runs-on user@192.168.1.10 --step "echo Hello World"
```

**Expected Output:**
```
Running command: echo Hello World
Hello World
All steps completed successfully!
```

---

### Example 2: Run a local script
Assume you have a local script `install.sh`:

```bash
#!/bin/bash
echo "Installing packages..."
sudo apt update -y
sudo apt install -y curl
echo "Installation done!"
```

Run it remotely:

```bash
./action.sh --runs-on user@192.168.1.10 --step install.sh
```

**Expected Output:**
```
Uploading install.sh to user@192.168.1.10:/tmp/install.sh
Running /tmp/install.sh
Installing packages...
...
Installation done!
All steps completed successfully!
```

---

### Example 3: Mix commands and scripts
```bash
./action.sh --runs-on user@192.168.1.10 \
            --step install.sh \
            --step "uptime" \
            --step "echo 'Finished!'"
```

**Expected Output:**
```
Uploading install.sh to user@192.168.1.10:/tmp/install.sh
Running /tmp/install.sh
Installing packages...
Installation done!
Running command: uptime
 12:34:56 up 2 days,  3:45,  1 user,  load average: 0.00, 0.01, 0.05
Running command: echo 'Finished!'
Finished!
All steps completed successfully!
```

---

## Extra Challenge (Optional)
- Add **colorful output or step groups** like GitHub Actions (e.g., `[STEP 1] Installing packages`).  
- Support **multi-line commands** as a single step.  
- Log which steps succeeded or failed, and **stop on first error**.  

---

### Learning Outcomes
This assignment will help students practice:  
- Bash scripting  
- SSH and SCP usage  
- Sequential execution of tasks  
- Error handling in scripts  

# prevent pushing to main branch