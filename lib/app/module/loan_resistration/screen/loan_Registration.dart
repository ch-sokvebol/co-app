import 'package:chokchey_finance/app/module/loan_resistration/custom/custom_registration.dart';
import 'package:chokchey_finance/app/module/config/app_color.dart';
import 'package:flutter/material.dart';

class LoanRegistation extends StatelessWidget {
  const LoanRegistation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        leading: BackButton(),
        title: Text(
          "Loan Registrantion",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        backgroundColor: AppColor.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
            top: 20,
          ),
          child: Column(
            children: [
              CustomLoadRegistration(
                onTap: () {
                  debugPrint("--nat----");
                },
                icon: Icons.person,
                isTextCenter: true,
                title: 'Customer',
                textStyle: TextStyle(fontSize: 14, color: Colors.black),
                subtitle: 'customer(*)',
                subTitleStyle: TextStyle(fontSize: 10, color: Colors.red),
                isTrailingIcon: true,
                isSubtitle: true,
                iconTrainding: Icons.close,
              ),
              CustomLoadRegistration(
                onTap: () {},
                icon: Icons.person_add,
                title: "Customer ID",
              ),
              CustomLoadRegistration(
                onTap: () {},
                icon: Icons.done,
                title: 'Currencise(*)',
                textStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
                isSubtitle: true,
                subtitle: 'Currencies(*)',
                isTrailingIcon: true,
                iconTrainding: Icons.arrow_downward,
                subTitleStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xff505050),
                ),
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'Laon amount(*)',
                icon: Icons.money_off,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'Laon Product(*)',
                textStyle: TextStyle(
                  fontSize: 12,
                  color: Color(0xff505050),
                ),
                isSubtitle: true,
                icon: Icons.money_off,
                isTrailingIcon: true,
                iconTrainding: Icons.arrow_downward,
                subtitle: 'Loan amount(*)',
                subTitleStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xff505050),
                ),
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'Number of team',
                icon: Icons.book,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'Monthly interest rate',
                icon: Icons.numbers,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'Maintenance fee(*)',
                icon: Icons.numbers,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'Admim fee(*)',
                icon: Icons.numbers,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'IRR',
                icon: Icons.numbers,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'Repayment method(*)',
                textStyle: TextStyle(
                  fontSize: 12,
                  color: Color(0xff505050),
                ),
                subtitle: "Repayment method(*)",
                subTitleStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xff505050),
                ),
                icon: Icons.done,
                iconTrainding: Icons.arrow_downward,
                isTrailingIcon: true,
                isSubtitle: true,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'Expected Date(*)',
                icon: Icons.date_range,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'Grace Period(*)',
                icon: Icons.logo_dev,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'Loan Purpose(*)',
                icon: Icons.money,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: 'LTV(*)',
                icon: Icons.label,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: "Dscr(*)",
                icon: Icons.dark_mode,
              ),
              CustomLoadRegistration(
                onTap: () {},
                title: "Refer by who",
                icon: Icons.person_add,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: AppColor.primaryColor,
                ),
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
