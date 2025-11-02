---
layout: default
title: How It Works
nav_order: 6
---

## The URL

**Model:**

`cw://0?/main.cml`

URLs is how Craft-Web talks to other computers. Mainly servers (similar to browsers). 

1. *The URL starts off with the protocol.* In this case, it's `cw`. Of course it does support other protocols such as `http` or `https`.

*Followed by the protocol is the characters `://`. These aren't **THAT** important, but does indicate that it's a URL*

2. After the protocol, comes the id of the  target server. This id can be found by going into lua and doing `os.getComputerID()`. For the model, the id is `0`.

*Followed by the id is `?/`. Once again, these characters aren't that important to take note of, but should be a good indicator of a URL.*

3. After the id, is the file name on the server to fetch. This can either be a large directory, or a small one that can be found in the root of the server. It all depends on where it is.
