Return-Path: <linux-spi+bounces-11635-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE615C8FF62
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 20:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3305A4E657E
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56F5303A02;
	Thu, 27 Nov 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yi9tuhDu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B02FFDE2;
	Thu, 27 Nov 2025 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270038; cv=none; b=FMJWKtCHPbUN+Sx63RiM4Euq5/nvDcTjkPhLpRGylmS6M6BYP/J3t8ru0lm1rsboMQYuGZt9npQWT6QNmJtenwNgzMMBP3bMQXCTWPpguh7ENFLYTnmREH3zOnm7mM2slDcf8XiwNNAyTqA2sii5cRgD0GnOzpBoLsueXimAkBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270038; c=relaxed/simple;
	bh=yuDl+vV9uGiSg1HH//XrjlArBAJ2MDXUa6CNLBLNkqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHzn5E5v+GM3U96cxBAcEs4TM6a3NbLnYh5cCpIRW7ToApAK6wm3BYOo9je+C/lOo1/Mwv3fKFJQz7DeyhJiCCzPXZo3Pc4w9WkYcuQpCTAOgnp+mIRyTQRg0p8ZFBDOuItfVVvPWD62GE926FuTVpmLtFSTSjBx0VbUqYqEMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yi9tuhDu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764270037; x=1795806037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yuDl+vV9uGiSg1HH//XrjlArBAJ2MDXUa6CNLBLNkqc=;
  b=Yi9tuhDu8ZkFKKb0rP3vKKO6Ogh7bQKEWLQu5mRiyFSZvj7bBEiYEPqR
   JQ9Z49Cw/oXEBnQo0djeYBLaO1evdO12S+rRcRZMEBS9USRAxSQ9uMOim
   O4xjDo4Cq6Jk/EAjBsIDr/4h5IlAf6OZUn2ytSac9uwKePJKa6tRFjMHl
   a6d+cBmVAxvU93oCYohOGKqSqaES8ORzDA1ry641h637xIcKYpT+WshvR
   ZhspFywfY5ZWhCrHtKl9tumL6OXki8Z7wInm5rggyfmBZgFW/y7l11Uck
   u4UPjXkGA+5X/2Maq0j7hh0rg9xbJYT2//Dw4dLO5DLQFhF7uudRLkOgW
   Q==;
X-CSE-ConnectionGUID: /gXmrsw3Rs+QQXhJnSTafw==
X-CSE-MsgGUID: PhOUnBNTTjilPHP7m64vNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="91796255"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="91796255"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:00:35 -0800
X-CSE-ConnectionGUID: vdevt3uLSx6K1c9n9Gi2Vg==
X-CSE-MsgGUID: QzmVBog8TnmHOap/Zht6Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="216645897"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2025 11:00:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 394FEA0; Thu, 27 Nov 2025 20:00:32 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v3 1/6] spi: microchip-core: use min() instead of min_t()
Date: Thu, 27 Nov 2025 19:58:58 +0100
Message-ID: <20251127190031.2998705-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
References: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
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

Reviewed-by: David Laight <david.laight.linux@gmail.com>
Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
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


