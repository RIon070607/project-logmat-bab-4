Program berikut menguji seluruh hukum pada bagian ini dengan mencoba semua kombinasi nilai p, q, dan r.
program HukumLogika;
{ ============================================================
  BAB IV : HUKUM LOGIKA  (bagian 5.11 Program Pascal)
  Program ini membuktikan hukum-hukum logika dengan cara
  menguji SEMUA kombinasi nilai p, q, r (True / False).
  Dua ekspresi ekuivalen jika hasilnya sama di semua kombinasi.
  Konstanta B (benar) = True, S (salah) = False.
  Compiler: Free Pascal (FPC)
  ============================================================ }

const
  KB = True;      { konstanta B (benar) }
  KS = False;     { konstanta S (salah) }
  JUMLAH_UJI = 14;

  NamaUji : array[1..JUMLAH_UJI] of string = (
    'Tabel IV.1 : p v (~p ^ q)  =  p v q',
    'Contoh 4.1 : (p v q) ^ (p v ~q)  =  p',
    'Contoh 4.2 : p ^ ~(p ^ q)  =  p ^ ~q',
    'Contoh 6.1 : (p^B) v (q^S) v (p^~p)  =  p',
    'Contoh 6.2 : ~(p v q) v (~p ^ q)  =  ~p',
    'Contoh 6.3 : (p v q) ^ ~p  =  ~p ^ q',
    'Latihan 2  : (p v S) ^ (q v B)  =  p',
    'Latihan 3  : (p ^ q) v (p ^ ~q)  =  p',
    'Latihan 4  : ~(~p ^ q) ^ p  =  p',
    'Latihan 6  : (p v q) ^ ~(p v q)  =  S',
    'Latihan 7  : (p^q) v (q^p) v (p^p)  =  p',
    'Latihan 8  : ~(p ^ ~q) v (p ^ q)  =  ~p v q',
    'Evaluasi IV.4 : p v (p ^ q)  =  p',
    'Evaluasi IV.3 : (p^q) v (p^~q) v ~p  =  B'
  );

{ ---------- fungsi dan prosedur bantu ---------- }

function BoolKeStr(x: boolean): string;
begin
  if x then
    BoolKeStr := 'B'
  else
    BoolKeStr := 'S';
end;

function Ekuivalen(a, c: boolean): boolean;
begin
  Ekuivalen := (a = c);
end;

procedure Lapor(no: integer; nama: string; ok: boolean);
begin
  write(no:3, '. ', nama, ' : ');
  if ok then
    writeln('TERBUKTI (ekuivalen di semua kombinasi)')
  else
    writeln('GAGAL');
end;

procedure Tunggu;
begin
  writeln;
  write('Tekan Enter untuk kembali ke menu...');
  readln;
end;

{ ---------- 10 hukum logika (Tabel IV.12) ---------- }

function HukumIdentitas: boolean;
var
  p, ok: boolean;
begin
  ok := True;
  for p := False to True do
  begin
    if not Ekuivalen((p or KS), p) then ok := False;
    if not Ekuivalen((p and KB), p) then ok := False;
  end;
  HukumIdentitas := ok;
end;

function HukumDominasi: boolean;
var
  p, ok: boolean;
begin
  ok := True;
  for p := False to True do
  begin
    if not Ekuivalen((p and KS), KS) then ok := False;
    if not Ekuivalen((p or KB), KB) then ok := False;
  end;
  HukumDominasi := ok;
end;

function HukumIdempoten: boolean;
var
  p, ok: boolean;
begin
  ok := True;
  for p := False to True do
  begin
    if not Ekuivalen((p or p), p) then ok := False;
    if not Ekuivalen((p and p), p) then ok := False;
  end;
  HukumIdempoten := ok;
end;

function HukumKomplemen: boolean;
var
  p, ok: boolean;
