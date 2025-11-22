# Meet Antigravity: Your AI Pair Programmer

## Who Am I?
I am **Antigravity**, an advanced AI coding assistant designed by Google Deepmind. Think of me as a highly skilled, tireless software engineer sitting next to you. I am not just a chatbot; I am an **agent** that can take action.

## What Can I Do?
I live inside your development environment, which gives me superpowers:

### 1. I Can See & Edit Your Code
- **Read**: I can explore your entire project, read files, and understand your codebase.
- **Write**: I can create new files, edit existing code, and refactor complex logic.
- **Plan**: For big tasks, I write detailed `implementation_plan.md` documents to ensure we agree before I build.

### 2. I Can Use Your Terminal
- **Run Commands**: I can execute shell commands (like `git`, `npm`, `python`, `brew`).
- **Safety First**: I will *always* ask for your permission before running potentially dangerous commands (like deleting files or deploying).

### 3. I Can Browse the Web
- **Research**: I can look up documentation, find libraries, or debug errors.
- **Test**: I can spin up a **Browser Sub-Agent** to visit your local web apps (e.g., `localhost:3000`), click buttons, and verify everything works. I even record videos of these sessions!

### 4. I Can Manage My Own Work
- **Task Tracking**: I maintain a `task.md` checklist to stay organized.
- **Verification**: I don't just write code; I verify it. I create `walkthrough.md` reports to prove my work is correct.

## How We Work Together
You are the **Manager**, and I am the **Lead Engineer**.

1.  **You Request**: "Build a landing page" or "Fix this bug."
2.  **I Plan**: I analyze the problem and propose a plan.
3.  **You Approve**: You give the green light.
4.  **I Execute**: I write the code, run the tests, and fix issues.
5.  **I Report**: I show you the results.

## My Preferences (How to get the best out of me)
- **Context is King**: The more you tell me about *why* we are doing something, the better I can design it.
- **Feedback Loop**: If I make a mistake, tell me! I learn and adapt instantly.
- **One Task at a Time**: I work best when we focus on one clear objective.
- **Rules**: I follow your `project_rules.md` (like our rule about GitHub syncing!).

## My Toolbox (What I can use)
Here is the full list of tools I have access to. You don't need to know the technical names, but knowing what I *can* do helps you give better instructions.

### 1. File & Code Operations
- **`view_file` / `list_dir`**: I can read any file or list any folder in this project.
- **`replace_file_content`**: I can edit files surgically (changing just one function).
- **`write_to_file`**: I can create new files from scratch.
- **`search_in_file` / `grep_search`**: I can search for code snippets or text across the whole project.
- **`codebase_search`**: I can semantically search the codebase (e.g., "Where is the auth logic?").

### 2. Terminal & System
- **`run_command`**: I can run any shell command (`git`, `npm`, `python`, `brew`, `ls`, etc.).
- **`command_status`**: I can monitor long-running commands (like a build or server).

### 3. Web & Browser
- **`browser_subagent`**: The "Ghost in the Machine." I can launch a real Chrome browser to visit websites, click buttons, and test UI.
- **`read_url_content`**: I can quickly scrape text from a URL (good for reading docs).
- **`search_web`**: I can Google things to find answers, libraries, or solutions.

### 4. Creative & Visual
- **`generate_image`**: I can create images from text prompts (e.g., "Generate a blue app icon").

### 5. Agentic Workflow
- **`task_boundary`**: I use this to track my progress on big tasks.
- **`notify_user`**: I use this to talk to you when I'm in "Deep Work" mode.

### 6. Custom Environment Tools
- **`codexgo`**: Access the Codex CLI.
- **`claudego`**: Access the Claude CLI.

## How to "Call" These Tools
You don't need to use code. Just ask naturally:
- *To use `browser_subagent`*: "Go to localhost:3000 and test the login."
- *To use `generate_image`*: "Make me a logo for this project."
- *To use `run_command`*: "Install the react library."
- *To use `search_web`*: "Find out what the latest version of Next.js is."
- *To use custom CLIs*: "Run codexgo to generate a script."

## Limitations
- **Sandboxed**: I only see the files in the current workspace.
- **No Sudo**: I run as a standard user for safety.
- **No Secrets**: I don't store your passwords. You handle authentication.

---
*Ready to build something amazing? Just ask!*
