require 'spec_helper'

describe Mehibi::Processor do
  let(:processor) { described_class.new nil }

  describe 'メソッド' do
    describe '#initialize(term, additional_terms)' do
      it '@term, @additional_termsに引数をセットする' do
        processor = described_class.new('hoge', 'fuga')
        expect(processor.instance_variable_get(:@term)).to eq 'hoge'
        expect(processor.instance_variable_get(:@additional_terms)).to eq 'fuga'
      end
    end

    describe '#terms' do
      it 'analyzed, term, additional_termsからなる配列を返す' do
        allow(processor).to receive(:analyzed).and_return ['hoge']
        allow(processor).to receive(:term).and_return 'fuga'
        allow(processor).to receive(:additional_terms).and_return ['piyo']

        expect(processor.terms).to match_array %w(hoge fuga piyo)
      end

      it 'termをかな、ローマ字表記に分割して配列として返す' do
        processor = described_class.new('すもももももも')
        expect(processor.terms).to match_array(%w(すもももももも すもも スモモ もも モモ sumomo momo))
      end
    end

    describe '#analyzed' do
      it 'splitの戻り値すべてをanalyzeに送って集めた値を返す' do
        allow(processor).to receive(:split).and_return([1, 2, 3])
        expect(processor).to receive(:analyze).with(1).exactly(1).times.and_return('hoge')
        expect(processor).to receive(:analyze).with(2).exactly(1).times.and_return('fuga')
        expect(processor).to receive(:analyze).with(3).exactly(1).times.and_return('piyo')
        expect(processor.analyzed).to match_array %w(hoge fuga piyo)
      end
    end

    describe '#split' do
      it 'execの戻り値を改行文字で分割した配列を返す' do
        allow(processor).to receive(:exec).and_return("あ\nい\nう")
        expect(processor.split).to match_array %w(あ い う)
      end
    end

    describe '#analyze(text)' do
      it '引数のテキストをLine.newに渡しtermsをよんだ値を返す' do
        line = Struct.new(:hoge) do
          def terms(*_args)
            'hoge'
          end
        end.new
        expect(line).to receive(:terms).and_call_original
        expect(::Mehibi::Line).to receive(:new).with('fuga').exactly(1).times.and_return(line)
        expect(processor.analyze('fuga')).to eq 'hoge'
      end
    end
  end
end
