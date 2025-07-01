import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/modules/ui_v2/Accueil/accueil.dart';
import 'package:lesto/app/modules/ui_v2/Livraison/livraison.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MenuSemaine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
      ),
      home: MenuSemaineScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuSemaineScreen extends StatefulWidget {
  @override
  _MenuSemaineScreenState createState() => _MenuSemaineScreenState();
}

class _MenuSemaineScreenState extends State<MenuSemaineScreen> {
  int _currentIndex = 2; // Onglet Courses sélectionné par défaut
  String _selectedDay = 'Lun';
  int _numberOfPeople = 2;

  // État des checkboxes pour la liste de courses
  final Map<String, bool> _shoppingItems = {
    'Champignons': false,
    'Tomates': false,
    'Courgettes': false,
    'Poivrons': false,
    'Riz pour risotto': false,
    'Pâtes': false,
    'Quinoa': false,
    'Sauce tomate': false,
    'Pâte de curry': false,
    'Parmesan': false,
    'Crème fraîche': false,
    'Lait de coco': false,
    'Basilic frais': false,
  };

  final List<String> _days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];

  final Map<String, List<Map<String, dynamic>>> _weeklyMenus = {
    'Lun': [
      {
        'type': 'Déjeuner',
        'name': 'Risotto aux champignons',
        'cuisine': 'Italien',
        'regime': 'Végétarien',
        'duration': '30 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Salade de quinoa aux légumes grillés',
        'cuisine': 'Méditerranéen',
        'regime': 'Végétarien',
        'duration': '20 min',
        'icon': Icons.menu_book,
      },
    ],
    'Mar': [
      {
        'type': 'Déjeuner',
        'name': 'Pasta à la carbonara',
        'cuisine': 'Italien',
        'regime': 'Standard',
        'duration': '25 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Saumon grillé aux légumes',
        'cuisine': 'Français',
        'regime': 'Standard',
        'duration': '35 min',
        'icon': Icons.menu_book,
      },
    ],
    'Mer': [
      {
        'type': 'Déjeuner',
        'name': 'Salade César végétarienne',
        'cuisine': 'Américain',
        'regime': 'Végétarien',
        'duration': '15 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Curry de légumes',
        'cuisine': 'Indien',
        'regime': 'Végétalien',
        'duration': '40 min',
        'icon': Icons.menu_book,
      },
    ],
    'Jeu': [
      {
        'type': 'Déjeuner',
        'name': 'Quiche aux épinards',
        'cuisine': 'Français',
        'regime': 'Végétarien',
        'duration': '45 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Tacos aux haricots noirs',
        'cuisine': 'Mexicain',
        'regime': 'Végétarien',
        'duration': '30 min',
        'icon': Icons.menu_book,
      },
    ],
    'Ven': [
      {
        'type': 'Déjeuner',
        'name': 'Sushi végétarien',
        'cuisine': 'Japonais',
        'regime': 'Végétarien',
        'duration': '50 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Pizza margherita',
        'cuisine': 'Italien',
        'regime': 'Végétarien',
        'duration': '25 min',
        'icon': Icons.menu_book,
      },
    ],
    'Sam': [
      {
        'type': 'Déjeuner',
        'name': 'Pancakes aux fruits',
        'cuisine': 'Américain',
        'regime': 'Végétarien',
        'duration': '20 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Ratatouille',
        'cuisine': 'Français',
        'regime': 'Végétalien',
        'duration': '60 min',
        'icon': Icons.menu_book,
      },
    ],
    'Dim': [
      {
        'type': 'Déjeuner',
        'name': 'Brunch végétarien',
        'cuisine': 'International',
        'regime': 'Végétarien',
        'duration': '30 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Soupe de légumes',
        'cuisine': 'Français',
        'regime': 'Végétalien',
        'duration': '45 min',
        'icon': Icons.menu_book,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PrimaryColor.primary600,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: '👋 Salut,',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Gilroy')),
                TextSpan(
                    text: "Lesto",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'GilroyBold')),
                TextSpan(
                    text: ' !',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'GilroySemi')),
              ]),
            ),
            Text(
              'Planifiez vos repas facilement',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 18),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: _currentIndex == 1
          ? _buildMenusContent()
          : _currentIndex == 2
              ? _buildCoursesContent()
              : _currentIndex == 0
                  ? RecipeHomePage()
                  : DeliveryScreen(), // Correctly call placeholder content
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: PrimaryColor.primary600,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome02,
              color: Colors.grey,
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome02,
              color: PrimaryColor.primary600,
            ),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(HugeIcons.strokeRoundedDish01),
            activeIcon: Icon(HugeIcons.strokeRoundedDish01),
            label: 'Menus',
          ),
          BottomNavigationBarItem(
            icon: Icon(HugeIcons.strokeRoundedShoppingBasket02),
            activeIcon: Icon(HugeIcons.strokeRoundedShoppingBasket02),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(HugeIcons.strokeRoundedDeliveryTruck01),
            activeIcon: Icon(HugeIcons.strokeRoundedDeliveryTruck01),
            label: 'Livraison',
          ),
        ],
      ),
    );
  }

  Widget _buildMenusContent() {
    return Column(
      children: [
        // Header avec titre et nombre de personnes
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Menu de la semaine',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PrimaryColor.primary600.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Pour $_numberOfPeople personnes',
                  style: const TextStyle(
                    color: PrimaryColor.primary700,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Sélecteur de jours
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _days.length,
            itemBuilder: (context, index) {
              final day = _days[index];
              final isSelected = day == _selectedDay;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDay = day;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? PrimaryColor.primary600
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected
                        ? null
                        : Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Liste des repas
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: _buildMealsList(),
            ),
          ),
        ),

        // Bouton Voir ma liste de courses
        Container(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showShoppingListDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor.primary600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Voir ma liste de courses',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildMealsList() {
    final meals = _weeklyMenus[_selectedDay] ?? [];
    List<Widget> widgets = [];

    for (int i = 0; i < meals.length; i++) {
      final meal = meals[i];

      // Titre du repas (Déjeuner/Dîner)
      widgets.add(
        Padding(
          padding: EdgeInsets.only(top: i == 0 ? 0 : 24, bottom: 12),
          child: Row(
            children: [
              Text(
                meal['type'] as String? ?? 'Type inconnu',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              _buildActionButton(
                  'Ingrédients', Colors.orange.shade100, Colors.orange.shade700,
                  () {
                _showIngredientsDialog(
                    meal['name'] as String? ?? 'Plat inconnu');
              }),
              const SizedBox(width: 8),
              _buildActionButton(
                  'Commander', Colors.green.shade100, Colors.green.shade700,
                  () {
                _showOrderDialog(meal['name'] as String? ?? 'Plat inconnu');
              }),
            ],
          ),
        ),
      );

      // Carte du plat
      widgets.add(
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: PrimaryColor.primary600.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: PrimaryColor.primary600.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: PrimaryColor.primary600.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  meal['icon'] as IconData? ?? Icons.help_outline,
                  color: PrimaryColor.primary600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal['name'] as String? ?? 'Plat inconnu',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${meal['cuisine'] as String? ?? 'N/A'} • ${meal['regime'] as String? ?? 'N/A'} • ${meal['duration'] as String? ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  Widget _buildActionButton(String label, Color backgroundColor,
      Color textColor, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              label == 'Ingrédients' ? Icons.receipt_long : Icons.shopping_bag,
              size: 14,
              color: textColor,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoursesContent() {
    final items = [
      {
        'category': 'Fruits et légumes',
        'items': [
          {'name': 'Champignons', 'price': '3,50 €', 'quantity': '250g'},
          {'name': 'Tomates', 'price': '2,80 €', 'quantity': '500g'},
          {'name': 'Courgettes', 'price': '1,95 €', 'quantity': '2 pièces'},
          {'name': 'Poivrons', 'price': '2,20 €', 'quantity': '2 pièces'},
        ]
      },
      {
        'category': 'Épicerie',
        'items': [
          {'name': 'Riz pour risotto', 'price': '3,20 €', 'quantity': '500g'},
          {'name': 'Pâtes', 'price': '1,50 €', 'quantity': '500g'},
          {'name': 'Quinoa', 'price': '3,90 €', 'quantity': '300g'},
          {'name': 'Sauce tomate', 'price': '1,80 €', 'quantity': '400g'},
          {'name': 'Pâte de curry', 'price': '2,50 €', 'quantity': '100g'},
        ]
      },
      {
        'category': 'Produits frais',
        'items': [
          {'name': 'Parmesan', 'price': '3,60 €', 'quantity': '150g'},
          {'name': 'Crème fraîche', 'price': '1,95 €', 'quantity': '20cl'},
          {'name': 'Lait de coco', 'price': '2,10 €', 'quantity': '400ml'},
        ]
      },
      {
        'category': 'Herbes et épices',
        'items': [
          {'name': 'Basilic frais', 'price': '1,45 €', 'quantity': '1 bouquet'},
        ]
      },
    ];

    double totalPrice = 0;
    _shoppingItems.forEach((key, value) {
      if (value) {
        final item = items
            .expand<Map<String, dynamic>>((category) =>
                (category['items'] as List<dynamic>?)
                    ?.map<Map<String, dynamic>>(
                        (e) => e as Map<String, dynamic>)
                    .toList() ??
                [])
            .firstWhere((item) => (item['name'] as String?) == key,
                orElse: () => {'price': '0,00 €'});
        final priceString = item['price'] as String? ?? '0,00 €';
        final price =
            double.parse(priceString.replaceAll(' €', '').replaceAll(',', '.'));
        totalPrice += price;
      }
    });

    return Column(
      children: [
        // Header avec titre et nombre de personnes
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Liste de courses',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PrimaryColor.primary600.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Pour $_numberOfPeople personnes',
                  style: const TextStyle(
                    color: Color(0xFF6366F1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Total estimé
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total estimé',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                '${totalPrice.toStringAsFixed(2).replaceAll('.', ',')} €',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        // Liste des catégories et produits
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map<Widget>(
                      (categoryData) => _buildCategorySection(categoryData))
                  .toList(),
            ),
          ),
        ),

        // Bouton Commander la livraison
        Container(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Action for ordering delivery
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor.primary600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_shipping_outlined, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Commander la livraison',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection(Map<String, dynamic> categoryData) {
    final categoryName =
        categoryData['category'] as String? ?? 'Catégorie inconnue';
    final items = (categoryData['items'] as List<dynamic>?)
            ?.map<Map<String, dynamic>>((e) => e as Map<String, dynamic>)
            .toList() ??
        [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12),
          child: Text(
            categoryName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6366F1),
            ),
          ),
        ),
        ...items.map<Widget>((item) => _buildShoppingItem(item)).toList(),
      ],
    );
  }

  Widget _buildShoppingItem(Map<String, dynamic> item) {
    final itemName = item['name'] as String? ?? 'Article inconnu';
    final isChecked = _shoppingItems[itemName] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                _shoppingItems[itemName] = value ?? false;
              });
            },
            activeColor: PrimaryColor.primary600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: Text(
              itemName,
              style: TextStyle(
                fontSize: 16,
                color: isChecked ? Colors.grey.shade600 : Colors.black87,
                decoration: isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item['price'] as String? ?? '0,00 €',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                item['quantity'] as String? ?? 'Qté inconnue',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderContent() {
    String title = '';
    switch (_currentIndex) {
      case 0:
        title = 'Accueil';
        break;
      case 3:
        title = 'Livraison';
        break;
      default:
        title = 'Contenu'; // Fallback for unexpected index
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
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

  void _showIngredientsDialog(String mealName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ingrédients'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ingrédients pour: $mealName'),
              const SizedBox(height: 16),
              const Text('• 200g de riz arborio'),
              const Text('• 300g de champignons'),
              const Text('• 1 oignon'),
              const Text('• 50g de parmesan'),
              const Text('• 1L de bouillon de légumes'),
              const Text('• 2 cuillères d\'huile d\'olive'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _showOrderDialog(String mealName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Commander'),
          content: Text(
              style: TextStyle(color: PrimaryColor.primary700),
              'Commande des ingrédients pour "$mealName" ajoutée au panier !'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showShoppingListDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Liste de courses'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                  'Liste générée pour X personnes:'), // Using X as _numberOfPeople is not passed to this dialog
              SizedBox(height: 16),
              Text('✓ 1.4kg de riz arborio'),
              Text('✓ 2.1kg de champignons'),
              Text('✓ 7 oignons'),
              Text('✓ 350g de parmesan'),
              Text('✓ 7L de bouillon de légumes'),
              Text('✓ 500ml d\'huile d\'olive'),
              Text('✓ Quinoa (500g)'),
              Text('✓ Légumes variés (2kg)'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fermer'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Liste de courses exportée !')),
                );
              },
              child: const Text('Exporter'),
            ),
          ],
        );
      },
    );
  }
}
