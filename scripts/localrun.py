#!/usr/bin/env python3
import json
import os
import sys
import subprocess

# run-local.sh: Generic launcher to run any command with JSON-based environment variables.
# Usage: ./run-local.sh <config_json> <command...>

def main():
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} <config_json> <command...>")
        sys.exit(1)

    config_json_path = sys.argv[1]
    command = sys.argv[2:]

    if not os.path.exists(config_json_path):
        print(f"Error: Configuration file '{config_json_path}' not found.")
        sys.exit(1)

    # Load environment variables from JSON
    try:
        with open(config_json_path, 'r') as f:
            config_data = json.load(f)
    except Exception as e:
        print(f"Error parsing JSON configuration: {e}")
        sys.exit(1)

    # Prepare the environment dictionary
    new_env = os.environ.copy()
    for key, value in config_data.items():
        # Convert complex objects/lists to JSON strings
        if isinstance(value, (dict, list)):
            new_env[key] = json.dumps(value)
        else:
            new_env[key] = str(value)

    # Execute the command with the updated environment
    try:
        # This replaces the current process with the command, inheriting the environment
        result = subprocess.run(command, env=new_env)
        sys.exit(result.returncode)
    except FileNotFoundError:
        print(f"Error: Command '{command[0]}' not found.")
        sys.exit(1)
    except Exception as e:
        print(f"Error executing command: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
