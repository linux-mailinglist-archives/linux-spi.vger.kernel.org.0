Return-Path: <linux-spi+bounces-11534-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F62C86FA9
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 21:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3048634DF64
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633FD33B96E;
	Tue, 25 Nov 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYiBoCpw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624D33ADA7;
	Tue, 25 Nov 2025 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101827; cv=none; b=E80sOhFf+8sF3qjYn3XQXiyk7B5yFLKIeRR5u4dIEwD+jiZTVDpkGZWVtgvqOsFnxrYJo5E7UgbdfC/fdn0ogH9BsA1XNCdMJBGXSliMvS/zWds5ARNDc9MQuMKQ5de3jrsySomA+S7MEg0whPeBG/rodIHRjPVOn4J134la6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101827; c=relaxed/simple;
	bh=i348gRZwFs1j437kjQtd2OZNYyRNL6pS+Luhhms/cVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8rc4rMX5j9eziTql4U3O/wMMxi3T0tzPDmk1V3sT54aMKYjkSlOhnagIHU8PmZjrwoQ52Htw6lzF1M5qc5fwdZr2YDk9J2EbkmK2LhfI9AHhLJ60gD4Wr8I0B1j/EmFvRYJD5jlQcSRzvQEWzuD4aENBYpsPE4xPLyoDFAXdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYiBoCpw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764101826; x=1795637826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i348gRZwFs1j437kjQtd2OZNYyRNL6pS+Luhhms/cVs=;
  b=OYiBoCpw9XOWpTyqWKObdp5rBtz/Ps5NA+/s80YlT0QiuyncVYfCRO2F
   sgDdO+uenKilSLD+W2M7lUmgxiFmTcjk3XyQc91jxZHUQmD8uveRYzFxJ
   p1GF0j+DXyB8weNE2T5DsHkeI3rFtcb2IwyUzIckQGwhyyNPk74GqPHBl
   MIkvquBWFklR9k0V7OBZGaCo/XulB5tRi5tC38I74+2A5zKNTrgIMp4/J
   8ONqppFV/ixOqmD5CTAp6zJGtkSkA5TYkk+xLbvhq8KjeE+I/IuvvgdBJ
   AHLLh6KWz1YiFktk5jSv8GpKG1E9LiI7ywEmYD6Xi6LebHq1TJg3YOq7e
   w==;
X-CSE-ConnectionGUID: TT6dfz3RRFuTvYVTwlAuVw==
X-CSE-MsgGUID: TR76kcVLTxqcsrU+ttnkzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69990024"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="69990024"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:17:05 -0800
X-CSE-ConnectionGUID: sEj+fqk5QMeyiqHbsenffA==
X-CSE-MsgGUID: dQEvqoEmRNqyCFAXmcnKlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="223720983"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 25 Nov 2025 12:17:03 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 46821A1; Tue, 25 Nov 2025 21:17:02 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/7] spi: microchip-core: use min() instead of min_t()
Date: Tue, 25 Nov 2025 21:15:31 +0100
Message-ID: <20251125201700.1901959-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

min_t(int, a, b) casts an 'unsigned int' to 'int'. This might lead
to the cases when big number is wrongly chosen. On the other hand,
the SPI transfer length is unsigned and driver uses signed type for
an unknown reason. Change the type of the transfer length to be
unsigned and convert use min() instead of min_t().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 16e0885474a0..08ccdc5f0cc9 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -74,8 +74,8 @@ struct mchp_corespi {
 	u8 *rx_buf;
 	u32 clk_gen;
 	int irq;
-	int tx_len;
-	int rx_len;
+	unsigned int tx_len;
+	unsigned int rx_len;
 	u32 fifo_depth;
 };
 
@@ -214,7 +214,7 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 		       spi->regs + MCHP_CORESPI_REG_INTCLEAR);
 		finalise = true;
 		dev_err(&host->dev,
-			"RX OVERFLOW: rxlen: %d, txlen: %d\n",
+			"RX OVERFLOW: rxlen: %u, txlen: %u\n",
 			spi->rx_len, spi->tx_len);
 	}
 
@@ -223,7 +223,7 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 		       spi->regs + MCHP_CORESPI_REG_INTCLEAR);
 		finalise = true;
 		dev_err(&host->dev,
-			"TX UNDERFLOW: rxlen: %d, txlen: %d\n",
+			"TX UNDERFLOW: rxlen: %u, txlen: %u\n",
 			spi->rx_len, spi->tx_len);
 	}
 
@@ -283,7 +283,7 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 	spi->rx_len = xfer->len;
 
 	while (spi->tx_len) {
-		int fifo_max = min_t(int, spi->tx_len, spi->fifo_depth);
+		unsigned int fifo_max = min(spi->tx_len, spi->fifo_depth);
 
 		mchp_corespi_write_fifo(spi, fifo_max);
 		mchp_corespi_read_fifo(spi, fifo_max);
-- 
2.50.1


