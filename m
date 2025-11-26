Return-Path: <linux-spi+bounces-11564-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF2BC88871
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E53F3B617A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1A2314D3B;
	Wed, 26 Nov 2025 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCNktjCM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F652D248C;
	Wed, 26 Nov 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143767; cv=none; b=t4NG2VhqsHTyRGcNuXggwU+KXZCMkzLUuToaB4iS8mOoLCd4nPQYSp3RjeswA2ZUi+7VBr0dFxz5rGxkQUQjbuC6k4qoMVOWAf1w56PYgkdUZyEEW2ZDRKkkkdJ4FGMv9ERNj58d0NLZWHYgiQFzfEOFdCJd85ko/BdZG0dv9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143767; c=relaxed/simple;
	bh=i348gRZwFs1j437kjQtd2OZNYyRNL6pS+Luhhms/cVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHNi3U39ebie6DhmcblixfFyhH1AVvdSNrpN9Cwt2CO1ya/q+V2GpjOFVVuSr3H9qUmALEFVcBk+pnEZ9fbn9k42F52aK+5dKGKBE+Aj9zwV/OyOewagkulO+gLHKDIVbd1ReddK56AdUA7WVAb8U96uD4aAV7iEMUXSwxyxDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCNktjCM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764143766; x=1795679766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i348gRZwFs1j437kjQtd2OZNYyRNL6pS+Luhhms/cVs=;
  b=bCNktjCMjRoF3kSSaMMH3Up6cOA212PW/b/mYqVZgb98BBMBAq21kxwz
   LvZysVgrW12jEf+7R6CnTNTpcug4yP+gcH5aVQjr4/xSI98eMT1HY98im
   13o4vijPZwz/noU4laaSLfMLuoeN4Nlz+v3tRVNcgE/kCYyTV4PYSOE0T
   nUNCG5DIWyQmk7fq4MDazcbWybgJYUGAl513SLBGJaWjgB/1tzdF14Vpf
   epSrd6WTUAwUof0WWlFXJxH8rYeTR4rABKsqaAs0IrHZusGtZGvGLLFyx
   u1WGNpGr8wG0LCRLkIA7Js0RU/bPgdH9RTxyHiELzkmboTn6YOfQvYv0b
   Q==;
X-CSE-ConnectionGUID: DelBNBZjT92lLdfvMT2/+Q==
X-CSE-MsgGUID: YVJAW2OZQJ6JVgDhG1NwgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="77538901"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="77538901"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:56:03 -0800
X-CSE-ConnectionGUID: Z38RqhYvTe2RKATIFvt0NA==
X-CSE-MsgGUID: bpe86PM0RRGm+5m2I4VXQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="197026112"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2025 23:56:02 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1BF19A1; Wed, 26 Nov 2025 08:56:00 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/6] spi: microchip-core: use min() instead of min_t()
Date: Wed, 26 Nov 2025 08:54:39 +0100
Message-ID: <20251126075558.2035012-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
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


