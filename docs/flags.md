---
title: Ampersand Flags
layout: default
nav_order: 5
---

## What are Ampersand Flags?

Ampersand Flags are flags that are activated when followed by the `&` symbol. They can modify how URLs are sent and received. 

*In comparison to methods that alter how the client and server communicate*

- ### `include`
    * ***Purpose:***
        Keeps the file on the client's system
    
    * **Example:**

        Let's say I had a file named `important.cml` on my server with the id `1`. Though, not only do I want to see the contents of it, I want to install the file onto my computer (as in save to the filesystem). To do so:

        `cw://1?/important.cml&include`
    * **Methods that support this flag:**
        - `GET`
        - `POST`

    * **Notes:**
        - All Ampersand Flags need to go at the very end of the URL, regardless of what they are or what they do
        - If it doesn't make sense for `POST`, just imagine the file being sent the server, but `&include` copying it to the server instead of sending it completely and you losing access to it (assuming you don't have direct access to the server).









