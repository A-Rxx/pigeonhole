class Binary < Tape
  
  attr_accessor :mime, :name
  
  validates :body, :presence => true
  
  def initialize(args={})
    super
    @id   = args.fetch(:id, SecureRandom.hex(4))
    @mime = args.fetch(:mime, 'text/plain')
    @name = args.fetch(:name, filename)
    self
  end
  
  def serialize
    { :body => body,
      :time => time,
      :mime => mime,
      :name => name }.to_yaml
  end
  
  def unserialize(raw)
    yaml = YAML.load(raw)
    @body = yaml.fetch(:body, nil)
    @time = yaml.fetch(:time, nil)
    @mime = yaml.fetch(:mime, nil)
    @name = yaml.fetch(:name, nil)
    self
  end
  
end