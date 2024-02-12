namespace :pals do
  task scrape: :environment do
    url = 'https://palworld.wiki.gg/wiki/Pals'
    main_target = 'table.sortable.mw-collapsible.wikitable.jquery-tablesorter tbody tr'
    pal_scraper = Scraper.new(url, main_target)
    pal_scraper.scrape do |tr|
      name = tr.xpath()
    end
  end
end
