class EndPoints {
  // ========== AUTHENTICATION ENDPOINTS ==========
  static const String register = '/register';
  static const String login = '/login';
  static const String verifyOtp = '/verify-otp';
  static const String resendOtp = '/resend-otp';
  static const String forgotPassword = '/password/forgot';
  static const String logout = '/logout';

  // ========== USER MANAGEMENT ENDPOINTS ==========
  static const String users = '/users';
  static const String updateprofile = '/';

  // Update this to include the user ID placeholder
  static String updateProfile(int userId) => '/profile/update/$userId';

  static const String userPreferences = '/users/preferences';
  // leagues 
  static const String leagues = '/cricket/list';

  // ========== PROGRESS & ANALYTICS ENDPOINTS ==========
  static const String dailyProgress = '/progress/daily';
  static const String weeklyProgress = '/progress/weekly';
  static const String monthlyProgress = '/progress/monthly';
  static const String setGoals = '/progress/goals';
  static const String updateGoals = '/progress/goals/update';
  static const String progressInsights = '/progress/insights';

  // ========== MEAL PLANNING ENDPOINTS ==========
  static const String mealPlan = '/meal-plan';
  static const String generateMealPlan = '/meal-plan/generate';
  static const String updateMealPlan = '/meal-plan/update';
  static const String mealSuggestions = '/meal-plan/suggestions';

  // ========== REWARDS & GAMIFICATION ENDPOINTS ==========
  static const String rewards = '/rewards';
  static const String achievements = '/rewards/achievements';
  static const String claimReward = '/rewards/claim';
  static const String userPoints = '/rewards/points';
  static const String leaderboard = '/rewards/leaderboard';

  // ========== NOTIFICATIONS & REMINDERS ENDPOINTS ==========
  static const String notifications = '/notifications';
  static const String notificationSettings = '/notifications/settings';
  static const String markNotificationRead = '/notifications/mark-read';
  static const String clearNotifications = '/notifications/clear';
  static const String mealReminders = '/notifications/reminders';

  // ========== APP CONFIGURATION ENDPOINTS ==========
  static const String appConfig = '/config/app';
  static const String foodDatabase = '/config/food-database';
  static const String nutritionFacts = '/config/nutrition-facts';
  static const String dietTypes = '/config/diet-types';
  static const String allergens = '/config/allergens';

  // ========== AI & ML ENDPOINTS ==========
  static const String aiScan = '/ai/scan';
  static const String aiAnalyze = '/ai/analyze';
  static const String aiRecommendations = '/ai/recommendations';
  static const String imageUpload = '/ai/upload';

  // ========== SUBSCRIPTION & PAYMENTS ENDPOINTS ==========
  static const String subscriptionPlans = '/subscription/plans';
  static const String subscribe = '/subscription/subscribe';
  static const String subscriptionStatus = '/subscription/status';
  static const String cancelSubscription = '/subscription/cancel';

  // ========== SUPPORT & FEEDBACK ENDPOINTS ==========
  static const String contactSupport = '/support/contact';
  static const String feedback = '/support/feedback';
  static const String reportIssue = '/support/report-issue';
  static const String faq = '/support/faq';

  // ========== MISC ENDPOINTS ==========
  static const String healthCheck = '/health';
  static const String appVersion = '/version';
  static const String privacyPolicy = '/privacy';
  static const String termsConditions = '/terms-conditions';
}
