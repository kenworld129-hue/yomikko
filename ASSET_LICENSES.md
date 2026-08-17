# よみっこ — 使用素材ライセンス一覧

本アプリ「よみっこ」で使用している第三者素材のライセンス情報を一覧化したものです。
すべての素材について商用利用・アプリへの埋め込み配布が許諾されたものを採用しています。

最終更新：2026-08-17

---

## 1. イラスト

### 出典：Loose Drawing

- サイトURL：https://loosedrawing.com
- 利用規約：https://loosedrawing.com/terms/
- ライセンス概要：
  - 商用利用：可（個人/法人問わず無料）
  - クレジット表記：不要（任意でリンク掲載は推奨）
  - 改変（リサイズ・色変更等）：可
  - アプリへの埋め込み配布：可（規約 FAQ Q2「自社サービスのアプリ上で使用」に該当。利用は素材を「単語を表すサポート要素」として組み込む形であり、規約 Q3 の許可範囲内）

### 使用素材一覧（プリセット20語＋フォールバック1点）

命名規則：ローマ字ヘボン式・長音は母音重ね（例：たいよう→`taiyou`、ぼーる→`bouru`）。SwiftData の `Word.imagePath` と1:1で対応。

| # | 用途 | 単語 | imagePath | 素材URL |
|---|------|------|-----------|---------|
| 1 | プリセット | いぬ | `inu.png` | https://loosedrawing.com/illust/594/ |
| 2 | プリセット | ねこ | `neko.png` | https://loosedrawing.com/illust/506/ |
| 3 | プリセット | くるま | `kuruma.png` | https://loosedrawing.com/illust/444/ |
| 4 | プリセット | でんしゃ | `densha.png` | https://loosedrawing.com/illust/477/ |
| 5 | プリセット | りんご | `ringo.png` | https://loosedrawing.com/illust/331/ |
| 6 | プリセット | ばなな | `banana.png` | https://loosedrawing.com/illust/333/ |
| 7 | プリセット | はな | `hana.png` | https://loosedrawing.com/illust/1053/ |
| 8 | プリセット | ほん | `hon.png` | https://loosedrawing.com/illust/1177/ |
| 9 | プリセット | かばん | `kaban.png` | https://loosedrawing.com/illust/460/ |
| 10 | プリセット | くつ | `kutsu.png` | https://loosedrawing.com/illust/1617/ |
| 11 | プリセット | ぼーる | `bouru.png` | https://loosedrawing.com/illust/526/ |
| 12 | プリセット | たいよう | `taiyou.png` | https://loosedrawing.com/illust/554/ |
| 13 | プリセット | つき | `tsuki.png` | https://loosedrawing.com/illust/497/ |
| 14 | プリセット | ほし | `hoshi.png` | https://loosedrawing.com/illust/ic011/ |
| 15 | プリセット | みず | `mizu.png` | https://loosedrawing.com/illust/1060/ |
| 16 | プリセット | かさ | `kasa.png` | https://loosedrawing.com/illust/924/ |
| 17 | プリセット | いえ | `ie.png` | https://loosedrawing.com/illust/487/ |
| 18 | プリセット | きのこ | `kinoko.png` | https://loosedrawing.com/illust/378/ |
| 19 | プリセット | とり | `tori.png` | https://loosedrawing.com/illust/545/ |
| 20 | プリセット | さかな | `sakana.png` | https://loosedrawing.com/illust/820/ |
| 21 | フォールバック | （写真未登録単語の汎用表示） | `fallback.png` | https://loosedrawing.com/illust/681/ |

---

## 2. 効果音

### 出典：効果音ラボ

