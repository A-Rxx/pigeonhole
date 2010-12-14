class Package
  
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend  ActiveModel::Translation
  extend  ActiveModel::Naming
  
  attr_accessor :body, :time
  attr_reader   :id, :key
  
  def initialize(args={})
    @id   = args.fetch(:id, SecureRandom.hex(3))
    @key  = args.fetch(:key, String.random)
    @body = args.fetch(:body, nil)
    @time = Time.new.utc
    self
  end
  
  def self.find(args={})
    new(args).load
  end
  
  def path
    File.join(PATH_UPLOAD, @id)
  end
  
  def save
    return false unless (errors.empty? and valid?)
    File.open(path, 'wb') { |f| f.write serialize.encrypted(@key) }
    exists?
  end
  
  def exists?
    File.file?(path)
  end
  
  def load
    if exists? and raw = File.read(path).decrypted(@key)
      unserialize(raw)
    else
      # sleep 3 if @key
      nil
    end
  end
  
  def destroy
    begin
      File.delete(path)
      exists?
    rescue Errno::ENOENT => e
      false
    end
  end
  
  # Mandatory for ActiveModel
  def persisted?
    false
  end
  
  def serialize
    { :body => body,
      :time => time }.to_yaml
  end
    
  def timestamp
    @time.to_s(:nicedate) + ', ' + @time.to_s(:nicetime) + ' UTC'
  end
  
  def filename
    @time.to_s(:file) + '.txt'
  end
  
  def unserialize(raw)
    yaml = YAML.load(raw)
    @body = yaml.fetch(:body, nil)
    @time = yaml.fetch(:time, nil)
    self
  end
  
  def to_download
    timestamp + "\n" + Array.new(13, '.').join(' ') + "\n\n" + body
  end
  
end