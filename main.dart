import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const PortfolioApp());

const purple = Color(0xFF8067B7);
const navy = Color(0xFF373653);
const pink = Color(0xFFF3A6C8);
const teal = Color(0xFF83CFC3);
const orange = Color(0xFFFFC98B);
const pageBg = Color(0xFFFFF8FC);

class CertificateItem {
  final String title, provider, description, link;
  final IconData icon;
  final Color color;
  final bool asset;
  const CertificateItem(this.title, this.provider, this.description, this.link,
      this.icon, this.color, {this.asset = false});
}

const certificates = <CertificateItem>[
  CertificateItem('Data Structures', 'Course Certificate',
      'Certificate for learning Data Structures.',
      'https://drive.google.com/file/d/173UP4pc5wnPnR1gQI83aTmFaCGNelV6L/view?usp=drivesdk',
      Icons.account_tree_rounded, purple),
  CertificateItem('OOPs Through Java', 'Course Certificate',
      'Object-oriented programming concepts using Java.',
      'https://drive.google.com/file/d/192_06rF02N2aq0bwA_pUxT-2F317o5gr/view?usp=drivesdk',
      Icons.code_rounded, teal),
  CertificateItem('Machine Learning', 'SAMARDH AI Solutions',
      'Data Collection Techniques, Training and Deployment of ML Models.',
      'assets/assets/certificates/26BVHWML1073.pptx.pdf',
      Icons.psychology_rounded, pink, asset: true),
  CertificateItem('Google AI Professional Certificate', 'Google / Coursera',
      'Seven courses covering AI fundamentals, research, writing, data analysis and app building.',
      'assets/assets/certificates/Coursera%20last.pdf',
      Icons.workspace_premium_rounded, orange, asset: true),
  CertificateItem('Web Development — Frontend', 'Course Certificate',
      'Frontend web development certificate.',
      'https://drive.google.com/file/d/1ux9wQbqDm3lF4vDqYe0FJ0u7nEzBTRSX/view?usp=sharing',
      Icons.web_rounded, purple),
  CertificateItem('YMHFA — COPE Club', 'Mpower',
      'Youth Mental Health First Aider accreditation after training and assessment.',
      'assets/assets/certificates/1.%20YMHFA%20Certificate%20-%20Accreditation-part-6.pdf',
      Icons.favorite_rounded, teal, asset: true),
];

Future<void> openCertificate(CertificateItem c) async {
  final uri = c.asset ? Uri.base.resolve(c.link) : Uri.parse(c.link);
  final opened = await launchUrl(uri, mode: LaunchMode.platformDefault);
  if (!opened) debugPrint('Could not open ${c.title}: $uri');
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'My Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: pageBg,
          colorScheme: ColorScheme.fromSeed(seedColor: purple),
        ),
        home: const LoginPage(),
      );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final roll = TextEditingController();
  final password = TextEditingController();

  void login() {
    if (roll.text.trim().isEmpty || password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter roll number and password')),
      );
      return;
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const DashboardPage()));
  }

  @override
  void dispose() {
    roll.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const CircleAvatar(
                      radius: 42,
                      backgroundColor: Color(0xFFE5DDF6),
                      child: Icon(Icons.person, size: 48, color: navy),
                    ),
                    const SizedBox(height: 18),
                    const Text('My Portfolio ✨',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: navy)),
                    const SizedBox(height: 8),
                    const Text('Welcome! Sign in to explore my portfolio.',
                        textAlign: TextAlign.center),
                    const SizedBox(height: 24),
                    TextField(
                      controller: roll,
                      decoration: const InputDecoration(
                        labelText: 'Roll Number',
                        prefixIcon: Icon(Icons.badge_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: password,
                      obscureText: true,
                      onSubmitted: (_) => login(),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: login,
                        style: FilledButton.styleFrom(
                            backgroundColor: purple,
                            foregroundColor: Colors.white),
                        child: const Text('Login'),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      );
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    final items = <_MenuItem>[
      _MenuItem('Education', 'My academics', Icons.school, const EducationPage(), purple),
      _MenuItem('Certificates', 'Courses & learning', Icons.workspace_premium, const CertificatesPage(), orange),
      _MenuItem('Activities', 'Clubs & interests', Icons.palette, const ActivitiesPage(), pink),
      _MenuItem('My Projects', 'Things I built', Icons.rocket_launch, const ProjectsPage(), teal),
    ];
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          final width = constraints.maxWidth > 1100 ? 1050.0 : constraints.maxWidth - 36;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: SizedBox(
                width: width,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Row(children: [
                    const Text('Raajitha ✨', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: navy)),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage())),
                      icon: const Icon(Icons.logout, color: Colors.redAccent),
                      label: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
                    ),
                  ]),
                  const SizedBox(height: 42),
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFFE8DFFF), Color(0xFFFFE4F0)]),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('HELLO THERE 👋', style: TextStyle(color: navy)),
                      SizedBox(height: 10),
                      Text("I'm Raajitha!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: navy)),
                      SizedBox(height: 8),
                      Text('A Computer Science student who loves learning, building projects, art and creativity.', style: TextStyle(fontSize: 16, color: navy)),
                    ]),
                  ),
                  const SizedBox(height: 28),
                  const Text('Explore My Portfolio', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: navy)),
                  const SizedBox(height: 16),
                  LayoutBuilder(builder: (context, inner) {
                    final cols = inner.maxWidth > 850 ? 5 : inner.maxWidth > 570 ? 3 : 2;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 1.12,
                      ),
                      itemBuilder: (context, i) {
                        final item = items[i];
                        return InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item.page)),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                CircleAvatar(backgroundColor: item.color.withOpacity(.28), child: Icon(item.icon, color: navy)),
                                const SizedBox(height: 10),
                                Text(item.title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, color: navy)),
                                const SizedBox(height: 4),
                                Text(item.subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                              ]),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                  const Center(child: Text('Made with 💜 by Raajitha', style: TextStyle(color: Colors.black54))),
                ]),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _MenuItem {
  final String title, subtitle;
  final IconData icon;
  final Widget page;
  final Color color;
  const _MenuItem(this.title, this.subtitle, this.icon, this.page, this.color);
}

