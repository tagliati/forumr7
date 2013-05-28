#encoding: utf-8
#
module Blacklist
  class << self
   mattr_accessor :word,:original_word
    def getChars
      letters = { "a"=> "a,á,à,ã,â,ä,å,4,ª,@","b"=>"b","c"=>"c,ç","d"=>"d","e"=>"e,é,è,ê,ë,&,3,³","f"=>"f","g"=>"g","h"=>"h","i"=>"i,í,ì,î,ï,!,|,1,¹","j"=>"j","k"=>"k","l"=>"l","m"=>"m","n"=>"n","o"=>"0,o,ó,ò,õ,ô,ö","p"=>"p","q"=>"q","r"=>"r","s"=>"s,$,5","t"=>"t,7","u"=>"u,ú,ù,û,ü","v"=>"v","w"=>"w","x"=>"x","y"=>"y,ý,ÿ","z"=>"z,2,²"}
    end

    def Blacklist.normalize_word
      nword = ""
      self.word.split("").each do |i|
        unless self.getChars.has_key?(i.downcase)
          self.getChars().each do |c,v|
            if v.include?(i)
              i = c
              break
            end
          end
        end
          nword << i
      end
      self.word = nword
    end

    def validate_word
      unless Badword.where(:word => self.word).count.zero?
        self.word.gsub!(/./,"x")
      else
        self.word = self.original_word
      end
    end

    def censor
      self.normalize_word()
      self.validate_word()
    end

    def set_word(word)
      self.original_word = word
      self.word = word
    end

    def validate_comment(comment)
      comment.split(" ").each do |word|
        if word.size > 1
          self.set_word(word)
          self.censor
          if self.word != self.original_word
            comment.sub! self.original_word ,self.word
          end
        end
      end
      comment
    end
  end
end
