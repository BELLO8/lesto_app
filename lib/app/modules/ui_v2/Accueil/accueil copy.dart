import 'package:flutter/material.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

class HomeScreenMenu extends StatefulWidget {
  @override
  _HomeScreenMenuState createState() => _HomeScreenMenuState();
}

class _HomeScreenMenuState extends State<HomeScreenMenu> {
  int _currentIndex = 0;
  int _numberOfPeople = 2;
  String _selectedCuisine = 'Française';
  String _selectedRegime = 'Standard';

  final List<String> _cuisines = [
    'Française',
    'Italienne',
    'Asiatique',
    'Méditerranéenne',
    'Mexicaine',
    'Indienne',
  ];

  final List<String> _regimes = [
    'Standard',
    'Végétarien',
    'Végétalien',
    'Sans gluten',
    'Keto',
    'Paléo',
  ];

  final List<Map<String, dynamic>> _recentMenus = [
    {'title': 'Menu Italien Végétarien', 'date': 'Généré le 15/06/2023'},
    {'title': 'Menu Français Standard', 'date': 'Généré le 08/06/2023'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PrimaryColor.primary100, body: _buildAccueilContent());
  }

  Widget _buildAccueilContent() {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),

          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFE2D4),
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: 'Créez des menus',
                        style: TextStyle(
                            color: PrimaryColor.primary800,
                            fontSize: 22,
                            fontFamily: 'GilroyBold')),
                    TextSpan(
                        text: ' qui',
                        style: TextStyle(
                            color: NeutralColor.neutral800,
                            fontSize: 16,
                            fontFamily: 'Gilroy')),
                    TextSpan(
                        text: '\n reflètent votre',
                        style: TextStyle(
                            color: NeutralColor.neutral900,
                            fontSize: 16,
                            fontFamily: 'Gilroy')),
                    TextSpan(
                        text: ' style de vie .',
                        style: TextStyle(
                            color: PrimaryColor.primary800,
                            fontSize: 22,
                            fontFamily: 'GilroyBold')),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: size.height * 0.12,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Container(
                        height: size.height * 0.05,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF6366F1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Nombre de personnes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Bouton Générer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showGeneratedMenuDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimaryColor.primary600,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Générer mon menu',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: "GilroySemi"),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 40),

          // Menus récents
          Text(
            'Menus récents',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),

          ..._recentMenus.map((menu) => _buildRecentMenuItem(menu)).toList(),
        ],
      ),
    );
  }

  Widget _buildRecentMenuItem(Map<String, dynamic> menu) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menu['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  menu['date'],
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              _showMenuDetailsDialog(menu['title']);
            },
            child: Text(
              'Voir',
              style: TextStyle(
                color: Color(0xFF6366F1),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherContent() {
    String title = '';
    switch (_currentIndex) {
      case 1:
        title = 'Menus';
        break;
      case 2:
        title = 'Courses';
        break;
      case 3:
        title = 'Livraison';
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 64, color: Colors.grey.shade400),
          SizedBox(height: 16),
          Text(
            '$title - En construction',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showGeneratedMenuDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Menu généré !'),
          content: Text(
            'Menu $_selectedCuisine $_selectedRegime pour $_numberOfPeople personne${_numberOfPeople > 1 ? 's' : ''} généré avec succès !',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showMenuDetailsDialog(String menuTitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(menuTitle),
          content: Text('Détails du menu à implémenter...'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}
