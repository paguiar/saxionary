require_relative 'wiktionary_page'

class WiktionaryVocabulary < WiktionaryPage
  def handle_page
    super

    if @title_is_of_interest
      #puts @page_text

      if page_text_fr = french_only

        cached_name = "cache/#{@page_title}"
        IO.write(cached_name, page_text_fr)
      end

    end
  end

  def french_only
    text_split = @page_text.split("\n").map do |line|
      line.strip
    end.join("\n")

    if m = @page_text.match(/^==\s?{{langue\|fr}}\s?==[^=](.+)/m)
      before_french_removed = m[1]
      if m = before_french_removed.match(/(.+?)^==[^=]/m)
        french = m[1]
      else
        french = before_french_removed
      end
    else
      #puts "French not found!?!"
      return nil
    end

  end
end
