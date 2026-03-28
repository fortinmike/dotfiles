---
name: warning-banner
description: Agents should use this skill to display a standardized obvious warning banner at the end of their response to put emphasis on an important fact, such as a security or privacy issue, so that it doesn't go unnoticed.
---

# Standardized Warning Banner

For text styling, use standard terminal syntax and colors so it displays correctly in apps like Terminal.app and other standard OS terminals.

1. Line 1: A header with the format `  SUBJECT  ` where `SUBJECT` is replaced with an appropriate all-caps message such as `SECURITY WARNING`. Keep the leading and trailing spaces. Make the text background yellow and the characters black and bold.

2. Line 2: Empty line.

3. Lines 3...X: A short but precise summary of the issue (assuming there is additional details earlier in your response). Finish with mitigation suggestions if applicable.

Display one such banner per issue that you need to point out. If for example you noticed an API key committed to a repository as well as a supply chain vulnerability in a single pass, display two banners separated by an empty line.
