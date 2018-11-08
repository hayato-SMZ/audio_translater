# audio_translater
## 概要
- [sox](http://sox.sourceforge.net/)とrakeで音声を一括変換するツール集
- targetフォルダに入っているwavファイルの変換する
- 

### mp3ファイルに変換をする場合
` rake mp3`

- mp3をモノラルに変換する場合には
` rake monomp3 `

### 音声ファイルを無音で区切る
` rake split `

- うまく区切れない，音が落ちる場合にはrakeファイルのauto_spritのsilence 以下の数値を調整する。

### 音量の調整＆モノラル化
` rake set_volandmono`