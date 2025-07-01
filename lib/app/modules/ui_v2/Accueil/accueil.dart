import 'package:flutter/material.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

class RecipeHomePage extends StatefulWidget {
  @override
  _RecipeHomePageState createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> {
  List<String> selectedIngredients = ['Chicken', 'Egg', 'Onion', 'Garlic'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and notification icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: Text(
                    'Vous ne savez pas quoi cuisiner aujourd\'hui ?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      color: Colors.black,
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
                        "Créez des menus reflètent votre style de vie.",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            fontFamily: "GilroyMedium"),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Ingredients chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedIngredients.map((ingredient) {
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
                              onTap: () {
                                setState(() {
                                  selectedIngredients.remove(ingredient);
                                });
                              },
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
                  ),

                  SizedBox(height: 12),
                  Text(
                    'Add Ingredients',
                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                  ),

                  SizedBox(height: 20),

                  // Generate Recipe button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
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
                            'Generate Recipe',
                            style: TextStyle(
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
                  Container(
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
                  'Historique des recettes',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Voir tout',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: "Gilroy"),
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
