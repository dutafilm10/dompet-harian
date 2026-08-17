DOMPET HARIAN — CLOUD SYNC

1. Buat project Supabase.
2. SQL Editor -> jalankan seluruh schema.sql.
3. Project Settings -> API -> salin Project URL dan Publishable key.
4. Isi config.js dengan dua nilai tersebut.
5. Upload folder ini ke hosting HTTPS.
6. Di HP dan laptop buka URL yang sama.
7. Daftar/login menggunakan akun yang sama.

Jangan gunakan service_role key di browser. Gunakan Publishable key.
RLS pada schema.sql membatasi akses berdasarkan auth.uid().
Perubahan pada categories dan expenses dipantau melalui Supabase Realtime.

Catatan: saya tidak bisa membuat project Supabase atau mengambil credential akun Anda dari sini. Paket ini sudah siap untuk dihubungkan ke project Anda.
