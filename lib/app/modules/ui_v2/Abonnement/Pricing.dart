import 'package:flutter/material.dart';

void main() => runApp(const UnlockCrestLightApp());

class UnlockCrestLightApp extends StatelessWidget {
  const UnlockCrestLightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UnlockCrestLightScreen(),
    );
  }
}

class UnlockCrestLightScreen extends StatelessWidget {
  const UnlockCrestLightScreen({super.key});

  // --- Couleurs de référence (pipettes depuis la maquette) ---
  static const Color _gradientStart = Color(0xFFF7F6FB); // haut (presque blanc)
  static const Color _gradientEnd = Color(
    0xFFE7E3F0,
  ); // bas (légèrement lavande)
  static const Color _accentRed = Color(0xFFD56A6A); // boutons / border
  static const Color _textMain = Colors.black87;

  // Liste des avantages :
  static const List<String> _benefits = [
    'Access the Full trend charts',
    'Change currencies',
    'Personalized Tips, Just for You',
    'Customize Your App Experience',
    'Download Comprehensive Reports',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Supprime l’ombre de la barre de statut.
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_gradientStart, _gradientEnd],
          ),
        ),
        child: SafeArea(
          bottom: false, // pour contrôler manuellement le padding du bas
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -------------------------------------------------- Fermeture
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 22, color: _textMain),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    splashRadius: 20,
                  ),
                ),
                const SizedBox(height: 12),
                // -------------------------------------------------- Titre
                const Text(
                  'Unlock Crest.',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: _textMain,
                  ),
                ),
                const SizedBox(height: 28),
                // -------------------------------------------------- Liste avantages
                ..._benefits.map<Widget>(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 18,
                          color: _textMain,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: _textMain,
                              fontSize: 14.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // -------------------------------------------------- Offre Premium
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _accentRed, width: 1.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Premium',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: _textMain,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Gives you access to\nall features',
                            style: TextStyle(
                              color: _textMain,
                              fontSize: 13.5,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text(
                                '₦40,000/year',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: _textMain,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '₦50,000/year',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Badge “For You 20% OFF”
                    Positioned(
                      top: -12,
                      right: 40,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _accentRed,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Text(
                          'For You 20% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // -------------------------------------------------- Bouton Continue
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      // Action for Continue button
                      debugPrint('Continue button pressed!');
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                // -------------------------------------------------- Privacy & Terms
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Action for Privacy & Terms button
                      debugPrint('Privacy & Terms button pressed!');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey.shade600,
                      padding: EdgeInsets.zero,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Text(
                      'Privacy & Terms',
                      style: TextStyle(fontSize: 12.5),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
