import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _bookingKey = GlobalKey();
  String _selectedModality = 'Online';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  void _scrollToBooking() {
    Scrollable.ensureVisible(
      _bookingKey.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _submitBooking() {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa tu nombre y email.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¡Solicitud enviada!'),
        content: Text(
          'Gracias ${_nameController.text}. Te contactaré pronto para coordinar tu primera clase ($_selectedModality).',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _nameController.clear();
              _emailController.clear();
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Español Fluido',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: FilledButton(
              onPressed: _scrollToBooking,
              child: const Text('Reservar clase'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHero(context),
            const Divider(height: 1),
            _buildServices(context),
            const Divider(height: 1),
            _buildPricing(context),
            const Divider(height: 1),
            _buildBookingForm(context),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 48,
      ),
      child: MaxWidthContainer(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFC0392B),
              child: Icon(Icons.record_voice_over, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Text(
              'Habla español con fluidez y confianza',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C3E50),
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Clases individuales de conversación adaptadas a tu nivel. '
              'Aprende de forma práctica y natural, sin presiones.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black87,
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _scrollToBooking,
              icon: const Icon(Icons.calendar_today),
              label: const Text('Reserva tu clase de prueba'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServices(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 700;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: MaxWidthContainer(
        child: Column(
          children: [
            Text(
              'Modalidades',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 32),
            isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildCard('Online', Icons.computer, 'Aprende desde cualquier lugar por videollamada con total flexibilidad.')),
                      const SizedBox(width: 24),
                      Expanded(child: _buildCard('Presencial (Málaga)', Icons.location_on, 'Clases cara a cara en Málaga. Práctica real y natural en contexto.')),
                    ],
                  )
                : Column(
                    children: [
                      _buildCard('Online', Icons.computer, 'Aprende desde cualquier lugar por videollamada con total flexibilidad.'),
                      const SizedBox(height: 24),
                      _buildCard('Presencial (Málaga)', Icons.location_on, 'Clases cara a cara en Málaga. Práctica real y natural en contexto.'),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, String desc) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: const Color(0xFFC0392B)),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            // ignore: deprecated_member_use
            Text(desc, style: TextStyle(color: const Color(0xFF000000).withOpacity(0.7))),
          ],
        ),
      ),
    );
  }

  Widget _buildPricing(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: MaxWidthContainer(
        child: Column(
          children: [
            Text(
              'Tarifas sencillas',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: [
                _buildPriceCard('Clase suelta', '15€', 'por hora (Online)', ['60 minutos', 'Corrección en vivo', 'Materiales incluidos'], false),
                _buildPriceCard('Bono 5 Clases', '65€', '13€ / hora', ['Ahorra un 13%', 'Horarios flexibles', 'Seguimiento personal'], true),
                _buildPriceCard('Presencial', '20€', 'por hora (Málaga)', ['Encuentros en Málaga', 'Inmersión práctica', 'Objetivos propios'], false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceCard(String title, String price, String subtitle, List<String> features, bool isHighlighted) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xFF2C3E50) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isHighlighted ? const Color(0xFF2C3E50) : Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isHighlighted ? Colors.white : Colors.black)),
          const SizedBox(height: 12),
          Text(price, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: isHighlighted ? Colors.white : const Color(0xFFC0392B))),
          Text(subtitle, style: TextStyle(color: isHighlighted ? Colors.white70 : Colors.black54)),
          const SizedBox(height: 20),
          ...features.map((f) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.check, size: 18, color: isHighlighted ? Colors.white : Colors.green),
                    const SizedBox(width: 8),
                    Expanded(child: Text(f, style: TextStyle(color: isHighlighted ? Colors.white : Colors.black87, fontSize: 13))),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildBookingForm(BuildContext context) {
    return Container(
      key: _bookingKey,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: MaxWidthContainer(
        child: Column(
          children: [
            Text('Reserva tu primera clase', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedModality,
                    decoration: const InputDecoration(labelText: 'Modalidad', border: OutlineInputBorder()),
                    items: const [
                      DropdownMenuItem(value: 'Online', child: Text('Online')),
                      DropdownMenuItem(value: 'Presencial (Málaga)', child: Text('Presencial (Málaga)')),
                    ],
                    onChanged: (val) => setState(() => _selectedModality = val!),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submitBooking,
                      style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: const Text('Enviar solicitud'),
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

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: const Color(0xFF2C3E50),
      child: const Center(
        child: Text('© Español Fluido. Clases de conversación online y en Málaga.', style: TextStyle(color: Colors.white70, fontSize: 13)),
      ),
    );
  }
}

class MaxWidthContainer extends StatelessWidget {
  final Widget child;
  const MaxWidthContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: child,
      ),
    );
  }
}