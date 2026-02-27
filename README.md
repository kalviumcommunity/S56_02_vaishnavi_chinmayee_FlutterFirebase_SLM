📚 Smart Library Management System
A modern Flutter + Firebase web application that helps manage library operations like books, issuing, returns, analytics, and admin controls with a clean dashboard UI.

🚀 Features
👤 User Features
Browse available books
View book details
Reserve / issue books
Track issued books
Profile section

🛠 Admin Features
Admin dashboard
Add & manage books
Issue & return system
Fine tracking
Analytics charts

📊 Dashboard
Total books count
Issued books stats
Returned books stats
Visual charts

🧱 Tech Stack
Frontend: Flutter (Web)
Backend: Firebase
Firebase Authentication
Cloud Firestore
Firebase Hosting (optional)
Charts: fl_chart

📂 Project Structure
lib/
 ├ core/
 │   └ theme.dart
 ├ screens/
 │   ├ dashboard.dart
 │   ├ books_page.dart
 │   ├ book_detail_page.dart
 │   ├ admin_dashboard.dart
 │   ├ admin_analytics_dashboard.dart
 │   └ profile_page.dart
 ├ widgets/
 │   ├ sidebar.dart
 │   └ stat_card.dart
 ├ services/
 │   └ firebase_service.dart
 ├ firebase_options.dart
 └ main.dart
⚙️ Setup Instructions
1️⃣ Clone the repository
git clone <your-repo-url>
cd smart_library
2️⃣ Install dependencies
flutter pub get
3️⃣ Configure Firebase
flutterfire configure
This will generate:
lib/firebase_options.dart
4️⃣ Run the project
flutter run -d chrome
or

flutter run -d edge
🔑 Firebase Configuration
Make sure Firebase project includes:

Authentication enabled
Firestore database created
Web app registered

📸 UI Design
Inspired by modern dashboard designs with:
Sidebar navigation
Responsive layout
Animated charts
Hero transitions

📈 Future Improvements
Role‑based authentication
Notifications system
Book search & filters
Dark mode
Mobile responsiveness

👨‍💻 Authors
Vaishnavi Salunkhe
Chinmayee Harane