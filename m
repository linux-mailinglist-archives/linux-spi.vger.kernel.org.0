Return-Path: <linux-spi+bounces-11537-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC64C86FCB
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 21:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FC33B4CC5
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F3233C508;
	Tue, 25 Nov 2025 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jxe3WLUk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F133B96B;
	Tue, 25 Nov 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101829; cv=none; b=YWEnxAPzfIFQaMvBodpwMI8CuRDZawZtc2ZCEX+G6nloxL2P1HrG5GWIVMOETaO/tIbc1JZzRd8/xbj0Wp3EUml+/zV6iFAEpNXHTYWkDNYR4diDcAQEjRnpgdhYo6hUOZHw3npF+uq6IB3AQ4C3MHwhYx0txjUOjL8hcFxE2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101829; c=relaxed/simple;
	bh=umfO1LiVv+7gw2Cmc/AtbcmBkYzpnzSS8hN3J7X+x1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMqT7uWovYzlcxZJ5AHEW21XWshm/pbIdjjcA+T0rplu7bRt5ibeIQHpijnMlJOTKtZWELVD9lmU3mnV4sZ7HLXAXw65XAdLmzFMOX5G3vqNbxm2mrGcZ0nlROO7hixVZkJUZuJaStJSAI7ljM/h45QbIf6WnmBq1TPZNR3GhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jxe3WLUk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764101828; x=1795637828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=umfO1LiVv+7gw2Cmc/AtbcmBkYzpnzSS8hN3J7X+x1k=;
  b=Jxe3WLUkva7ifL/ncrrgwuueSG6NkhAc8i7E2A74Q2syhhj1HNEBk2Nv
   nq8wFFyvoImz8fbiit1dztK7fi3EXqy9uE/RAQsMNMQsPkAb+Ak8FQ2Mv
   VeMQ4AlS4Bdp1KbeLpfBreOUMBgOMS+RZTf2ViqEjmglyKQI2aQa/z61O
   h2Bw4wSsYAh5Z4nTNSer6Du6tZ9qQQR3dFg5zI6xvfM8QjHJm+YZZRNLQ
   Oj3PC355LypHiDhMgr+3hkG0oIgaEcvu0A2L+vL+wDR/XrQX5ZIrOeH0n
   i6t20ujs+FW/J19+2kV0OH0LZv9L91+DNE6VIVXeTsXLhZKFkkP5UAmV+
   Q==;
X-CSE-ConnectionGUID: g1pS5U7CTGypQ+8nWfFOZg==
X-CSE-MsgGUID: VT6nhlWuR5iVzAsA+2Lt8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="53699530"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="53699530"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:17:05 -0800
X-CSE-ConnectionGUID: 62zhrn+kQaGa18s8dCHFOQ==
X-CSE-MsgGUID: IVWWzyzaQPCs8s6RG3X/gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="192836171"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 25 Nov 2025 12:17:03 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4F424A3; Tue, 25 Nov 2025 21:17:02 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/7] spi: microchip-core: Refactor FIFO read and write handlers
Date: Tue, 25 Nov 2025 21:15:33 +0100
Message-ID: <20251125201700.1901959-4-andriy.shevchenko@linux.intel.com>
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

Make both handlers to be shorter and easier to understand.
While at it, unify their style.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 32 +++++++++-------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index d2d1e86568a3..9620aa886912 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -92,21 +92,14 @@ static inline void mchp_corespi_disable(struct mchp_corespi *spi)
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
 
@@ -128,23 +121,18 @@ static void mchp_corespi_disable_ints(struct mchp_corespi *spi)
 
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


