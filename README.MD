# MultiScraper

***Uploaded to GitHub for posterity, I don't recommended you use this. Try [Scrapy](https://scrapy.org/) or [Wombat](https://github.com/felipecsl/wombat) instead.***  


A structured web scraper.

This was designed to pull data from multiple sources and return it a structured way, ready to be validate and saved. So pretty much the extract and transform steps of ETL.

This was recovered, as such is not functional and tests were lost.

There is also the [v1 branch](https://github.com/harrisbaird/multi_scraper/tree/v1) which is functional and has tests.

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

Run the scraper with `HackerNewsScraper.parse`.


```ruby
{
  items: [
    {
      title: "Why do investment bankers feel their jobs are safe from automation?",
      url: "https://www.quora.com/Why-do-traders-in-investment-banks-feel-their-jobs-are-immune-from-AI-automation-and-deep-learning?share=1",
      points: 54,
      user: "aburan28",
      posted: "2 hours ago"
    }
    # snipped 29 more items
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
