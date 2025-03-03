Return-Path: <linux-spi+bounces-7034-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35FFA4EBD4
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 19:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BA47A5258
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4074F24C093;
	Tue,  4 Mar 2025 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EABLV7M0"
X-Original-To: linux-spi@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5F1C84DB
	for <linux-spi@vger.kernel.org>; Tue,  4 Mar 2025 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112724; cv=fail; b=dg/unq90zzLpXzSxiJsViI6g1J+fWJeh2BWLuy8a2yChdNqpW4efinDvE+rZfnWMZDl+uLinCPQ5VsPtCw2MKgTq2cRTAdz1ZCljZBLNy0LrUnthaxVsxeZ1H4WCRvlpJumKMpiI46S95hmmZW4sL5xQD62exDp5lCxgqiVHmDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112724; c=relaxed/simple;
	bh=Bmygpzn/8Cwf0eDzohTCD08BpNlslOTqk9asMbjGsjM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TuLiKxl2j8stqMuA/xP4BygU3s3zgfS+L+30HprdsnrjzDjPik1C7a0a8jUUkSyb1R6KIzASxBVZA3GOIHEJD43SuFojMkacZHYcz4rVLCCil5eKcgUhkL0r7ptfXQqZZPVBdMh/6rkj9QlVAoFl9bY0RT5yk7sQ9+tkLNC9H5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=microchip.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EABLV7M0 reason="signature verification failed"; arc=none smtp.client-ip=68.232.154.123; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id B6466408B666
	for <linux-spi@vger.kernel.org>; Tue,  4 Mar 2025 21:25:20 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=EABLV7M0
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dtR40DnzFxfr
	for <linux-spi@vger.kernel.org>; Tue,  4 Mar 2025 17:51:43 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id D3BFF400C6; Tue,  4 Mar 2025 17:51:42 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EABLV7M0
X-Envelope-From: <linux-kernel+bounces-541432-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EABLV7M0
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 3A52042FE5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:49:49 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 113F63063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:49:49 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A415188676B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C311F3B9C;
	Mon,  3 Mar 2025 10:49:33 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D61E376C;
	Mon,  3 Mar 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998970; cv=none; b=gfg4ACCnLc2S+wfAof8ZZ3C7IrGfdyJjNEL0QcViJbZQ7ntmKMRCM2ZIhvAzd5HZa1a9luwCuZmldWpTyjlcBfJajcNGaLsQMzrjhPBwCovurFIdKNttkC+cF/9JPPjLs59ainUDbkprMMZswPemKGtSGAThRDwGGW4AJFrjoAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998970; c=relaxed/simple;
	bh=FxTyFdldQ/Rg6PXUyOvwskxzWGQOyp4Jrbq8b9VUONU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PEWz2YR6Jr9tYsLewlvdyGUdZaZt9psvGaI6Nevcg9eTuQvj2Sj8fMc5fvKaWs3z7EHmIfIPCd8H3Ouv0PZMVQT/9Zv3HGB23BDDRl/JZeb6sruywcOFhHGO65fGXrqwodPZJRC899hl/kW2HfdGwUr49Ux9ghwDoezFhbMljCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EABLV7M0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740998969; x=1772534969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FxTyFdldQ/Rg6PXUyOvwskxzWGQOyp4Jrbq8b9VUONU=;
  b=EABLV7M0S4zxmAJV4JIEzkZhziFIkiS1AI3I9DHLV6z826RyiaGTVMAI
   jMwtKPnN0h/xn6jJOKwMQ6BfWB3+oKJuaXVXNVBRQW7EV6lyeH2xREb3G
   fF/B15RHqRIE9lQEEBZo8rSpiBJCBEicmEVyaL8bG0lXlqJc9O+JEyKNO
   GJOjlsgmcxiJfvxVkX0n02Gs4SyaJhoDpG9QCZ/Ccg5DSVsVBKP+g97pc
   D1Z4/T1rplsy1NPgIpNV34XIfBfo6IomolOroP1kuKhVRlvObpUrsOL8y
   otHKuaK4vjfRn5ouRZ3auUshbt17b1cG24Lg602R7xOmcjEJtRnlOI1kK
   Q==;
X-CSE-ConnectionGUID: BikYLFOYSh2j96/3XZqldw==
X-CSE-MsgGUID: eIVd+EFRTYWJnQbd7HU8Qg==
X-IronPort-AV: E=Sophos;i="6.13,329,1732604400"; 
   d="scan'208";a="38768207"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2025 03:49:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 3 Mar 2025 03:48:32 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Mar 2025 03:48:31 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-spi@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, <stable@vger.kernel.org>,
	"Daire McNamara" <daire.mcnamara@microchip.com>, Mark Brown
	<broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] spi: microchip-core: prevent RX overflows when transmit size > FIFO size
Date: Mon, 3 Mar 2025 10:47:40 +0000
Message-ID: <20250303-veal-snooper-712c1dfad336@wendy>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4430; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=FxTyFdldQ/Rg6PXUyOvwskxzWGQOyp4Jrbq8b9VUONU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOlHO85KdGQ0fHr+8KSfXzH7n6m/Je2v/ju5m/9u/llPpozP H/zLO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRk8IM/ytqOt/+tbZ5fmjmnfAcXf G8t41L2VTfdNotn50cnhF0SIfhv8eGv2yppW3Whk79jGpT3XKuN+16IspsVXnh2+dYE/80XgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dtR40DnzFxfr
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717383.21695@M2tei6oGfuVcRPeRI3G9vA
X-ITU-MailScanner-SpamCheck: not spam

