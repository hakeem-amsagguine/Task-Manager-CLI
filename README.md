📝 Task Manager CLI
Welcome to Task Manager CLI – a simple and efficient command-line tool built with Go to help you manage your tasks like a pro! 🚀

📋 Features
Add Tasks: Quickly add tasks with a title and description.
List Tasks: View all your tasks in a neat list.
Update Tasks: Mark tasks as completed or update their details.
Delete Tasks: Remove tasks that are no longer needed.
🚀 Getting Started
Follow these instructions to get a copy of the project up and running on your local machine.

1. Clone the Repository
bash
Copier le code
git clone https://github.com/yourusername/task-manager-cli.git
cd task-manager-cli
2. Install Go
Make sure you have Go installed on your system.

3. Run the Application
Compile and run the application:

bash
Copier le code
go run main.go <command> [arguments]
💻 Usage
Here’s how you can use the Task Manager CLI to organize your tasks:

➕ Add a Task
Create a new task by providing a title and description:

bash
Copier le code
go run main.go add "Write code" "Complete the Go CLI project"
📜 List All Tasks
View all your tasks with their ID, title, description, and completion status:

bash
Copier le code
go run main.go list
✏️ Update a Task
Mark a task as completed or update its details:

bash
Copier le code
go run main.go update <id> <completed>
Example:

bash
Copier le code
go run main.go update 1 true
❌ Delete a Task
Remove a task using its ID:

bash
Copier le code
go run main.go delete <id>
Example:

bash
Copier le code
go run main.go delete 1
🛠️ Project Structure
Here’s a quick overview of the project structure:

bash
Copier le code
task-manager-cli/
├── main.go               # Entry point of the application
├── task/
│   ├── task.go           # Task model definition
│   └── task_test.go      # Tests for the Task model
├── storage/
│   ├── storage.go        # In-memory storage implementation
│   └── storage_test.go   # Tests for the storage layer
└── README.md             # This file!
🧪 Running Tests
To run the tests and ensure everything is working correctly, use the following command:

bash
Copier le code
go test ./...
🎉 Contributing
Contributions are welcome! Feel free to fork this repository, create a new branch, and submit a pull request. Whether it's a bug fix, new feature, or documentation improvement, your input is appreciated!

📜 License
This project is licensed under the MIT License. See the LICENSE file for more details.
