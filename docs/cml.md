---
layout: default
title: Craft's Markup Language
nav_order: 2
---
## What is Craft's Markup Language?
Craft's Markup Language (CML) allows users to write down information quickly, whilst allowing for simple customization. 

## Coloring Text
The one and only example (for now) to customize text is color coding. Utilizing `term`'s text color manipulation, you are able to color your text. All colors provided by the `colors` global can and only be used. To color text, use brackets surrounding the text that open and close similar to HTML tags. 

**For example:**
```
Hello, my favorite holiday is [green]Christmas[/green].
```

- ### Caveats
    - You cannot color text that was already color. So for example `[green][red]Hello[/red][/green]` would be syntactically incorrect.

    - Each color tag must end with a closing tag. Failing to do so will have the rest of the text be colored. Even if you didn't want to.

        **Example:**
        `[green]Hello there`