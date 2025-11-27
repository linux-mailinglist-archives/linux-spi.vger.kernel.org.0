Return-Path: <linux-spi+bounces-11636-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C4BC8FF65
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 20:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0743ABD77
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A627303A27;
	Thu, 27 Nov 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnsaBVEw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448133019D9;
	Thu, 27 Nov 2025 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270039; cv=none; b=OGgj1x4y0+/GjJ91cvwZxELtbyQXuNiYMwNiOOpnqK2fiu49ozjMAb16ejnos2MAfZv43FREXuBLROPZg3v22wX8AHqwrxHsYSd14Pk8O8upKI7/CzC91J7TqdhkMSVJGhgsK5BpplF1ZMR9yUx/Kw6vWLJK4Kk3q0L9W8EXY4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270039; c=relaxed/simple;
	bh=gzhFPNW1rSQDFFo/j0rgc+ix95rNKLoLSvWot7esoxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4Bfi33lpr2Uorua57g7d/a5DfI2GVNCVzqdGJ+GK3Wnml5hSh1l6RV2PtpSKJACi/h2kaBw84bL7nTJUyozJ4zOk+EOwoADC6bOKJs3REjiZo5zdmHJToAsHTYypGK6N9hlJRTPehrAlaRScS4QOBKSDQ2WXz42YySy/PJInys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnsaBVEw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764270037; x=1795806037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gzhFPNW1rSQDFFo/j0rgc+ix95rNKLoLSvWot7esoxI=;
  b=nnsaBVEw7PmgucoC/btuot9VbyZBdmNuFJ5ODtYHITql7X9awSgwqJJw
   aHQfPFZnES4qqMwIILGvNQIdRevarUQenNT213b1AtV2m6fbtzgoSj5Fx
   jiUOfJFP9vpJwNiEp7ZXKG9Hufm5YKW+DQ4+y9Kt602Z00zPEqZqoEHn/
   uJ4TcW6bt1uv/I5yMt+4SCzsSn7LZPVDnTzQnVPpgdJ1TbS5OtncdIot1
   qtAIWs2NHR39V8FdkQxwVA8VLlTLcVyPK1GEK+RYOe5QviPQigzVieQFO
   HL8OC2IITCxhu52QWAfHGD0BIm3mqOJ70dgCH9EuqQeklaT6MUbsi1F4R
   g==;
X-CSE-ConnectionGUID: J0R9QHwWSfuE21hNlWj5qQ==
X-CSE-MsgGUID: ETDXQRcTRvWSjngZ7eP8/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="91796260"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="91796260"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:00:35 -0800
X-CSE-ConnectionGUID: hmGdEsekTiGWAs596F1ERw==
X-CSE-MsgGUID: 0g/OAAjkSX6gWgg7I5k90A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="216645899"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2025 11:00:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3D67DA1; Thu, 27 Nov 2025 20:00:32 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 2/6] spi: microchip-core: Refactor FIFO read and write handlers
Date: Thu, 27 Nov 2025 19:58:59 +0100
Message-ID: <20251127190031.2998705-3-andriy.shevchenko@linux.intel.com>
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

Make both handlers to be shorter and easier to understand.
While at it, unify their style.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 31 +++++++++++-----------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 08ccdc5f0cc9..439745a36f9c 100644
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


