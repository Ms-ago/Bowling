# コマンドラインから引数を取る
score = ARGV[0]
# 引数を一文字ずつに区切る
scores = score.chars
# 引数を数字に変換して配列に加える
shots = []
scores.each do |score|
  if score == 'X'
    shots << 10
    shots << 0
  else
    shots << score.to_i
  end
end

# 2つずつに区切ってフレームを作る
frames = []
shots.each_slice(2) do |frame|
  frames << frame
end

# 10投目に3回投げれる場合、11個目の要素を参照して10個目の要素に追加する
frames.each_with_index do |frame, index|
  # ストライクの場合
  if index == 9 && (frame[0] == 10)
    nextFrame = frames[index + 1]
    frame.pop(1)
    frame << nextFrame[0]
    frame << nextFrame[0]
    frames.pop(2)
  # スペアの場合
  elsif index == 9 && (frame[0] + frame[1] == 10)
    nextFrame = frames[index + 1]
    frame << nextFrame[0]
    frames.pop(1)
  end
end

# スペア・ストライク時の加点
frames.each_with_index do |frame, index|
  # ストライク
  if frame.size == 2 && (frame[0] == 10)
    nextFrame = frames[index + 1]
    frame << nextFrame[0] << nextFrame[1]
  # スペア
  elsif frame.size == 2 && (frame[0] + frame[1] == 10)
    nextFrame = frames[index + 1]
    frame << nextFrame[0]
  end
end

# 計算する
point = 0
frames.each do |frame|
  point += frame.sum
end
puts point
