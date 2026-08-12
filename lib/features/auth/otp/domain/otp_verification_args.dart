enum OtpFlow { register, resetPassword }

class OtpVerificationArgs {
  final String contact;
  final OtpFlow flow;
  final String? userId;

  const OtpVerificationArgs({
    required this.contact,
    required this.flow,
    this.userId,
  });
}
