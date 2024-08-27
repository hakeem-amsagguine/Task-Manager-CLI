package main

import (
    "fmt"
    "os"
    "strconv"
    "task-manager-cli/storage"
    "task-manager-cli/task"
    "time"
)

func main() {
    if len(os.Args) < 2 {
        fmt.Println("expected 'add', 'list', 'update', 'delete' subcommands")
        os.Exit(1)
    }

    switch os.Args[1] {
    case "add":
        addTask(os.Args[2:])
    case "list":
        listTasks()
    case "update":
        updateTask(os.Args[2:])
    case "delete":
        deleteTask(os.Args[2:])
    default:
        fmt.Println("expected 'add', 'list', 'update', 'delete' subcommands")
    }
}

func addTask(args []string) {
    if len(args) < 2 {
        fmt.Println("Usage: add <title> <description>")
        return
    }
    t := task.Task{
        Title:       args[0],
        Description: args[1],
        CreatedAt:   time.Now(),
        UpdatedAt:   time.Now(),
    }
    t = storage.CreateTask(t)
    fmt.Printf("Added task: %d\n", t.ID)
}

func listTasks() {
    tasks := storage.ListTasks()
    for _, t := range tasks {
        fmt.Printf("%d: %s - %s (Completed: %t)\n", t.ID, t.Title, t.Description, t.Completed)
    }
}

func updateTask(args []string) {
    if len(args) < 2 {
        fmt.Println("Usage: update <id> <completed>")
        return
    }
    id, err := strconv.Atoi(args[0])
    if err != nil {
        fmt.Println("Invalid task ID")
        return
    }
    completed, err := strconv.ParseBool(args[1])
    if err != nil {
        fmt.Println("Invalid completion status")
        return
    }
    t, err := storage.GetTask(id)
    if err != nil {
        fmt.Println(err)
        return
    }
    t.Completed = completed
    t.UpdatedAt = time.Now()
    err = storage.UpdateTask(t)
    if err != nil {
        fmt.Println(err)
    } else {
        fmt.Println("Updated task")
    }
}

func deleteTask(args []string) {
    if len(args) < 1 {
        fmt.Println("Usage: delete <id>")
        return
    }
    id, err := strconv.Atoi(args[0])
    if err != nil {
        fmt.Println("Invalid task ID")
        return
    }
    err = storage.DeleteTask(id)
    if err != nil {
        fmt.Println(err)
    } else {
        fmt.Println("Deleted task")
    }
}
