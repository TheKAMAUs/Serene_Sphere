import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:visibility_detector/visibility_detector.dart';

import 'package:zo_animated_border/zo_animated_border.dart';

import 'package:flutter_animate/flutter_animate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'serenespherenetworks',
      debugShowCheckedModeBanner: false, // Hides the debug banner
      theme: ThemeData(
        brightness: Brightness.dark, // Dark mode for a modern look
        primaryColor: Colors.indigo, // Primary theme color
        scaffoldBackgroundColor: Colors.black, // Background color
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo.shade900,
          foregroundColor: Colors.white, // AppBar text and icons
          elevation: 5,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.grey.shade900, // Dark drawer theme
        ),

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home:
          // DriversList(),
          const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // Sections with GlobalKeys for smooth scrolling
  final Map<String, Map<String, GlobalKey>> _sectionKeys = {
    "Home": {"animate": GlobalKey(), "section": GlobalKey()},
    "About Us": {"animate": GlobalKey(), "section": GlobalKey()},
    "Vision": {"animate": GlobalKey(), "section": GlobalKey()},
    "Motto": {"animate": GlobalKey(), "section": GlobalKey()},
    "Services": {"animate": GlobalKey(), "section": GlobalKey()},

    "CCTV": {"animate": GlobalKey(), "section": GlobalKey()},
    "GSM Booster": {"animate": GlobalKey(), "section": GlobalKey()},

    "Why Choose Us": {"animate": GlobalKey(), "section": GlobalKey()},
    "Contact": {"animate": GlobalKey(), "section": GlobalKey()},
  };

  String? _selectedSection; // Track the selected section

  // Function to scroll to a specific section and apply animation
  void _scrollToSection(String section, {bool fromDrawer = false}) {
    setState(() {
      _selectedSection = section;
    });

    final sectionKey = _sectionKeys[section]?["section"];
    final keyContext = sectionKey?.currentContext;

    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }

    // 👇 only close drawer if it's fromDrawer
    if (fromDrawer) {
      Navigator.pop(context);
    }
  }

  final Map<String, List<Effect>> _sectionAnimations = {
    "About Us": [
      SlideEffect(
        begin: const Offset(-1.0, 0), // Slide in from left
        end: Offset.zero,
        duration: 1000.ms,
        curve: Curves.easeOut,
      ),
      FadeEffect(duration: 800.ms),
    ],
    "Vision": [
      SlideEffect(
        begin: const Offset(1.0, 0), // Slide in from right
        end: Offset.zero,
        duration: 1000.ms,
        curve: Curves.easeOutBack,
      ),
      FadeEffect(duration: 800.ms),
    ],
    "Motto": [
      SlideEffect(
        begin: const Offset(-1.0, 0), // Slide in from left
        end: Offset.zero,
        duration: 1000.ms,
        curve: Curves.easeInOut,
      ),
      FadeEffect(duration: 800.ms),
    ],
    "Services": [
      SlideEffect(
        begin: const Offset(1.0, 0), // Slide in from right
        end: Offset.zero,
        duration: 1000.ms,
        curve: Curves.easeOut,
      ),
      FadeEffect(duration: 800.ms),
    ],
    "GSM Booster": [
      ScaleEffect(
        begin: const Offset(1.5, 1.5), // Bounce zoom
        end: const Offset(1.0, 1.0),
        duration: 1800.ms,
        curve: Curves.elasticOut,
      ),
    ],
    "CCTV": [
      SlideEffect(
        begin: const Offset(-1.0, 0), // Slide in from left
        end: Offset.zero,
        duration: 1000.ms,
        curve: Curves.easeOut,
      ),
      FadeEffect(duration: 800.ms),
    ],
    "Why Choose Us": [
      SlideEffect(
        begin: const Offset(1.0, 0), // Slide in from right
        end: Offset.zero,
        duration: 1000.ms,
        curve: Curves.easeInOut,
      ),
      FadeEffect(duration: 2000.ms),
      ShakeEffect(hz: 2),
    ],

    "Final": [
      SlideEffect(
        begin: const Offset(0, 1.0), // Slide from bottom
        end: Offset.zero,
        duration: 1200.ms,
        curve: Curves.easeInOut,
      ),
      FadeEffect(duration: 1000.ms),
    ],
  };

  final Map<String, Color> _sectionColors = {
    "Home": Colors.transparent,
    "About Us": Colors.transparent,
    "Vision": Colors.transparent,
    "Motto": Colors.transparent,
    "Services": Colors.transparent,
    "GSM Booster": Colors.transparent,
    "CCTV": Colors.transparent,
    "Why Choose Us": Colors.transparent,
    "Contact": Colors.transparent,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 136, 36),
        title: Image.asset(
          "assets/IMG_20250930_141707.jpg", // 🔹 replace with your logo path
          height: 40, // adjust size to fit nicely
          fit: BoxFit.contain,
        ),
        // centerTitle: true, // optional: centers the logo
      ),
      endDrawer: Drawer(
        // 👈 replaces "drawer:" with "endDrawer:"
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 27, 52, 96),
              ),
              child: Image.asset(
                "assets/IMG_20250929_080615.jpg", // 🔹 replace with your logo path
                height: 80, // adjust size to fit nicely
                fit: BoxFit.contain,
              ),
            ),
            ..._sectionKeys.keys.map(
              (section) => ListTile(
                title: Text(section),
                onTap: () {
                  _scrollToSection(section, fromDrawer: true);
                },
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Positioned.fill(
          //   child: Image.asset(
          //     "assets/spline.png", // Replace with your image path
          //     fit: BoxFit.cover,
          //   ),
          // ),
          SingleChildScrollView(
            child: Column(
              children:
                  _sectionKeys.keys.map((section) {
                    final animation = _sectionAnimations[section] ?? [];

                    if (section == "Home") {
                      // 👈 instead of AnimatedSection, show your custom SkillsSection
                      return KeyedSubtree(
                        key: _sectionKeys[section]?["section"],
                        child: CompanyIntroSection(
                          backgroundColor:
                              _sectionColors[section] ?? Colors.black,
                          scroll: _scrollToSection, // ✅ pass function directly
                        ),
                      );
                    }

                    if (section == "Contact") {
                      // 👈 instead of AnimatedSection, show your custom SkillsSection
                      return KeyedSubtree(
                        key: _sectionKeys[section]?["section"],
                        child: ActionsSection(
                          backgroundColor:
                              _sectionColors[section] ?? Colors.black,
                          scroll: _scrollToSection,
                          sectionColors:
                              _sectionColors, // ✅ pass function directly
                        ),
                      );
                    }

                    if (section == "About Us" ||
                        section == "Vision" ||
                        section == "Motto") {
                      final sectionData = _getSectionData(section);
                      // 👈 instead of AnimatedSection, show your custom SkillsSection
                      return KeyedSubtree(
                        key: _sectionKeys[section]?["section"],
                        child: AnimatedSection1(
                          key: _sectionKeys[section]!["section"],
                          title: section,
                          description: sectionData.description,
                          effects: animation,
                          image: section == 'Motto' ? sectionData.image : null,
                          backgroundColor:
                              _sectionColors[section] ?? Colors.black,
                        ),
                      );
                    }
                    final sectionData = _getSectionData(section);
                    return Animate(
                      key: _sectionKeys[section]!["animate"], // 👈 Unique key
                      effects: _selectedSection == section ? animation : [],
                      child:
                          section == "Enquiry"
                              ? _buildContactSection(
                                key:
                                    _sectionKeys[section]!["section"]!, // 👈 give the GlobalKey
                              )
                              : AnimatedSection(
                                key: _sectionKeys[section]!["section"],
                                title: section,
                                description: sectionData.description,
                                image:
                                    sectionData.image ??
                                    "assets/IMG_20250930_135923.jpg", // fallback image
                                effects: animation,
                                backgroundColor:
                                    _sectionColors[section] ?? Colors.black,
                              ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  SectionData _getSectionData(String section) {
    switch (section) {
      case "About Us":
        return SectionData(
          description: const [
            Text(
              "Serene Sphere Networks is a forward-thinking Internet Service Provider (ISP) "
              "dedicated to delivering fast, reliable, and secure connectivity solutions. "
              "We empower individuals, businesses, and communities through innovative broadband, "
              "fiber, and wireless internet services. Founded with a vision to bridge the digital "
              "divide, we are committed to making internet access affordable, scalable, and future-ready.",
            ),
          ],
          image: "assets/images/about.png",
        );

      case "Vision":
        return SectionData(
          description: const [
            Text(
              "To be the most trusted provider of innovative and reliable networking solutions "
              "that empower individuals, businesses, and communities to thrive in the digital age.",
            ),
          ],
          image: "assets/images/vision.png",
        );

      case "Motto":
        return SectionData(
          description: const [
            Text("Connecting people, powering possibilities."),
          ],
          image: "assets/IMG_20250930_135923.jpg",
        );

      case "Services":
        return SectionData(
          description: [
            _buildOfferCard(
              Icons.home,
              "Home Internet Solutions",
              "Reliable fiber, wireless, and broadband for households.",
            ),
            _buildOfferCard(
              Icons.business,
              "Business Internet Solutions",
              "Dedicated, high-speed internet to support operations.",
            ),
            _buildOfferCard(
              Icons.apartment,
              "Enterprise Solutions",
              "Scalable connectivity for corporates, institutions, and government.",
            ),
            _buildOfferCard(
              Icons.wifi,
              "Managed Wi-Fi Services",
              "Secure and seamless wireless for homes, offices, and public spaces.",
            ),
            _buildOfferCard(
              Icons.cloud,
              "Cloud & Data Services",
              "Hosting, cloud storage, and data center solutions.",
            ),
            _buildOfferCard(
              Icons.call,
              "VoIP & Communication",
              "Cost-effective voice and video solutions.",
            ),
            _buildOfferCard(
              Icons.security,
              "Network Security",
              "Firewalls, VPNs, and secure internet services.",
            ),
          ],
          image: "assets/IMG_20250930_140018.jpg",
        );

      case "GSM Booster":
        return SectionData(
          description: [
            _buildOfferCard(
              Icons.settings_cell,
              "Frequency Band Support",
              "Must match operator frequency (900/1800/2100 MHz).",
            ),
            _buildOfferCard(
              Icons.area_chart,
              "Coverage Area",
              "Select power/output based on area size.",
            ),
            _buildOfferCard(
              Icons.signal_cellular_alt,
              "Gain Level",
              "65–70 dB for small/medium; up to 80 dB for larger buildings.",
            ),
            _buildOfferCard(
              Icons.bolt,
              "Output Power",
              "10–20 dBm, higher means more coverage.",
            ),
            _buildOfferCard(
              Icons.devices_other,
              "Hardware Components",
              "Outdoor Antenna, Coaxial Cable, Signal Booster, Indoor Antenna, Power Supply.",
            ),
            _buildOfferCard(
              Icons.network_cell,
              "Installation",
              "Place outdoor antenna high with strong reception.",
              imagePath: 'assets/IMG_20250930_140426.jpg',
            ),
            _buildOfferCard(
              Icons.sync_problem,
              "Feedback Prevention",
              "Keep distance between indoor & outdoor antennas.",
            ),
            _buildOfferCard(
              Icons.cable,
              "Cabling",
              "Use proper cable length and low-loss cables.",
              imagePath: 'assets/IMG_20250930_150206.jpg',
            ),
          ],
          image: "assets/IMG_20250930_150206.jpg",
        );

      case "CCTV":
        return SectionData(
          description: [
            _buildOfferCard(
              Icons.search,
              "Consultation & Site Survey",
              "Tailored security solutions for your premises.",
              imagePath: 'assets/IMG_20250930_154631.jpg',
            ),
            _buildOfferCard(
              Icons.build,
              "Professional Installation",
              "Cameras, cabling, and recording systems.",
              imagePath: 'assets/IMG_20250930_150206.jpg',
            ),
            _buildOfferCard(
              Icons.videocam,
              "Wide Range of Systems",
              "Analog/IP, indoor/outdoor, night vision, motion detection.",
              imagePath: 'assets/IMG_20250930_154657.jpg',
            ),
            _buildOfferCard(
              Icons.phone_iphone,
              "Remote Monitoring",
              "Access live video feeds from mobile/PC anytime.",
            ),
            _buildOfferCard(
              Icons.support_agent,
              "Maintenance & Support",
              "Regular checks, upgrades, and 24/7 support.",
              imagePath: 'assets/IMG_20250930_150247.jpg',
            ),
          ],
          image: "assets/IMG_20250930_140140.jpg",
        );

      case "Why Choose Us":
        return SectionData(
          description: [
            _buildOfferCard(
              Icons.thumb_up,
              "Reliable Solutions",
              "Affordable, reliable and scalable connectivity.",
            ),
            _buildOfferCard(
              Icons.engineering,
              "Expert Technicians",
              "Certified and experienced team at your service.",
            ),
            _buildOfferCard(
              Icons.design_services,
              "Custom Designs",
              "Tailored networking and security solutions.",
            ),
            _buildOfferCard(
              Icons.school,
              "Training",
              "After-installation training for easy system management.",
              imagePath: 'assets/IMG_20250930_150247.jpg',
            ),
          ],
          image: "assets/IMG_20250930_140426.jpg",
        );

      default:
        return SectionData(description: const []);
    }
  }

  Widget _buildContactSection({required Key key}) {
    return Container(
      key: key,
      height: 400,
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/spline.png"), // Use a relevant image
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Contact Me",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: "Your Name",
              filled: true,
              fillColor: const Color.fromARGB(255, 57, 53, 53).withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Your Email",
              filled: true,
              fillColor: const Color.fromARGB(255, 66, 61, 61).withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Your Message",
              filled: true,
              fillColor: const Color.fromARGB(255, 45, 39, 39).withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle form submission
            },
            child: Text("Send Message"),
          ),
        ],
      ),
    );
  }
}

// Reusable method for offer cards
Widget _buildOfferCard(
  IconData? icon,
  String title,
  String description, {
  String? imagePath, // optional image
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0), // spacing between cards
    child: Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16), // curve amount
              child: SizedBox(
                width: 190,
                height: 80,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // or contain
                ),
              ),
            )
          else if (icon != null)
            Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    ),
  );
}

