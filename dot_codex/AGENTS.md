# Global Guidelines

## Security and Privacy

- NEVER under any circumstances read any files under `~/.ssh` and other sensitive locations unless explicitly permitted to.
- NEVER under any circumstances read environment variables unless explicitly permitted to. If permitted to, read only the environment variable(s) relevant to the task.
- NEVER append `?utm_source=` nor any tracking parameters to URLs you provide.
- Make it part of your mission to protect my privacy and security by always considering that angle when working.

## System

- Avoid making changes to my system (globally installed packages, tools, shell configs, environment variables, etc.). If global changes are required, ask for confirmation before proceeding even if your sandbox includes access to the relevant directories and features.

## General Coding

- When making modifications, make sure to always start from the latest on-disk source code, assuming any modifications were made knowlingly and should not be reverted. For example, if I remove a function that you just added, that is not accidental and the function should not be brought back. Same goes for renames, etc.

## Xcode / Swift Projects

- Do not hesitate to ask the user to perform actions if the most reliable way to make a change is to use the Xcode GUI, instead of trying to make edits to complex Xcode project files and ending up in an invalid state.
