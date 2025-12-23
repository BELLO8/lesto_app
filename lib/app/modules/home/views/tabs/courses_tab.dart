import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/constants/colors/color_primary.dart';
import 'package:lesto/app/modules/home/controllers/home_controller.dart';

class CoursesTab extends GetView<HomeController> {
  const CoursesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Obx(() {
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
          final price = double.parse(
              priceString.replaceAll(' €', '').replaceAll(',', '.'));
          totalPrice += price;
        }
      });

      return Column(
        children: [
          // Header
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

          // Liste
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
    });
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
      child: GestureDetector(
        onTap: () {
          controller.shoppingItems[itemName] = !isChecked;
        },
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                controller.shoppingItems[itemName] = value ?? false;
              },
              activeColor: PrimaryColor.primary600,
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
      ),
    );
  }
}
