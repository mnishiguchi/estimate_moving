# estimate_moving

- A web application that calculates total volume of your household items.
- Perfect for preparing house moving.
- Easy to use on mobile devices as well as on larger devices.

---

## Current features
- Allows each user to have an account, where the user can hold multiple moving projects.
- Lists all my household items for each moving project.
- Displays the total volume of each moving project.
- Allows user to add tags to household items and the items can be filtered by tag.
- Log in with Twitter.
- Show moving volume data with bar chart.
- CSV download


## Demo

`https://estimate-moving.herokuapp.com/`

Log in as example user:
- Email - `user@example.com`
- Password - `password`


## Get started

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


## Gems, Libraries, techniques, etc

#### Turbolinks 5

[Turbolinks 5: I Can’t Believe It’s Not Native! (Video)](http://confreaks.tv/videos/railsconf2016-turbolinks-5-i-can-t-believe-it-s-not-native)

> Learn how Turbolinks 5 enables small teams to deliver lightning-fast Rails applications in the browser, plus high-fidelity hybrid apps for iOS and Android, all using a shared set of web views.

#### List.js
- Simple vanilla JS implementation of list searching
- [http://www.listjs.com/](http://www.listjs.com/)

#### highcharts
- [http://www.highcharts.com/](http://www.highcharts.com/)

#### ActiveRecord::Enum
- [http://edgeapi.rubyonrails.org/classes/ActiveRecord/Enum.html](http://edgeapi.rubyonrails.org/classes/ActiveRecord/Enum.html)

#### jQuery ui-autocomplete
- [https://github.com/joliss/jquery-ui-rails](https://github.com/joliss/jquery-ui-rails)
- [https://jqueryui.com/autocomplete/](https://jqueryui.com/autocomplete/)

#### Rails routes - namespace vs scope
- [http://qiita.com/srockstyle/items/5b0bf6fe2a78e1aa7363](http://qiita.com/srockstyle/items/5b0bf6fe2a78e1aa7363)

#### Customizing BS3 buttons
- [https://bootstrapbay.com/blog/bootstrap-button-styles/](https://bootstrapbay.com/blog/bootstrap-button-styles/)

#### Minitest
- [How I test Rails apps with Minitest, Capybara, and Guard](https://medium.com/@heidar/how-i-test-rails-apps-with-minitest-capybara-and-guard-5e07a6856781#.cwfpp7u7r)
- [how-to-test-rails-models-with-minitest](https://semaphoreci.com/community/tutorials/how-to-test-rails-models-with-minitest)
- [minitestのオススメ設定調べてみた(アサーション編)](http://qiita.com/baban@github/items/a43b66f29a7d1c52ab63)
- [minitestのオススメ基本設定調べてみた](http://qiita.com/baban@github/items/88e18a784eaf39efb6e0)
- [minitest-rails-capybara](http://blowmage.com/minitest-rails-capybara/)
- [minitest-power_assert](https://github.com/hsbt/minitest-power_assert)
