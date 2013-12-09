# cost basis class if I'm using that term correctly

class Basis

  # load our costs and portfolio standings
  def self.costs
    @@basis = YAML.load(File.open('basis.yml'))
  end

end