class SectionData {
  final List<Widget> description;
  final String? image; // nullable image

  SectionData({required this.description, this.image});
}

class AnimatedSection1 extends StatefulWidget {
  final String title;
  final dynamic description; // Widget or List<Widget>
  final String? image;
  final List<Effect> effects;
  final Color backgroundColor;

  const AnimatedSection1({
    required this.title,
    required this.description,
    this.image,
    required this.effects,
    required this.backgroundColor,
    super.key,
  });

  @override
  _AnimatedSection1State createState() => _AnimatedSection1State();
}

class _AnimatedSection1State extends State<AnimatedSection1> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    // Helper to animate description
    Widget buildDescription() {
      List<Widget> items;

      if (widget.description is List<Widget>) {
        items = widget.description;
      } else if (widget.description is Widget) {
        items = [widget.description];
      } else {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < items.length; i++) ...[
            items[i].animate(
              target: isVisible ? 1 : 0,
              delay: (300 + i * 150).ms,
              effects: widget.effects, // only use passed effects
            ),
            const SizedBox(height: 12),
          ],
        ],
      );
    }

    return VisibilityDetector(
      key: Key(widget.title),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !isVisible) {
          setState(() => isVisible = true);
        }
      },
      child: Container(
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 140, 138, 138),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: buildDescription(),
                  ),
                  const SizedBox(height: 20),
                  if (widget.image != null && widget.image!.isNotEmpty)
                    ClipRRect(
                          borderRadius: BorderRadius.circular(
                            20,
                          ), // adjust the radius
                          child: Image.asset(
                            widget.image ?? '',
                            fit: BoxFit.contain,
                            height: 250,
                          ),
                        )
                        .animate(target: isVisible ? 1 : 0)
                        .scale(
                          begin: const Offset(0.0, 0.0),
                          end: const Offset(1.0, 1.0),
                          duration: 2200.ms,
                          curve: Curves.fastEaseInToSlowEaseOut,
                        )
                        .fadeIn(duration: 7000.ms),
                ],
              ),
            ),
          )
          .animate(target: isVisible ? 1 : 0)
          .slideY(begin: 0.21, end: 0, duration: 1200.ms, curve: Curves.easeOut)
          .color(
            begin: Colors.transparent,
            end: widget.backgroundColor,
            duration: 800.ms,
          ),
    );
  }
}

