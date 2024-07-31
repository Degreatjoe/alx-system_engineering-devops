#!/usr/bin/python3
"""
A script to fetch and display the TODO list progress for a given employee ID.
The script uses the urllib module to access the REST API and outputs the
in a specific format.

Requirements:
- Use the urllib module
- Accept an integer as a parameter (employee ID)
- Display the employee's TODO list progress in the format:
  "Employee EMPLOYEE_NAME is done with tasks(NUMBER_OF_DONE
  Followed by the titles of completed tasks, each preceded by a tab and space.
"""

import json
import urllib.request
import sys


def get_employee_todo_list(employee_id):
    """
    Fetch and display the TODO list progress of the specified employee.

    Args:
    employee_id (int): The ID of the employee.

    Returns:
    None
    """
    # Base URL for the API
    base_url = "https://jsonplaceholder.typicode.com"

    try:
        # Fetch employee information
        with urllib.request.urlopen(f"{base_url}/users/{employee_id}")\
             as response:
            user = json.loads(response.read().decode())
            employee_name = user.get("name")

        # Fetch employee's TODO list
        with urllib.request.urlopen(f"{base_url}/todos?userId={employee_id}")\
             as response:
            todos = json.loads(response.read().decode())
            total_tasks = len(todos)
            done_tasks = [todo for todo in todos if todo.get("completed")]

            number_of_done_tasks = len(done_tasks)
    except urllib.error.URLError as e:
        print(f"Error fetching data: {e}")
        return

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