class PageShell extends StatelessWidget {
  final String title;
  final Widget child;
  const PageShell({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: navy)), backgroundColor: pageBg, foregroundColor: navy),
        body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1050), child: child)),
      );
}

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});
  @override
  Widget build(BuildContext context) {
    final rows = [
      ['10th Class', 'Sriram School', '94%'],
      ['12th Class', 'Pragathi Junior College', '94.3%'],
      ['B.Tech - 1st Year', 'BVRIT Hyderabad', '9.15 CGPA'],
      ['B.Tech - 2nd Year', 'BVRITH', '8.8 CGPA'],
    ];
    return PageShell(
      title: 'Education',
      child: ListView(padding: const EdgeInsets.all(24), children: [
        const Text('My Education 🎓', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: navy)),
        const SizedBox(height: 8),
        const Text('A look at my academic journey.', style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 22),
        Card(color: Colors.white, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
          columns: const [DataColumn(label: Text('Class')), DataColumn(label: Text('Institution')), DataColumn(label: Text('Score'))],
          rows: rows.map((r) => DataRow(cells: [
            DataCell(Text(r[0])), DataCell(Text(r[1])),
            DataCell(Text(r[2], style: const TextStyle(color: purple, fontWeight: FontWeight.bold))),
          ])).toList(),
        ))),
        const SizedBox(height: 20),
        const InfoCard(icon: Icons.school, title: 'B.Tech in Computer Science', subtitle: 'BVRIT Hyderabad College of Engineering for Women', color: Color(0xFFE4DDF5)),
      ]),
    );
  }
}

class CertificatesPage extends StatelessWidget {
  const CertificatesPage({super.key});
  @override
  Widget build(BuildContext context) => PageShell(
        title: 'Certificates',
        child: ListView(padding: const EdgeInsets.all(22), children: [
          const Text('My Certificates 🏅', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: navy)),
          const SizedBox(height: 8),
          const Text('Select a certificate to open it.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          ...certificates.map((c) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(color: Colors.white, child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                CircleAvatar(radius: 27, backgroundColor: c.color.withOpacity(.28), child: Icon(c.icon, color: navy)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(c.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: navy)),
                  const SizedBox(height: 4),
                  Text(c.provider, style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 5),
                  Text(c.description, style: const TextStyle(fontSize: 12)),
                ])),
                const SizedBox(width: 8),
                IconButton(tooltip: 'Open certificate', onPressed: () => openCertificate(c), icon: const Icon(Icons.open_in_new, color: purple)),
              ]),
            )),
          )),
        ]),
      );
}

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});
  @override
  Widget build(BuildContext context) => PageShell(
    title: 'Activities',
    child: ListView(padding: const EdgeInsets.all(24), children: const [
      Text('Activities & Interests 🎨', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: navy)),
      SizedBox(height: 18),
      InfoCard(icon: Icons.palette, title: 'Art Club', subtitle: 'Creative work and club activities', color: pink),
      InfoCard(icon: Icons.volunteer_activism, title: 'COPE Club', subtitle: 'Volunteering and club activities', color: teal),
      InfoCard(icon: Icons.music_note, title: 'Classical Dance', subtitle: 'Learning and practising classical dance', color: orange),
      InfoCard(icon: Icons.headphones, title: 'Music', subtitle: 'Music as a creative interest', color: purple),
      InfoCard(icon: Icons.brush, title: 'Artist', subtitle: 'Art and creative expression', color: pink),
      InfoCard(icon: Icons.favorite, title: 'Volunteering', subtitle: 'Participating in community and club activities', color: teal),
    ]),
  );
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});
  @override
  Widget build(BuildContext context) => PageShell(
    title: 'My Projects',
    child: ListView(padding: const EdgeInsets.all(24), children: const [
      Text('Things I Built 🚀', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: navy)),
      SizedBox(height: 18),
      InfoCard(icon: Icons.directions_car, title: 'ResaleX', subtitle: 'Used-SUV resale price prediction • Python • Pandas • Scikit-learn • XGBoost • Flask', color: purple),
      SizedBox(height: 12),
      InfoCard(icon: Icons.newspaper, title: 'TechNewsDigest', subtitle: 'Technology news aggregation and summarization • Python • Streamlit • NLP • Hugging Face', color: teal),
      SizedBox(height: 12),
      InfoCard(icon: Icons.shield, title: 'Scam URL Detection', subtitle: 'Machine learning project to classify suspicious and legitimate URLs • Python • Pandas • ML', color: pink),
    ]),
  );
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final Color color;
  const InfoCard({super.key, required this.icon, required this.title, required this.subtitle, required this.color});
  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Row(children: [
        CircleAvatar(backgroundColor: color.withOpacity(.28), child: Icon(icon, color: navy)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: navy)),
          const SizedBox(height: 5),
          Text(subtitle, style: const TextStyle(color: Colors.black54)),
        ])),
      ]),
    ),
  );
}
