# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, foreign_key: 'author_id', dependent: :destroy
  has_many :answers, foreign_key: 'author_id', dependent: :destroy
  has_many :rewards
  has_many :votes, dependent: :destroy

  def author_of?(object)
    id == object.author_id
  end

  def voted_for?(object)
    votes.exists?(votable: object)
  end

  def assign_reward(reward)
    if rewards.include?(reward)
      reward.update(user: nil)
    else
      rewards << reward
    end
  end
end
