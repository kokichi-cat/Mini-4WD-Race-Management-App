class Event < ApplicationRecord
  validates :weather, length: { maximum: 255 } # 値が空でない事を確認し、文字数の最大値を制限する　天気
  validates :temperature, length: { maximum: 255 } # 気温
  validates :event_name, presence: true, length: { maximum: 255 } # 大会、イベント名
  validates :venue, presence: true, length: { maximum: 255 } # 店舗
  validates :coment, length: { maximum: 65_535 }
  validates :link, format: { with: URI::DEFAULT_PARSER.make_regexp, allow_blank: true }, if: :link_present?

  belongs_to :user # EventモデルがUserモデルに属している
  validates :user, presence: true # ログイン中のユーザーを自動的に関連付けられるようになる
  has_many :course_photos, dependent: :destroy # コース写真との関連
  has_many :machines, dependent: :destroy # マシーンとの関連
  has_many :race_times, dependent: :destroy # レースタイムとの関連
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user

  accepts_nested_attributes_for :race_times # ネストされたフォームからrace_timeを保存可能にする
  accepts_nested_attributes_for :machines, allow_destroy: true
  accepts_nested_attributes_for :course_photos, allow_destroy: true

  acts_as_taggable_on :tags # :tags はカスタマイズ可能,タグ機能を追加する記述

  # リンクを分割して配列として返すメソッド
  def links
    link.present? ? link.split(",").map(&:strip) : []
  end

  private

  # リンクが存在しているか確認するメソッド
  def link_present?
    link.present?
  end
end