class AnimatedSection extends StatefulWidget {
  final String title;
  final dynamic description; // 🔹 can be Widget OR List<Widget>
  final String? image;
  final List<Effect> effects;
  final Color backgroundColor;

  const AnimatedSection({
    required this.title,
    required this.description,
    this.image,
    required this.effects,
    required this.backgroundColor,
    super.key,
  });

  @override
  _AnimatedSectionState createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.title),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !isVisible) {
          setState(() => isVisible = true);
        }
      },
      child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 140, 138, 138),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🔹 Animate description (now supports single widget or list)
                  _buildAnimatedDescription(
                    widget.description,
                    isVisible,
                    widget.effects,
                  ),
                  const SizedBox(height: 20),

                  // Image
                  if (widget.image != null && widget.image!.isNotEmpty)
                    ClipRRect(
                          borderRadius: BorderRadius.circular(
                            20,
                          ), // adjust the radius
                          child: Image.asset(
                            widget.image ?? '',
                            fit: BoxFit.contain,
                            height: 250,
                          ),
                        )
                        .animate(target: isVisible ? 1 : 0)
                        .scale(
                          begin: const Offset(0.0, 0.0),
                          end: const Offset(1.0, 1.0),
                          duration: 2200.ms,
                          curve: Curves.bounceOut,
                        )
                        .fadeIn(duration: 600.ms),
                ],
              ),
            ),
          )
          // 🔹 Animate container background + entrance
          .animate(target: isVisible ? 1 : 0)
          .slideY(begin: 0.2, end: 0, duration: 1200.ms, curve: Curves.easeOut)
          .color(
            duration: 800.ms,
            begin: Colors.transparent,
            end: widget.backgroundColor,
          ),
    );
  }
}

