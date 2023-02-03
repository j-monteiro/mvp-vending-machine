# frozen_string_literal: true

module Services
  module Users
    class Delete
      def perform(user_id:)
        User.delete(user_id)
      end
    end
  end
end
