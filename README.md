# 媽媽的手帳

股票損益日曆＋畫畫日曆。網站放在 GitHub Pages，資料和畫作照片放在 Supabase（免費方案）。

## 一、先試用（不用設定）
把 `index.html` 和 `icon-180.png` 放到 GitHub Pages 上，用手機打開就能玩。這時是**示範版**，資料只存在那支手機裡。

## 二、改成雲端版（約 15 分鐘）
1. 到 supabase.com 註冊，按 **New project**。Region 選 **Northeast Asia (Tokyo)** 或 **Singapore**，資料庫密碼自己記好。
2. 左邊選 **SQL Editor**，貼上 `setup.sql` 的全部內容，按 **Run**。
3. 左邊選 **Authentication → Users → Add user → Create new user**，幫媽媽建立 Email＋密碼，並勾選 **Auto Confirm User**。
4. **Authentication → Sign In / Providers**：把 **Allow new users to sign up** 關掉，這樣陌生人就不能註冊。
5. **Project Settings → API**（或 **Data API**）：複製 **Project URL** 和 **anon public key**。
6. 打開 `index.html`，找到最上面這兩行，填進去：
   ```js
   const SUPABASE_URL='https://xxxx.supabase.co';
   const SUPABASE_ANON_KEY='eyJ...';
   ```
   anon key 本來就是設計給網頁公開用的，放在 GitHub 上沒關係。每個人的資料都有權限規則保護，只有登入的本人看得到。
7. 推上 GitHub。在媽媽的 iPhone 上用 Safari 打開網址，登入一次，再按「分享 →加入主畫面」。

> 如果媽媽之前已經在示範版輸入了資料，第一次登入時會自動搬上雲端。這個步驟要用**同一支手機、同一個 App**來做。

## 三、防止 Supabase 自動暫停
Supabase 的免費專案 7 天沒有使用就會暫停。`.github/workflows/keepalive.yml` 每 3 天會自動連一次，讓專案保持運作。
到 GitHub repo 的 **Settings → Secrets and variables → Actions**，新增兩個 secret：
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`

新增後，可以到 **Actions** 分頁手動按一次 **Run workflow**，測試能不能連上。
