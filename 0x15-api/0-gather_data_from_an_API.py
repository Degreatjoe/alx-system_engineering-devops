#!/usr/bin/python3

import sys
import requests


def get_employee_todo_list(employee_id):
    # Base URL for the API
    base_url = "https://jsonplaceholder.typicode.com"

    # Fetch employee information
    user_url = f"{base_url}/users/{employee_id}"
    user_response = requests.get(user_url)
    if user_response.status_code != 200:
        print("Error fetching employee information")
        return

    user = user_response.json()
    employee_name = user.get("name")

    # Fetch employee's TODO list
    todos_url = f"{base_url}/todos?userId={employee_id}"
    todos_response = requests.get(todos_url)
    if todos_response.status_code != 200:
        print("Error fetching TODO list")
        return

    todos = todos_response.json()
    total_tasks = len(todos)
    done_tasks = [todo for todo in todos if todo.get("completed")]

    number_of_done_tasks = len(done_tasks)

    # Output the required information
    print(f"Employee {employee_name} is done with tasks\
          ({number_of_done_tasks}/{total_tasks}):")
    for task in done_tasks:
        print(f"\t {task.get('title')}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 0-gather_data_from_an_API.py <employee_id>")
        sys.exit(1)

    try:
        employee_id = int(sys.argv[1])
        get_employee_todo_list(employee_id)
    except ValueError:
        print("Please provide a valid integer for the employee ID.")
