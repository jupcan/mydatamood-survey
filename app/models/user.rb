class User < ApplicationRecord
    after_initialize :generate_uuid
    has_many :interests
end
