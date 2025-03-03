Return-Path: <linux-spi+bounces-6981-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8AAA4BCDB
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 11:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A087168E4D
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8E71F0E44;
	Mon,  3 Mar 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EABLV7M0"
X-Original-To: linux-spi@vger.kernel.org
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
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4430; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=FxTyFdldQ/Rg6PXUyOvwskxzWGQOyp4Jrbq8b9VUONU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOlHO85KdGQ0fHr+8KSfXzH7n6m/Je2v/ju5m/9u/llPpozP H/zLO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRk8IM/ytqOt/+tbZ5fmjmnfAcXf G8t41L2VTfdNotn50cnhF0SIfhv8eGv2yppW3Whk79jGpT3XKuN+16IspsVXnh2+dYE/80XgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When the size of a transfer exceeds the size of the FIFO (32 bytes), RX
overflows will be generated and receive data will be corrupted and
warnings will be produced. For example, here's an error generated by a
transfer of 36 bytes:

  spi_master spi0: mchp_corespi_interrupt: RX OVERFLOW: rxlen: 4, txlen: 0

The driver is currently split between handling receiving in the
interrupt handler, and sending outside of it. Move all handling out of
the interrupt handling, and explicitly link the number of bytes read of
of the RX FIFO to the number written into the TX one. This both resolves
the overflow problems as well as simplifying the flow of the driver.

CC: stable@vger.kernel.org
Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

Contrary to last time, the reporter did actually manage to this this
version, and it resolved their probably apparently.

Changes in v2:
- Move all FIFO interactions out of the interrupt handler
- Disable the non-error interrupts since they're dealt with out of the
  isr now

v1: https://lore.kernel.org/all/20250114-easiness-pregame-d1d2d4b57e7b@spud/

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: linux-spi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-microchip-core.c | 41 ++++++++++++++------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 5b6af55855efc..62ba0bd9cbb7e 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -70,8 +70,7 @@
 #define INT_RX_CHANNEL_OVERFLOW		BIT(2)
 #define INT_TX_CHANNEL_UNDERRUN		BIT(3)
 
-#define INT_ENABLE_MASK (CONTROL_RX_DATA_INT | CONTROL_TX_DATA_INT | \
-			 CONTROL_RX_OVER_INT | CONTROL_TX_UNDER_INT)
+#define INT_ENABLE_MASK (CONTROL_RX_OVER_INT | CONTROL_TX_UNDER_INT)
 
 #define REG_CONTROL		(0x00)
 #define REG_FRAME_SIZE		(0x04)
@@ -133,10 +132,15 @@ static inline void mchp_corespi_disable(struct mchp_corespi *spi)
 	mchp_corespi_write(spi, REG_CONTROL, control);
 }
 
-static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi)
+static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi, int fifo_max)
 {
-	while (spi->rx_len >= spi->n_bytes && !(mchp_corespi_read(spi, REG_STATUS) & STATUS_RXFIFO_EMPTY)) {
-		u32 data = mchp_corespi_read(spi, REG_RX_DATA);
+	for (int i = 0; i < fifo_max; i++) {
+		u32 data;
+
+		while (mchp_corespi_read(spi, REG_STATUS) & STATUS_RXFIFO_EMPTY)
+			;
+
+		data = mchp_corespi_read(spi, REG_RX_DATA);
 
 		spi->rx_len -= spi->n_bytes;
 
@@ -211,11 +215,10 @@ static inline void mchp_corespi_set_xfer_size(struct mchp_corespi *spi, int len)
 	mchp_corespi_write(spi, REG_FRAMESUP, len);
 }
 
-static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi)
+static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi, int fifo_max)
 {
-	int fifo_max, i = 0;
+	int i = 0;
 
-	fifo_max = DIV_ROUND_UP(min(spi->tx_len, FIFO_DEPTH), spi->n_bytes);
 	mchp_corespi_set_xfer_size(spi, fifo_max);
 
 	while ((i < fifo_max) && !(mchp_corespi_read(spi, REG_STATUS) & STATUS_TXFIFO_FULL)) {
@@ -413,19 +416,6 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 	if (intfield == 0)
 		return IRQ_NONE;
 
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
-		finalise = true;
-
 	if (intfield & INT_RX_CHANNEL_OVERFLOW) {
 		mchp_corespi_write(spi, REG_INT_CLEAR, INT_RX_CHANNEL_OVERFLOW);
 		finalise = true;
@@ -512,9 +502,14 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 
 	mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
 
-	while (spi->tx_len)
-		mchp_corespi_write_fifo(spi);
+	while (spi->tx_len) {
+		int fifo_max = DIV_ROUND_UP(min(spi->tx_len, FIFO_DEPTH), spi->n_bytes);
 
+		mchp_corespi_write_fifo(spi, fifo_max);
+		mchp_corespi_read_fifo(spi, fifo_max);
+	}
+
+	spi_finalize_current_transfer(host);
 	return 1;
 }
 
-- 
2.48.1


