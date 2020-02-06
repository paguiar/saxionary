require 'nokogiri'

class WiktionaryPage < Nokogiri::XML::SAX::Document
  @@title_tag = "title"
  @@page_tag = "page"

  def initialize
    @page_text = ""
    @handled_pages_counter = 0
    @is_within_element = {}
  end

  def start_element name, attrs = []
    update_within_element_state name, true

    if name == @@page_tag
      @page_text = ""
    end

    if name == @@title_tag
      @page_title = ""
      @title_is_of_interest = false
    end
  end

  def characters s
    if @is_within_element[@@title_tag]
      @page_title += s
    end

    if @is_within_element["text"] && @title_is_of_interest
      @page_text += s
    end
  end

  def end_element name
    update_within_element_state name, false

    if name == @@page_tag
      handle_page
    end

    if name == @@title_tag
      @title_is_of_interest = !(@page_title =~ /[:\/]/)
    end
  end

  def update_within_element_state name, state
    @is_within_element[name] = state
  end

  def handle_page
    if @title_is_of_interest
      @handled_pages_counter += 1
    end
  end
end

