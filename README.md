# Mehibi

入力された文字列を検索用に分割して、かな、カナ、ローマ字表記の配列を返すライブラリ

シェル上で`mecab`コマンドが必要です

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mehibi', github: 'https://github.com/mosson/mehibi'
```

And then execute:

    $ bundle

## Usage

```ruby
Mehibi::Processor.new('すもももももも').terms
  # => %W(すもももももも すもも スモモ もも モモ sumomo momo)
```

## Contributing

1. Fork it ( https://github.com/mosson/mehibi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
