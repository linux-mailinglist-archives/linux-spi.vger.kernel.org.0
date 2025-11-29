Return-Path: <linux-spi+bounces-11666-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C2CC9406F
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 16:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5149434685C
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568317A30A;
	Sat, 29 Nov 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l++vZusx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF2636B;
	Sat, 29 Nov 2025 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764428829; cv=none; b=KCNqMtDHzA7LK7PfylrjpGfWmuDYA3AWmrGk50+jvss+PcdA05Sswfgs14Oxdqg2Ht9Wm9QmZioawt1Wl+r+vN+d2VHPqnY0hcLtmAjauV5SxmWHx+3P0JkfMcazcShGQHfb90m8As7AtMpimqsuVtPPRUj4w2QCyVku4fo/QkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764428829; c=relaxed/simple;
	bh=coO62zeWjlHcq9EHe4yL2z0FLBsPVU8osPD+nqHLLPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLgvJkd2mJpx36NuJT5UREfAK7Jqk6xZJ/8MVdccR8f2tChZgDfURoFaHC0o/FFW1X66IPYAJQu5dLUKnJhZ691fYcc+KgALnFlAHL1WAkykgba1Ock5omU7iJlfTFv5XBA3LqLuNCoHvhxQhzxAGk9k31uHZ8fb3qRFxbo22pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l++vZusx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764428828; x=1795964828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=coO62zeWjlHcq9EHe4yL2z0FLBsPVU8osPD+nqHLLPk=;
  b=l++vZusxwGfkUqeJGR37kiRNqMLZRgqdfMBxfEwGj6JvBFqSxygtp8II
   685gs1giyyhGRd/l3DGyZTL7bbQRR3yLOyshq1HgorBnHPGCow33MP916
   8WLxL6WDuioBON+VM3cdQ/CaQjarf2pOOYMJljTtIzUZ6uyt3uyOxnT5w
   Sh48uSElk15Imn9NGLqLFk9CeoDAMJeeWaGd369qnYCj4Bvo8WDEAi0t+
   SCYu/oqSQlAaO//V3XT4IMSzB7j4agb0yL+AlhP0v9VKLUGOiKO2CbAdZ
   2v6edNZIGVOQYShh9N6VrkZTLa8bjh3flGurXztuqaG02F07j6rqHVSAn
   A==;
X-CSE-ConnectionGUID: Jhyxw0gXSJmQ0e5A14QorQ==
X-CSE-MsgGUID: SZFwrgKQRda/qvdoICCpDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="66375315"
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="66375315"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 07:07:07 -0800
X-CSE-ConnectionGUID: QGHYK9mcR8yCVORZgjbh3A==
X-CSE-MsgGUID: ZQupdNL3R6Wo2Cf3uGJooA==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 29 Nov 2025 07:07:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1738993; Sat, 29 Nov 2025 16:07:05 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/1] spi: cadence-xspi: Replace OF/ACPI specifics by agnostic APIs
Date: Sat, 29 Nov 2025 16:07:04 +0100
Message-ID: <20251129150704.3998301-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace OF/ACPI specific call to get matched driver data with
the agnostic one. This doesn't change functionality. While at
it, add missing property.h include, and drop now unneeded of.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-cadence-xspi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index f2557fb7d5e5..3fc5d8e37a9e 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -12,9 +12,9 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/bitfield.h>
@@ -1157,12 +1157,9 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		SPI_MODE_0  | SPI_MODE_3;
 
 	cdns_xspi = spi_controller_get_devdata(host);
-	cdns_xspi->driver_data = of_device_get_match_data(dev);
-	if (!cdns_xspi->driver_data) {
-		cdns_xspi->driver_data = acpi_device_get_match_data(dev);
-		if (!cdns_xspi->driver_data)
-			return -ENODEV;
-	}
+	cdns_xspi->driver_data = device_get_match_data(dev);
+	if (!cdns_xspi->driver_data)
+		return -ENODEV;
 
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		host->mem_ops = &marvell_xspi_mem_ops;
-- 
2.50.1


