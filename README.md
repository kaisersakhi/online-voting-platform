## Online Voting Platform

This is an online voting system built using Rails framework, with Tailwindcss for styling and HTML/CSS for front-end development. The purpose of this system is to allow election administrators to create and manage elections, while allowing voters to cast their votes securely and easily.
<br>
Features<br>
**Admin** 

    1. Sign up and sign in
    2. Create and manage elections
    3. Create and manage ballots with questions and answer options
    4. Register and manage voters
    5. Launch and end an election
    6. View running results of an election

**Voter**

    1. Visit the public URL of an election
    2. Sign in with a Voter ID and Voter password
    3. Select one answer from the available options for each question
    4. Submit selections and prevent voters from casting votes multiple times
    5. View the result of an election after it has ended

**Other Users**

    Ability to see election results


**Technologies Used**

    Ruby on Rails
    Tailwindcss
    HTML/CSS

Getting Started

    Clone the repository

```bash

git clone https://github.com/kaisersakhi/online-voting-platform.git
```
    Install the necessary gems

`bundle install`

    Create the database and run migrations

```bash

rails db:create
rails db:migrate
```

    Start the server

`rails server`

    Open a web browser and go to http://localhost:3000


![Demo Video](public/video/ovp-demo.mp4)