begin
  ok := True;
  for p := False to True do
  begin
    if not Ekuivalen((p or (not p)), KB) then ok := False;
    if not Ekuivalen((p and (not p)), KS) then ok := False;
  end;
  HukumKomplemen := ok;
end;

function HukumInvolusi: boolean;
var
  p, ok: boolean;
begin
  ok := True;
  for p := False to True do
    if not Ekuivalen(not (not p), p) then ok := False;
  HukumInvolusi := ok;
end;

function HukumKomutatif: boolean;
var
  p, q, ok: boolean;
begin
  ok := True;
  for p := False to True do
    for q := False to True do
    begin
      if not Ekuivalen((p or q), (q or p)) then ok := False;
      if not Ekuivalen((p and q), (q and p)) then ok := False;
    end;
  HukumKomutatif := ok;
end;

function HukumAsosiatif: boolean;
var
  p, q, r, ok: boolean;
begin
  ok := True;
  for p := False to True do
    for q := False to True do
      for r := False to True do
      begin
        if not Ekuivalen((p or (q or r)), ((p or q) or r)) then ok := False;
        if not Ekuivalen((p and (q and r)), ((p and q) and r)) then ok := False;
      end;
  HukumAsosiatif := ok;
end;

function HukumDistributif: boolean;
var
  p, q, r, ok: boolean;
begin
  ok := True;
  for p := False to True do
    for q := False to True do
      for r := False to True do
      begin
        if not Ekuivalen((p and (q or r)), ((p and q) or (p and r))) then ok := False;
        if not Ekuivalen((p or (q and r)), ((p or q) and (p or r))) then ok := False;
      end;
  HukumDistributif := ok;
end;

function HukumDeMorgan: boolean;
var
  p, q, ok: boolean;
begin
  ok := True;
  for p := False to True do
    for q := False to True do
    begin
      if not Ekuivalen(not (p and q), ((not p) or (not q))) then ok := False;
      if not Ekuivalen(not (p or q), ((not p) and (not q))) then ok := False;
    end;
  HukumDeMorgan := ok;
end;

function HukumAbsorpsi: boolean;
var
  p, q, ok: boolean;
begin
  ok := True;
  for p := False to True do
    for q := False to True do
    begin
      if not Ekuivalen((p or (p and q)), p) then ok := False;
      if not Ekuivalen((p and (p or q)), p) then ok := False;
    end;
  HukumAbsorpsi := ok;
end;

procedure VerifikasiSemuaHukum;
begin
  writeln('=== VERIFIKASI 10 HUKUM LOGIKA (Tabel IV.12) ===');
  writeln('Setiap hukum diuji pada semua kombinasi nilai p, q, r.');
  writeln;
  Lapor(1,  'Identitas',  HukumIdentitas);
  Lapor(2,  'Dominasi',   HukumDominasi);
  Lapor(3,  'Idempoten',  HukumIdempoten);
  Lapor(4,  'Komplemen',  HukumKomplemen);
  Lapor(5,  'Involusi',   HukumInvolusi);
  Lapor(6,  'Komutatif',  HukumKomutatif);
  Lapor(7,  'Asosiatif',  HukumAsosiatif);
  Lapor(8,  'Distributif', HukumDistributif);
  Lapor(9,  'De Morgan',  HukumDeMorgan);
  Lapor(10, 'Absorpsi',   HukumAbsorpsi);
end;

{ ---------- Tabel IV.9 : verifikasi De Morgan ---------- }

procedure TabelDeMorgan;
var
  p, q: boolean;
  ruasKiri, ruasKanan: boolean;
  sama: boolean;
