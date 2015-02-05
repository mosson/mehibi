require 'spec_helper'

describe Mehibi::Line do
  let(:line) { described_class.new('hoge') }
  describe 'メソッド' do
    describe '#initialize(text)' do
      it '引数のtextをタブで区切った配列を@sectionにアサインする' do
        line = described_class.new("ほげ\tふが")
        expect(line.instance_variable_get(:@section)).to match_array(%w(ほげ ふが))
      end
    end

    describe '#terms' do
      it 'term, term_kana, term_romaの戻り値からなる配列からnilを除いたもの返す' do
        allow(line).to receive(:term).and_return('hoge')
        allow(line).to receive(:term_kana).and_return('kana')
        allow(line).to receive(:term_roma).and_return(nil)
        expect(line.terms).to match_array(%w(hoge kana))
      end

      it 'mecabの出力をパースして配列として候補の文字列を返す' do
        line1 = described_class.new('すもも	名詞,一般,*,*,*,*,すもも,スモモ,スモモ')
        expect(line1.terms).to eq %w(すもも スモモ sumomo)

        line2 = described_class.new('EOF')
        expect(line2.terms).to eq []
      end
    end

    describe '#term' do
      it 'noun?がfalsyを返すときnilを返す' do
        allow(line).to receive(:noun?).and_return(false)
        expect(line.term).to eq nil
      end

      it 'noun?がfalsyを返さないときはsection[0]を返す' do
        allow(line).to receive(:noun?).and_return(true)
        expect(line.term).to eq 'hoge'
      end
    end

    describe '#term_kana' do
      it 'noun?がfalsyを返すときnilを返す' do
        allow(line).to receive(:noun?).and_return(false)
        expect(line.term_kana).to eq nil
      end

      it 'noun?がfalsyを返さないときはdescription[7]を返す' do
        line = described_class.new("ほげ\t1,2,3,4,5,6,7,8")
        allow(line).to receive(:noun?).and_return(true)
        expect(line.description).to eq %w(1 2 3 4 5 6 7 8)
        expect(line.term_kana).to eq '8'
      end
    end

    describe '#term_roma' do
      it 'noun?がfalsyを返すときnilを返す' do
        allow(line).to receive(:noun?).and_return(false)
        expect(line.term_roma).to eq nil
      end

      it 'noun?がfalsyを返さないときはterm_kanaをRomaji#kana2romajiに渡した値を返す' do
        allow(line).to receive(:noun?).and_return(true)

        allow(line).to receive(:term_kana).and_return('かな')
        allow(Romaji).to receive(:kana2romaji).and_return('kana')

        expect(line.term_roma).to eq 'kana'
      end
    end

    describe '#speech' do
      it 'descriptionの最初の要素を返す' do
        allow(line).to receive(:description).and_return([0, 1, 2])
        expect(line.speech).to eq 0
      end
    end

    describe '#description' do
      it 'section[1]をカンマで区切った配列を返す' do
        line = described_class.new("ほげ\thoge,hogehoge,fugafuga")
        expect(line.section[1]).to eq 'hoge,hogehoge,fugafuga'
        expect(line.description).to eq %w(hoge hogehoge fugafuga)

        line = described_class.new('EOF')
        expect(line.section[1]).to eq nil
        expect(line.description).to eq []
      end
    end

    describe '#noun?' do
      it 'speechが名詞をふくむときtruthyを返す' do
        allow(line).to receive(:speech).and_return('めい名詞めい')
        expect(line.noun?).to be_truthy

        allow(line).to receive(:speech).and_return('めいめい')
        expect(line.noun?).not_to be_truthy
      end
    end
  end
end
