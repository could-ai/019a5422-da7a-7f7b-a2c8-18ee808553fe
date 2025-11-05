import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../providers/brand_provider.dart';
import '../../widgets/dashboard_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _loadUserBrands();
  }

  Future<void> _loadUserBrands() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final brandProvider = Provider.of<BrandProvider>(context, listen: false);
    
    if (authProvider.user != null) {
      await brandProvider.loadSavedBrands(authProvider.user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final brandProvider = Provider.of<BrandProvider>(context);
    final user = authProvider.user;

    return Scaffold(
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
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'BrandVault',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                    ),
                  ),
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.person_outline, color: Color(0xFF2196F3)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Section
                      Text(
                        'Welcome back, ${user?.name ?? "User"}!',
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create your brand identity in under 60 seconds',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: const Color(0xFF757575),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Quick Actions
                      Text(
                        'Quick Actions',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DashboardCard(
                              icon: Icons.auto_awesome,
                              title: 'Generate Brand',
                              description: 'AI-powered identity',
                              gradient: LinearGradient(
                                colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/brand-input');
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DashboardCard(
                              icon: Icons.palette,
                              title: 'Create Logo',
                              description: 'AI logo generator',
                              gradient: LinearGradient(
                                colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/logo-generator');
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DashboardCard(
                              icon: Icons.campaign,
                              title: 'Social Content',
                              description: 'Posts & captions',
                              gradient: LinearGradient(
                                colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/content-generator');
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DashboardCard(
                              icon: Icons.download,
                              title: 'Brand Kit',
                              description: 'Export as PDF',
                              gradient: LinearGradient(
                                colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/brand-kit');
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Saved Brands
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Brands',
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF212121),
                            ),
                          ),
                          if (user != null && !user.isBusiness)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${brandProvider.savedBrands.length}/${user.maxBrands}',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF2196F3),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      if (brandProvider.savedBrands.isEmpty)
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Icon(
                                Icons.business_center_outlined,
                                size: 80,
                                color: Colors.grey.shade300,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No brands yet',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Create your first brand identity',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/brand-input');
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Generate Brand'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2196F3),
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: brandProvider.savedBrands.length,
                          itemBuilder: (context, index) {
                            final brand = brandProvider.savedBrands[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: brand.logoUrl != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          brand.logoUrl!,
                                          width: 56,
                                          height: 56,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        width: 56,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(Icons.business, color: Colors.white),
                                      ),
                                title: Text(
                                  brand.name,
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(
                                      brand.tagline,
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: const Color(0xFF757575),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: brand.colorPalette.take(4).map((color) {
                                        return Container(
                                          width: 24,
                                          height: 24,
                                          margin: const EdgeInsets.only(right: 4),
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(color.replaceAll('#', '0xFF'))),
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: Colors.grey.shade300),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.more_vert),
                                  onPressed: () {
                                    _showBrandOptions(context, brand);
                                  },
                                ),
                                onTap: () {
                                  brandProvider.setCurrentBrand(brand);
                                  Navigator.pushNamed(context, '/brand-results');
                                },
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (user != null && 
              !user.isBusiness && 
              brandProvider.savedBrands.length >= user.maxBrands) {
            _showUpgradeDialog(context);
          } else {
            Navigator.pushNamed(context, '/brand-input');
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('New Brand'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
    );
  }

  void _showBrandOptions(BuildContext context, brand) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Brand'),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<BrandProvider>(context, listen: false).setCurrentBrand(brand);
                  Navigator.pushNamed(context, '/brand-results');
                },
              ),
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('Export Brand Kit'),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<BrandProvider>(context, listen: false).setCurrentBrand(brand);
                  Navigator.pushNamed(context, '/brand-kit');
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete Brand', style: TextStyle(color: Colors.red)),
                onTap: () async {
                  Navigator.pop(context);
                  await Provider.of<BrandProvider>(context, listen: false).deleteBrand(brand.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Upgrade Required'),
          content: const Text('You\'ve reached your brand limit. Upgrade to Pro or Business to create more brands.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/subscription');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                foregroundColor: Colors.white,
              ),
              child: const Text('Upgrade'),
            ),
          ],
        );
      },
    );
  }
}