begin
  writeln('=== TABEL IV.9 : ~(p ^ q)  =  ~p v ~q ===');
  writeln;
  writeln('  p   q  | p^q | ~(p^q) |  ~p  ~q | ~pv~q | sama?');
  writeln('---------+-----+--------+---------+-------+------');
  sama := True;
  for p := True downto False do
    for q := True downto False do
    begin
      ruasKiri  := not (p and q);
      ruasKanan := (not p) or (not q);
      if ruasKiri <> ruasKanan then sama := False;
      writeln('  ', BoolKeStr(p), '   ', BoolKeStr(q), '  |  ',
              BoolKeStr(p and q), '  |   ', BoolKeStr(ruasKiri), '    |  ',
              BoolKeStr(not p), '   ', BoolKeStr(not q), '  |   ',
              BoolKeStr(ruasKanan), '   |  ',
              BoolKeStr(ruasKiri = ruasKanan));
    end;
  writeln;
  if sama then
    writeln('Kolom ~(p^q) dan ~p v ~q sama di setiap baris -> terbukti.')
  else
    writeln('Ada baris yang berbeda -> tidak ekuivalen.');
end;

{ ---------- pengujian penyederhanaan ekspresi ---------- }

{ ruas kiri (bentuk awal) dari uji nomor 'no' }
function Kiri(no: integer; p, q: boolean): boolean;
begin
  case no of
    1  : Kiri := p or ((not p) and q);
    2  : Kiri := (p or q) and (p or (not q));
    3  : Kiri := p and (not (p and q));
    4  : Kiri := (p and KB) or (q and KS) or (p and (not p));
    5  : Kiri := (not (p or q)) or ((not p) and q);
    6  : Kiri := (p or q) and (not p);
    7  : Kiri := (p or KS) and (q or KB);
    8  : Kiri := (p and q) or (p and (not q));
    9  : Kiri := (not ((not p) and q)) and p;
    10 : Kiri := (p or q) and (not (p or q));
    11 : Kiri := (p and q) or (q and p) or (p and p);
    12 : Kiri := (not (p and (not q))) or (p and q);
    13 : Kiri := p or (p and q);
    14 : Kiri := (p and q) or (p and (not q)) or (not p);
  else
    Kiri := False;
  end;
end;

{ ruas kanan (bentuk sederhana) dari uji nomor 'no' }
function Kanan(no: integer; p, q: boolean): boolean;
begin
  case no of
    1  : Kanan := p or q;
    2  : Kanan := p;
    3  : Kanan := p and (not q);
    4  : Kanan := p;
    5  : Kanan := not p;
    6  : Kanan := (not p) and q;
    7  : Kanan := p;
    8  : Kanan := p;
    9  : Kanan := p;
    10 : Kanan := KS;
    11 : Kanan := p;
    12 : Kanan := (not p) or q;
    13 : Kanan := p;
    14 : Kanan := KB;
  else
    Kanan := False;
  end;
end;

{ true bila ruas kiri = ruas kanan pada semua kombinasi p, q }
function UjiSederhana(no: integer): boolean;
var
  p, q, ok: boolean;
begin
  ok := True;
  for p := False to True do
    for q := False to True do
      if Kiri(no, p, q) <> Kanan(no, p, q) then
        ok := False;
  UjiSederhana := ok;
end;

{ menghitung berapa baris yang bernilai B pada ruas kiri }
function JenisEkspresi(no: integer): string;
var
  p, q: boolean;
  jumlahB: integer;
begin
  jumlahB := 0;
  for p := False to True do
    for q := False to True do
      if Kiri(no, p, q) then
        jumlahB := jumlahB + 1;
  if jumlahB = 4 then
    JenisEkspresi := 'tautologi'
  else if jumlahB = 0 then
    JenisEkspresi := 'kontradiksi'
  else
    JenisEkspresi := 'kontingensi';
end;

procedure UjiSemuaPenyederhanaan;
var
  i: integer;
begin
  writeln('=== UJI PENYEDERHANAAN EKSPRESI (Contoh & Latihan) ===');
  writeln;
  for i := 1 to JUMLAH_UJI do
  begin
    writeln(i:2, '. ', NamaUji[i]);
    if UjiSederhana(i) then
      writeln('     -> TERBUKTI ekuivalen, jenis ekspresi awal: ',
              JenisEkspresi(i))
    else
      writeln('     -> TIDAK ekuivalen');
  end;
