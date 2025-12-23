import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/constants/colors/color_primary.dart';
import 'package:lesto/app/modules/home/controllers/home_controller.dart';

class MenuTab extends GetView<HomeController> {
  const MenuTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Obx(() => Container(
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
                  )),
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
              return Obx(() {
                final isSelected = day == controller.selectedDay.value;
                return GestureDetector(
                  onTap: () {
                    controller.selectedDay.value = day;
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
                          color:
                              isSelected ? Colors.white : Colors.grey.shade600,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ),

        // Liste des repas
        Expanded(
          child: Obx(() => SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: _buildMealsList(),
                ),
              )),
        ),

        // Bouton Voir ma liste de courses
        Container(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controller.currentIndex.value = 2; // Switch to Courses tab
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
}
