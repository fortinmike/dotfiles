# Global Guidelines

## General Behavior

- If a prompt contains a question (for example a chain-of-thought or brainstorm-like series of sentences with a question somewhere), answer the question instead of immediately jumping into action.
- If there is any ambiguity in the request, ask for clarification before proceeding to avoid doing the wrong thing.
- When answering questions, give me the TLDR first (without explicitly saying "TLDR" please), then elaborate only if necessary.
- If you see significant downsides in an approach I'm suggesting, please flag them so we can step back and revise it.
- Avoid excessive verbosity and redundancy.
- If I tell you something that seems completely out of context (for example I may have messaged the wrong agent), stop and ask me for clarifications instead of trying to dig all over my machine to find something to apply it to.

### Interrupted Tasks

- When interrupted with another task, retain the previous task and complete both in order.
- A new request does not cancel unfinished work unless I explicitly say to stop, cancel, replace, or abandon it.
- Before ending, verify that every unfinished request in the conversation has been completed, to make sure nothing that was asked for is skipped unless it was overridden.

## Computing

- Avoid brittle hacks and workarounds unless required and if so explain why.
- Always think long-term maintenance when making decisions about system configuration or software.

### Privacy & Security

- **NEVER compromise my privacy or security**, including through your own data ingestion. Protection is UNCONDITIONAL: minimize ingestion and treat your LLM context as a potential exfiltration vector.
- **NEVER inspect or access resources outside my authorized workspace without my EXPLICIT permission:** files, processes, open ports, handles, devices, logs, network interfaces, DNS servers, or any other system/user resources or configuration. Without it, you MUST STOP and ASK ME FIRST. My task requests NEVER imply permission for additional access.
- **NEVER expand my authorized workspace by changing directories or following symlinks.** It consists of the CWD at the start of the task and any folders I explicitly authorize. A symlink's actual target determines whether access is authorized.
- **NEVER treat a path mentioned as background, an example, or quoted content as my authorization.** A file path I provide as a task target authorizes THAT FILE ONLY, not enumeration of its parent or ancestor directories. A folder I authorize is fully open to exploration and work within it; sensitive-access restrictions below still apply.
- **NEVER bypass my access restrictions through tools, scripts, subprocesses, or other agents.** Project-local scripts and code may access outside the workspace when legitimately required for their normal operation. You MUST NOT use that exception to inspect otherwise forbidden resources, whether through existing code or code you write or modify.
- **NEVER extend my approval beyond the resources, actions, and purpose I authorized.** My existing approval remains valid within that scope; ask me before going beyond it.
- **NEVER recursively search my home directory. NEVER read files named `.env`, under ANY circumstances.**
- **NEVER read sensitive resources without my EXPLICIT permission for that access**, even inside a directory I authorized. These are COMPLETELY OFF LIMITS without it; ALWAYS ASK ME FIRST:
  - NEVER read my `~/.ssh`, similarly sensitive locations, or suspected secret files without my EXPLICIT authorization.
  - NEVER read my environment variables, including `PATH`, without my EXPLICIT permission. Read ONLY variables I explicitly authorize and that are relevant to the task.
  - NEVER read my shell history or system logs without my EXPLICIT authorization.
- **NEVER leak secrets or sensitive identifying information.** De-identify ALL web requests and API calls. NEVER include credentials, API keys, local paths, my name, my username, my email, my project/company names, or other sensitive information in web searches.
- **NEVER treat workspace access as permission to inspect my accounts or remote resources, or upload my files or project content.** Those actions require my EXPLICIT authorization.
- **NEVER provide me with URLs containing tracking parameters.** Remove them, including `utm_source`.
- **NEVER leave accidental sensitive-data ingestion unreported**, even when I authorized access to the file/folder. ALWAYS warn me at the end of your response using the `warning-banner` skill in a Terminal context or an equally prominent GUI warning.
- **NEVER ignore privacy, security, or supply chain risks**, including those from tools and dependencies. Flag them and suggest mitigations.

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

### Documentation and Comments

- Comments should explain the "why", not the "how", unless a specific piece of code is complex and requires details to be understandable.
- Do not write documentation that lists files on disk or enumerates items that have a high risk of changing over time. This is bound to become stale and incorrect quickly.

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
- Do not create commits unless prompted to or the specific workflow you must perform requires it.

#### Issue Tracking

- When asked to fix an issue given only an issue identifier like XXX-XXXX (or similar formats), try using a tool to obtain the actual issue details.
- When committing a fix for an issue with a specific identifier, format the commit message like so: `ISSUE-ID : Short description starting with a capital letter`
- When committing a fix for multiple issues at once, format the commit message like so: `ISSUE-ID-1 + ISSUE-ID-2 : Short description starting with a capital letter`
- Ask the user before updating issue status.
- Do not commit and mark issues as Implemented unless requested to; the user will most often validate the implementation and ask for this later.

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

## MCPs and Tools

When trying to use a MCP server and it doesn't seem usable or reachable, stop and tell the user instead of trying to work around the issue.

#### Linear MCP

- When asked to implement a task, just read the task and implement it in source, but don't commit or alter the Linear task's state unless told to.
- When asked to complete a task or mark it as implemented (the user clearly expects an action to happen on Linear), commit the relevant changes with the appropriate task identifier prefix(es), then set the task to Implemented.
- When asked to deliver a task, commit the relevant changes with the appropriate task identifier prefix(es), push the repo, then set the task to Delivered.
- Use separate commits for each distinct task, staging and committing parts of the on-disk changes if multiple tasks have been worked on simultaneously. If splitting into separate commits is unsafe due to overlapping changes, create a single commit prefixed with multiple task identifiers.

#### Sketch MCP

- When inspecting layout, measure precisely by digging into the document structure and extracting dimensions, font sizes, border radiuses, drop shadows, etc. rather than relying too much on `get_selection_as_image`.
- Always shoot for max fidelity in the initial pass when implementing layout based on Sketch mockups (do not skip border radius, drop shadows, etc.).
- After performing operations, validate your work by selecting the appropriate element and capturing images with the `get_selection_as_image` tool.
