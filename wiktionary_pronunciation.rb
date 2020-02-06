require_relative 'wiktionary_page'

class WiktionaryPronunciation < WiktionaryPage
  def handle_page
    super

    if @title_is_of_interest
      pronunciation = extract_pronunciation_from @page_text
      if pronunciation
        puts "#{@page_title}\t#{pronunciation}"
        $stdout.flush
      end
    end
  end

  def extract_pronunciation_from text
    pronunciation = /{fr-rég[^|]*\|([^{}|=]+)}/.match text

    if pronunciation
      raw_pronunciation = $1
      cleaned_pronunciation = clean_pronunciation raw_pronunciation
      return cleaned_pronunciation
    end

    return nil
  end

  def clean_pronunciation raw_pronunciation
    cleaned_pronunciation = raw_pronunciation.gsub ".", ""
    return cleaned_pronunciation
  end
end
