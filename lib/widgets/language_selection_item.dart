import 'package:flutter/material.dart';

class LanguageSelectionItem extends StatelessWidget {
  final String languageName;
  final String flagPath;
  final bool isSelected;
  final VoidCallback onSelect;

  const LanguageSelectionItem({
    super.key,
    required this.languageName,
    required this.flagPath,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.grey.shade100, offset: Offset(4,4),blurRadius: 4,spreadRadius: 1)]
            : null,
      ),
      child: Row(
        children: [
          // Flag icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(flagPath),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Language name
          Expanded(
            child: Text(
              languageName,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),

          // Selection button
          if (isSelected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Selected',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          else
            InkWell(
              onTap: onSelect,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