Widget _buildAnimatedDescription(
  List<Widget> descriptionList,
  bool isVisible,
  List<Effect> effects,
) {
  return Wrap(
    spacing: 12, // horizontal spacing between items
    runSpacing: 12, // vertical spacing between lines
    alignment: WrapAlignment.start,
    children: [
      for (int i = 0; i < descriptionList.length; i++)
        descriptionList[i].animate(
          target: isVisible ? 1 : 0,
          delay: (300 + i * 150).ms, // staggered
          effects: [
            SlideEffect(
              begin:
                  i % 2 == 0
                      ? const Offset(-0.5, 0) // slide from left
                      : const Offset(0.5, 0), // slide from right
              end: Offset.zero,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 800),
            ),
            const FadeEffect(),
            // ...effects, // additional effects if any
          ],
        ),
    ],
  );
}

class CompanyIntroSection extends StatefulWidget {
  final Color backgroundColor;
  final void Function(String section) scroll;

  const CompanyIntroSection({
    super.key,
    required this.backgroundColor,
    required this.scroll,
  });

  @override
  _CompanyIntroSectionState createState() => _CompanyIntroSectionState();
}

class _CompanyIntroSectionState extends State<CompanyIntroSection> {
  bool isVisible = false;
  final typewriterController = AnimatedTextController();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key("CompanyIntroSection"),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !isVisible) {
          setState(() => isVisible = true);
        }
      },
      child: Container(
        height: 750,
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: widget.backgroundColor, // fallback background color
          image: const DecorationImage(
            image: AssetImage(
              "assets/IMG_20250930_135923.jpg",
            ), // <-- your background image
            fit: BoxFit.cover, // cover the whole container
            opacity: 0.2, // adjust visibility so text/icons pop
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 30.0,
                fontFamily: 'Agne',
                color: Colors.white, // make text white
                fontWeight: FontWeight.bold, // make text bold
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Smart, reliable solutions for Kenyan businesses and homes.',
                    cursor: '💡',
                  ),
                ],
                controller: typewriterController,
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 Description message
            Text(
              "Struggling with weak signals or security blind spots? Losing peace of mind "
              "because your network drops or your premises aren’t protected? "
              "From powerful GSM boosters to advanced CCTV systems, we build "
              "affordable, easy-to-use solutions that keep you connected, secure, "
              "and ready to grow — so you can focus on what truly matters most.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 40),

            ElevatedButton(
                  onPressed: () => widget.scroll("Contact"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // remove default padding
                    backgroundColor:
                        Colors.transparent, // so only your custom child shows
                    shadowColor: Colors.transparent, // no button shadow
                  ),
                  child: ZoMultiColorBorder(
                    strokeWidth: 3,
                    borderRadius: 75,
                    colors: [
                      const Color.fromARGB(255, 36, 78, 202),
                      Colors.orange,
                      Colors.red,
                      const Color.fromARGB(255, 204, 108, 44),
                      Colors.blue,
                    ],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        75,
                      ), // ✅ ensures clipping
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 40,
                        color: const Color.fromARGB(255, 49, 47, 47),
                        child: const Text(
                          "Get in touch",
                          style: TextStyle(
                            color: Colors.white,
                          ), // make it readable
                        ),
                      ),
                    ),
                  ),
                )
                .animate(target: isVisible ? 1 : 0)
                .fadeIn(duration: 1500.ms)
                .slide(begin: const Offset(0, 2.5), duration: 1800.ms),
          ],
        ),
      ),
    );
  }
}

