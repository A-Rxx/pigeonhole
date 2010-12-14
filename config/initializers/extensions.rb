Dir.glob(Rails.root.join('lib', 'core_extensions', '*.rb')) { |file| require file }
Dir.glob(Rails.root.join('lib', 'rails_extensions', '*.rb')) { |file| require file }
Dir.glob(Rails.root.join('lib', 'gem_extensions', '*.rb')) { |file| require file }
Dir.glob(Rails.root.join('lib', 'pigeonhole', '*.rb')) { |file| require file }
