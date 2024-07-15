Return-Path: <linux-spi+bounces-3857-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39B19312D5
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 13:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CED01F23617
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E411C1891C5;
	Mon, 15 Jul 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XbW/q/Ux"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C35188CDB;
	Mon, 15 Jul 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042089; cv=none; b=JFPrtnnuDDcD441c3CJHKeDV5uI1VdNpnmqX112lQ1owR4Av+YuYt93hpPgh+RRq8Bj/MFHkcAhfRnvq/THYxr5LwaJkyw2XKvO6lbezonnWfwctlvvcUBxynvmyKIEs/AyIUPSAUcZ5GylHbmgfzYrKvnEOdbZIUOb6gdmQUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042089; c=relaxed/simple;
	bh=UfK7h7obrCHWGo/3KO5Qle9LpnBmp02kqWYr9V4TgLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttBB3YLnpKxsKnj0lxcAo4ChIbuMhORx5tcFDT0IqA36YL+iQpYTPheT56cusIffvV/P97AUcLZ4L4I/BXIm2ehnTMLSlZ6/IMsWJf+8/+PhB6psOJUKe2xpzwQ0ed4VX7Zl+uLYEDt6bVHOua4/nliI+Cw3ZEItqOXp98qqOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XbW/q/Ux; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721042088; x=1752578088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UfK7h7obrCHWGo/3KO5Qle9LpnBmp02kqWYr9V4TgLo=;
  b=XbW/q/UxjEh9XFH5XMxNe8tvPoNjp59N4YYROT9x7n+gzIbO+FGOOAXu
   pcXGicFBYn9QEr4rCm19E7/MlS1UwTCVpVcuXJFaZbC7OV7grHBrOyvsz
   tHd/GuLixACYUH7LgmNfE691wUfxwnV3z2DHjdOdni8l9BYfV80WJio+P
   XsOeYE1uvIOvviEnOQfgxA8H0YZn575tPDYVRaql4SdjXtDU2jOllu9gP
   CgIQJ1rJdu1tcM4GgunRhwmUTimvzm9CuHjt2qkNNsU0WDGik3ZGcjgbz
   SqppkmWLFAeEJqGfXQpgFl1hcWuoDsOyqT+5mFIG6P5gP8OKzX0P5/voz
   A==;
X-CSE-ConnectionGUID: M47IHorFQcORQBAq4muecw==
X-CSE-MsgGUID: kU3KcMOcQKuIXPQieJmBFA==
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="196643518"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2024 04:14:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jul 2024 04:14:33 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 15 Jul 2024 04:14:31 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-spi@vger.kernel.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Steve Wilkins
	<steve.wilkins@raymarine.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/6] spi: microchip-core: defer asserting chip select until just before write to TX FIFO
Date: Mon, 15 Jul 2024 12:13:53 +0100
Message-ID: <20240715-sanitizer-recant-dd96b7a97048@wendy>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715-retail-magnolia-bbd49a657a89@wendy>
References: <20240715-retail-magnolia-bbd49a657a89@wendy>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3345; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=IQoUe8n5PhWYLVOj6psll7DXRuNtQ/NcFNyVRjNFIvE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlTWQonpn0+zFKlGaiRoZWlK7Yp4SF/n7B4UPWT73rbZmv8 ianrKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwER+f2ZkWGjxUs+kf8G76ATz/3tus5 nIPGaJv9r17uy5ibaP1vZe+sLwh9vwroGL66qt++4cnRbPcqLBeSf7z/NJt28U9uewyLDxsgIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Steve Wilkins <steve.wilkins@raymarine.com>

Setting up many of the registers for a new SPI transfer requires the
SPI controller to be disabled after set_cs() has been called to assert
the chip select line. However, disabling the controller results in the
SCLK and MOSI output pins being tristate, which can cause clock
transitions to be seen by a slave device whilst SS is active. To fix
this, the CS is only set to inactive inline, whilst setting it active
is deferred until all registers are set up and the any controller
disables have been completed.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Steve Wilkins <steve.wilkins@raymarine.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index a81e1317d52e6..b042160bd8811 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -103,6 +103,7 @@ struct mchp_corespi {
 	u8 *rx_buf;
 	u32 clk_gen; /* divider for spi output clock generated by the controller */
 	u32 clk_mode;
+	u32 pending_slave_select;
 	int irq;
 	int tx_len;
 	int rx_len;
@@ -249,8 +250,18 @@ static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
 	reg = mchp_corespi_read(corespi, REG_SLAVE_SELECT);
 	reg &= ~BIT(spi_get_chipselect(spi, 0));
 	reg |= !disable << spi_get_chipselect(spi, 0);
+	corespi->pending_slave_select = reg;
 
-	mchp_corespi_write(corespi, REG_SLAVE_SELECT, reg);
+	/*
+	 * Only deassert chip select immediately. Writing to some registers
+	 * requires the controller to be disabled, which results in the
+	 * output pins being tristated and can cause the SCLK and MOSI lines
+	 * to transition. Therefore asserting the chip select is deferred
+	 * until just before writing to the TX FIFO, to ensure the device
+	 * doesn't see any spurious clock transitions whilst CS is enabled.
+	 */
+	if (((spi->mode & SPI_CS_HIGH) == 0) == disable)
+		mchp_corespi_write(corespi, REG_SLAVE_SELECT, reg);
 }
 
 static int mchp_corespi_setup(struct spi_device *spi)
@@ -266,6 +277,7 @@ static int mchp_corespi_setup(struct spi_device *spi)
 	if (spi->mode & SPI_CS_HIGH) {
 		reg = mchp_corespi_read(corespi, REG_SLAVE_SELECT);
 		reg |= BIT(spi_get_chipselect(spi, 0));
+		corespi->pending_slave_select = reg;
 		mchp_corespi_write(corespi, REG_SLAVE_SELECT, reg);
 	}
 	return 0;
@@ -307,7 +319,8 @@ static void mchp_corespi_init(struct spi_controller *host, struct mchp_corespi *
 	 * select is relinquished to the hardware. SSELOUT is enabled too so we
 	 * can deal with active high targets.
 	 */
-	mchp_corespi_write(spi, REG_SLAVE_SELECT, SSELOUT | SSEL_DIRECT);
+	spi->pending_slave_select = SSELOUT | SSEL_DIRECT;
+	mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
 
 	control = mchp_corespi_read(spi, REG_CONTROL);
 
@@ -476,6 +489,8 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 	mchp_corespi_set_xfer_size(spi, (spi->tx_len > FIFO_DEPTH)
 				   ? FIFO_DEPTH : spi->tx_len);
 
+	mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
+
 	while (spi->tx_len)
 		mchp_corespi_write_fifo(spi);
 
-- 
2.43.2


