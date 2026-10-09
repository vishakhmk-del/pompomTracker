import 'package:flutter/material.dart';
import 'package:pompomtracker/core/routes/approute.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  static const Color primaryTeal = Color(0xFF00A88F);
  static const Color lightTealBg = Color(0xFFE0F7F1);
  static const Color accentTeal = Color(0xFF13BC91);
  static const Color darkTealGradient = Color(0xFF0E9D78);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTealBg,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              Navigator.pushReplacement(context, Approutes().mainScreen),
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: [
              // Top Section (Portfolio Card + Action Buttons)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Portfolio Teal Gradient Card
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            accentTeal,
                            darkTealGradient,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header & Date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Your portfolio',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'May 10, 2026',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Total balance:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // Balance & MTD Pill
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '₹4,003.46',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.end,
                              //   children: [
                              //     const Text(
                              //       'Month-to-date',
                              //       style: TextStyle(
                              //         color: Colors.white70,
                              //         fontSize: 12,
                              //       ),
                              //     ),
                              //     const SizedBox(height: 4),
                              //     Container(
                              //       padding: const EdgeInsets.symmetric(
                              //         horizontal: 10,
                              //         vertical: 4,
                              //       ),
                              //       decoration: BoxDecoration(
                              //         color: Colors.white24,
                              //         borderRadius: BorderRadius.circular(12),
                              //       ),
                              //       child: Row(
                              //         children: const [
                              //           Icon(
                              //             Icons.arrow_drop_up,
                              //             color: Colors.white,
                              //             size: 16,
                              //           ),
                              //           Text(
                              //             '+4.12%',
                              //             style: TextStyle(
                              //               color: Colors.white,
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 12,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _ActionButton(
                          icon: Icons.south_rounded,
                          label: 'Add money',
                        ),
                        // _ActionButton(
                        //   icon: Icons.swap_horiz_rounded,
                        //   label: 'Transfer',
                        // ),
                        _ActionButton(
                          icon: Icons.account_balance_wallet_outlined,
                          label: 'Statements',
                        ),
                        _ActionButton(
                          icon: Icons.keyboard_arrow_down_rounded,
                          label: 'More',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Bottom Section Container (AI Banner + Menu Items)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // AI Assistant Banner
                    // Container(
                    //   padding: const EdgeInsets.all(16),
                    //   decoration: const BoxDecoration(
                    //     borderRadius: BorderRadius.vertical(
                    //       top: Radius.circular(20),
                    //     ),
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         accentTeal,
                    //         darkTealGradient,
                    //       ],
                    //       begin: Alignment.centerLeft,
                    //       end: Alignment.centerRight,
                    //     ),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         padding: const EdgeInsets.all(10),
                    //         decoration: const BoxDecoration(
                    //           color: Colors.white,
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: const Icon(
                    //           Icons.memory,
                    //           color: primaryTeal,
                    //           size: 24,
                    //         ),
                    //       ),
                    //       const SizedBox(width: 12),
                    //       Expanded(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: const [
                    //             Text(
                    //               'AI StockBit Assistant',
                    //               style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 15,
                    //               ),
                    //             ),
                    //             SizedBox(height: 2),
                    //             Text(
                    //               'Get up to 150% profit on your investment portfolio',
                    //               style: TextStyle(
                    //                 color: Colors.white70,
                    //                 fontSize: 11,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       const Icon(
                    //         Icons.chevron_right,
                    //         color: Colors.white,
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // Menu List Options
                    const _MenuItem(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    const _MenuItem(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: 'Contact us',
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    const _MenuItem(
                      icon: Icons.lock_outline_rounded,
                      title: 'Privacy policy',
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Action Button Helper Widget
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 52,
          width: 52,
          decoration: const BoxDecoration(
            color: WalletScreen.lightTealBg,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: WalletScreen.primaryTeal,
            size: 22,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

// Menu Item Helper Widget
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLast;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          Colors.transparent, // Keeps the parent container's white background
      child: ListTile(
        // Wrap with ClipRRect or pass matching borderRadius to InkWell/ListTile if needed
        shape: isLast
            ? const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: WalletScreen.lightTealBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: WalletScreen.primaryTeal,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.black45,
        ),
        onTap: () {},
      ),
    );
  }
}
