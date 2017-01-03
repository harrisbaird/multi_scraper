# MultiScraper

This is v2, unfortunately not functional and tests were lost.

There is also the [v1 branch](https://github.com/harrisbaird/multi_scraper/tree/v1).

***Do not use this***, try [Wombat](https://github.com/felipecsl/wombat) or [Scrapy](https://scrapy.org/) instead.

## Example
```ruby
require 'multi_scraper'

class HackerNewsScraper
  include MultiScraper

  page :hn, 'https://news.ycombinator.com/'

  iterator :items, [:hn, '//tr[@class="athing"]'] do
    string :title, [:current, './/td[@class="title"]/a']
    string :url, [:current,  './/td[@class="title"]/a/@href']

    # Lookup xpath and store result as `data` for future use.
    fragment :data, [:current, 'following-sibling::tr']

    integer :points, [:data, './/span[@class="score"]', /(\d+) points/]
    string :user, [:data, './/a[@class="hnuser"]']
    string :posted, [:data,  './/span[@class="age"]']
  end

  group :stats do
    integer :item_count, proc { items.count }
    value :most_popular, proc { items.max_by { |i| i[:points] } }
  end
end
```
