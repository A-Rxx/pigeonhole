PRIVATE_PATH = File.join(Rails.root, 'private')

# More examples:
# PRIVATE_UPLOAD_PATH = File.join(Rails.root, 'private', 'uploads')
# PUBLIC_UPLOAD_PATH = File.join(Rails.root, 'public', 'images', 'uploads')

[PRIVATE_PATH].each do |path|
  Dir.mkdir(path) unless File.directory?(path)
end
