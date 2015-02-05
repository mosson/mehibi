require 'romaji'

module Mehibi
  class Line
    attr_reader :section

    def initialize(text)
      @section = text.to_s.split("\t")
    end

    def terms
      @terms ||= [term, term_kana, term_roma].compact
    end

    def term
      return unless noun?
      @term ||= section[0]
    end

    def term_kana
      return unless noun?
      @term_kana ||= description[7]
    end

    def term_roma
      return unless noun?
      @term_roma ||= Romaji.kana2romaji(term_kana.to_s)
    end

    def speech
      @speech ||= description.first
    end

    def description
      @description ||= (section[1] || '').split(',')
    end

    def noun?
      /名詞/ =~ speech.to_s
    end
  end
end
