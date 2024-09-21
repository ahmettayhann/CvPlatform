module Api
  module V1
    class SchoolSerializer < ActiveModel::Serializer
      attributes :id, :name
    end
  end
end