import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({Key? key, this.size = 40}) : super(key: key); // even smaller default size

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          tag: 'app_logo',
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green.shade400,
                      Colors.green.shade600,
                    ],
                    stops: const [0.2, 0.8],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.how_to_vote_rounded,
                size: size * 0.4,  // slightly smaller icon
                color: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),  // reduced spacing
        Text(
          'AI Vote',
          style: TextStyle(
            fontSize: 20,  // smaller font
            fontWeight: FontWeight.w700,
            color: Colors.green.shade700,
            height: 1,
          ),
        ),
        const SizedBox(height: 2),  // minimal spacing
        Text(
          'Secure • Smart • Simple',
          style: TextStyle(
            fontSize: 11,  // smaller font
            color: Colors.grey.shade600,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
