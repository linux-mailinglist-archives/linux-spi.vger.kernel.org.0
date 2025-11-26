Return-Path: <linux-spi+bounces-11560-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D07F2C88853
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CBC63531D8
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 07:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B00729E11D;
	Wed, 26 Nov 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyNfxT1+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450A28A1D5;
	Wed, 26 Nov 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143765; cv=none; b=gYOVg8wwzxlq1d3P80gRgtZZcjCUtFzMVTezxM6hJQX4air1HnM5nmkJTOTDlDNu1X0FUKn9U5cR3iBk9S7dD07y+MheIz8GsXDifiS+zRMHhIFuAgRm3hqktN4jqTGd0dlXt9SAG/sPu2Mtf1t+c37y4TxKwqMZIZfL38Ixpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143765; c=relaxed/simple;
	bh=GytgTS3doh0clrn2XZQYNItYbD2H3EB7QTcmYQEHqbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px/IfEOUIUuOgWaLLr5YE8B5Kd9UyuinIdqeGhA3X6ZSHqo0h8uqBLAGavcBwAn57bQ1be8kWCzpPS5nQQh6vtipZOTlnNuOcvdSYs/xXXu5xixqaR4X+spt13Zh/ltDoGGcRLv3GuW5Jmt3yzyTeFJvMw/RX0wGLYao/rdQfi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyNfxT1+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764143763; x=1795679763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GytgTS3doh0clrn2XZQYNItYbD2H3EB7QTcmYQEHqbM=;
  b=dyNfxT1+4v7IYxAbd3K7CpB7JTtTIjJ/X9+YpuXqppznlMCPFBcPdp27
   8eb3m5Gmjh7k2INA0gmfEAu1LdIAggQGW0thXM0pPFCCeU/ODM2VhqxIf
   wX9T2Q1ft3Z53AuMXYDoCXswh9TDwUeAY5Pt1HSG4hY4PjH40rgUIYJiA
   5b6nldoqD3pkeP1Kos/bBtH2OPE/gAvgJJMnKKD7uqGSRNbg5p2iiiP6l
   8vxLosRzfOkpZi22YSG2/jCDd64LOG2NebC6fezpJtsEaKew/8XvMfwxn
   3rzp6c2MncAixiqGJXRcVg/o1wWP9WHOK5T0MePuBYyuQzrdxQHmmeyiU
   A==;
X-CSE-ConnectionGUID: cX9okra/Spm7g1zU8M8Ozg==
X-CSE-MsgGUID: hkuKTrgKTkaOUIY/hImobQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="77538900"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="77538900"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:56:03 -0800
X-CSE-ConnectionGUID: G5alzGODRG6q1VJNr1ylMg==
X-CSE-MsgGUID: tAWbd/pUSJWyHGkLlhDxbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="197026110"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2025 23:56:02 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 202F1A2; Wed, 26 Nov 2025 08:56:00 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/6] spi: microchip-core: Refactor FIFO read and write handlers
Date: Wed, 26 Nov 2025 08:54:40 +0100
Message-ID: <20251126075558.2035012-3-andriy.shevchenko@linux.intel.com>
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

Make both handlers to be shorter and easier to understand.
While at it, unify their style.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 32 +++++++++-------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 08ccdc5f0cc9..f8184b711272 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -91,21 +91,14 @@ static inline void mchp_corespi_disable(struct mchp_corespi *spi)
 static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi, u32 fifo_max)
 {
 	for (int i = 0; i < fifo_max; i++) {
-		u32 data;
-
 		while (readb(spi->regs + MCHP_CORESPI_REG_STAT) &
 		       MCHP_CORESPI_STATUS_RXFIFO_EMPTY)
 			;
 
-		data = readb(spi->regs + MCHP_CORESPI_REG_RXDATA);
+		if (spi->rx_buf)
+			*spi->rx_buf++ = readb(spi->regs + MCHP_CORESPI_REG_RXDATA);
 
 		spi->rx_len--;
-		if (!spi->rx_buf)
-			continue;
-
-		*spi->rx_buf = data;
-
-		spi->rx_buf++;
 	}
 }
 
@@ -127,23 +120,18 @@ static void mchp_corespi_disable_ints(struct mchp_corespi *spi)
 
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


