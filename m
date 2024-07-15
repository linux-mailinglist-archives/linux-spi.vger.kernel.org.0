Return-Path: <linux-spi+bounces-3861-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830299312DD
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 13:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045EF1F23A41
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279E818A93D;
	Mon, 15 Jul 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Se13DQqE"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCAA1891DC;
	Mon, 15 Jul 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042092; cv=none; b=DVK1qpM/6NLRb27xt2o0uBc+Uq1wmhPooO4h01ypq7oC0rB67QH+hsQ+ysZcZxInKXTgHOWDX/5Ow3HXGCSEoH+4O+90TQO6VVHKGAS8WDwY0b1dkz0iklkJuZKnbLNqGOHSflEz6DfYl5k2/+/Q6K7GdxeEMHBQ2SBV/dDOrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042092; c=relaxed/simple;
	bh=BEQ52OycMXhuGlXXvUjM+j81jFqhZR2hcVcYZWfDbOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7LP9bViJM5z+btP+u372mZwIl0G7VcvIWwM/5MusMYoXijO0mKYssv1fFtP9wU6nBn+ppBspMjGNNtS5slTEZBWdVV0e1BWyueDViJFmn6lmI+HpH/vms7XMBql5apY5+9aHWWdmlQcY3Iv9GNjv6oaq8j18KHJvCKI3Ob2zpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Se13DQqE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721042090; x=1752578090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BEQ52OycMXhuGlXXvUjM+j81jFqhZR2hcVcYZWfDbOw=;
  b=Se13DQqEFfr8qhEJopu3cfWNk/v5EL1H+Z4pQ+ywI5YaXGpw5yPue9Xw
   7WtsZ4ed3NvRkmSICChA8rTulPK/8q3wKkeLKVDKru71x63uwR8M1zuh0
   DBqjwo1cLvlNd6kAIcwDJvZ7L7bEqIyKzf26ujuNGDLyRgGM00D734g1f
   7+PiZX7qglJz9uFfRLpzAVQG8WDgmg3faD1mBN832SNSAIo1cEea/QgSI
   Xd3/rCiTNlFT6MdSiR6dMDsBdy4i2m7el9fC2LbYl8Z2EPf44QgqxyKgj
   tNGHO2V9K+eZe+kfwCsgSMqKOrboLtJfv+nouTumSVf4R9JqaxoQR8QuH
   w==;
X-CSE-ConnectionGUID: M47IHorFQcORQBAq4muecw==
X-CSE-MsgGUID: BEBq5ILYTtKHb08hHg+Ncw==
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="196643523"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2024 04:14:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jul 2024 04:14:45 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 15 Jul 2024 04:14:43 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-spi@vger.kernel.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Steve Wilkins
	<steve.wilkins@raymarine.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 6/6] spi: microchip-core: add support for word sizes of 1 to 32 bits
Date: Mon, 15 Jul 2024 12:13:57 +0100
Message-ID: <20240715-cogwheel-uniquely-0d4ef518b809@wendy>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715-retail-magnolia-bbd49a657a89@wendy>
References: <20240715-retail-magnolia-bbd49a657a89@wendy>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4283; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=SLr+fKyui42+8hroU8IV8E1Sye2BojjF+ZVhjk0+kHU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlTWYqDbgutmLqi6aSjewlv1DSumFrbAyrXf+u1nNJ0kFOb yu/bUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIl84mRkWFOy1d3wvV/T+XWBLaZ7Y4 tLrh78wfK3TDVd/JBUi4IHEyPDvqaY/dcvNv4Pv7ny22/lsF7mqQn3nqxacnLFe6tP3l18XAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Steve Wilkins <steve.wilkins@raymarine.com>

The current implementation only supports a word size of 8 bits,
which limits the devices it can be used with. Add support for any
word size between 1 and 32 bits, as supported by the hardware.

Signed-off-by: Steve Wilkins <steve.wilkins@raymarine.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 53 +++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 9f37603ccf10a..856bcbf0292d4 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -111,7 +111,7 @@ struct mchp_corespi {
 	int irq;
 	int tx_len;
 	int rx_len;
-	int pending;
+	int n_bytes;
 };
 
 static inline u32 mchp_corespi_read(struct mchp_corespi *spi, unsigned int reg)
