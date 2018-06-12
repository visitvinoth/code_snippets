require 'digest/sha1'
require 'json'

class Block
  GENESIS_HASH = 'SOME HASH FOR THE GENESIS BLOCK'
  attr_reader :data, :previous_block_hash
  def initialize(data, previous_block_hash)
    raise ArgumentError.new("Previous Block Hash Cannot Be Blank") if previous_block_hash.nil?
    self.data = data
    self.previous_block_hash = previous_block_hash
  end

  def genesis_block?
    previous_block_hash == GENESIS_HASH
  end

  def block_json
    {
      data: self.data,
      previous_block_hash: self.previous_block_hash
    }.to_json
  end

  def hash
    Digest::SHA1.hexdigest block_json
  end

  def store!
    out_file = File.new("blocks/#{hash}.block", "w")
    out_file.puts(block_json)
    out_file.close
  end

end
