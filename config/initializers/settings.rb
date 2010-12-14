PATH_UPLOAD = File.join Rails.root, 'private'

Time::DATE_FORMATS.merge!(
  :nicedate    => '%d.%m.%Y',
  :nicetime    => '%H:%M:%S',
  :file   => '%y.%m.%d_%H.%M.%S'
)
