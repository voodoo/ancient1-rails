class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.present? && url_valid?(value)
      record.errors.add(attribute, "must be a valid URL")
    end
  end

  private

  def url_valid?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end