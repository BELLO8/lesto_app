import 'package:flutter/material.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  int selectedStoreIndex = 0;
  String selectedTimeSlot = "Aujourd'hui, 14h - 16h";
  bool showDishes = false;

  final List<Store> stores = [
    Store(
      name: "SuperMarché Express",
      deliveryTime: "Livraison en 2h",
      price: "Frais: 4,99€",
      color: Colors.green,
      icon: Icons.shopping_bag,
    ),
    Store(
      name: "Marché Bio Local",
      deliveryTime: "Livraison demain",
      price: "Frais: 2,99€",
      color: Colors.red,
      icon: Icons.shopping_bag,
    ),
    Store(
      name: "HyperFrais",
      deliveryTime: "Livraison en 3h",
      price: "Frais: 3,99€",
      color: Colors.blue,
      icon: Icons.shopping_bag,
    ),
  ];

  final List<Restaurant> restaurants = [
    Restaurant(
      name: "La Trattoria",
      cuisine: "Italien",
      deliveryTime: "30-45 min",
      price: "4,99€",
      color: Colors.orange,
    ),
    Restaurant(
      name: "Veggie Delight",
      cuisine: "Végétarien",
      deliveryTime: "20-35 min",
      price: "3,99€",
      color: Colors.green,
    ),
    Restaurant(
      name: "Spice Garden",
      cuisine: "Indien",
      deliveryTime: "40-55 min",
      price: "5,99€",
      color: Colors.purple,
    ),
  ];

  final List<Dish> dishes = [
    Dish(
      name: "Risotto aux champignons",
      restaurant: "La Trattoria",
      deliveryTime: "30-45 min",
      price: "12,90 €",
    ),
    Dish(
      name: "Curry de légumes",
      restaurant: "Spice Garden",
      deliveryTime: "40-55 min",
      price: "11,50 €",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!showDishes) ...[
                    // Store Selection Section
                    const Text(
                      'Livraison de courses',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Choisir un magasin',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...stores.asMap().entries.map((entry) {
                      int index = entry.key;
                      Store store = entry.value;
                      return _buildStoreCard(store, index);
                    }).toList(),
                  ],

                  const SizedBox(height: 24),

                  // Delivery Address Section
                  const Text(
                    'Adresse de livraison',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Domicile',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '123 Rue de la Paix, 75001 Paris',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Modifier'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Time Slot Section
                  const Text(
                    'Créneau de livraison',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedTimeSlot,
                        isExpanded: true,
                        items: [
                          "Aujourd'hui, 14h - 16h",
                          "Demain, 10h - 12h",
                          "Demain, 14h - 16h",
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTimeSlot = newValue!;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showDishes = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColor.primary600,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Confirmer la livraison',
                        style: TextStyle(
                          fontFamily: 'GilroySemi',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Restaurants Section
                  const Text(
                    'Livraison de plats',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Restaurants partenaires',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...restaurants
                      .map((restaurant) => _buildRestaurantCard(restaurant))
                      .toList(),

                  if (showDishes) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Plats disponibles',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...dishes.map((dish) => _buildDishCard(dish)).toList(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF6366F1) : Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? const Color(0xFF6366F1) : Colors.grey,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        if (isActive)
          Container(
            margin: const EdgeInsets.only(top: 2),
            height: 2,
            width: 20,
            color: const Color(0xFF6366F1),
          ),
      ],
    );
  }

  Widget _buildStoreCard(Store store, int index) {
    bool isSelected = selectedStoreIndex == index;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedStoreIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF6366F1) : Colors.grey[200]!,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: store.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  store.icon,
                  color: store.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${store.deliveryTime} • ${store.price}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Radio<int>(
                value: index,
                groupValue: selectedStoreIndex,
                onChanged: (int? value) {
                  setState(() {
                    selectedStoreIndex = value!;
                  });
                },
                activeColor: const Color(0xFF6366F1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: restaurant.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.restaurant,
              color: restaurant.color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${restaurant.cuisine} • ${restaurant.deliveryTime} • ${restaurant.price}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Voir'),
          ),
        ],
      ),
    );
  }

  Widget _buildDishCard(Dish dish) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dish.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                dish.price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${dish.restaurant} • ${dish.deliveryTime}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor.primary600,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Commander',
                style: TextStyle(
                  fontFamily: "GilroySemi",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Store {
  final String name;
  final String deliveryTime;
  final String price;
  final Color color;
  final IconData icon;

  Store({
    required this.name,
    required this.deliveryTime,
    required this.price,
    required this.color,
    required this.icon,
  });
}

class Restaurant {
  final String name;
  final String cuisine;
  final String deliveryTime;
  final String price;
  final Color color;

  Restaurant({
    required this.name,
    required this.cuisine,
    required this.deliveryTime,
    required this.price,
    required this.color,
  });
}

class Dish {
  final String name;
  final String restaurant;
  final String deliveryTime;
  final String price;

  Dish({
    required this.name,
    required this.restaurant,
    required this.deliveryTime,
    required this.price,
  });
}
