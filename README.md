# estimate_moving

- A web application that calculates total volume of your household items.
- Perfect for preparing house moving.
- Easy to use on mobile devices as well as on larger devices.

---

## Current features
- Allows each user to have an account, where the user can hold multiple moving projects.
- Lists all my household items for each moving project.
- Displays the total volume of each moving project.
- Allows user to add tags to household items and the items can be fitered by tag.

## Pending features
- graphs/charts for moving volume data.
- sign up and log in via Facebook or twitter.

## Demo

`https://estimate-moving.herokuapp.com/`

Log in as example user:
- Email - `user@example.com`
- Password - `password`

## Local setup

```bash
$ git clone git@github.com:mnishiguchi/estimate_moving.git
$ cd estimate_moving
$ bundle install --without production
$ [bundle exec] rake db:create
$ [bundle exec] rake db:migrate
$ [bundle exec] rake db:seed
$ rails s
```

## Models

![](erd.jpg)
