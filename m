Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28DB11C439
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 04:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLLDlf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Dec 2019 22:41:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:58520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727377AbfLLDkA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Dec 2019 22:40:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECAB9AE40;
        Thu, 12 Dec 2019 03:39:57 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [RFC 04/25] spi: gpio: Implement LSB First bitbang support
Date:   Thu, 12 Dec 2019 04:39:31 +0100
Message-Id: <20191212033952.5967-5-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191212033952.5967-1-afaerber@suse.de>
References: <20191212033952.5967-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for slave DT property spi-lsb-first, i.e., SPI_LSB_FIRST mode.

Duplicate the inline helpers bitbang_txrx_be_cpha{0,1} as LE versions.
Make checkpatch.pl happy by changing "unsigned" to "unsigned int".

Conditionally call them from all the spi-gpio txrx_word callbacks.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/spi/spi-bitbang-txrx.h | 68 ++++++++++++++++++++++++++++++++++++++++--
 drivers/spi/spi-gpio.c         | 42 ++++++++++++++++++++------
 2 files changed, 99 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index ae61d72c7d28..999a89325325 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -45,7 +45,7 @@
 
 static inline u32
 bitbang_txrx_be_cpha0(struct spi_device *spi,
-		unsigned nsecs, unsigned cpol, unsigned flags,
+		unsigned int nsecs, unsigned int cpol, unsigned int flags,
 		u32 word, u8 bits)
 {
 	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
@@ -77,7 +77,7 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 
 static inline u32
 bitbang_txrx_be_cpha1(struct spi_device *spi,
-		unsigned nsecs, unsigned cpol, unsigned flags,
+		unsigned int nsecs, unsigned int cpol, unsigned int flags,
 		u32 word, u8 bits)
 {
 	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
@@ -106,3 +106,67 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 	}
 	return word;
 }
+
+static inline u32
+bitbang_txrx_le_cpha0(struct spi_device *spi,
+		unsigned int nsecs, unsigned int cpol, unsigned int flags,
+		u32 word, u8 bits)
+{
+	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
+
+	u32 oldbit = !(word & 1);
+	/* clock starts at inactive polarity */
+	for (; likely(bits); bits--) {
+
+		/* setup LSB (to slave) on trailing edge */
+		if ((flags & SPI_MASTER_NO_TX) == 0) {
+			if ((word & 1) != oldbit) {
+				setmosi(spi, word & 1);
+				oldbit = word & 1;
+			}
+		}
+		spidelay(nsecs);	/* T(setup) */
+
+		setsck(spi, !cpol);
+		spidelay(nsecs);
+
+		/* sample LSB (from slave) on leading edge */
+		word >>= 1;
+		if ((flags & SPI_MASTER_NO_RX) == 0)
+			word |= getmiso(spi) << (bits - 1);
+		setsck(spi, cpol);
+	}
+	return word;
+}
+
+static inline u32
+bitbang_txrx_le_cpha1(struct spi_device *spi,
+		unsigned int nsecs, unsigned int cpol, unsigned int flags,
+		u32 word, u8 bits)
+{
+	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
+
+	u32 oldbit = !(word & 1);
+	/* clock starts at inactive polarity */
+	for (; likely(bits); bits--) {
+
+		/* setup LSB (to slave) on leading edge */
+		setsck(spi, !cpol);
+		if ((flags & SPI_MASTER_NO_TX) == 0) {
+			if ((word & 1) != oldbit) {
+				setmosi(spi, word & 1);
+				oldbit = word & 1;
+			}
+		}
+		spidelay(nsecs); /* T(setup) */
+
+		setsck(spi, cpol);
+		spidelay(nsecs);
+
+		/* sample LSB (from slave) on trailing edge */
+		word >>= 1;
+		if ((flags & SPI_MASTER_NO_RX) == 0)
+			word |= getmiso(spi) << (bits - 1);
+	}
+	return word;
+}
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 7ceb0ba27b75..493723eda844 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -135,25 +135,37 @@ static inline int getmiso(const struct spi_device *spi)
 static u32 spi_gpio_txrx_word_mode0(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha0(spi, nsecs, 0, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
 }
 
 static u32 spi_gpio_txrx_word_mode1(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	return bitbang_txrx_be_cpha1(spi, nsecs, 0, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha1(spi, nsecs, 0, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha1(spi, nsecs, 0, flags, word, bits);
 }
 
 static u32 spi_gpio_txrx_word_mode2(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	return bitbang_txrx_be_cpha0(spi, nsecs, 1, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha0(spi, nsecs, 1, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha0(spi, nsecs, 1, flags, word, bits);
 }
 
 static u32 spi_gpio_txrx_word_mode3(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
-	return bitbang_txrx_be_cpha1(spi, nsecs, 1, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha1(spi, nsecs, 1, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha1(spi, nsecs, 1, flags, word, bits);
 }
 
 /*
@@ -170,28 +182,40 @@ static u32 spi_gpio_spec_txrx_word_mode0(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
 	flags = spi->master->flags;
-	return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha0(spi, nsecs, 0, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
 }
 
 static u32 spi_gpio_spec_txrx_word_mode1(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
 	flags = spi->master->flags;
-	return bitbang_txrx_be_cpha1(spi, nsecs, 0, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha1(spi, nsecs, 0, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha1(spi, nsecs, 0, flags, word, bits);
 }
 
 static u32 spi_gpio_spec_txrx_word_mode2(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
 	flags = spi->master->flags;
-	return bitbang_txrx_be_cpha0(spi, nsecs, 1, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha0(spi, nsecs, 1, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha0(spi, nsecs, 1, flags, word, bits);
 }
 
 static u32 spi_gpio_spec_txrx_word_mode3(struct spi_device *spi,
 		unsigned nsecs, u32 word, u8 bits, unsigned flags)
 {
 	flags = spi->master->flags;
-	return bitbang_txrx_be_cpha1(spi, nsecs, 1, flags, word, bits);
+	if (unlikely(spi->mode & SPI_LSB_FIRST))
+		return bitbang_txrx_le_cpha1(spi, nsecs, 1, flags, word, bits);
+	else
+		return bitbang_txrx_be_cpha1(spi, nsecs, 1, flags, word, bits);
 }
 
 /*----------------------------------------------------------------------*/
@@ -389,7 +413,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
-			    SPI_CS_HIGH;
+			    SPI_CS_HIGH | SPI_LSB_FIRST;
 	if (!spi_gpio->mosi) {
 		/* HW configuration without MOSI pin
 		 *
-- 
2.16.4

