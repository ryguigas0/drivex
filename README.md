# Drivex
Elixir powered cloud drive

## TODO
- Account login (phoenix tokens) -> OK
- File upload / download / deleting -> OK
- Add folders: organizing files
    - User has one main folder
    - Main folder has many folders
    - Folders can have many folders and files
    - Folder schema
        - Name
        - Folders
        - Files
- File searching: easier file finding
- File sharing: public or certain users

## Recomended tools
- Elixir 1.13.0
- Phoenix 1.6.2
## Dev environment setup
1. `git clone` this project
2. `cd drivex`
3. `mix setup`
4. `mix phx.server`
5. GET request [`localhost:4000/api/health`](http://localhost:4000/api/health) to know if its running properly