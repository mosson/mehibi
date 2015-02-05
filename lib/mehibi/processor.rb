module Mehibi
  class Processor
    attr_reader :term, :additional_terms

    def initialize(term, additional_terms = [])
      @term = term
      @additional_terms = additional_terms
    end

    def terms
      ([analyzed, term] + additional_terms)
        .flatten
        .compact
        .uniq
    end

    def analyzed
      split.map(&method(:analyze))
    end

    def split
      exec.split("\n")
    end

    def exec
      `echo "#{term}" | mecab`
    end

    def analyze(text)
      ::Mehibi::Line.new(text).terms
    end
  end
end
