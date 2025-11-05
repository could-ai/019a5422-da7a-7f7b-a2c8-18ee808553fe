import 'package:flutter/foundation.dart';
import '../models/brand_model.dart';
import '../models/logo_model.dart';
import '../models/content_model.dart';
import '../services/ai_service.dart';

class BrandProvider with ChangeNotifier {
  final AIService _aiService = AIService();
  
  List<BrandModel> _savedBrands = [];
  BrandModel? _currentBrand;
  LogoModel? _currentLogo;
  List<ContentModel> _generatedContent = [];
  
  bool _isGenerating = false;
  String? _errorMessage;

  List<BrandModel> get savedBrands => _savedBrands;
  BrandModel? get currentBrand => _currentBrand;
  LogoModel? get currentLogo => _currentLogo;
  List<ContentModel> get generatedContent => _generatedContent;
  bool get isGenerating => _isGenerating;
  String? get errorMessage => _errorMessage;

  // Generate Brand Identity
  Future<void> generateBrand({
    required String industry,
    required String tone,
    required String targetAudience,
    String? additionalInfo,
  }) async {
    _isGenerating = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final brand = await _aiService.generateBrand(
        industry: industry,
        tone: tone,
        targetAudience: targetAudience,
        additionalInfo: additionalInfo,
      );

      _currentBrand = brand;
      _isGenerating = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to generate brand: ${e.toString()}';
      _isGenerating = false;
      notifyListeners();
    }
  }

  // Generate Logo
  Future<void> generateLogo(String prompt, {String? style}) async {
    _isGenerating = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final logo = await _aiService.generateLogo(prompt, style: style);
      _currentLogo = logo;
      
      if (_currentBrand != null) {
        _currentBrand = BrandModel(
          id: _currentBrand!.id,
          name: _currentBrand!.name,
          tagline: _currentBrand!.tagline,
          description: _currentBrand!.description,
          industry: _currentBrand!.industry,
          tone: _currentBrand!.tone,
          targetAudience: _currentBrand!.targetAudience,
          colorPalette: _currentBrand!.colorPalette,
          fonts: _currentBrand!.fonts,
          logoUrl: logo.imageUrl,
          createdAt: _currentBrand!.createdAt,
        );
      }

      _isGenerating = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to generate logo: ${e.toString()}';
      _isGenerating = false;
      notifyListeners();
    }
  }

  // Generate Social Media Content
  Future<void> generateContent({
    required String platform,
    required String tone,
    String? topic,
  }) async {
    _isGenerating = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final content = await _aiService.generateContent(
        brandName: _currentBrand?.name ?? 'Your Brand',
        platform: platform,
        tone: tone,
        topic: topic,
      );

      _generatedContent.add(content);
      _isGenerating = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to generate content: ${e.toString()}';
      _isGenerating = false;
      notifyListeners();
    }
  }

  // Save Brand
  Future<void> saveBrand() async {
    if (_currentBrand != null) {
      _savedBrands.add(_currentBrand!);
      // TODO: Save to Supabase database
      notifyListeners();
    }
  }

  // Load Saved Brands
  Future<void> loadSavedBrands(String userId) async {
    // TODO: Load from Supabase database
    // Mock data for now
    notifyListeners();
  }

  // Set Current Brand
  void setCurrentBrand(BrandModel brand) {
    _currentBrand = brand;
    notifyListeners();
  }

  // Update Logo Colors
  void updateLogoColors(List<String> colors) {
    if (_currentLogo != null) {
      _currentLogo = LogoModel(
        id: _currentLogo!.id,
        imageUrl: _currentLogo!.imageUrl,
        prompt: _currentLogo!.prompt,
        style: _currentLogo!.style,
        colors: colors,
        createdAt: _currentLogo!.createdAt,
      );
      notifyListeners();
    }
  }

  // Clear Current Brand
  void clearCurrentBrand() {
    _currentBrand = null;
    _currentLogo = null;
    _generatedContent.clear();
    notifyListeners();
  }

  // Delete Brand
  Future<void> deleteBrand(String brandId) async {
    _savedBrands.removeWhere((brand) => brand.id == brandId);
    // TODO: Delete from Supabase database
    notifyListeners();
  }
}
