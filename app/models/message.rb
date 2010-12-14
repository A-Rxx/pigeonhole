class Message < Package

  attr_accessor :attachment, :mime, :name
  
  def initialize(args={})
    super
    @id         = args.fetch(:id, SecureRandom.hex(3))
    @attachment = args.fetch(:attachment, nil)
    @mime       = args.fetch(:mime, 'text/plain')
    @name       = args.fetch(:name, filename)
    self
  end

  validates :key, :presence => true, :length => { :within => 9..20 }
  
  def serialize
    { :body => body,
      :attachment => attachment,
      :time => time,
      :mime => mime,
      :name => name }.to_yaml
  end
  
  def unserialize(raw)
    yaml = YAML.load(raw)
    @body       = yaml.fetch(:body, nil)
    @attachment = yaml.fetch(:attachment, nil)
    @time       = yaml.fetch(:time, nil)
    @mime       = yaml.fetch(:mime, nil)
    @name       = yaml.fetch(:name, nil)
    self
  end
  
  def to_download
    timestamp + ", Attachment: #{name}" + "\n" + Array.new((20 + (name.length/2)), '.').join(' ') + "\n\n" + body
  end
  

end