import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Text('Tu Clima', ),
              const Spacer(),
              IconButton(
                onPressed: () {
                 
                },
                icon: const Icon(Icons.search),
              ),
              
          
            
              
            ],
          ),
        ),
      ),
    );
  }
}
