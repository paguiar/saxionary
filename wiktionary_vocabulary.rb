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
        if m = @page_text.match(/^== {{langue\|fr}} ==.*?^==[^=]/m)
            m[0]
        else
            #puts "French not found!?!"
            nil
        end
    end
end
