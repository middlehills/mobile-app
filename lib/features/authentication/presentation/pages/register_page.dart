import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return midhillAnnotatedRegion(
      child: const Scaffold(),
    );
  }
}
