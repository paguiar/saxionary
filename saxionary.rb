require 'optparse'
require_relative 'wiktionary_pronunciation'
require_relative 'wiktionary_vocabulary'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: saxionary.rb [options]"

  opts.on('-d', '--document DOCUMENT', 'Document type') { |v| options[:document] = v }
  opts.on('-w', '--wiktionary WIKTIONARY_DUMP', 'Path to wiktionary dump') { |v| options[:wiktionary] = v }
end.parse!

raise OptionParser::MissingArgument if options[:document].nil?
raise OptionParser::MissingArgument if options[:wiktionary].nil?

document = nil

case options[:document]
when "pronunciation"
  document = WiktionaryPronunciation.new
when "vocabulary"
  document = WiktionaryVocabulary.new
else
  puts "Unrecognized document type"
  raise ArgumentError.new
end

parser = Nokogiri::XML::SAX::Parser.new(document)

parser.parse(File.open(options[:wiktionary]))

#ruby saxionary.rb -d vocabulary -w ~/Documents/frw/frwiktionary-20200120-pages-meta-current.xml
