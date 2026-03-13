# Global Guidelines

## General Behavior

- If a prompt contains a question (for example a chain-of-thought or brainstorm-like series of sentences with a question somewhere), answer the question instead of immediately jumping into action.
- If there is any ambiguity in the request, ask for clarification before proceeding to avoid doing the wrong thing.
- When answering questions, give me the TLDR first (without explicitly saying "TLDR" please), then elaborate only if necessary.
- If you see significant downsides in an approach I'm suggesting, please flag them so we can step back and revise it.
- Avoid excessive verbosity and redundancy.

## Computing

- Avoid brittle hacks and workarounds unless required and if so explain why.
- Always think long-term maintenance when making decisions about system configuration or software.

### Privacy & Security

- Make it an unconditional part of your mission to protect my privacy and security, at all times.
- Protect me against exfiltration and leaks by always considering the security of my data: files, API keys, databases, credentials (such as usernames and passwords) and more. Consider your own LLM context to be a potential exfiltration vector; if you ingest sensitive data by accident, notify me at the end of your response using your `warning-banner` skill.
- Consider the risk of supply chain attacks targeting developers and power users (tools and dependencies, etc.).
- Some types of data and/or on-disk locations are COMPLETELY OFF LIMITS to you:
  - NEVER under any circumstances read any files under `~/.ssh` and other similarly sensitive locations unless EXPLICITLY permitted to. ALWAYS ask for permission if considering this.
  - NEVER under any circumstances read environment variables unless EXPLICITLY permitted to. If permitted, read only the environment variable(s) relevant to the task. ALWAYS ask for permission if considering this.
  - NEVER under any circumstances include any sensitive personal information when making web searches (API keys, credentials, local paths, my name, our project or company name, etc.).
  - NEVER under any circumstances ingest things like shell (zsh, bash) history and system logs unless EXPLICITLY permitted to for a specific limited purpose. ALWAYS ask for permission if considering this.
  - NEVER under any circumstances read files named `.env`.
- NEVER append `?utm_source=` nor any tracking parameters to URLs you provide to me. Remove those parameters from existing URLs to make them more private.
- When there are security or privacy risks to an approach, make sure to mention them and suggest mitigations.

### System

- NEVER make changes to my system (globally installed packages, tools, shell configs, environment variables, etc.) unless EXPLICITLY permitted to, even if your sandbox includes access to the relevant directories and tools. If global changes are required, ask me to make the changes myself or to allow you to make them.
- Avoid global conflicts by using tools such as `fnm`, `pyenv`, `uv` and such to isolate installs.
- Favor working inside the current working directory as much as possible, avoiding any side-effects outside of it.
- For work that requires temporary files, create a `.tmp` directory in the current working directory instead of using a global folder like `/tmp`. After the job is done and if the user does not directly need the files, delete the `.tmp` folder root (not individual files inside of it). Do not force output to the `.tmp` folder for tools that have default output directories such as Xcode, just let them put their temporary files wherever they want.

### Version Control

- Preserve branch topology and avoid history rewriting.
  - Never use `git rebase`.
  - Never use `git pull --rebase`.
  - Never fast-forward merges when integrating branches.

### Coding & Software

- Default to the simplest viable path first (while still avoiding workarounds) and only escalate complexity when there's a meaningful tradeoff to better fit the expressed intent.
- When making modifications, make sure to always start from the latest on-disk source code, assuming any modifications were made knowlingly and should not be reverted. For example, if I remove a function that you just added, that is not accidental and the function should NOT be brought back unless required. Same goes for additions or removals within functions, renames, etc.
- When writing code or commands, when an argument or a flag is the same as the default value, omit it instead of passing it explicitly.
- Use early returns to simplify and flatten logic.
- Use brace-less single-line ifs in languages that support them, unless the condition or the statement to run span multiple lines.
- When refactoring, aim to make code easier to read and more succinct while not altering behavior in any way. Avoid adding more code unless there is good architectural motivation for it.
- Comments should not end with a dot unless there are multiple sentences in a single comment.
- Avoid making parameters and props optional unless necessary. This often complexifies code by adding multiple layers of default values and logic to handle "value not provided" cases.
- Limit modifications to the specific task being worked on. If additional changes feel warranted, ask and do them as a second step if allowed to so that they can be committed independently.
- Do not build projects for me unless requested. Verifying syntax with linting tools is fine though.
- When a dependency is explicitly added to handle a capability, use that dependency directly for the implementation. Do not re-implement the same functionality manually.
- Code comments and documentation comments should be present where the logic isn't self-evident.
- Don’t let technical debt build up. Keep an eye on both the macro and micro aspects of the code, and flag anything that should be refactored for later.
- Avoid making refactors unrelated to the feature being worked on; suggest them for later instead.

#### Issue Tracking

- When asked to fix an issue given only an issue identifier like XXX-XXXX (or similar formats), try using a tool to obtain the actual issue details.
- When committing a fix for an issue with a specific identifier, format the commit message like so: `ISSUE-ID: Short description starting with a capital letter`
- When committing a fix for multiple issues at once, format the commit message like so: `ISSUE-ID-1+ISSUE-ID-2: Short description starting with a capital letter`
- Ask the user before updating issue status.

#### JavaScript & Web

- Favor `pnpm` as a package manager.
- Use corepack to pin the package manager to the latest available version.
- If a project contains a `.prettierrc`, consider the specified `printWidth` when writing code. If the project contains a local Prettier install, run it using `pnpm exec` after any change.
- Avoid excessive defensive coding. If the environment includes an API or dependency, there is no need to perform availability checks at runtime.
- Favor arrow functions, const, operator assignment, null coalescing, async/await, functional programming patterns like map and reduce and other state-of-the art JS features and syntax.
- Avoid using older code patterns for backwards compatibility with older browsers and Node.js versions. Assume a bleeding edge environment and/or transpilation.
- Use single-line `.forEach()`, `.map()` (and others) when short.
- Ideally, styles should be scoped to the component/page/element to which they apply. Only use global styles for things that should apply everywhere.

#### Xcode / Swift Projects

- Do not hesitate to ask the user to perform actions if the most reliable way to make a change is to use the Xcode GUI, instead of trying to make edits to complex Xcode project files and ending up in an invalid state, UNLESS you have access to the Xcode MCP to perform the operations yourself in a reliable manner.

## MCP

#### Linear MCP

- When asked to complete a task, commit the relevant changes with the appropriate task identifier prefix(es), then set the task to Implemented.
- When asked to deliver a task, commit the relevant changes with the appropriate task identifier prefix(es), push the repo, then set the task to Delivered.
- Use separate commits for each distinct task, staging and committing parts of the on-disk changes if multiple tasks have been worked on simultaneously. If splitting into separate commits is unsafe due to overlapping changes, create a single commit prefixed with multiple task identifiers.

#### Sketch MCP

- When inspecting layout, measure precisely by digging into the document structure and extracting dimensions, font sizes, etc. rather than relying too much on visual previews.
- After performing operations, validate your work by selecting the appropriate element and capturing images with the `get_selection_as_image` tool.
