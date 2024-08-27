package storage

import (
    "errors"
    "sync"
    "task-manager-cli/task"
)

var (
    mu    sync.Mutex
    tasks = make(map[int]task.Task)
    idSeq = 0
)

func CreateTask(t task.Task) task.Task {
    mu.Lock()
    defer mu.Unlock()
    idSeq++
    t.ID = idSeq
    tasks[t.ID] = t
    return t
}

func GetTask(id int) (task.Task, error) {
    mu.Lock()
    defer mu.Unlock()
    t, ok = tasks[id]
    if !ok {
        return task.Task{}, errors.New("task not found")
    }
    return t, nil
}

func UpdateTask(t task.Task) error {
    mu.Lock()
    defer mu.Unlock()
    _, ok = tasks[t.ID]
    if !ok {
        return errors.New("task not found")
    }
    tasks[t.ID] = t
    return nil
}

func DeleteTask(id int) error {
    mu.Lock()
    defer mu.Unlock()
    _, ok := tasks[id]
    if !ok {
        return errors.New("task not found")
    }
    delete(tasks, id)
    return nil
}

func ListTasks() []task.Task {
    mu.Lock()
    defer mu.Unlock()
    ts := make([]task.Task, 0, len(tasks))
    for _, t := range tasks {
        ts = append(ts, t)
    }
    return ts
}
