module MovingsHelper
  # 1 ft3 = 35.315 m3
  def m3_to_ft3(value)
    (value * 35.315).round(2)
  end

  def ft3_to_m3(value)
    (value / 35.315).round(2)
  end
end
