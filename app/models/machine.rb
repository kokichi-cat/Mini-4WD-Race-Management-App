class Machine < ApplicationRecord
  belongs_to :event # イベントとの関連付け
  has_many :gimmicks, dependent: :destroy # ギミックとの関連付け
  accepts_nested_attributes_for :gimmicks, allow_destroy: true
  has_many :breakes, dependent: :destroy # ブレーキとの関連付け
  has_many :mass_dampers, dependent: :destroy # マスダンパーとの関連付け
  has_many :machine_photos, dependent: :destroy # マシーン写真との関連付け
  validates :event, presence: true
  # validates :machine_name, presence: true
  accepts_nested_attributes_for :machine_photos, allow_destroy: true


  # モーターの選択肢
  enum motor: {
    mahha: 0, hyper: 1, sprint: 2, pawerda: 3, light: 4, rev: 5, torque: 6, atomi: 7, nomamo: 8, mini: 9, touch: 10, zen: 11, jet: 12, ultra: 13, plasma: 14, other: 15
  }

  # ギア比の選択肢
  enum gear_ratio: {
    ratio_3_5_1: 0, ratio_3_7_1: 1, ratio_4_1: 2, ratio_4_2_1: 3, ratio_5_1: 4, ratio_6_4_1: 5, ratio_8_75_1: 6, ratio_11_2_1: 7
  }

  # シャーシの選択肢
  enum frame: {
    ms: 0, ma: 1, fma: 2, s2: 3, vs: 4, vz: 5,
    x: 6, xx: 7, type1: 8, type2: 9, type3: 10,
    type4: 11, type5: 12, zero: 13, fm: 14, sfm: 15,
    s1: 16, tz: 17, tzx: 18
  }
end
