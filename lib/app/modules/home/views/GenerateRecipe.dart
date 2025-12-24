// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lesto/app/components/Dialog/modal_dialog.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/modules/home/controllers/home_controller.dart';
import 'package:lesto/app/routes/app_pages.dart';

class GenerateRecipe extends GetView<HomeController> {
  const GenerateRecipe({Key? key}) : super(key: key);

  void _showAddIngredientBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ajouter les ingrédients',
                        style: TextStyle(
                          fontFamily: 'GilroySemi',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Terminer',
                          style: TextStyle(
                            color: PrimaryColor.primary600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Barre de recherche
                  TextField(
                    onChanged: (value) => controller.searchIngredients(value),
                    decoration: InputDecoration(
                      hintText: 'Rechercher un ingrédient...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            controller.filteredIngredients.map((ingredient) {
                          bool isSelected = controller.selectedIngredients
                              .contains(ingredient.nom);
                          return GestureDetector(
                            onTap: () =>
                                controller.toggleIngredient(ingredient.nom),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.green[50]
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.green
                                      : Colors.grey[300]!,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isSelected)
                                    Padding(
                                      padding: EdgeInsets.only(right: 6),
                                      child: Icon(
                                        Icons.check_circle,
                                        size: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                  Text(
                                    ingredient.nom,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'GilroySemi',
                                      color: isSelected
                                          ? Colors.green[700]
                                          : Colors.black,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGenerateRecipeBottomSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Personnalisation du menu',
                      style: TextStyle(
                        fontFamily: 'GilroyBold',
                        fontSize: 22,
                        color: NeutralColor.neutral900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ajustez les détails pour votre menu de la semaine.',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildSoftSection(
                      icon: HugeIcons.strokeRoundedUserGroup,
                      title: "Nombre de personnes",
                      child: _buildPersonSelector(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(height: 1, color: Color(0xFFF5F5F5)),
                    ),
                    _buildSoftSection(
                      icon: HugeIcons.strokeRoundedCalendar03,
                      title: "Dates du menu",
                      child: _buildDateRangeSelector(),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          _showLoadingAlert(context, size);
                          await controller.getMenu(
                            1,
                            controller.dateDebut.value,
                            controller.dateFin.value,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColor.primary600,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Générer mon menu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'GilroyBold',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSoftSection(
      {required IconData icon, required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey.shade400),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'GilroySemi',
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  void _showLoadingAlert(BuildContext context, Size size) {
    showAlert(
      context,
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: PrimaryColor.primary600,
                strokeWidth: 3,
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              "Génération en cours...",
              style: TextStyle(
                fontFamily: 'GilroySemi',
                fontSize: 15,
                color: NeutralColor.neutral800,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
      size.width * 0.8,
      90,
      false,
    );
  }

  Widget _buildPersonSelector() {
    return Row(
      children: [
        _buildCounterButton(
          icon: Icons.remove_rounded,
          onTap: () =>
              controller.updatePersons(controller.selectedPersons.value - 1),
        ),
        const SizedBox(width: 20),
        Obx(() => Text(
              '${controller.selectedPersons.value} Personnes',
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'GilroyBold',
                color: NeutralColor.neutral800,
              ),
            )),
        const SizedBox(width: 20),
        _buildCounterButton(
          icon: Icons.add_rounded,
          onTap: () =>
              controller.updatePersons(controller.selectedPersons.value + 1),
        ),
      ],
    );
  }

  Widget _buildCounterButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Icon(icon, size: 20, color: NeutralColor.neutral700),
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildDatePickerItem(
            label: "Début",
            value: controller.dateDebut,
            onTap: () => _pickDate(true),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildDatePickerItem(
            label: "Fin",
            value: controller.dateFin,
            onTap: () => _pickDate(false),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerItem({
    required String label,
    required RxString value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Gilroy',
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Row(
                  children: [
                    Icon(HugeIcons.strokeRoundedCalendar01,
                        size: 16, color: PrimaryColor.primary600),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        value.value == "Date de début" ||
                                value.value == "Date de fin"
                            ? value.value
                            : DateFormat('dd/MM/yyyy')
                                .format(DateTime.parse(value.value)),
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'GilroySemi',
                          color: value.value.contains("Date")
                              ? Colors.grey.shade400
                              : NeutralColor.neutral800,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Future<void> _pickDate(bool isDebut) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: PrimaryColor.primary600,
              onPrimary: Colors.white,
              onSurface: NeutralColor.neutral800,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      if (isDebut) {
        controller.updateDateDebut(formattedDate);
      } else {
        controller.updateDateFin(formattedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColor.neutral50,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vous ne savez pas quoi cuisiner aujourd\'hui ?',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'GilroyBold',
                          color: NeutralColor.neutral900,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Laissez Lesto vous concocter un menu sur mesure.',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Gilroy',
                          color: NeutralColor.neutral600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            SizedBox(height: 24),

            // Premium banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF96913), Color(0xFFE8713C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF96913).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'À partir de 10\$/mois',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Générez des recettes en illimité !',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'GilroyBold',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(HugeIcons.strokeRoundedChefHat,
                        color: Colors.white, size: 32),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Recipe generation card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: NeutralColor.neutral200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(HugeIcons.strokeRoundedAiMagic,
                          size: 20, color: PrimaryColor.primary500),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Avez-vous des ingrédients que vous ne désirez pas ?",
                          style: TextStyle(
                              fontFamily: 'GilroySemi',
                              fontSize: 14,
                              color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Ingredients chips
                  Obx(() => controller.selectedIngredients.isEmpty
                      ? Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: NeutralColor.neutral200),
                          ),
                          child: Center(
                            child: Text(
                              "Aucun ingrédient interdit",
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 13,
                                  fontFamily: 'Gilroy'),
                            ),
                          ),
                        )
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              controller.selectedIngredients.map((ingredient) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: PrimaryColor.primary100.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: PrimaryColor.primary200),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    ingredient,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'GilroySemi',
                                      color: PrimaryColor.primary700,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () =>
                                        controller.removeIngredient(ingredient),
                                    child: const Icon(
                                      Icons.close_rounded,
                                      size: 14,
                                      color: PrimaryColor.primary600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )),

                  const SizedBox(height: 24),

                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => _showAddIngredientBottomSheet(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: NeutralColor.neutral200),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(HugeIcons.strokeRoundedPlusSign,
                                  size: 18, color: NeutralColor.neutral600),
                              const SizedBox(width: 8),
                              Text(
                                'Ajouter des exclusions',
                                style: TextStyle(
                                  color: NeutralColor.neutral600,
                                  fontSize: 14,
                                  fontFamily: 'GilroySemi',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () =>
                              _showGenerateRecipeBottomSheet(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PrimaryColor.primary600,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                            shadowColor:
                                PrimaryColor.primary600.withOpacity(0.4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(HugeIcons.strokeRoundedMagicWand01,
                                  color: Colors.white, size: 20),
                              SizedBox(width: 12),
                              Text(
                                'Générer mon menu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'GilroyBold',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // History section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Historique',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'GilroyBold',
                    color: NeutralColor.neutral900,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Voir tout',
                    style: TextStyle(
                      fontSize: 14,
                      color: PrimaryColor.primary600,
                      fontFamily: 'GilroySemi',
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // History list
            Obx(() => controller.historyMenus.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          Icon(HugeIcons.strokeRoundedCalendar03,
                              size: 40, color: NeutralColor.neutral300),
                          const SizedBox(height: 12),
                          Text(
                            "Aucun historique pour le moment",
                            style: TextStyle(
                              color: NeutralColor.neutral700,
                              fontFamily: 'GilroySemi',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.historyMenus.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final menu = controller.historyMenus[index];
                      return GestureDetector(
                        onTap: () =>
                            Get.toNamed(Routes.GENERATE_MENU, arguments: menu),
                        child: RecipeHistoryItem(
                          imagePath: 'assets/images/plat_default.png',
                          title: "Menu personnalisé (${menu.length} jours)",
                          time: "Variable",
                          ingredients: "${menu.length} recettes",
                          date: "Aujourd'hui",
                        ),
                      );
                    },
                  )),
            const SizedBox(
                height: 100), // Bottom padding for floating navigation bar
          ],
        ),
      ),
    );
  }
}

class RecipeHistoryItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String time;
  final String ingredients;
  final String date;

  const RecipeHistoryItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.time,
    required this.ingredients,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[100],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: PrimaryColor.primary100,
                    child: const Icon(
                      Icons.restaurant_rounded,
                      color: PrimaryColor.primary600,
                      size: 28,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildTag(HugeIcons.strokeRoundedClock01, time,
                        Colors.red.shade600, Colors.red.shade50),
                    const SizedBox(width: 8),
                    _buildTag(HugeIcons.strokeRoundedKitchenUtensils,
                        ingredients, Colors.blue.shade600, Colors.blue.shade50),
                    const Spacer(),
                    Text(
                      date,
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: Colors.grey[400],
                          fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'GilroyBold',
                    color: NeutralColor.neutral900,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(IconData icon, String text, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontFamily: 'GilroyBold',
            ),
          ),
        ],
      ),
    );
  }
}
