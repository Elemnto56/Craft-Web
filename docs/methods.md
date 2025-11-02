---
title: Methods
layout: default
nav_order: 4
---

## What are methods?

Craft-Web Methods are similar to HTTP Methods, in such a way that allows them to alter how the client communicates to the server. Methods can serve a variety of purposes to meet your needs!

---

- ### GET
    * ***Purpose:***

    Receives a file from the server, and displays its contents on screen
    * ***URL Syntax:***

    Follow the format `cw://[id]?/[file on server]` when crafting the URL. *For a more detailed breakdown, go to [How It Works](workings.md)*

    **Example:**

    Say I have a file named `data.cml` on my server with the id `25` that I want to view. To do so, I'd type the URL:

    `cw://25?/data.cml`

- ### POST
    * ***Purpose:***

    Sends a file to the server
    * ***URL Syntax:***

    Input your URL as you when using `GET`, except when at the server path you want to place the file, use the *@* symbol followed by the word in all-caps *"POST"*, then a colon with the path to the file you want to send to the server.

    **Example:**

    Suppose I wanted to send my file `diary.cml` from the directory `/home/` into the server's directory `/uploads`. Then I'd do:

    `cw://0?/uploads/@POST:/home/dairy.cml`

- ### DELETE
    * ***Purpose:***

    Removes/deletes a file on the server
    * ***URL Syntax***
    
    Similar to a `POST` method, you'd include the *@* symbol. Though, in this case, you'd do it after the file from the server's file directory.

    **Example:**

    Let's say I wanted to delete `secret-stuff.cml` from my server with the id `55`. To do so you'd do:

    `cw://55?/secret-stuff.cml@DELETE`