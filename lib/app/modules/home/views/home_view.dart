// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/modules/home/views/GenerateRecipe.dart';
import 'package:lesto/app/modules/ui_v2/Livraison/livraison.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

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
      body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: [
            GenerateRecipe(),
            _buildMenusContent(), // Menus
            _buildCoursesContent(), //
            DeliveryScreen(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() => (BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.currentIndex.value = index;
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
          ))),
    );
  }

  Widget _buildMenusContent() {
    return Column(
      children: [
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
                  'Pour ${controller.numberOfPeople.value} personnes',
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
            itemCount: controller.days.length,
            itemBuilder: (context, index) {
              final day = controller.days[index];
              final isSelected = day == controller.selectedDay.value;
              return GestureDetector(
                onTap: () {
                  // setState(() {
                  //   _selectedDay = day;
                  // });
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
              onPressed: () {},
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
    final meals = controller.weeklyMenus[controller.selectedDay.value] ?? [];
    List<Widget> widgets = [];

    for (int i = 0; i < meals.length; i++) {
      final meal = meals[i];

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
              _buildActionButton('Ingrédients', Colors.orange.shade100,
                  Colors.orange.shade700, () {}),
              const SizedBox(width: 8),
              _buildActionButton('Commander', Colors.green.shade100,
                  Colors.green.shade700, () {}),
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
    controller.shoppingItems.forEach((key, value) {
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
                  'Pour ${controller.numberOfPeople.value} personnes',
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
    final isChecked = controller.shoppingItems[itemName] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
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
}
