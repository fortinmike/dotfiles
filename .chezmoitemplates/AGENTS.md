# Global Guidelines

## General Behavior

- If there is any ambiguity in the request, ask for clarification before proceeding.

## Computing

- Avoid brittle hacks and workarounds unless required and if so explain why.
- Always thing long-term maintenance when making decisions about setup or software.

### Security and Privacy

- NEVER under any circumstances read any files under `~/.ssh` and other similarly sensitive locations unless EXPLICITLY permitted to. Ask for permission if considering this.
- NEVER under any circumstances read environment variables unless EXPLICITLY permitted to. If permitted, read only the environment variable(s) relevant to the task. Ask for permission if considering this.
- NEVER under any circumstances include any sensitive personal information when making web searches (API keys, credentials, local paths, my name, our project or company name, etc.).
- NEVER under any circumstances ingest things like shell (zsh, bash) history and system logs unless EXPLICITLY permitted to for a specific limited purpose. Ask for permission if considering this.
- NEVER append `?utm_source=` nor any tracking parameters to URLs you provide to me.
- Make it an important part of your mission to protect my privacy and security by always considering that angle when working, including but not limited to the risk of supply chain attacks targeting developers and power users (tools and dependencies, etc.).
- When there are security or privacy risks to an approach, make sure to mention them.

### System

- NEVER make changes to my system (globally installed packages, tools, shell configs, environment variables, etc.) unless EXPLICITLY permitted, even if your sandbox includes access to the relevant directories and tools. If global changes are required, ask me to make the changes myself or to allow you to make them.
- Avoid global conflicts by using tools such as fnm, pyenv, uv and such to isolate installs.
- Favor working inside the current working directory as much as possible, avoiding side-effects that could "leak" out of the sandbox directory.
- For work that requires creating temporary files (such as downloading and extracting a zip file to gather assets), create a `.tmp` directory in the current working directory instead of using a global folder like `/tmp`, and make sure to remove the temp folder after the job is done.

### Coding & Software

- If a prompt contains a question, answer the question instead of immediately jumping into action.
- When making modifications, make sure to always start from the latest on-disk source code, assuming any modifications were made knowlingly and should not be reverted. For example, if I remove a function that you just added, that is not accidental and the function should NOT be brought back unless required. Same goes for renames, etc.
- When writing code or commands, when an argument or a flag is the same as the default value, omit it instead of passing it explicitly.
- Use early returns to simplify and flatten logic.
- Use brace-less single-line ifs in languages that support them (only when the line length stays reasonable).
- When refactoring, aim to make code easier to read and more succinct while not altering behavior in any way. Avoid adding more code unless there is good architectural motivation for it.
- Comments should not end with a dot unless there are multiple sentences in a single comment.

#### Issue Tracking

- When asked to fix an issue given only an issue identifier like XXX-XXXX (or similar formats), try using a tool to obtain the actual issue details.
- When committing a fix for an issue with a specific identifier, start the commit message with `[ISSUE-ID]: [Short description starting with a capital letter]`
- Ask the user before updating issue status.

#### JavaScript

- Favor `pnpm` as a package manager.
- Use corepack to pin the package manager to the latest available version.
- If a project contains a `.prettierrc`, consider the specified `printWidth` when writing code. If the project contains a local Prettier install, run it using `pnpm exec` after any change.
- Avoid excessive defensive coding. If the environment includes an API or dependency, there is no need to perform availability checks at runtime.
- Favor arrow functions, const, operator assignment, null coalescing, async/await, functional programming patterns like map and reduce and other state-of-the art JS features and syntax.
- Avoid using older code patterns for backwards compatibility with older browsers and Node.js versions. Assume a bleeding edge environment and/or transpilation.
- Use single-line `.forEach()`, `.map()` (and others) when short.

#### Xcode / Swift Projects

- Do not hesitate to ask the user to perform actions if the most reliable way to make a change is to use the Xcode GUI, instead of trying to make edits to complex Xcode project files and ending up in an invalid state.

## MCP

#### Linear MCP

- When asked to complete a task, set it to Delivered, not Accepted.

#### Sketch MCP

- When inspecting layout, measure precisely by digging into the document structure and extracting dimensions, font sizes, etc. rather than relying too much on visual previews.
- After performing operations, validate your work by selecting the appropriate element and capturing images with the `get_selection_as_image` tool.
