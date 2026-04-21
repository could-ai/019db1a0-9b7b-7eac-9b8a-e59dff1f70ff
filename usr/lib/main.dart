import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrición Link in Bio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B9080), // Soft sage green
          background: const Color(0xFFF6F8F6),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: const LinkInBioScreen(),
    );
  }
}

class LinkInBioScreen extends StatelessWidget {
  const LinkInBioScreen({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('No se pudo abrir $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.2), 
                            width: 4
                        ),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'), // Aesthetic healthy food/salad
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Name
                    Text(
                      'Lic. Laura Nutrición',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2B4141),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    
                    // Bio
                    Text(
                      'Nutrición Integrativa & Alimentación Consciente 🌱\nTe ayudo a sanar tu relación con la comida.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Social Icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialIcon(
                          icon: Icons.camera_alt_outlined, // Repr. Instagram
                          onTap: () => _launchUrl('https://instagram.com'),
                        ),
                        const SizedBox(width: 16),
                        _SocialIcon(
                          icon: Icons.video_library_outlined, // Repr. TikTok/YouTube
                          onTap: () => _launchUrl('https://tiktok.com'),
                        ),
                        const SizedBox(width: 16),
                        _SocialIcon(
                          icon: Icons.message_outlined, // Repr. WhatsApp
                          onTap: () => _launchUrl('https://wa.me/1234567890'),
                        ),
                        const SizedBox(width: 16),
                        _SocialIcon(
                          icon: Icons.email_outlined, // Email
                          onTap: () => _launchUrl('mailto:contacto@nutricion.com'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Services / Links
                    _LinkCard(
                      title: 'Asesoría Nutricional 1:1',
                      subtitle: 'Planes personalizados online y presenciales',
                      icon: Icons.calendar_month_outlined,
                      onTap: () => _launchUrl('https://example.com/reserva'),
                    ),
                    const SizedBox(height: 16),
                    
                    _LinkCard(
                      title: 'Reto 21 Días Detox',
                      subtitle: 'Únete a la próxima edición que empieza pronto',
                      icon: Icons.local_florist_outlined,
                      onTap: () => _launchUrl('https://example.com/reto'),
                    ),
                    const SizedBox(height: 16),

                    _LinkCard(
                      title: 'E-Book: 50 Recetas Saludables',
                      subtitle: 'Desayunos, almuerzos y cenas fáciles y rápidas',
                      icon: Icons.menu_book_outlined,
                      onTap: () => _launchUrl('https://example.com/ebook'),
                      isHighlighted: true, // Highlights this specific card
                    ),
                    const SizedBox(height: 16),
                    
                    _LinkCard(
                      title: 'Mi Tienda Recomendada',
                      subtitle: 'Suplementos y productos que utilizo',
                      icon: Icons.shopping_bag_outlined,
                      onTap: () => _launchUrl('https://example.com/tienda'),
                    ),
                    const SizedBox(height: 40),

                    // Footer
                    Text(
                      '© 2026 Laura Nutrición. Todos los derechos reservados.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
      ),
    );
  }
}

class _LinkCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isHighlighted;

  const _LinkCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isHighlighted = false,
  });

  @override
  State<_LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<_LinkCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        child: Card(
          elevation: _isHovered ? 8 : (widget.isHighlighted ? 4 : 0),
          color: widget.isHighlighted ? colorScheme.primary : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: widget.isHighlighted 
                ? BorderSide.none 
                : BorderSide(color: colorScheme.primary.withOpacity(0.2)),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: widget.isHighlighted 
                          ? Colors.white.withOpacity(0.2)
                          : colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.isHighlighted ? Colors.white : colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.isHighlighted ? Colors.white : const Color(0xFF2B4141),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: widget.isHighlighted 
                                ? Colors.white.withOpacity(0.9) 
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: widget.isHighlighted 
                        ? Colors.white.withOpacity(0.7) 
                        : Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
