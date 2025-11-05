import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/brand_provider.dart';

class BrandInputScreen extends StatefulWidget {
  const BrandInputScreen({super.key});

  @override
  State<BrandInputScreen> createState() => _BrandInputScreenState();
}

class _BrandInputScreenState extends State<BrandInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _additionalInfoController = TextEditingController();
  
  String _selectedIndustry = 'Technology';
  String _selectedTone = 'Professional';
  String _selectedAudience = 'Startups';

  final List<String> _industries = [
    'Technology',
    'Fashion',
    'Food & Beverage',
    'Fitness & Wellness',
    'Finance',
    'Education',
    'Healthcare',
    'Real Estate',
    'Entertainment',
    'E-commerce',
  ];

  final List<String> _tones = [
    'Professional',
    'Luxury',
    'Minimalist',
    'Witty',
    'Friendly',
    'Bold',
    'Elegant',
    'Playful',
  ];

  final List<String> _audiences = [
    'Startups',
    'Small Businesses',
    'Enterprises',
    'Millennials',
    'Gen Z',
    'Professionals',
    'Students',
    'Parents',
    'Seniors',
  ];

  @override
  void dispose() {
    _additionalInfoController.dispose();
    super.dispose();
  }

  Future<void> _generateBrand() async {
    if (_formKey.currentState!.validate()) {
      final brandProvider = Provider.of<BrandProvider>(context, listen: false);
      
      await brandProvider.generateBrand(
        industry: _selectedIndustry,
        tone: _selectedTone,
        targetAudience: _selectedAudience,
        additionalInfo: _additionalInfoController.text.isNotEmpty 
            ? _additionalInfoController.text 
            : null,
      );

      if (mounted && brandProvider.currentBrand != null) {
        Navigator.pushNamed(context, '/brand-results');
      } else if (mounted && brandProvider.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(brandProvider.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Generate Brand Identity',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              const Color(0xFFE3F2FD),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Icon(
                  Icons.auto_awesome,
                  size: 64,
                  color: const Color(0xFF2196F3),
                ),
                const SizedBox(height: 16),
                Text(
                  'AI Brand Generator',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF212121),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Tell us about your business and we\'ll create a complete brand identity',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF757575),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Industry Selection
                Text(
                  'Industry',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedIndustry,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.business),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: _industries.map((industry) {
                      return DropdownMenuItem(
                        value: industry,
                        child: Text(industry),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedIndustry = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Tone Selection
                Text(
                  'Brand Tone',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedTone,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.palette),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: _tones.map((tone) {
                      return DropdownMenuItem(
                        value: tone,
                        child: Text(tone),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTone = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Target Audience Selection
                Text(
                  'Target Audience',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedAudience,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.people),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: _audiences.map((audience) {
                      return DropdownMenuItem(
                        value: audience,
                        child: Text(audience),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedAudience = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Additional Information (Optional)
                Text(
                  'Additional Information (Optional)',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _additionalInfoController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Tell us more about your brand vision, values, or unique selling points...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Generate Button
                Consumer<BrandProvider>(
                  builder: (context, brandProvider, child) {
                    return ElevatedButton(
                      onPressed: brandProvider.isGenerating ? null : _generateBrand,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: brandProvider.isGenerating
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'Generating Brand...',
                                  style: GoogleFonts.inter(fontSize: 16),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.auto_awesome),
                                const SizedBox(width: 8),
                                Text(
                                  'Generate Brand Identity',
                                  style: GoogleFonts.inter(fontSize: 16),
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}