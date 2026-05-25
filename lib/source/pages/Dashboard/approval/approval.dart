part of '../../index.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetCutiCubit>(context).getCutiKepalaBagian(context);
    BlocProvider.of<GetIzinCubit>(context).getizinKepalaBagian(context);
    BlocProvider.of<GetLemburCubit>(context).getLemburKepalaBagian(context);
  }

  Widget cutiView(BuildContext context) {
    return BlocBuilder<GetCutiCubit, GetCutiState>(
      builder: (context, state) {
        if (state is GetCutiLoading) {
          return Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
            child: Column(
              children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
            ),
          );
        }
        if (state is GetCutiFailed) {
          var data = state.json;
          var statusCode = state.statusCode;
          if (statusCode == 403) {
            return const Center(child: Text("This user does not have access."));
          } else if (statusCode == 404) {
            return const Center(child: Text("Not Found"));
          } else {
            return Center(child: Text(data['message'].toString()));
          }
        }
        if (state is GetCutiLoaded == false) {
          return Container();
        }
        var data = (state as GetCutiLoaded).model;
        if (data!.data!.isEmpty) {
          return const Center(child: Text("Data Kosong"));
        }
        return Container(
          padding: const EdgeInsets.all(12),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              BlocProvider.of<GetCutiCubit>(context).getCutiKepalaBagian(context);
            },
            child: ListView.builder(
              itemCount: data.data!.length,
              itemBuilder: (context, index) {
                var a = data.data![index];
                if (a.status == 0 || a.status == 1 || a.status == 2 || a.status == 3) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(color: hijauDark, borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      margin: const EdgeInsets.only(left: 12),
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                      decoration: const BoxDecoration(
                        color: whiteCustom2,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 3, child: AutoSizeText(a.pegawai!.nama!, style: const TextStyle(fontFamily: 'MontserratSemiBold'))),
                              if (a.status == 0)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      width: 120,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: amber, borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("Pending",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                              if (a.status == 1)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: Colors.green[600], borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("ACC KEPALA",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                              if (a.status == 2)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: merah, borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("Rejected",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                              if (a.status == 3)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("ACC HRD",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Table(
                            border: TableBorder.all(style: BorderStyle.none),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(100),
                              1: FixedColumnWidth(15),
                            },
                            children: [
                              TableRow(
                                children: [
                                  const Text('Tgl Mulai Cuti', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(formatDate(a.tglMulai!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Tgl Selesai Cuti', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(formatDate(a.tglSelesai!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Tgl Acc', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  if (a.tglAcc != null) Text(formatDate(a.tglAcc!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  if (a.tglAcc == null) const Text("", style: TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Jenis Cuti', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(a.jenisCuti!.namaCuti!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Keterangan', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(a.keterangan!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Feedback', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(a.feedback!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (a.status == 0)
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: CustomButton2(
                                onTap: () {
                                  Navigator.pushNamed(context, approvalDetailScreen);
                                  setState(() {
                                    idApproval = a.id;
                                    namaApproval = a.pegawai!.nama!;
                                    tanggalApproval = "${formatDate(a.tglMulai!)} - ${formatDate(a.tglSelesai!)}";
                                    keteranganApproval = a.keterangan!;
                                    menuApproval = "cuti";
                                  });
                                },
                                backgroundColor: biru,
                                text: "DETAIL",
                                roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                textStyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', color: Colors.white),
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget lemburView(BuildContext context) {
    return BlocBuilder<GetLemburCubit, GetLemburState>(
      builder: (context, state) {
        if (state is GetLemburLoading) {
          return Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
            child: Column(
              children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
            ),
          );
        }
        if (state is GetLemburFailed) {
          var data = state.json;
          var statusCode  = state.statusCode;
          if (statusCode == 403) {
            return const Center(child: Text("This user does not have access."));
          } else if (statusCode == 404) {
            return const Center(child: Text("Not Found"));
          } else {
            return Center(child: Text(data['message'].toString()));
          }
        }
        if (state is GetLemburLoaded == false) {
          return Container();
        }
        var data = (state as GetLemburLoaded).model;
        var idPegawai = (state).idPegawai;
        if (data!.data!.isEmpty) {
          return const Center(child: Text("Data Kosong"));
        }
        return Container(
          padding: const EdgeInsets.all(12),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              BlocProvider.of<GetLemburCubit>(context).getLemburKepalaBagian(context);
            },
            child: ListView.builder(
              itemCount: data.data!.length,
              itemBuilder: (context, index) {
                var a = data.data![index];
                if (a.status == 0 || a.status == 1 || a.status == 2 || a.status == 3) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(color: hijauDark, borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      margin: const EdgeInsets.only(left: 12),
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                      decoration: const BoxDecoration(
                        color: whiteCustom2,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 3, child: AutoSizeText(a.pegawai!.nama!, style: const TextStyle(fontFamily: 'MontserratSemiBold'))),
                              if (a.status == 0)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      width: 120,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: amber, borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("Pending",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                              if (a.status == 1)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: Colors.green[600], borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("ACC KEPALA",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                              if (a.status == 2)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: merah, borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("Rejected",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                              if (a.status == 3)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("ACC HRD",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Table(
                            border: TableBorder.all(style: BorderStyle.none),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(100),
                              1: FixedColumnWidth(15),
                            },
                            children: [
                              TableRow(
                                children: [
                                  const Text('Tgl Pengajuan', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(formatDate(a.tanggal!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Tgl Acc', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  if (a.tglAcc != null) Text(formatDate(a.tglAcc!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  if (a.tglAcc == null) const Text("", style: TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Jam Mulai', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(a.jamMulai!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Jam Selesai', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(a.jamSelesai!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Total Jam', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text("${a.jumlahJam!} jam", style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Keterangan', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(a.keterangan!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Feedback', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(a.feedback!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (a.status == 0)
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: CustomButton2(
                                onTap: () {
                                  Navigator.pushNamed(context, approvalDetailScreen);
                                  setState(() {
                                    idApproval = a.id;
                                    namaApproval = a.pegawai!.nama!;
                                    tanggalApproval = formatDate(a.tanggal!);
                                    keteranganApproval = a.keterangan!;
                                    menuApproval = "lembur";
                                  });
                                },
                                backgroundColor: biru,
                                text: "DETAIL",
                                roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                textStyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', color: Colors.white),
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget izinView(BuildContext context) {
    return BlocBuilder<GetIzinCubit, GetIzinState>(
      builder: (context, state) {
        if (state is GetIzinLoading) {
          return Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
            child: Column(
              children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
            ),
          );
        }
        if (state is GetIzinFailed) {
          var data = state.json;
          var statusCode = state.statusCode;
             if (statusCode == 403) {
            return const Center(child: Text("This user does not have access."));
          } else if (statusCode == 404) {
            return const Center(child: Text("Not Found"));
          } else {
            return Center(child: Text(data['message'].toString()));
          }
        }
        if (state is GetIzinLoaded == false) {
          return Container();
        }
        var data = (state as GetIzinLoaded).model!;
        var idPegawai = (state).idPegawai;
        if (data.data!.isEmpty) {
          return const Center(child: Text("Data Kosong"));
        }
        return Container(
          padding: const EdgeInsets.all(12),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              BlocProvider.of<GetIzinCubit>(context).getizinKepalaBagian(context);
            },
            child: ListView.builder(
              itemCount: data.data!.length,
              itemBuilder: (context, index) {
                var a = data.data![index];
                if (a.status == 0 || a.status == 1 || a.status == 2 || a.status == 3) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(color: hijauDark, borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      margin: const EdgeInsets.only(left: 12),
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                      decoration: const BoxDecoration(
                        color: whiteCustom2,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 3, child: AutoSizeText(a.pegawai!.nama!, style: const TextStyle(fontFamily: 'MontserratSemiBold'))),
                              if (a.status == 0)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      width: 120,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: amber, borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("Pending",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                              if (a.status == 1)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: Colors.green[600], borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("ACC KEPALA",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                              if (a.status == 2)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: merah, borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("Rejected",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                              if (a.status == 3)
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(1, 2),
                                        ),
                                      ]),
                                      child: const Text("ACC HRD",
                                          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Table(
                            border: TableBorder.all(style: BorderStyle.none),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(100),
                              1: FixedColumnWidth(15),
                            },
                            children: [
                              TableRow(
                                children: [
                                  const Text('Tgl Pengajuan', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(formatDate(a.tanggal!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Tgl Acc', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  if (a.tglAcc != null) Text(formatDate(a.tglAcc!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  if (a.tglAcc == null) const Text("", style: TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Alasan', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text("${a.alasan}", style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Keterangan', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text("${a.keterangan}", style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Feedback', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text("${a.feedback}", style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (a.status == 0)
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: CustomButton2(
                                onTap: () {
                                  Navigator.pushNamed(context, approvalDetailScreen);
                                  setState(() {
                                    idApproval = a.id;
                                    namaApproval = a.pegawai!.nama!;
                                    tanggalApproval = formatDate(a.tanggal!);
                                    keteranganApproval = a.keterangan!;
                                    menuApproval = "izin";
                                  });
                                },
                                backgroundColor: biru,
                                text: "DETAIL",
                                roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                textStyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', color: Colors.white),
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: hijauLight,
          bottom: const TabBar(
            indicatorColor: whiteCustom2,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(child: Text("CUTI", style: TextStyle(fontFamily: 'JakartaSansBold', color: whiteCustom2))),
              Tab(child: Text("LEMBUR", style: TextStyle(fontFamily: 'JakartaSansBold', color: whiteCustom2))),
              Tab(child: Text("IZIN", style: TextStyle(fontFamily: 'JakartaSansBold', color: whiteCustom2))),
            ],
          ),
          title: const Text('Approval', style: TextStyle(fontFamily: 'JakartaSansMedium', color: whiteCustom2)),
          iconTheme: const IconThemeData(color: whiteCustom2),
        ),
        body: TabBarView(children: [
          cutiView(context),
          lemburView(context),
          izinView(context),
        ]),
      ),
    );
  }
}
