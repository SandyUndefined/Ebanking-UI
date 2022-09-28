class BankType {
  final String name;
  final int code;

  const BankType(this.name, this.code);
}

const List<BankType> getBankType = <BankType>[
  BankType('Balance Enquiry', 1),
  BankType('Mini Statement', 2),
  BankType('Cash Withdrawl', 3),
  BankType('Aadhar Pay', 4),
];
