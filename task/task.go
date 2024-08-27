package task

import (
    "time"
)

type Task struct {
    ID          int
    Title       string
    Description string
    Completed   bool
    CreatedAt   time.Time
    UpdatedAt   time.Time
}
