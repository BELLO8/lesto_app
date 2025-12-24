import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColor.neutral50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: NeutralColor.neutral800, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Mon Profil',
          style: TextStyle(
            color: NeutralColor.neutral900,
            fontFamily: 'GilroyBold',
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildMenuSection(),
            const SizedBox(height: 40),
            _buildLogoutButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Obx(() => Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: PrimaryColor.primary200, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: PrimaryColor.primary100,
                      backgroundImage:
                          controller.userAvatar.value.startsWith('assets')
                              ? AssetImage(controller.userAvatar.value)
                                  as ImageProvider
                              : null,
                      child: controller.userAvatar.value == ""
                          ? const Icon(Icons.person,
                              size: 50, color: PrimaryColor.primary600)
                          : null,
                    ),
                  )),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _showAvatarSelection(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: PrimaryColor.primary600,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(HugeIcons.strokeRoundedCamera01,
                        color: Colors.white, size: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() => Text(
                controller.userName.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'GilroyBold',
                  color: NeutralColor.neutral900,
                ),
              )),
          const SizedBox(height: 4),
          Obx(() => Text(
                controller.userEmail.value,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Gilroy',
                  color: NeutralColor.neutral600,
                ),
              )),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: PrimaryColor.primary100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(HugeIcons.strokeRoundedCircleArrowDown01,
                    color: PrimaryColor.primary600, size: 16),
                SizedBox(width: 8),
                Text(
                  'Membre Premium',
                  style: TextStyle(
                    color: PrimaryColor.primary700,
                    fontFamily: 'GilroyBold',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMenuTitle("Compte"),
          _buildMenuItem(
            icon: HugeIcons.strokeRoundedUserEdit01,
            title: "Mes Informations",
            onTap: () => _showEditInfoModal(),
          ),
          _buildMenuItem(
            icon: HugeIcons.strokeRoundedCircleArrowDown01,
            title: "Abonnement",
            onTap: () => Get.toNamed(Routes.SUBSCRIPTION),
          ),
          const SizedBox(height: 24),
          _buildMenuTitle("Préférences"),
          Obx(() => _buildMenuItem(
                icon: HugeIcons.strokeRoundedGlobal,
                title: "Langue",
                trailing: controller.currentLanguage.value,
                onTap: () => _showLanguageModal(),
              )),
          _buildMenuItem(
            icon: HugeIcons.strokeRoundedInformationCircle,
            title: "À propos de Lesto",
            onTap: () => Get.toNamed(Routes.ABOUT),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'GilroyBold',
          color: NeutralColor.neutral500,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? trailing,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColor.neutral200),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: NeutralColor.neutral700),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'GilroySemi',
            color: NeutralColor.neutral800,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailing != null)
              Text(
                trailing,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Gilroy',
                  color: NeutralColor.neutral600,
                ),
              ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: NeutralColor.neutral400),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextButton(
        onPressed: () => controller.logout(),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.red.shade100),
          ),
          backgroundColor: Colors.red.shade50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(HugeIcons.strokeRoundedLogout01,
                color: Colors.red.shade600, size: 20),
            const SizedBox(width: 12),
            Text(
              "Déconnexion",
              style: TextStyle(
                color: Colors.red.shade600,
                fontFamily: 'GilroyBold',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditInfoModal() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Modifier mes infos",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'GilroyBold',
                  color: NeutralColor.neutral900,
                ),
              ),
              const SizedBox(height: 24),
              _buildModalField(
                label: "Nom Complet",
                controller: controller.nameController,
              ),
              const SizedBox(height: 16),
              _buildModalField(
                label: "E-mail",
                controller: controller.emailController,
                type: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildModalField(
                label: "Téléphone",
                controller: controller.phoneController,
                type: TextInputType.phone,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.updateProfile();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColor.primary600,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Enregistrer",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'GilroyBold',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildModalField({
    required String label,
    required TextEditingController controller,
    TextInputType type = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'GilroySemi',
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: type,
          style: const TextStyle(fontFamily: 'GilroySemi', fontSize: 15),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: NeutralColor.neutral200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: NeutralColor.neutral200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: PrimaryColor.primary600),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  void _showAvatarSelection() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choisir un avatar",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'GilroyBold',
                color: NeutralColor.neutral900,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.avatars.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final String avatarPath = controller.avatars[index];
                  return GestureDetector(
                    onTap: () {
                      controller.changeAvatar(avatarPath);
                    },
                    child: Obx(() => Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: controller.userAvatar.value == avatarPath
                                  ? PrimaryColor.primary600
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: PrimaryColor.primary100,
                            backgroundImage: AssetImage(avatarPath),
                          ),
                        )),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showLanguageModal() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choisir la langue",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'GilroyBold',
                color: NeutralColor.neutral900,
              ),
            ),
            const SizedBox(height: 24),
            _buildLanguageItem("Français", "🇫🇷"),
            _buildLanguageItem("English", "🇬🇧"),
            _buildLanguageItem("Wolof", "🇸🇳"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageItem(String lang, String flag) {
    return ListTile(
      onTap: () => controller.changeLanguage(lang),
      leading: Text(flag, style: const TextStyle(fontSize: 20)),
      title: Text(
        lang,
        style: const TextStyle(
          fontFamily: 'GilroySemi',
          fontSize: 15,
          color: NeutralColor.neutral800,
        ),
      ),
      trailing: Obx(() => controller.currentLanguage.value == lang
          ? const Icon(Icons.check_circle, color: PrimaryColor.primary600)
          : const SizedBox.shrink()),
    );
  }
}
