Return-Path: <linux-spi+bounces-11686-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D35C97AEC
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B54C4342DC2
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA07231770B;
	Mon,  1 Dec 2025 13:43:54 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388883191A2;
	Mon,  1 Dec 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596634; cv=none; b=vAlmqPH8fqnckzSAxi3i0fANMp87+Q22oGDDAjNS1Rm3ztwjSbuT4TFvkUeYt8izL5fyHIsThm/w6eWH9zMQR+B5vyoSOqqpNSTNOZ4Bf3I32beCL8xIY/MV/EG/f9sScKYbgW5uIra5YUbtL6UshX7yvXqbCX3vFB7z0rOdZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596634; c=relaxed/simple;
	bh=GeAaz+Wi1uM8FERJPGZGCHtKTCzPfUBafULTCaDC5Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G21e8CbMw27vx3a+PqmxwBQ1P9Yet6Hp0BzTJ/HQXXz0F++I70KkC2OzFqKW8QOokZQfys40TKAWp+jL0yWdlz4EfMbMJY90CSkgY1BR+UNPMhVYbB/nRcQC7fB3fVRN/PP7dCmkxg7UgSPcNO2095seM9krwzU8K3jI/1fNFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: cWu70kYfQVitmQYuxk/ehg==
X-CSE-MsgGUID: Alw3zvHxQhu8irJEZIgwTA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2025 22:43:49 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D1F504215A4E;
	Mon,  1 Dec 2025 22:43:45 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 06/13] spi: rzv2h-rspi: set MUST_RX/MUST_TX
Date: Mon,  1 Dec 2025 15:42:22 +0200
Message-ID: <20251201134229.600817-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for implementing DMA support, set MUST_RX and MUST_TX
flags on the controller so that we always receive non-NULL buffers.

The PIO mode already handles this manually by checking if rx_buf/tx_buf
are set on the transfer, and doing a dummy read/write if not.

DMA will not be able to implement this special handling, and although
the SPI controller advertises support for transmit-only or receive-only
transfers via SPCR's register TXMD bitfield, it does not seem to work.

Remove the special handling for PIO and let the SPI controller core
handle it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 50fd7ddef58d..f0bbbd21c763 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -113,11 +113,7 @@ struct rzv2h_rspi_priv {
 static inline void rzv2h_rspi_tx_##type(struct rzv2h_rspi_priv *rspi,	\
 					const void *txbuf,		\
 					unsigned int index) {		\
-	type buf = 0;							\
-									\
-	if (txbuf)							\
-		buf = ((type *)txbuf)[index];				\
-									\
+	type buf = ((type *)txbuf)[index];				\
 	func(buf, rspi->base + RSPI_SPDR);				\
 }
 
@@ -126,9 +122,7 @@ static inline void rzv2h_rspi_rx_##type(struct rzv2h_rspi_priv *rspi,	\
 					void *rxbuf,			\
 					unsigned int index) {		\
 	type buf = func(rspi->base + RSPI_SPDR);			\
-									\
-	if (rxbuf)							\
-		((type *)rxbuf)[index] = buf;				\
+	((type *)rxbuf)[index] = buf;					\
 }
 
 RZV2H_RSPI_TX(writel, u32)
@@ -596,6 +590,7 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 
 	controller->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
 				SPI_LSB_FIRST | SPI_LOOP;
+	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
 	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	controller->prepare_message = rzv2h_rspi_prepare_message;
 	controller->unprepare_message = rzv2h_rspi_unprepare_message;
-- 
2.52.0


