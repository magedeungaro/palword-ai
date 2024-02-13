namespace :pals do
  task scrape: :environment do
    def validate
      raise ArgumentError, 'Element table is empty. Run seed first.' if Element.count.zero?
    end

    def create_pal(name)
      Pal.find_or_create_by!(name:)
    end

    def create_pal_element(pal, pal_element)
      element = Element.find_by(name: pal_element)
      pal.pal_elements.find_or_create_by!(element:)
    end

    def create_pal_work_suitability(pal, work_suitability_el)
      work_suitability_regex = /(?<skill>.*)\sLv\s*(?<level>\d+)/
      match = work_suitability_el.text.strip.match(work_suitability_regex)
      name = match[:skill].downcase.strip
      level = match[:level].to_i

      work_suitability = WorkSuitability.find_by(name:)
      pal.pal_work_suitabilities.find_or_create_by!(work_suitability:, level:)
    end
    
    validate
    url = 'https://palworld.wiki.gg/wiki/Pals'
    main_target = 'tbody tr'
    pal_scraper = Scraper.new(url:, main_target:)

    pal_scraper.scrape do |tr|
      pal_name = tr.search('td:nth-child(1) span.infoicon a:nth-child(2)').text.strip.downcase
      pal = create_pal(pal_name)

      return unless pal

      elements = tr.search('td:nth-child(4) span.infoicon a:nth-child(2)').each do |element|
        pal_element = element.text.strip.downcase
        create_pal_element(pal, pal_element)
      end
      
      work_suitabilities = tr.search('td:nth-child(5)').each do |work_suitability|
        create_pal_work_suitability(pal, work_suitability)
      end
    end
  end
end
