class SlipGaji {
  static String htmlSlipGaji(data, nameMonth, year, img, imglogo) {
    // final pendapatanList = data.pendapatan!
    //     .map((e) => '<li class="d-flex justify-content-between"><span>${e.komponenGaji!.namaKomponen!}</span><span>Rp ${formatRupiah(e.nilai!)}</span></li>')
    //     .join();
    final pendapatanList =
        data.pendapatan!.map((e) => '<tr> <td style="width: 250px;">${e.komponenGaji!.namaKomponen!}</td> <td>Rp ${formatRupiah(e.nilai!)}</td></tr>').join();

    // final potonganList = data.potongan!
    //     .map((e) => '<li class="d-flex justify-content-between"><span>${e.komponenGaji!.namaKomponen!}</span><span>Rp ${formatRupiah(e.nilai!)}</span></li>')
    //     .join();
    final potonganList =
        data.potongan!.map((e) => '<tr> <td style="width: 250px;">${e.komponenGaji!.namaKomponen!}</td> <td>Rp ${formatRupiah(e.nilai!)}</td></tr>').join();
    return """
<!DOCTYPE html>
<html lang="id">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Slip Gaji</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .slip-container {
      max-width: 800px;
      margin: auto;
      /* border: 1px solid #383838; */
      border-radius: 12px;
      padding: 20px;
      background: white;
    }

    .header-logo {
      width: 80px;
    }

    .table-bordered th,
    .table-bordered td {
      vertical-align: middle;
      text-align: left;
    }
th {
  font-size: 11px;
}
td {
  font-size: 11px;
}
    .section-title {
      font-weight: bold;
      margin-top: 20px;
    }
  </style>
</head>

<body class="bg-light">

  <div class="slip-container shadow mt-5 position-relative">
    <img src="data:image/png;base64,$img" alt="Logo" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); height: 300px; opacity: 0.1; z-index: 0;">
    <div class="text-center mb-4 border-bottom">

      <img src="data:image/png;base64,$imglogo" alt="Logo" class="header-logo mb-2">
      <h5>RUMAH SAKIT UMUM UNIVERSITAS MUHAMMADIYAH CIREBON</h5>
      <p class="mb-0">Jl. KH. Wahid Hasyim No.8, Mertapada Wetan, Kec. Astanajapura, Kabupaten Cirebon, Jawa Barat 45181
      </p>
      <p>Email: rsuumc@rsuumc.com | Telp: (0231) 638000</p>
    </div>

    <h4 class="text-center mb-4">SLIP GAJI</h4>

    <div class="row mb-3">
      <div class="col-md-6">
        <table>
          <tr>
            <th style="width: 100px;">NIK</th>
            <th style="width: 10px;">:</th>
            <td>${data.pegawai.nik}</td>
          </tr>
          <tr>
            <th style="width: 100px;">Nama</th>
            <th style="width: 10px;">:</th>
            <td>${data.pegawai.nama}</td>
          </tr>
          <tr>
            <th style="width: 100px;">Pendidikan</th>
            <th style="width: 10px;">:</th>
            <td>${data.pegawai.pendidikan}</td>
          </tr>
          <tr>
            <th style="width: 100px;">Jabatan</th>
            <th style="width: 10px;">:</th>
            <td>${data.pegawai.jabatan}</td>
          </tr>
        </table>
      </div>
      <div class="col-md-6">
        <table>
          <tr>
            <th style="width: 100px;">Gol</th>
            <th style="width: 10px;">:</th>
            <td>${data.pegawai.golongan}</td>
          </tr>
          <tr>
            <th style="width: 100px;">Masa Jabatan</th>
            <th style="width: 10px;">:</th>
            <td>${data.pegawai.masaJabatan}</td>
          </tr>
          <tr>
            <th style="width: 100px;">NPWP</th>
            <th style="width: 10px;">:</th>
            <td>${data.pegawai.npwp}</td>
          </tr>
          <tr>
            <th style="width: 100px;">Periode</th>
            <th style="width: 10px;">:</th>
            <td>$nameMonth $year</td>
          </tr>
        </table>
      </div>
    </div>

    <div class="row">
      <div class="col-md-6">
        <h6 class="section-title">Pendapatan</h6>
        <table class="table table-bordered">
          <tbody>
          $pendapatanList
           <tr style="width: 250px;">
            <th >Total</th>
            <td>RP ${formatRupiah(data.payroll![0].pendapatan!)}</td>
          </tr>
          </tbody>
        </table>
      </div>

      <div class="col-md-6">
        <h6 class="section-title">Potongan</h6>
        <table class="table table-bordered">
          <tbody>
           $potonganList
            <tr style="width: 250px;">
            <th >Total</th>
            <td>RP ${formatRupiah(data.payroll![0].potongan!)}</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
         <div class="mb-4">
           <div class="d-flex justify-content-between border-top pt-2 fw-bold">
             <span style="font-size: 12px;">Total Gaji</span>
             <span style="font-size: 12px;">Rp ${formatRupiah(data.payroll![0].pendapatan! - data.payroll![0].potongan!)}</span>
           </div>
        </div>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
""";
//     return """
// <!DOCTYPE html>
// <html lang="id">
// <head>
//   <meta charset="UTF-8">
//   <meta name="viewport" content="width=device-width, initial-scale=1">
//   <title>Slip Gaji $nameMonth $year</title>
//   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
// </head>
// <body class="bg-light py-4">
//   <div class="container">
//     <div class="card shadow-sm">
//       <div class="card-body position-relative">
//       <img src="data:image/png;base64,$img" alt="Logo" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); height: 300px; opacity: 0.1; z-index: 0;">

//         <div class="d-flex justify-content-between align-items-center mb-3 border-bottom">
//           <div>
//             <h5 class="mb-0">${data.payroll[0].pegawai.nama}</h5>
//             <small class="text-muted">${data.payroll[0].pegawai.jabatan.namaJabatan}</small>
//           </div>

//           <div><strong>$nameMonth $year</strong></div>
//         </div>

//         <div class="mb-4">
//           <h6 class="text-secondary border-bottom pb-1">Pendapatan Gaji</h6>
//           <ul class="list-unstyled">
//             $pendapatanList
//           </ul>
//           <div class="d-flex justify-content-between border-top pt-2 fw-bold">
//             <span>Total</span>
//             <span>Rp ${formatRupiah(data.payroll![0].pendapatan!)}</span>
//           </div>
//         </div>

//         <div class="mb-4">
//           <h6 class="text-secondary border-bottom pb-1">Potongan Gaji</h6>
//           <ul class="list-unstyled">
//             $potonganList
//           </ul>
//           <div class="d-flex justify-content-between border-top pt-2 fw-bold">
//             <span>Total</span>
//             <span>Rp ${formatRupiah(data.payroll![0].potongan!)}</span>
//           </div>
//         </div>
//         <div class="mb-4">
//           <div class="d-flex justify-content-between border-top pt-2 fw-bold">
//             <span>Total Gaji</span>
//             <span>Rp ${formatRupiah(data.payroll![0].pendapatan! - data.payroll![0].potongan!)}</span>
//           </div>
//         </div>

//       </div>
//     </div>
//   </div>
// </body>
// </html>
// """;
  }

  static String formatRupiah(num value) {
    return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}
