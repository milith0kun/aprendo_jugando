import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as Math;
import '../../providers/auth_provider.dart';
import '../../config/app_theme.dart';

class ChildLoginScreen extends StatefulWidget {
  const ChildLoginScreen({Key? key}) : super(key: key);

  @override
  State<ChildLoginScreen> createState() => _ChildLoginScreenState();
}

class _ChildLoginScreenState extends State<ChildLoginScreen> with TickerProviderStateMixin {
  String? _selectedChildId;
  String _pin = '';
  late AnimationController _scaleController;
  late AnimationController _shakeController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _handlePinInput(String digit) {
    if (_pin.length < 4) {
      setState(() {
        _pin += digit;
      });
      _scaleController.forward().then((_) => _scaleController.reverse());

      if (_pin.length == 4) {
        _handleLogin();
      }
    }
  }

  void _handleDelete() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _shakeAnimation() {
    _shakeController.reset();
    _shakeController.forward();
  }

  Future<void> _handleLogin() async {
    if (_selectedChildId == null) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.loginChild(_selectedChildId!, _pin);

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pushReplacementNamed('/child-home');
    } else {
      _shakeAnimation();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 8),
              const Text('PIN incorrecto. Intenta de nuevo'),
            ],
          ),
          backgroundColor: AppTheme.dangerColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      setState(() {
        _pin = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final children = authProvider.getChildren();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _selectedChildId == null
                  ? _buildChildSelector(children)
                  : _buildPinInput(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildSelector(List<dynamic> children) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.secondaryColor.withOpacity(0.1),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.waving_hand,
            size: 60,
            color: AppTheme.accentColor,
          ),
          const SizedBox(height: 16),
          Text(
            '¡Hola!',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '¿Quién eres?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: children.length,
              itemBuilder: (context, index) {
                final child = children[index];
                return _buildChildCard(child, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildCard(dynamic child, int index) {
    final colors = [
      AppTheme.primaryColor,
      AppTheme.secondaryColor,
      AppTheme.accentColor,
      Colors.purple,
    ];
    final color = colors[index % colors.length];

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedChildId = child.id;
          });
        },
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.7),
                  color.withOpacity(0.9),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      child.displayName[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 36,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  child.displayName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinInput(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        final offset = Math.sin(_shakeController.value * Math.pi * 2) * 10;
        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor.withOpacity(0.05),
              AppTheme.secondaryColor.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Ingresa tu PIN',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Usa tu código de 4 dígitos',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => _buildPinDot(index),
                ),
              ),
            ),
            const SizedBox(height: 56),
            _buildNumberPad(),
          ],
        ),
      ),
    );
  }

  Widget _buildPinDot(int index) {
    final isFilled = index < _pin.length;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        gradient: isFilled
            ? LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              )
            : null,
        color: isFilled ? null : Colors.grey[200],
        shape: BoxShape.circle,
        boxShadow: isFilled
            ? [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isFilled ? 1 : 0,
          child: const Icon(
            Icons.circle,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildNumberPad() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          _buildNumberRow(['1', '2', '3']),
          const SizedBox(height: 16),
          _buildNumberRow(['4', '5', '6']),
          const SizedBox(height: 16),
          _buildNumberRow(['7', '8', '9']),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 75),
              _buildNumberButton('0'),
              _buildDeleteButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((digit) => _buildNumberButton(digit)).toList(),
    );
  }

  Widget _buildNumberButton(String digit) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 200 + (int.parse(digit) * 30)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handlePinInput(digit),
          customBorder: const CircleBorder(),
          splashColor: AppTheme.primaryColor.withOpacity(0.3),
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey[100]!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                digit,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleDelete,
          customBorder: const CircleBorder(),
          splashColor: AppTheme.dangerColor.withOpacity(0.3),
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.dangerColor.withOpacity(0.1),
              border: Border.all(
                color: AppTheme.dangerColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.backspace_outlined,
              size: 30,
              color: AppTheme.dangerColor,
            ),
          ),
        ),
      ),
    );
  }
}