@@ -135,20 +135,23 @@ static inline void mchp_corespi_disable(struct mchp_corespi *spi)
 
 static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi)
 {
-	u8 data;
-	int fifo_max, i = 0;
+	while (spi->rx_len >= spi->n_bytes && !(mchp_corespi_read(spi, REG_STATUS) & STATUS_RXFIFO_EMPTY)) {
+		u32 data = mchp_corespi_read(spi, REG_RX_DATA);
 
-	fifo_max = min(spi->rx_len, FIFO_DEPTH);
+		spi->rx_len -= spi->n_bytes;
 
-	while ((i < fifo_max) && !(mchp_corespi_read(spi, REG_STATUS) & STATUS_RXFIFO_EMPTY)) {
-		data = mchp_corespi_read(spi, REG_RX_DATA);
+		if (!spi->rx_buf)
+			continue;
 
-		if (spi->rx_buf)
-			*spi->rx_buf++ = data;
-		i++;
+		if (spi->n_bytes == 4)
+			*((u32 *)spi->rx_buf) = data;
+		else if (spi->n_bytes == 2)
+			*((u16 *)spi->rx_buf) = data;
+		else
+			*spi->rx_buf = data;
+
+		spi->rx_buf += spi->n_bytes;
 	}
-	spi->rx_len -= i;
-	spi->pending -= i;
 }
 
 static void mchp_corespi_enable_ints(struct mchp_corespi *spi)
@@ -210,20 +213,28 @@ static inline void mchp_corespi_set_xfer_size(struct mchp_corespi *spi, int len)
 
 static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi)
 {
-	u8 byte;
 	int fifo_max, i = 0;
 
-	fifo_max = min(spi->tx_len, FIFO_DEPTH);
+	fifo_max = DIV_ROUND_UP(min(spi->tx_len, FIFO_DEPTH), spi->n_bytes);
 	mchp_corespi_set_xfer_size(spi, fifo_max);
 
 	while ((i < fifo_max) && !(mchp_corespi_read(spi, REG_STATUS) & STATUS_TXFIFO_FULL)) {
-		byte = spi->tx_buf ? *spi->tx_buf++ : 0xaa;
-		mchp_corespi_write(spi, REG_TX_DATA, byte);
+		u32 word;
+
+		if (spi->n_bytes == 4)
+			word = spi->tx_buf ? *((u32 *)spi->tx_buf) : 0xaa;
+		else if (spi->n_bytes == 2)
+			word = spi->tx_buf ? *((u16 *)spi->tx_buf) : 0xaa;
+		else
+			word = spi->tx_buf ? *spi->tx_buf : 0xaa;
+
+		mchp_corespi_write(spi, REG_TX_DATA, word);
+		if (spi->tx_buf)
+			spi->tx_buf += spi->n_bytes;
 		i++;
 	}
 
-	spi->tx_len -= i;
-	spi->pending += i;
+	spi->tx_len -= i * spi->n_bytes;
 }
 
 static inline void mchp_corespi_set_framesize(struct mchp_corespi *spi, int bt)
@@ -490,10 +501,9 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 	spi->rx_buf = xfer->rx_buf;
 	spi->tx_len = xfer->len;
 	spi->rx_len = xfer->len;
-	spi->pending = 0;
+	spi->n_bytes = roundup_pow_of_two(DIV_ROUND_UP(xfer->bits_per_word, BITS_PER_BYTE));
 
-	mchp_corespi_set_xfer_size(spi, (spi->tx_len > FIFO_DEPTH)
-				   ? FIFO_DEPTH : spi->tx_len);
+	mchp_corespi_set_framesize(spi, xfer->bits_per_word);
 
 	mchp_corespi_write(spi, REG_COMMAND, COMMAND_RXFIFORST | COMMAND_TXFIFORST);
 
@@ -511,7 +521,6 @@ static int mchp_corespi_prepare_message(struct spi_controller *host,
 	struct spi_device *spi_dev = msg->spi;
 	struct mchp_corespi *spi = spi_controller_get_devdata(host);
 
-	mchp_corespi_set_framesize(spi, DEFAULT_FRAMESIZE);
 	mchp_corespi_set_mode(spi, spi_dev->mode);
 
 	return 0;
@@ -538,7 +547,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	host->num_chipselect = num_cs;
 	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	host->setup = mchp_corespi_setup;
-	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	host->transfer_one = mchp_corespi_transfer_one;
 	host->prepare_message = mchp_corespi_prepare_message;
 	host->set_cs = mchp_corespi_set_cs;
-- 
2.43.2