When the size of a transfer exceeds the size of the FIFO (32 bytes), RX
overflows will be generated and receive data will be corrupted and
warnings will be produced. For example, here's an error generated by a
transfer of 36 bytes:

  spi_master spi0: mchp_corespi_interrupt: RX OVERFLOW: rxlen: 4, txlen: =
0

The driver is currently split between handling receiving in the
interrupt handler, and sending outside of it. Move all handling out of
the interrupt handling, and explicitly link the number of bytes read of
of the RX FIFO to the number written into the TX one. This both resolves
the overflow problems as well as simplifying the flow of the driver.

CC: stable@vger.kernel.org
Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers=
")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

Contrary to last time, the reporter did actually manage to this this
version, and it resolved their probably apparently.

Changes in v2:
- Move all FIFO interactions out of the interrupt handler
- Disable the non-error interrupts since they're dealt with out of the
  isr now

v1: https://lore.kernel.org/all/20250114-easiness-pregame-d1d2d4b57e7b@sp=
ud/

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: linux-spi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-microchip-core.c | 41 ++++++++++++++------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip=
-core.c
index 5b6af55855efc..62ba0bd9cbb7e 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -70,8 +70,7 @@
 #define INT_RX_CHANNEL_OVERFLOW		BIT(2)
 #define INT_TX_CHANNEL_UNDERRUN		BIT(3)
=20
-#define INT_ENABLE_MASK (CONTROL_RX_DATA_INT | CONTROL_TX_DATA_INT | \
-			 CONTROL_RX_OVER_INT | CONTROL_TX_UNDER_INT)
+#define INT_ENABLE_MASK (CONTROL_RX_OVER_INT | CONTROL_TX_UNDER_INT)
=20
 #define REG_CONTROL		(0x00)
 #define REG_FRAME_SIZE		(0x04)
@@ -133,10 +132,15 @@ static inline void mchp_corespi_disable(struct mchp=
_corespi *spi)
 	mchp_corespi_write(spi, REG_CONTROL, control);
 }
=20
-static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi)
+static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi, int =
fifo_max)
 {
-	while (spi->rx_len >=3D spi->n_bytes && !(mchp_corespi_read(spi, REG_ST=
ATUS) & STATUS_RXFIFO_EMPTY)) {
-		u32 data =3D mchp_corespi_read(spi, REG_RX_DATA);
+	for (int i =3D 0; i < fifo_max; i++) {
+		u32 data;
+
+		while (mchp_corespi_read(spi, REG_STATUS) & STATUS_RXFIFO_EMPTY)
+			;
+
+		data =3D mchp_corespi_read(spi, REG_RX_DATA);
=20
 		spi->rx_len -=3D spi->n_bytes;
=20
@@ -211,11 +215,10 @@ static inline void mchp_corespi_set_xfer_size(struc=
t mchp_corespi *spi, int len)
 	mchp_corespi_write(spi, REG_FRAMESUP, len);
 }
=20
-static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi)
+static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi, int=
 fifo_max)
 {
-	int fifo_max, i =3D 0;
+	int i =3D 0;
=20
-	fifo_max =3D DIV_ROUND_UP(min(spi->tx_len, FIFO_DEPTH), spi->n_bytes);
 	mchp_corespi_set_xfer_size(spi, fifo_max);
=20
 	while ((i < fifo_max) && !(mchp_corespi_read(spi, REG_STATUS) & STATUS_=
TXFIFO_FULL)) {
@@ -413,19 +416,6 @@ static irqreturn_t mchp_corespi_interrupt(int irq, v=
oid *dev_id)
 	if (intfield =3D=3D 0)
 		return IRQ_NONE;
=20
-	if (intfield & INT_TXDONE)
-		mchp_corespi_write(spi, REG_INT_CLEAR, INT_TXDONE);
-
-	if (intfield & INT_RXRDY) {
-		mchp_corespi_write(spi, REG_INT_CLEAR, INT_RXRDY);
-
-		if (spi->rx_len)
-			mchp_corespi_read_fifo(spi);
-	}
-
-	if (!spi->rx_len && !spi->tx_len)
-		finalise =3D true;
-
 	if (intfield & INT_RX_CHANNEL_OVERFLOW) {
 		mchp_corespi_write(spi, REG_INT_CLEAR, INT_RX_CHANNEL_OVERFLOW);
 		finalise =3D true;
@@ -512,9 +502,14 @@ static int mchp_corespi_transfer_one(struct spi_cont=
roller *host,
=20
 	mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
=20
-	while (spi->tx_len)
-		mchp_corespi_write_fifo(spi);
+	while (spi->tx_len) {
+		int fifo_max =3D DIV_ROUND_UP(min(spi->tx_len, FIFO_DEPTH), spi->n_byt=
es);
=20
+		mchp_corespi_write_fifo(spi, fifo_max);
+		mchp_corespi_read_fifo(spi, fifo_max);
+	}
+
+	spi_finalize_current_transfer(host);
 	return 1;
 }
=20
--=20
2.48.1



