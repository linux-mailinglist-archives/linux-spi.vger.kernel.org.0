Return-Path: <linux-spi+bounces-11658-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4381DC92FB3
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 19:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F069434F33C
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36579334379;
	Fri, 28 Nov 2025 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjKq7tlq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3B32ED3D;
	Fri, 28 Nov 2025 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764356127; cv=none; b=GZpYdSj8nPLxc4UgtbOLXXwgWtv1fykauhkJpMD9/NaRRbDFoW1NMSNephALv76NAaq6wPD2Vt6wol9LXd9gmWeRpNUWhgFoZrGcyOwA6CbX4FoZ5uDX9hoLjoTPNrioLAG7La71gG1pMKkZg4s5HoHD/TgvAOWMKdEmVQ0OOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764356127; c=relaxed/simple;
	bh=KdDJzl7xxKiyl6+TxJyvQZiLRbgKc0ABK6CvwwzEZVA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHfQjZ0ykiXddOu6HJpYXd2VzYP+QaSEWvOoBoBG9k9uc7jMDEXKHSzL3XYfmbIQpShrUclegKzwNtdb5pVtv6oSWI1dS2jvxITbZVt4JygpBNIP0FduB1LbZvBDmGfiGz/jl9haw0DY7OG5HVDf6GB9TxHUg0N2s78HmKYsTC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjKq7tlq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764356125; x=1795892125;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=KdDJzl7xxKiyl6+TxJyvQZiLRbgKc0ABK6CvwwzEZVA=;
  b=RjKq7tlq1OjokVBrHgJIFIbJjYrKDWH2KtJs22fzI31qlTIgUsYYyTOW
   2BwBOnnxTyief19RJnXPkgDLOoZZBfgsHQ4E+SlDiYpsP/qEfdHR8D955
   JH9hR6nSxGwX9mQekqr32yBkzimh/623rSOKjFWqIXRl0e6XnrHp45TCh
   F4Et8TblDOOOcS/2Do+R4VSNz5LWBFB2N7GQppEfUemzWrmBtsnvx1gxC
   iQoRr0U4I5gpvqZXwNAHARO5KrzORIzzZZLfY1UMWC/8swuXBeV6wsLww
   /lr68PR67he4kb6QpNhj4w3SBSaIAE5h4K9KRkP3ztKQ15wSSYGtPme8c
   Q==;
X-CSE-ConnectionGUID: 1zmkqfxpSlCbB7Rp0kh/DA==
X-CSE-MsgGUID: AKoyWUEERIOj4Ao8Rgjeow==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="77856763"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="77856763"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 10:55:22 -0800
X-CSE-ConnectionGUID: AWcDyf5WQZyH3lw4wKmOyA==
X-CSE-MsgGUID: hCxERvQkQMq2busbixFmJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="230801963"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 28 Nov 2025 10:55:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8B9E3A0; Fri, 28 Nov 2025 19:55:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] spi: microchip-core: Refactor FIFO read and write handlers
Date: Fri, 28 Nov 2025 19:52:39 +0100
Message-ID: <20251128185518.3989250-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251128185518.3989250-1-andriy.shevchenko@linux.intel.com>
References: <20251128185518.3989250-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make both handlers to be shorter and easier to understand.
While at it, unify their style.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
---
 drivers/spi/spi-microchip-core-spi.c | 31 +++++++++++-----------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 892f066f0074..98bf0e6cd00e 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -97,15 +97,12 @@ static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi, u32 fifo_max
 		       MCHP_CORESPI_STATUS_RXFIFO_EMPTY)
 			;
 
+		/* On TX-only transfers always perform a dummy read */
 		data = readb(spi->regs + MCHP_CORESPI_REG_RXDATA);
+		if (spi->rx_buf)
+			*spi->rx_buf++ = data;
 
 		spi->rx_len--;
-		if (!spi->rx_buf)
-			continue;
-
-		*spi->rx_buf = data;
-
-		spi->rx_buf++;
 	}
 }
 
@@ -127,23 +124,19 @@ static void mchp_corespi_disable_ints(struct mchp_corespi *spi)
 
 static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi, u32 fifo_max)
 {
-	int i = 0;
-
-	while ((i < fifo_max) &&
-	       !(readb(spi->regs + MCHP_CORESPI_REG_STAT) &
-		 MCHP_CORESPI_STATUS_TXFIFO_FULL)) {
-		u32 word;
-
-		word = spi->tx_buf ? *spi->tx_buf : 0xaa;
-		writeb(word, spi->regs + MCHP_CORESPI_REG_TXDATA);
+	for (int i = 0; i < fifo_max; i++) {
+		if (readb(spi->regs + MCHP_CORESPI_REG_STAT) &
+		    MCHP_CORESPI_STATUS_TXFIFO_FULL)
+			break;
 
+		/* On RX-only transfers always perform a dummy write */
 		if (spi->tx_buf)
-			spi->tx_buf++;
+			writeb(*spi->tx_buf++, spi->regs + MCHP_CORESPI_REG_TXDATA);
+		else
+			writeb(0xaa, spi->regs + MCHP_CORESPI_REG_TXDATA);
 
-		i++;
+		spi->tx_len--;
 	}
-
-	spi->tx_len -= i;
 }
 
 static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
-- 
2.50.1


