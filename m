Return-Path: <linux-spi+bounces-959-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF888457D5
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 13:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2198A290A12
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619F85336C;
	Thu,  1 Feb 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbF5FggV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DA4D9E9
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790404; cv=none; b=ikXSejssDFfTjG12SUUyVLYXlG+Gee6k+hmq4Xgub8YiyciIw1TCc4hYEQjn0rERRxUH1Baus6XjY1oSOzsREBVKQYiADu+38ACmlrejmy+LmUQVHbHKf7OWVNo3qm3pkVaMVB3Fe5Ds9dGYNPGNXvnrCZg0Ke/HEx06K7tDqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790404; c=relaxed/simple;
	bh=xraGH4JiHqqeifFwFpjowniy0szVghPGxtGzll+Ui/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIUHferGSB8m7rEm4BjlIbBQZKcqfwFL9jucfyzH6CjUZV3jHHCyhawuYfnbhg16zkTJrncKoSyRRd4QVmhkqvBEF4bqXO618o2AwUeu6g9EeRiaISQSlLvFt8gu5yYxEg1gA3K1s8/hvdhZ2IFNh/QawsJROsipppjzD00LG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbF5FggV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790403; x=1738326403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xraGH4JiHqqeifFwFpjowniy0szVghPGxtGzll+Ui/A=;
  b=hbF5FggVXXmvY7wuLjmLQDMv3Lr2fA6yYUU+D+MKISldYLB7k4KUgREh
   3wkvqFAiVLkkpOvngkcbnTWYeY8tad6s4/jphVgaU/xk9RGxlzmasClqz
   fP9HUjEDaHyvKhPoSm8ff7zbaCaFIJ1vI1ASvztLMvUoK9wqkALBXoT8j
   9Ck4TacRUI2zMOQ02mXXqrzOUXMGOkJGHfiDvpDn46gO2aW0pTSImDUsw
   f4Hthl0RhNE0IrEi9XmfmwByKkC6dH2P4lt1SWbOoaOqVa9vyPqPLido3
   5D1RV6f2RFM9HM6UB7SAJx1WKE5i1ZuSM7u/f797zWaenpuYkd8FmcUze
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10982175"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10982175"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:26:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="908237684"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="908237684"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2024 04:26:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 283B08EA; Thu,  1 Feb 2024 14:16:39 +0200 (EET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi: intel: Keep the BIOS partition inside the first chip
Date: Thu,  1 Feb 2024 14:16:38 +0200
Message-ID: <20240201121638.207632-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201121638.207632-1-mika.westerberg@linux.intel.com>
References: <20240201121638.207632-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there are two flash chips connected flash regions can refer to the
second chip too. In this case we may see the following warning:

  mtd: partition "BIOS" extends beyond the end of device "0000:00:1f.5" --
  	size truncated to 0x400000

For this reason, check the BIOS partition size against the chip size and
make sure it stays within the that.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 467d39bf00b4..3e5dcf2b3c8a 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -1254,6 +1254,13 @@ static void intel_spi_fill_partition(struct intel_spi *ispi,
 		if (end > part->size)
 			part->size = end;
 	}
+
+	/*
+	 * Regions can refer to the second chip too so in this case we
+	 * just make the BIOS partition to occupy the whole chip.
+	 */
+	if (ispi->chip0_size && part->size > ispi->chip0_size)
+		part->size = MTDPART_SIZ_FULL;
 }
 
 static int intel_spi_read_desc(struct intel_spi *ispi)
@@ -1350,6 +1357,10 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
 	struct spi_board_info chip;
 	int ret;
 
+	ret = intel_spi_read_desc(ispi);
+	if (ret)
+		return ret;
+
 	pdata = devm_kzalloc(ispi->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -1369,10 +1380,6 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
 	if (!spi_new_device(ispi->host, &chip))
 		return -ENODEV;
 
-	ret = intel_spi_read_desc(ispi);
-	if (ret)
-		return ret;
-
 	/* Add the second chip if present */
 	if (ispi->host->num_chipselect < 2)
 		return 0;
-- 
2.43.0


