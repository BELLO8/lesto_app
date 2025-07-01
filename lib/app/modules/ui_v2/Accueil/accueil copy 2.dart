import 'package:flutter/material.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'SF Pro Display',
      ),
      home: RecipeHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RecipeHomePage extends StatefulWidget {
  @override
  _RecipeHomePageState createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> {
  List<String> selectedIngredients = ['Chicken', 'Egg', 'Onion', 'Garlic'];
  TextEditingController _ingredientController = TextEditingController();

  // Nouvelles variables d'état
  int selectedPersons = 2;
  String selectedPeriod = '1 day';
  List<String> selectedAllergies = [];
  String selectedCookingTime = '15-30 min';
  String selectedDifficulty = 'Easy';
  String selectedCuisineType = 'Asian';

  void _showAddIngredientBottomSheet() {
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
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
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
                    Text(
                      'Add Ingredients',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _ingredientController,
                      decoration: InputDecoration(
                        hintText: 'Enter ingredient name...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            if (_ingredientController.text.isNotEmpty) {
                              setState(() {
                                selectedIngredients.add(
                                  _ingredientController.text,
                                );
                                _ingredientController.clear();
                              });
                            }
                          },
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            selectedIngredients.add(value);
                            _ingredientController.clear();
                          });
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Popular Ingredients',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        'Tomato',
                        'Potato',
                        'Beef',
                        'Rice',
                        'Cheese',
                        'Pasta',
                        'Mushroom',
                        'Bell Pepper',
                        'Spinach',
                      ].map((ingredient) {
                        return GestureDetector(
                          onTap: () {
                            if (!selectedIngredients.contains(ingredient)) {
                              setState(() {
                                selectedIngredients.add(ingredient);
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selectedIngredients.contains(ingredient)
                                  ? Colors.green[50]
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selectedIngredients.contains(ingredient)
                                    ? Colors.green
                                    : Colors.grey[300]!,
                              ),
                            ),
                            child: Text(
                              ingredient,
                              style: TextStyle(
                                fontSize: 14,
                                color: selectedIngredients.contains(ingredient)
                                    ? Colors.green[700]
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGenerateRecipeBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
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
                      'Generate Recipe',
                      style: TextStyle(
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
                            'Selected Ingredients:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: selectedIngredients.map((ingredient) {
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Recipe Preferences',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Nombre de personnes
                    _buildPersonSelector(),
                    SizedBox(height: 16),

                    // Période de génération
                    _buildPeriodSelector(),
                    SizedBox(height: 16),

                    // Allergies
                    _buildAllergySelector(),
                    SizedBox(height: 16),

                    _buildPreferenceOption(
                      'Cooking Time',
                      ['< 15 min', '15-30 min', '30+ min'],
                      selectedCookingTime,
                      (value) {
                        setState(() {
                          selectedCookingTime = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    _buildPreferenceOption(
                      'Difficulty',
                      ['Easy', 'Medium', 'Hard'],
                      selectedDifficulty,
                      (value) {
                        setState(() {
                          selectedDifficulty = value;
                        });
                      },
                    ),
                    SizedBox(height: 12),
                    _buildPreferenceOption(
                      'Cuisine Type',
                      ['Asian', 'European', 'American', 'Mediterranean'],
                      selectedCuisineType,
                      (value) {
                        setState(() {
                          selectedCuisineType = value;
                        });
                      },
                    ),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showRecipeResultBottomSheet();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4A5D3A),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Generate My Recipe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
        Container(
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
                onTap: () {
                  if (selectedPersons > 1) {
                    setState(() {
                      selectedPersons--;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: selectedPersons > 1
                        ? Colors.grey[100]
                        : Colors.grey[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 16,
                    color:
                        selectedPersons > 1 ? Colors.black : Colors.grey[400],
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text(
                '$selectedPersons',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  if (selectedPersons < 10) {
                    setState(() {
                      selectedPersons++;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: selectedPersons < 10
                        ? Colors.grey[100]
                        : Colors.grey[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color:
                        selectedPersons < 10 ? Colors.black : Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    List<String> periods = ['1 day', '3 days', '1 week', '2 weeks', '1 month'];

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
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: periods.map((period) {
            bool isSelected = selectedPeriod == period;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = period;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF4A5D3A) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Color(0xFF4A5D3A) : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  period,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAllergySelector() {
    List<String> allergies = [
      'Gluten',
      'Dairy',
      'Nuts',
      'Shellfish',
      'Eggs',
      'Soy',
      'Fish',
      'Sesame',
      'Peanuts',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Allergies & Dietary Restrictions',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allergies.map((allergy) {
            bool isSelected = selectedAllergies.contains(allergy);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedAllergies.remove(allergy);
                  } else {
                    selectedAllergies.add(allergy);
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red[50] : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Colors.red[300]! : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      Icon(Icons.block, size: 14, color: Colors.red[600]),
                      SizedBox(width: 4),
                    ],
                    Text(
                      allergy,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.red[700] : Colors.black,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        if (selectedAllergies.isNotEmpty) ...[
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, size: 16, color: Colors.amber[700]),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Recipes will exclude: ${selectedAllergies.join(', ')}',
                    style: TextStyle(fontSize: 11, color: Colors.amber[800]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPreferenceOption(
    String title,
    List<String> options,
    String selectedValue,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 6),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            bool isSelected = selectedValue == option;
            return GestureDetector(
              onTap: () => onChanged(option),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Color(0xFF4A5D3A).withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Color(0xFF4A5D3A) : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Color(0xFF4A5D3A) : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showRecipeResultBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
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
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.check, color: Colors.green),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Recipe Generated Successfully!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.restaurant_menu,
                        size: 60,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Delicious Chicken & Egg Stir Fry',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4),
                        Text(
                          '20 minutes',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.person, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          '2-3 servings',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Ingredients:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ...selectedIngredients
                        .map(
                          (ingredient) => Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Text(
                              '• $ingredient',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                        .toList(),
                    SizedBox(height: 20),
                    Text(
                      'Instructions:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. Heat oil in a large pan over medium-high heat\n'
                      '2. Add chopped onions and garlic, cook until fragrant\n'
                      '3. Add chicken pieces and cook until golden brown\n'
                      '4. Beat eggs and scramble them with the chicken\n'
                      '5. Season with salt and pepper to taste\n'
                      '6. Serve hot and enjoy!',
                      style: TextStyle(fontSize: 14, height: 1.5),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Close'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Recipe saved to history!'),
                                ),
                              );
                            },
                            child: Text('Save Recipe'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4A5D3A),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '19:27',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        leadingWidth: 60,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Icon(
                  Icons.signal_cellular_4_bar,
                  color: Colors.black,
                  size: 16,
                ),
                SizedBox(width: 4),
                Icon(Icons.wifi, color: Colors.black, size: 16),
                SizedBox(width: 4),
                Stack(
                  children: [
                    Icon(Icons.battery_full, color: Colors.black, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and notification icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Not sure what to cook tonight?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Icon(Icons.notifications_outlined, size: 24),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
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
                        "We'll conjure a recipe from your ingredients",
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
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
                  GestureDetector(
                    onTap: _showAddIngredientBottomSheet,
                    child: Text(
                      'Add Ingredients',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _showGenerateRecipeBottomSheet,
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
                    color: Colors.green[100],
                    child: Icon(
                      Icons.restaurant,
                      color: Colors.green[600],
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
                      style: TextStyle(color: Colors.grey[500], fontSize: 10),
                    ),
                    Spacer(),
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey[500], fontSize: 10),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
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
