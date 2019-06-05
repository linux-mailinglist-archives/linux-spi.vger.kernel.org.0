Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D7436204
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2019 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfFERBo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jun 2019 13:01:44 -0400
Received: from bues.ch ([80.190.117.144]:48902 "EHLO bues.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbfFERBo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Jun 2019 13:01:44 -0400
X-Greylist: delayed 1139 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2019 13:01:43 EDT
Received: by bues.ch with esmtpsa (Exim 4.89)
        (envelope-from <m@bues.ch>)
        id 1hYYzq-00073t-A7; Wed, 05 Jun 2019 18:42:42 +0200
Date:   Wed, 5 Jun 2019 18:40:45 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Subject: [PATCH] spi-bcm2835: Always initialize local variable in
 bcm2835_wr_fifo_count
Message-ID: <20190605184045.5ce33d92@wiggum>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/4RLwKfv=p3bR0Cj/Kblnji7"; protocol="application/pgp-signature"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--Sig_/4RLwKfv=p3bR0Cj/Kblnji7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If count is less than 4 and memcpy copies less than 4 bytes into var,
some bytes remain uninitialized. These uninitialized bytes are taken
from var and written to the BCM2835_SPI_FIFO register.

While the hardware probably is able to ignore these extra bytes, it's
Undefined Behavior to read uninitialized bytes. So don't do that.

Signed-off-by: Michael Buesch <m@bues.ch>
Cc: stable@vger.kernel.org

---
 drivers/spi/spi-bcm2835.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 9c03da7c18dd..5b0119cc2b07 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -253,12 +253,11 @@ static inline void bcm2835_wr_fifo_count(struct bcm28=
35_spi *bs, int count)
 	bs->tx_len -=3D count;
=20
 	while (count > 0) {
+		val =3D 0;
 		if (bs->tx_buf) {
 			len =3D min(count, 4);
 			memcpy(&val, bs->tx_buf, len);
 			bs->tx_buf +=3D len;
-		} else {
-			val =3D 0;
 		}
 		bcm2835_wr(bs, BCM2835_SPI_FIFO, val);
 		count -=3D 4;
--=20
2.20.1


--Sig_/4RLwKfv=p3bR0Cj/Kblnji7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAlz38I0ACgkQ9TK+HZCN
iw6O+Q//dhtXhKnI0D+LNtjMoNTH3ONL7c4pjBStixjFCor/Se0Z/7LW4ufWquKF
A9L7RV8uCZKMh19lgNbBl2/U+2gfa8VUH4bE9Pu8s3+YMIbiMhBGk3iCRpFrNaG/
QAlSoTPXf6IqIAB9N4WWdnO+GbQx5Mq7WoY8HsY02xls6W6dsEBt/YB3jL4ciMK1
kVzhM02zaGLHqBMOkHSKOE1Ly/lOArYxAPETdZMdNr3ievaxZUlRtBZKn6bJUf5F
0MU78+zxQLC0yKbFqKDlO0RYphucPVjObTEBeAnyX+x9Si3nL/J2Lw1sQqeqcgla
GmMC9IRulFI8PWb21g/ilgpsDdKd+iCM1KHMMUlv/idTM7WKR8HLg8FCVa3kpbto
Gen6RikJxT5YFWUGCAT9FZ1r4WZXzRY1orOpvfg7UZRznkduG0f1VtTql7o1NEwo
bB9OJly5JZ/L7pk7l5zHNd+ehHXBsk3ScHJyitp9XZAKTWkpCspsMHoLm2/5LfnO
r8lITjqaKVjB7/O17/wI42if6Dgx1N6KgOxRxfRR3xJwuQcWBNm2I39qZQGNIe+x
AghGW0MoEqfOcQLc3Oo3CWII1LuLlghbcqrWcXEHskIIhS05NHjouRWuhlpwhvEK
bRm8uNRqq74G57AmWRdgmxOCo7z0GyNLPOkhy8BZkVRDktZ/TB4=
=yHTi
-----END PGP SIGNATURE-----

--Sig_/4RLwKfv=p3bR0Cj/Kblnji7--
