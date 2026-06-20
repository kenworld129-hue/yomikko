# よみっこ (Yomikko)

> 3歳児のためのひらがな読み練習 iOS アプリ

![Status](https://img.shields.io/badge/status-WIP_Phase_3-yellow)
![Platform](https://img.shields.io/badge/iOS-17%2B-blue)
![Xcode](https://img.shields.io/badge/Xcode-26.3-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## 概要

「よみっこ」は、ひらがなに興味を持ち始めた3歳児が、自分でタップして遊びながらひらがなの **「読み」** を練習できる iOS アプリです。

### コンセプト

- **「読み」に特化**。書きはアナログ（紙とペン）で学ぶべきという理念のもと、書き機能は持ちません。
- **写真カスタム登録による差別化**。親が子供の好きな写真や単語を登録できます。「家族の犬」「お気に入りのおもちゃ」など、その子だけの教材を作れます。
- **写真は後から外せる**。登録した写真・イラストは取り消して「文字だけで読む」状態に戻せます。絵は読みの“補助輪”という位置づけで、子の育ちに合わせて親が外せる設計です。
- **写真は端末ローカル保存のみ**。サーバー送信なし、外部送信される個人情報を扱わないシンプルな設計。

## 主な機能 (v1)

- プリセット20語 + 親登録のカスタム単語による読み練習
- 自動音声モード（「くるまはどれ？」と読み上げ、`AVSpeechSynthesizer` 速度0.4固定）
- 写真アップロード（フォトライブラリから選択）
- 10問1セッション、結果画面で正解数表示
- 写真未設定の単語には汎用イラストを自動割り当て
- プリセット20語を初期状態へ復元（削除・改名・写真変更したプリセットを購入時のイラストに戻す）

## 技術スタック

| 項目 | 採用技術 |
|------|---------|
| アーキテクチャ | SwiftUI + `@Observable` |
| データ永続化 | SwiftData |
| 音声合成 | AVSpeechSynthesizer |
| 写真連携 | PhotosUI |
| テスト | Swift Testing |
| ターゲット OS | iOS 17+ |
| 開発環境 | Xcode 26.3 |

### 設計判断の根拠

- **SwiftData を採用**（CoreData ではなく）：iOS 17 から登場したモダン API。`@Model` マクロで宣言的にスキーマを定義でき、SwiftUI との統合が一級。学習コストはあるが、最新 API での実装経験を積むことを優先。
- **書き機能を持たない**：機能スコープを絞ることでリリース距離を短縮。同時に「書きはアナログで」という育児上の理念を表明する役割も持たせている。
- **写真はローカル保存のみ**：プライバシー配慮とサーバー実装コスト回避を兼ねる。これにより GDPR 等のデータ越境問題からも切り離せる。
- **カメラ撮影は非対応**（フォトライブラリ選択のみ）：「いまの瞬間を撮る」のはカメラアプリの役割であり、本アプリの責務（ひらがな読み練習）の外と整理した。`PhotosPicker` 一択にすることで、権限ダイアログや `UIImagePickerController` のラップも不要になり実装がシンプルになる。
- **`@Observable` を採用**（`ObservableObject` ではなく）：iOS 17 のマクロベースの新方式。再描画粒度が細かくパフォーマンス的にも有利。
- **画面遷移は自前ルーティングで実装**（`NavigationStack` / `fullScreenCover` ではなく）：`@Observable` な `AppRouter` をアプリ全体で1つ Environment 注入し、ルート View が `switch` で表示画面を選択する方式。3歳児向け＋有料アプリとして UI を独自に作り込む方針上、画面切替トランジション演出まで自前で設計できる余地を確保する必要があったため、標準ナビゲーション API を意図的に外した。起動時免責モーダルのような「装飾不要・機械的トーンが意図と合致する」表示には標準 `.fullScreenCover` を併用し、責務に応じて標準 / 自前を使い分けている。

## 開発フェーズ進捗

- ✅ **Phase 0：事前準備** — Apple Developer Program 登録、プライバシーポリシー公開、App Store Connect アプリ枠作成
- ✅ **Phase 1：素材調達** — プリセット20語イラスト（Loose Drawing 一本化）、効果音（効果音ラボ）、アプリアイコン（Canva 内製）、ライセンス一覧（ASSET_LICENSES.md）整備
- ✅ **Phase 2：開発環境・基盤** — Xcode プロジェクト作成、ビルド・SwiftData 動作検証、GitHub Public 公開、Word モデル実装、プリセット20語の初期投入処理
- 🔶 **Phase 3：コア機能開発**（進行中）— 3-1〜3-6b 完了（ホーム画面と画面切替メカニズム、起動時免責モーダル、単語登録画面、フォトライブラリ連携、写真なし単語のフォールバック表示・一覧サムネイル、単語削除と下限20語維持、プリセット復元）、3-7 以降は問題画面 / ゲームロジック / 結果画面を順次実装
- ⬜ Phase 4：UI 品質・3歳児向け細部調整
- ⬜ Phase 5：TestFlight ベータテスト
- ⬜ Phase 6：App Store 申請
- ⬜ Phase 7：リリース・集客

詳細タスクは別途 `yomikko_design.md` にて管理しています。

## リリース目標

**2026年7月末**、App Store にて 100円（買い切り）でリリース予定。

## ロードマップ

### v1（リリース時）
- プリセット20語 + カスタム単語登録
- 自動音声モード
- 写真アップロード機能

### v2 以降の検討候補
- 50音順の単文字習得フロー
- 親読みモード
- 難易度レベル区別（単純一致 / 似た文字の識別）
- プログレス記録・成長グラフ
- 英語ローカライズ

## 開発環境

### 必要環境

- macOS（Apple Silicon 推奨）
- Xcode 26.3 以降
- iOS 17+ シミュレータまたは実機

### ビルド方法

```bash
git clone https://github.com/kenworld129-hue/yomikko.git
cd yomikko
open yomikko.xcodeproj
```

Xcode で `yomikko` スキームを選択し、シミュレータまたは実機を指定して `⌘R` で実行。

## プロジェクト構成

```
yomikko/
├── yomikko/                    # アプリソースコード
│   ├── App/                    # アプリエントリ・ルート View
│   │   ├── yomikkoApp.swift    # @main エントリポイント（ModelContainer 初期化・AppRouter 注入）
│   │   └── RootView.swift      # ルート View（画面切替の司令塔、switch + .fullScreenCover）
│   ├── Routing/                # 画面切替の状態管理
│   │   └── AppRouter.swift     # @Observable な画面切替・モーダル表示制御クラス（enum Screen 同居）
│   ├── Views/                  # 画面 View
│   │   ├── HomeView.swift       # ホーム画面（「はじめる」「登録」ボタン）
│   │   ├── DisclaimerView.swift # 起動時免責モーダル（保護者向け）
│   │   ├── RegisterView.swift   # 単語登録画面（一覧＋一覧/フォーム出し分け）
│   │   ├── WordFormView.swift   # 単語フォーム（新規・編集兼用）
│   │   └── WordImageView.swift  # 画像表示の共通 View（ImageSource で出し分け・fallback 内蔵）
│   ├── Models/                 # データモデル
│   │   └── Word.swift          # SwiftData モデル（単語データ）
│   ├── Services/               # ビジネスロジック・データ投入
│   │   ├── PresetSeeder.swift  # プリセット20語の初期投入・復元処理
│   │   └── ImageStore.swift    # 画像ファイルの URL 解決・読み込み・削除（Documents I/O 集約）
│   └── Assets.xcassets/        # 画像リソース（アプリアイコン枠・プリセットイラスト20点・フォールバック1点）
├── yomikkoTests/               # 単体テスト（Swift Testing）
├── yomikkoUITests/             # UI テスト
├── raw_assets/                 # 素材生データ（Xcode ターゲット非含有）
└── yomikko.xcodeproj/          # Xcode プロジェクトファイル
```

## ライセンス

MIT License - 詳細は [LICENSE](./LICENSE) を参照。

## 開発者

**umada kenshun**

- 本リポジトリは個人開発の学習・ポートフォリオ目的で公開しています
- アプリに関するお問い合わせ：uma.apps.help@gmail.com
- プライバシーポリシー：[Notion](https://tan-grin-bae.notion.site/349785b7c19180188853db019bd2a8da)

---

## 開発の背景

長年 COBOL 基幹システムの開発・運用に携わってきたエンジニアによる、SwiftUI / SwiftData を使ったモダン iOS 開発への挑戦記録です。「動くアプリ」だけでなく **「設計の意図が読めるリポジトリ」** を目指して、以下を意識して開発を進めています：

- 設計仕様を先に整備し、実装はそれに従う（仕様駆動開発）
- 各 Phase でのコミット粒度を、外部から進捗が読める単位に保つ
- 技術選定の理由をコード／README に明記する
