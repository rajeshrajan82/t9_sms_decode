class HomeController < ApplicationController
  def get_decoded_value
    sentence = ""
    params[:id].strip.split("0").each do |decoded_word|
      sentence += " " + get_word(decoded_word)
    end
    respond_to do |format|
      format.json {render :json => {:status => "ok", :data => sentence.strip}}
    end
  end
  
  def get_word(decoded_word)
    word = char = ""
    chars = decoded_word.split("") 
    [chars, nil].flatten.each_cons(2) do |element, next_element|
      char += element.to_s
      if char == " " || next_element.nil? || !(char.include? next_element)
        word += PredictiveText::T9_SMS_CODE[char.to_i].to_s
        char = ""
      end  
    end
    word
  end
  
end