- サイトURL：https://soundeffect-lab.info
- 利用規約URL：https://soundeffect-lab.info/agreement/
- FAQ URL：https://soundeffect-lab.info/faq/
- ライセンス概要（2026-05-10 規約・FAQ 全文確認済）：
  - 商用利用：可（規約3項目目「個人、法人、公的機関問わず無料で使用可能（商用利用無料）」）
  - クレジット表記：不要（規約1項目目「使用にあたっての報告、リンク、クレジット表記不要」）
  - アプリへの埋め込み配布：可（**FAQ 9「再配布ではないケース」例1「アプリに操作音として組み込む」を直接根拠**。よみっこは正解/不正解時の固定タイミング再生のため、規約上 NG とされる「効果音を自由に鳴らせるアプリ」には該当しない）
  - GitHub 公開時の取り扱い：FAQ 6 で「音源ファイルむき出しでも可」と明示。よみっこは `raw_assets/` を gitignore で除外済のため、より安全側
  - 改変（トリミング・音量調整）：可（規約5項目目「効果音を改変して利用することは問題ない」。ただし改変したものの再配布は禁止）
  - 禁止事項該当：なし（再配布全般／素材販売／楽曲化による音商標登録／AI学習用利用／Content ID登録／効果音のみを流す動画公開のいずれにも該当しない）

### 使用素材一覧

| # | 用途 | ファイル名 | 素材URL |
|---|------|-----------|---------|
| 1 | 正解音 | `correct.mp3` | https://soundeffect-lab.info/sound/anime/mp3/correct1.mp3 |
| 2 | 不正解音 | `incorrect.mp3` | https://soundeffect-lab.info/sound/anime/mp3/stupid3.mp3 |

- 保存先：`/Users/kenshun/red/yomikko/raw_assets/sounds/`（gitignore除外）
- 形式：MPEG-3 / 44.1kHz / 2ch
- 長さ：correct.mp3 = 1.75秒（基準を「1〜2秒以内・耳触りよく明るく」に緩和して採用）／ incorrect.mp3 = 1.04秒
- 改変：なし（DL状態のまま採用）

---

## 3. アプリアイコン

### 制作方法：Canva で内製（自作デザイン）

- ファイルパス：`raw_assets/icon/icon_1024.png`
- 仕様：1024×1024px PNG / アルファチャネルなし / 透明背景なし（Apple HIG 準拠）
- デザイン仕様：A1/B2/C1/D1/E1/F1（ひらがな「よ」白文字・ブルー単色背景・サブ要素なし・装飾なし）
- 制作日：2026-05-10
- 制作者：umada kenshun（自作）

### 使用要素

| 要素 | 内容 | 出典 |
|------|------|------|
| 背景 | ブルー単色塗り | Canva のカラーツール（第三者素材なし） |
| 文字 | ひらがな「よ」（白） | Canva テキストツールで描画（フォントは下記） |
| 装飾 | なし | — |

**Canva 上で使用したのはテキストツールとカラーツールのみ。プリセット素材（イラスト・テンプレート・写真・図形パーツ）および Pro 限定素材は一切使用していない。**

### 使用フォント：Zen Maru Gothic

- ライセンス：**SIL Open Font License (OFL) 1.1**
- 商用利用・アプリへの埋め込み配布：可（OFL が明示的に許可）
- フォント改変：なし（標準のまま使用）
- 配布形態：アイコンとしては PNG にラスタライズして埋め込むのみ。**（2026-08-17 追記）** Phase 4 以降は同フォントをアプリ内書体としても採用し、ttf の同梱・再配布を開始（第5節参照。OFL.txt 同梱で再配布義務を充足）
- 入手元：Google Fonts ／ Canva 経由

### Canva 利用条件確認（2026-05-10）

- 商用利用：可（無料プラン・有料プラン同条件）
- クレジット表記：不要
- アプリアイコンとしての配布：可（一般的な商用デザインの範囲内）
- Pro 限定素材（王冠マーク付き）：使用していない
- **商標登録**：本アイコンを商標登録する予定なし（Canva 規約は「Canva で作成したデザインを商標登録すること」を禁止しているが、よみっこはアイコンの商標登録を行わないため抵触しない）
- 素材の無加工再配布：該当せず（アイコンは加工後のオリジナルデザイン）

### 第三者素材：実質なし

Canva の有償素材ライセンスが必要な要素は一切使用していない。フォント Zen Maru Gothic も OFL で商用埋め込み許諾済のため、第三者素材としての追加ライセンス義務はない。

---

## 4. マスコットキャラクター（読み上げ演出用）

