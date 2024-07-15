## Legal Referral UI

https://github.com/user-attachments/assets/1d5b1785-ef85-4cae-bac8-6f2a0b736e76

## Description

- This project is a specialized platform designed for lawyers to create accounts based on their job preferences, ensuring they hold a valid attorney license.

- Once approved, lawyers can refer specific cases to one another, earning compensation for their referrals. Additionally, they can manage their professional feed. 

- Essentially, it's a LinkedIn-like application tailored for legal professionals, fostering networking and collaboration within the legal community.

## APP SIGNING
keytool -genkey -v -keystore ~/legal-referral-dev.jks -keyalg RSA -keysize 2048 -validity 10000 -alias androiddevkey
/gradlew signingReport

## Merge a local branch with a remote branch
    git merge origin/aRemoteBranch
    
## Abort a rebase    
    git rebase --abort

## Reset a commit
    git reset --hard HEAD@{1}   

## Generate Code
    dart run build_runner build --delete-conflicting-outputs

## Build APK
    flutter build apk --release --no-tree-shake-icons

## Web HTML Render
    flutter run -d chrome --web-renderer html

## Build Runner Clean
dart run build_runner clean
