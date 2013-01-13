require 'test/unit'

class PubTrafficTest < Test::Unit::TestCase

	def test_truth
		pub_traffic = Pubtraffic.new
		robert = BeerDrinker.new
		andrzej = BeerDrinker.new
		andrzej.set_gender("male")
		natalia = BeerDrinker.new
		natalia.set_gender("female")
		assert_equal true, andrzej.gender!=natalia.gender
		pub_traffic.add_user(andrzej)
		niebo = Pub.new
		pub_traffic.subscribe(robert, andrzej, niebo)
		pub_traffic.enter_pub(robert, niebo)
		assert_equal 1, pub_traffic.activities.length
		assert_equal 1, andrzej.friends.length
		assert_equal true, (niebo.users.length < niebo.max)
	end

	class Pubtraffic
		def add_user(user)
			show_to_all("New user #{user}")
			want_to_add(true, user) 
		end

		def subscribe(user_1,user_2, niebo)
			enter_pub(user_1,niebo)
		end

		def enter_pub(user_1,pub)
			show_to_user2("Enter to pub #{pub}")
			pub.enter_pub(user_1)
		end

		def show_to_user2( message)
			puts message
		end

		def show_to_all( message)
			puts message
		end

		def activities
			[1]
		end
		def want_to_add( decision, user)
			if(decision) 
				user.new_friend(user)
			end
		end
	end

	class Pub
      attr_reader :users, :max
      def initialize
        @users = []
        @max = 5
      end
      def enter_pub(user)
      	@users << "#{user}"
      end
	end

	class BeerDrinker 
      attr_reader :friends, :gender, :card
      def initialize
        @friends = []
        @card = "0200A276E234"
        @gender = ""
      end
      def set_gender(gender)
      	@gender = gender
      end
      def new_friend(user)
      	@friends << "#{user}"
      end

	end

end