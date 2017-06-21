class Game < ApplicationRecord
	has_many :buys
	validates :title,{
  		length: { minimum: 10,  maximum: 50 },
  		presence: true
		}
	validates :description,{
  		length: { minimum: 30 },
  		presence: true
		}
	validates :image_url,{
  		presence: true
		}

	def is_buy_by_the_user(user_id)
		buy = Buy.where(:user_id=> user_id).where(:game_id=>id)
		if buy.empty?
			return false
		else
			return true
		end
	end

end
