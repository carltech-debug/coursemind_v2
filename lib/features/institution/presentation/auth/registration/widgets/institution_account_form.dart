import 'package:flutter/material.dart';

import '../../../../../../../app/theme/app_spacing.dart';
import 'institution_dropdown_field.dart';
import 'institution_input_field.dart';

class InstitutionAccountForm extends StatelessWidget {
  const InstitutionAccountForm({
    required this.selectedInstitutionType, required this.selectedCountry, required this.onInstitutionTypeChanged, required this.onCountryChanged, super.key,
  });

  final String? selectedInstitutionType;
  final String selectedCountry;
  final ValueChanged<String?>
  onInstitutionTypeChanged;
  final ValueChanged<String?>
  onCountryChanged;

  @override
  Widget build(BuildContext context) {
    final isDesktop =
        MediaQuery.sizeOf(context).width >= 600;

    return Column(
      children: [
        _ResponsiveRow(
          isDesktop: isDesktop,
          first: const InstitutionInputField(
            label: 'Institution name',
            placeholder:
                "Enter your institution's full name",
            prefixIcon:
                Icons.account_balance_outlined,
          ),
          second:
              InstitutionDropdownField<String>(
            label: 'Institution type',
            value: selectedInstitutionType,
            hint: 'Select institution type',
            prefixIcon:
                Icons.account_balance_outlined,
            items: const [
              DropdownMenuItem(
                value: 'university',
                child: Text('University'),
              ),
              DropdownMenuItem(
                value: 'college',
                child: Text('College'),
              ),
              DropdownMenuItem(
                value: 'highschool',
                child: Text('High School'),
              ),
              DropdownMenuItem(
                value: 'other',
                child: Text('Other'),
              ),
            ],
            onChanged:
                onInstitutionTypeChanged,
          ),
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        _ResponsiveRow(
          isDesktop: isDesktop,
          first:
              InstitutionDropdownField<String>(
            label: 'Country',
            value: selectedCountry,
            hint: 'Select country',
            prefixIcon: Icons.language,
            items: const [
              DropdownMenuItem(
                value: 'Ghana',
                child: Text('Ghana'),
              ),
              DropdownMenuItem(
                value: 'Nigeria',
                child: Text('Nigeria'),
              ),
              DropdownMenuItem(
                value: 'Kenya',
                child: Text('Kenya'),
              ),
              DropdownMenuItem(
                value: 'South Africa',
                child: Text('South Africa'),
              ),
            ],
            onChanged: onCountryChanged,
          ),
          second:
              const InstitutionInputField(
            label: 'Institution website',
            placeholder:
                'https://www.institution.edu',
            prefixIcon: Icons.link,
            keyboardType: TextInputType.url,
          ),
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        const InstitutionInputField(
          label: 'Official institution email',
          placeholder:
              'admin@institution.edu',
          prefixIcon: Icons.mail_outline,
          keyboardType:
              TextInputType.emailAddress,
          helperText:
              'Use an official institution email where available.',
        ),
      ],
    );
  }
}

class _ResponsiveRow extends StatelessWidget {
  const _ResponsiveRow({
    required this.isDesktop,
    required this.first,
    required this.second,
  });

  final bool isDesktop;
  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) {
    if (!isDesktop) {
      return Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          first,
          const SizedBox(
            height: AppSpacing.md,
          ),
          second,
        ],
      );
    }

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Expanded(child: first),
        const SizedBox(
          width: AppSpacing.md,
        ),
        Expanded(child: second),
      ],
    );
  }
}