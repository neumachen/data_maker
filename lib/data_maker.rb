module DataMaker
  VERSION = "2.1.1"

  require 'data_maker/utilities/array_utilities'
  require 'data_maker/utilities/module_utilities'

  extend ModuleUtilities

  BASE_LIB_PATH = File.expand_path("..", __FILE__)

  LETTERS = [*'a'..'z']

  HEX = %w(0 1 2 3 4 5 6 7 8 9 A B C D E F)

  def self.hexify(*masks)
    begin
      if valid_mask?(*masks, /#/)
        masks.flatten.sample.gsub(/#/) { HEX.sample }
      end
    rescue
      return false
    end
  end

  def self.numerify(*masks)
    begin
      if valid_mask?(*masks, /#/)
        masks.flatten.sample.gsub(/#/) { rand(10).to_s }
      end
    rescue
      return false
    end
  end

  def self.letterify(*masks)
    begin
      if valid_mask?(*masks, /\?/)
        masks.flatten.sample.gsub(/\?/) { LETTERS.sample }
      end
    rescue
      return false
    end
  end

  def self.alphanumerify(masks)
    letterify(numerify(masks))
  end

  # Load all constants.
  Dir["#{BASE_LIB_PATH}/data_maker/**/*.rb"].sort.each do |f|
    require f
  end

  def self.valid_mask?(*masks, match_with)
    masks.each do |mask|
      unless mask.match(match_with)
        raise ArgumentError, "You must pass a #{match_with} sign sir!"
      end
    end
  end

  private_class_method :valid_mask?
end
