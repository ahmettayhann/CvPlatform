module Api
  module V1
    class ResumeListSerializer < ActiveModel::Serializer
      attributes :id, :title, :full_name

      def full_name
        object.user.full_name
      end
    end
  end
end