class ActionsSection extends StatefulWidget {
  final Color backgroundColor;
  final void Function(String section) scroll;
  final Map<String, Color> sectionColors;

  const ActionsSection({
    super.key,
    required this.backgroundColor,
    required this.scroll,
    required this.sectionColors, // 👈 pass your map here
  });

  @override
  _ActionsSectionState createState() => _ActionsSectionState();
}

class _ActionsSectionState extends State<ActionsSection> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final labels = widget.sectionColors.keys.toList(); // 👈 dynamic

    return VisibilityDetector(
      key: const Key("CompanyActionsSection"),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !isVisible) {
          setState(() => isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        color: widget.backgroundColor,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👇 Main Image
            Center(
              child: Image.asset("assets/IMG_20250929_080615.jpg", height: 150)
                  .animate(target: isVisible ? 1 : 0)
                  .scale(
                    begin: const Offset(0.0, 0.0),
                    end: const Offset(1.0, 1.0),
                    duration: 2200.ms,
                    curve: Curves.bounceOut,
                  )
                  .fadeIn(duration: 600.ms),
            ),
            const SizedBox(height: 40),

            // 👇 Buttons with staggered animations
            ...List.generate(labels.length, (index) {
              final section = labels[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.sectionColors[section],
                      ),
                      onPressed: () => widget.scroll(section),
                      child: Text(
                        section,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                    .animate(target: isVisible ? 1 : 0)
                    .fadeIn(duration: 600.ms, delay: (index * 300).ms)
                    .slide(begin: const Offset(0, 0.4), duration: 600.ms),
              );
            }),

            const SizedBox(height: 40),

            // 👇 Contact info (your provided case)
            ...[
              Text("📞 Phone: +254 708 504 863 | +254 707 433 711"),
              const SizedBox(height: 8),
              Text("📧 Email: serenespherelimited@gmail.com"),
              const SizedBox(height: 8),
              Text("📮 P.O. Box: 15373 – 00100 GPO Nairobi"),
              const SizedBox(height: 8),
              Text("📍 Address: Mumbi House, 1st Floor"),
            ].animate(
              effects: [
                FadeEffect(duration: 800.ms),
                SlideEffect(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                  duration: 800.ms,
                  curve: Curves.easeOut,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 👇 Get in Touch button
            ElevatedButton(
                  onPressed: () => widget.scroll("Contact"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // remove default padding
                    backgroundColor:
                        Colors.transparent, // so only your custom child shows
                    shadowColor: Colors.transparent, // no button shadow
                  ),
                  child: ZoMultiColorBorder(
                    strokeWidth: 3,
                    borderRadius: 75,
                    colors: [
                      const Color.fromARGB(255, 36, 78, 202),
                      Colors.orange,
                      Colors.red,
                      const Color.fromARGB(255, 204, 108, 44),
                      Colors.blue,
                    ],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        75,
                      ), // ✅ ensures clipping
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 40,
                        color: const Color.fromARGB(255, 49, 47, 47),
                        child: const Text(
                          "Get in touch",
                          style: TextStyle(
                            color: Colors.white,
                          ), // make it readable
                        ),
                      ),
                    ),
                  ),
                )
                .animate(target: isVisible ? 1 : 0)
                .fadeIn(duration: 1500.ms)
                .slide(begin: const Offset(0, 0.3), duration: 1800.ms),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