end;

procedure TabelSatuUji;
var
  no: integer;
  p, q: boolean;
begin
  write('Pilih nomor uji (1-', JUMLAH_UJI, ') : ');
  readln(no);
  if (no < 1) or (no > JUMLAH_UJI) then
  begin
    writeln('Nomor tidak valid.');
    exit;
  end;
  writeln;
  writeln(NamaUji[no]);
  writeln;
  writeln('  p   q  | ruas kiri | ruas kanan | sama?');
  writeln('---------+-----------+------------+------');
  for p := True downto False do
    for q := True downto False do
      writeln('  ', BoolKeStr(p), '   ', BoolKeStr(q), '  |     ',
              BoolKeStr(Kiri(no, p, q)), '     |      ',
              BoolKeStr(Kanan(no, p, q)), '     |  ',
              BoolKeStr(Kiri(no, p, q) = Kanan(no, p, q)));
  writeln;
  if UjiSederhana(no) then
    writeln('Kesimpulan: kedua ruas ekuivalen. Jenis ruas kiri: ',
            JenisEkspresi(no))
  else
    writeln('Kesimpulan: kedua ruas TIDAK ekuivalen.');
end;

{ ---------- Contoh 4.2 : kondisi percabangan pada program ---------- }

procedure KondisiProgram;
var
  x, y: integer;
  kondisiAsli, kondisiSederhana: boolean;
begin
  writeln('=== CONTOH 4.2 : PENYEDERHANAAN KONDISI IF ===');
  writeln('Asli      : if (x > 0) and not ((x > 0) and (y > 0))');
  writeln('Sederhana : if (x > 0) and not (y > 0)');
  writeln;
  write('Masukkan x : ');
  readln(x);
  write('Masukkan y : ');
  readln(y);

  kondisiAsli      := (x > 0) and (not ((x > 0) and (y > 0)));
  kondisiSederhana := (x > 0) and (not (y > 0));

  writeln;
  writeln('Kondisi asli      = ', BoolKeStr(kondisiAsli));
  writeln('Kondisi sederhana = ', BoolKeStr(kondisiSederhana));
  if kondisiAsli = kondisiSederhana then
    writeln('Hasil sama, sesuai hasil penyederhanaan a ^ ~b.')
  else
    writeln('Hasil berbeda (seharusnya tidak pernah terjadi).');

  if kondisiSederhana then
    writeln('proses() dijalankan: x positif dan y tidak positif.')
  else
    writeln('proses() tidak dijalankan.');
end;

{ ---------- program utama ---------- }

var
  pilihan: integer;

begin
  repeat
    writeln;
    writeln('==============================================');
    writeln('   BAB IV : HUKUM LOGIKA (B = Benar, S = Salah)');
    writeln('==============================================');
    writeln('1. Verifikasi 10 hukum logika');
    writeln('2. Tabel De Morgan (Tabel IV.9)');
    writeln('3. Uji semua penyederhanaan (contoh & latihan)');
    writeln('4. Tabel kebenaran satu penyederhanaan');
    writeln('5. Kondisi if pada program (Contoh 4.2)');
    writeln('0. Keluar');
    write('Pilihan : ');
    readln(pilihan);
    writeln;

    case pilihan of
      1: begin VerifikasiSemuaHukum; Tunggu; end;
      2: begin TabelDeMorgan; Tunggu; end;
      3: begin UjiSemuaPenyederhanaan; Tunggu; end;
      4: begin TabelSatuUji; Tunggu; end;
      5: begin KondisiProgram; Tunggu; end;
      0: writeln('Terima kasih, program selesai.');
    else
      writeln('Pilihan tidak valid, coba lagi.');
    end;
  until pilihan = 0;
end.
