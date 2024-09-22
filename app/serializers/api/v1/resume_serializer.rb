module Api
  module V1
    class ResumeSerializer < ActiveModel::Serializer
      attributes :id, :title, :description, :hobbies, :active
      
      belongs_to :user, serializer: Api::V1::UserSerializer
      has_many :schools, serializer: Api::V1::SchoolSerializer

      def description
        content = object.description.to_plain_text
        content.present? ? content : nil
      end
    end
  end
end