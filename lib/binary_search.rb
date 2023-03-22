class BinaryChop
  def initialize(array, target)
    @array = array
    @target = target
    @num_threads = 2
  end

  def binary_search
    return -1 if @array.empty? || !@array.include?(@target)

    chunk_size = (@array.length / @num_threads).ceil
    result = 0
    threads = []

    @num_threads.times do |i|
      low = i * chunk_size
      high = [low + chunk_size - 1, @array.length - 1].min
      threads << Thread.new do
        (low..high).each do |j|
          if @array[j] == @target
            result = j
            break
          end
        end
      end
    end
    threads.each { |t| t.join }
    result
  end
end