### 制作方法：ChatGPT（OpenAI 画像生成）で生成

- 生成日：2026-07-01（フリープラン）
- 生成者：umada kenshun（プロンプト指示による生成）
- ファイル：口開け `mascot_open.png` ／ 口閉じ `mascot_closed.png` の2点
- 保存先：`raw_assets/mascot/`（gitignore 除外）。Assets.xcassets に同名（拡張子なし）で取り込み
- 用途：問題画面の読み上げ中の口パク演出（Phase 3-9b。`isSpeaking` 連動の2コマ交互表示）

### ライセンス根拠（OpenAI 利用規約）

- 利用規約：https://openai.com/policies/terms-of-use
- アウトプットの権利：OpenAI はサービスのアウトプット（生成物）に関する OpenAI 側の権利・利益をユーザーに譲渡する（Terms of Use の Content 条項）＝生成画像はユーザーが使用可
- 商用利用：可（無料プラン・有料プランで条件差なし）
- クレジット表記：不要
- 留意点（受容済み・design.md 8-9b）：AI 生成画像は著作権による独占的保護が限定的（第三者が類似画像を生成・使用することを排除できない）。100円アプリのマスコット用途としてこのリスクを受容
- 類似性確認：既存の有名キャラクターに似ていないことを目視確認（2026-07-26、生成者本人。Assets 取り込み時に実施）

---

## 5. アプリ内書体（UI フォント）

### 出典：Zen Maru Gothic（Google Fonts）

- 配布元URL：https://fonts.google.com/specimen/Zen+Maru+Gothic
- ライセンス：**SIL Open Font License (OFL) 1.1**（全文＝同梱の `yomikko/Fonts/OFL.txt`）
- 取得日：2026-08-17
- 同梱ファイル：`ZenMaruGothic-Regular.ttf` ／ `ZenMaruGothic-Bold.ttf`（`yomikko/Fonts/` に配置。アプリバンドルと公開リポジトリの双方に含まれる）
- 用途：アプリ内 UI 書体（免責モーダルを除く全画面。Phase 4 前段で採用、design.md 8-14）
- ライセンス上の整理：
  - 商用アプリへの同梱・配布：可（OFL が明示的に許可。禁止されるのはフォント単体での販売のみで、ソフトウェアへのバンドルは許諾範囲）
  - 再配布時の義務：著作権表示とライセンス文書の同梱 → `OFL.txt` を `Fonts/` に同梱して充足
  - 改変：なし（Google Fonts 配布物をそのまま使用。Reserved Font Name の改名義務は改変時のみのため非該当）
  - クレジット表記：不要（任意）

---

## 6. 改訂履歴

| 日付 | 内容 |
|------|------|
| 2026-05-09 | 初版作成。Loose Drawing 21点を登録 |
| 2026-05-09 | imagePath列追加（命名規則：ローマ字ヘボン式・長音は母音重ね） |
| 2026-05-10 | アプリアイコンセクションを実体化（Phase 1-4 完了）：Canva 自作（プリセット素材未使用）、フォント Zen Maru Gothic（OFL 1.1）。Canva 利用条件 5 点・商標登録方針も明記 |
| 2026-05-10 | 効果音セクションを実体化（Phase 1-5 / 1-6 完了）：効果音ラボより `correct.mp3` / `incorrect.mp3` 2点登録。規約・FAQ 全文確認のうえライセンス概要 5 点と FAQ 9 例1 を直接根拠として記載 |
| 2026-07-26 | マスコットキャラクターセクションを新設（Phase 3-9b）：ChatGPT（OpenAI 画像生成）製の口開け/閉じ2点（`mascot_open` / `mascot_closed`）。OpenAI 規約のアウトプット権利譲渡を根拠に商用利用可、AI 生成物の保護限定性は受容として記録 |
| 2026-08-17 | アプリ内書体セクションを新設（Phase 4 前段）：Zen Maru Gothic の Regular/Bold 2ウェイトを `Fonts/` に同梱（OFL 1.1・OFL.txt 同梱で再配布義務充足）。あわせてアイコン節の「フォントファイル自体の再配布は行わない」記述を現状に合わせて更新 |
