### **Important Commands for Writing Shell Scripts**

When writing shell scripts, these are some essential commands you should know:

### **1. Basic Shell Commands**

- `echo` – Print text to the console
    
    ```bash
    
    echo "Hello, World!"
    
    ```
    
- `read` – Take user input
    
    ```bash
    
    read -p "Enter your name: " name
    echo "Hello, $name"
    
    ```
    
- `pwd` – Print working directory
    
    ```bash
    
    pwd
    
    ```
    
- `cd` – Change directory
    
    ```bash
    
    cd /path/to/directory
    
    ```
    
- `ls` – List files in a directory
    
    ```bash
    
    ls -l
    
    ```
    

### **2. File and Directory Management**

- `touch` – Create an empty file
    
    ```bash
    
    touch file.txt
    
    ```
    
- `mkdir` – Create a directory
    
    ```bash
    
    mkdir mydir
    
    ```
    
- `rm` – Remove files or directories
    
    ```bash
    
    rm -rf mydir
    
    ```
    
- `cp` – Copy files
    
    ```bash
    
    cp file1.txt file2.txt
    
    ```
    
- `mv` – Move or rename files
    
    ```bash
    
    mv oldname.txt newname.txt
    
    ```
    

### **3. Conditional Statements**

- `if` statement
    
    ```bash
    
    if [ -f "/etc/passwd" ]; then
        echo "File exists"
    else
        echo "File does not exist"
    fi
    
    ```
    
- `case` statement
    
    ```bash
    
    case $1 in
        start) echo "Starting service..." ;;
        stop) echo "Stopping service..." ;;
        *) echo "Usage: $0 {start|stop}" ;;
    esac
    
    ```
    

### **4. Loops**

- `for` loop
    
    ```bash
    
    for i in {1..5}; do
        echo "Number: $i"
    done
    
    ```
    
- `while` loop
    
    ```bash
    
    count=1
    while [ $count -le 5 ]; do
        echo "Count: $count"
        ((count++))
    done
    
    ```
    

### **5. Functions**

- Defining and calling functions
    
    ```bash
    
    function say_hello {
        echo "Hello, $1"
    }
    say_hello "Ashok"
    
    ```
    

### **6. Process Management**

- Running a script in the background
    
    ```bash
    
    ./script.sh &
    
    ```
    
- Checking running processes
    
    ```bash
    ps aux | grep process_name
    
    ```
    
- Killing a process
    
    ```bash
    
    kill -9 <PID>
    
    ```
    

### **7. File Handling**

- Reading a file line by line
    
    ```bash
    
    while IFS= read -r line; do
        echo "$line"
    done < file.txt
    
    ```
    
- Writing output to a file
    
    ```bash
    
    echo "Hello, World!" > output.txt
    
    ```
    

### **8. Debugging**

- Enable debugging in a script
    
    ```bash
    
    bash -x script.sh
    
    ```