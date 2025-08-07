// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lesto/app/components/Dialog/modal_dialog.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

import '../controllers/home_controller.dart';

class GenerateRecipe extends GetView<HomeController> {
  GenerateRecipe({Key? key}) : super(key: key);

  // Nouvelles variables d'état
  final int selectedPersons = 2;
  final String selectedPeriod = '1 day';
  final List<String> selectedAllergies = [];
  final String selectedCookingTime = '15-30 min';
  final String selectedDifficulty = 'Easy';
  final String selectedCuisineType = 'Asian';

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
                            color: Color(0xFF4A5D3A),
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
        height: MediaQuery.of(context).size.height * 0.6,
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Etape de generation de menu',
                      style: TextStyle(
                        fontFamily: 'GilroySemi',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingredients selectionnés:',
                            style: TextStyle(
                              fontFamily: "GilroySemi",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Obx(() => Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: controller.selectedIngredients
                                    .map((ingredient) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      ingredient,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green[700],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Préférences du menu',
                      style: TextStyle(
                        fontFamily: 'GilroySemi',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Nombre de personnes
                    _buildPersonSelector(),
                    SizedBox(height: 16),
                    _buildPeriodSelector(),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          controller.loading.value
                              ? showAlert(
                                  context,
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 35),
                                    child: Row(children: [
                                      CircularProgressIndicator(
                                        color: PrimaryColor.primary400,
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Text(
                                        "Génération du menu en cours",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily: 'Gilroy',
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ]),
                                  ),
                                  size.width * 0.85,
                                  size.height * 0.11,
                                  false)
                              : null;

                          await controller.getMenu(
                            1,
                            controller.dateDebut.value,
                            controller.dateFin.value,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4A5D3A),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Générer mon menu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'GilroySemi',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Number of Persons',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Obx(() => Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => controller
                        .updatePersons(controller.selectedPersons.value - 1),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: controller.selectedPersons.value > 1
                            ? Colors.grey[100]
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 16,
                        color: controller.selectedPersons.value > 1
                            ? Colors.black
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    '${controller.selectedPersons.value}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => controller
                        .updatePersons(controller.selectedPersons.value + 1),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: controller.selectedPersons.value < 10
                            ? Colors.grey[100]
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: controller.selectedPersons.value < 10
                            ? Colors.black
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menu Period',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    controller.updateDateDebut(formattedDate);
                  }
                },
                child: Obx(() => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        controller.dateDebut.value,
                        style: TextStyle(fontSize: 14),
                      ),
                    )),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    controller.updateDateFin(formattedDate);
                  }
                },
                child: Obx(() => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        controller.dateFin.value,
                        style: TextStyle(fontSize: 14),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Vous ne savez pas quoi cuisiner aujourd\'hui ?',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'GilroySemi',
                      fontWeight: FontWeight.bold,
                      color: NeutralColor.neutral800,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Recipe generation card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFF5F3F0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_fix_high, size: 20, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        "Avez-vous des ingrédients que vous \nne désirez pas (interdits)?",
                        style: TextStyle(
                            fontFamily: 'GilroyMedium',
                            fontSize: 14,
                            color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Ingredients chips
                  Obx(() => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            controller.selectedIngredients.map((ingredient) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  ingredient,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () =>
                                      controller.removeIngredient(ingredient),
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      )),

                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      _showAddIngredientBottomSheet(context);
                    },
                    child: Text(
                      'Ajouter les ingrédients',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 14,
                        fontFamily: 'GilroySemi',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showGenerateRecipeBottomSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4A5D3A),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_fix_high,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Générer un menu',
                            style: TextStyle(
                              fontFamily: 'GilroySemi',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            // Premium banner
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFA726), Color(0xFFFF8F00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start from \$10/month',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Generate Unlimited Recipe!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      'assets/chef_icon.png', // Vous devrez ajouter cette image
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.restaurant_menu,
                          color: Colors.white,
                          size: 40,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // History section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Recipe history items
            RecipeHistoryItem(
              imagePath: 'assets/javanese_rice.png',
              title: 'Javanese Beef Fried Rice with Tomato',
              time: '25 Min',
              ingredients: '6 ingredients',
              date: '24 Mar',
            ),

            SizedBox(height: 16),

            RecipeHistoryItem(
              imagePath: 'assets/nasi_liwet.png',
              title: 'Indonesian Original Nasi Liwet',
              time: '15 Min',
              ingredients: '4 ingredients',
              date: '17 Mar',
            ),
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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: PrimaryColor.primary200,
                    child: Icon(
                      Icons.restaurant,
                      color: PrimaryColor.primary500,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          color: Colors.red[600],
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      ingredients,
                      style: TextStyle(
                          fontFamily: 'GilroySemi',
                          color: Colors.grey[500],
                          fontSize: 10),
                    ),
                    Spacer(),
                    Text(
                      date,
                      style: TextStyle(
                          fontFamily: 'GilroySemi',
                          color: Colors.grey[500],
                          fontSize: 10),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'GilroySemi',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
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
}
