# frozen_string_literal: true

module Cors
  module Helpers
    API_ORIGINS = %r{\Ahttps://([^.]+\.)?\.mycompany\.com\z}
    LOCALHOST_ORIGINS = %r{\Ahttp://localhost}
  end
end
