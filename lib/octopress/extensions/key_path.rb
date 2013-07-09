class Hash
  # {a: 1, b: {c: 2, d: {e: 3, f: 4}, g: 5}}.key_paths.to_key_chain
  #=> [:a, {b: [:c, {d: [:e, :f]}, :g] }]
  def key_paths
    keys.map do |key|
      if self[key].is_a?(Hash)
        {key => self[key].key_paths}
      else
        key
      end
    end
  end
end

class Array
  # [:a, {b: [:c, {d: [:e, :f]}, :g] }].to_key_chain
  # [
  #   [:a],
  #   [:b, :c,],
  #   [:b, :d, :e],
  #   [:b, :d, :f],
  #   [:b, :g]
  # ]
  def to_key_chains
    chain = []
    each do |key_path|
      if key_path.is_a? Hash
        key = key_path.keys.first
        key_path[key].to_key_chains.each do |interior_chain|
          chain << interior_chain.unshift(key)
        end
      else
        chain << [key_path]
      end
    end
    chain
  end
end
