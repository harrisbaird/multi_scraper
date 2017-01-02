# MultiScraper

A web scraper which uses Ruby's metaprogramming to extract data from one or more sources, processes it and returns it in a structured way.

***This is just a test***, you really shouldn't use this, try [Wombat](https://github.com/felipecsl/wombat) instead.

## Example
```ruby
require 'multi_scraper'

class HackerNewsScraper
  include MultiScraper

  page :hn, url: 'https://news.ycombinator.com/'

  array :items, hn_xpath: '//tr[@class="athing"]' do |entry|
    string  :title,  entry_xpath: './/td[@class="title"]/a'
    string  :url,    entry_xpath: './/td[@class="title"]/a/@href'

    # Lookup node and save it as `data` for future use
    node    :data,   entry_xpath: 'following-sibling::tr'

    integer :points, data_xpath: './/span[@class="score"]',
                     regex: [/(\d+) points/, 1]
    string  :user,   data_xpath: './/a[@class="hnuser"]'
    string  :posted, data_xpath: './/span[@class="age"]'
  end

  group :stats do
    integer :item_count,   with: proc { items.count }
    value   :most_popular, with: proc { items.max_by { |i| i[:points] } }
  end
end

HackerNewsScraper.fetch

{
  items: [
    {
      title: "Why do investment bankers feel their jobs are safe from automation?",
      url: "https://www.quora.com/Why-do-traders-in-investment-banks-feel-their-jobs-are-immune-from-AI-automation-and-deep-learning?share=1",
      points: 54,
      user: "aburan28",
      posted: "2 hours ago"
    }
    # ...
  ],
  stats: {
    item_count: 30,
    most_popular: {
      title: "The moving sofa problem",
      url: "https://www.math.ucdavis.edu/~romik/movingsofa/",
      points: 496,
      user: "vinnyglennon",
      posted: "15 hours ago"
    }
  }
}
```
