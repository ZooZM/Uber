import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/signupcubit/signup_cubit.dart';
import 'custom_button.dart';
import 'custom_footer.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedGender;
  String? _selectedType;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _ageController.dispose();
    _phoneController.dispose(); // Dispose phone controller
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignupCubit>().signUp(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        region: 'Cairo',
        gender: _selectedGender?.toLowerCase() ?? 'male',
        age:
            (_selectedType != null &&
                !(_selectedType!.split('-')[0] == 'F' ||
                    _selectedType!.split('-')[0] == 'M' ||
                    _selectedType!.split('-')[0] == 'HC'))
            ? _ageController.text
            : '0',
        role: 'provider',
        phoneNumber: _phoneController.text,
        type: _selectedType!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
        } else if (state is SignupFailure) {
          if (state.errorMessage.toLowerCase().contains('already exists')) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        final isLoading = state is SignupLoading;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // DropdownButtonFormField<String>(
              //   decoration: InputDecoration(
              //     labelText: 'Type',
              //     prefixIcon: const Icon(Icons.category),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(24),
              //     ),
              //     isDense: true,
              //     contentPadding: const EdgeInsets.symmetric(
              //       vertical: 12,
              //       horizontal: 16,
              //     ),
              //   ),
              //   value: _selectedType,
              //   selectedItemBuilder: (BuildContext context) {
              //     return Data.categoresNames.map<Widget>((String category) {
              //       return Text(
              //         category.split('-')[1],
              //         style: Styles.text14Light.copyWith(color: kPrimaryColor),
              //         overflow: TextOverflow.ellipsis,
              //       );
              //     }).toList();
              //   },
              //   items: Data.categoresNames.map((String category) {
              //     return DropdownMenuItem<String>(
              //       value: category,
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 4),
              //         child: CategoriesCard(
              //           title: category,
              //           icon: Data.categores
              //               .firstWhere((c) => c.name == category)
              //               .icon,
              //           isCheck: false,
              //         ),
              //       ),
              //     );
              //   }).toList(),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       _selectedType = newValue;
              //     });
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select your Type';
              //     }
              //     return null;
              //   },
              //   icon: const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
              // ),
              const SizedBox(height: 20),
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Phone Number Field
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                    return 'Phone number must be exactly 11 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Age Field
              if (_selectedType != null &&
                  !(_selectedType!.split('-')[0] == 'F' ||
                      _selectedType!.split('-')[0] == 'M' ||
                      _selectedType!.split('-')[0] == 'HC'))
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: 'Enter your age',
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    controller: _ageController,
                    validator: (value) {
                      if (_selectedType != null &&
                          ['F', 'M', 'HC'].contains(_selectedType)) {
                        return null; // لا يوجد تحقق إذا كان النوع F/M/HC
                      }
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      final age = int.tryParse(value);
                      if (age == null) {
                        return 'Please enter a valid number';
                      }
                      if (age < 18 || age > 100) {
                        return 'Age must be between 18 and 100';
                      }
                      return null;
                    },
                  ),
                ),
              // Gender Field
              if (_selectedType != null &&
                  !(_selectedType!.split('-')[0] == 'F' ||
                      _selectedType!.split('-')[0] == 'M' ||
                      _selectedType!.split('-')[0] == 'HC'))
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    value: _selectedGender,
                    items: ['Male', 'Female'].map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                    validator: (value) {
                      if (_selectedType != null &&
                          ['F', 'M', 'HC'].contains(_selectedType)) {
                        return null; // لا يوجد تحقق إذا كان النوع F/M/HC
                      }
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                  ),
                ),
              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Confirm Password Field
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              // Sign Up Button
              CustomButton(
                text: 'Sign Up',
                onPressed: isLoading ? null : () => _submitForm(context),
                isLoading: isLoading,
              ),
              const SizedBox(height: 32),
              // Footer
              CustomFooter(
                text: "Already have an account?",
                buttonText: "Sign In",
                onPressed: () {
                  context.go('/');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
