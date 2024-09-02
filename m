Return-Path: <linux-spi+bounces-4502-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967759684B7
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 12:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0311AB23A65
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A1C13B5B7;
	Mon,  2 Sep 2024 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+KvHMF+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB613B5A1;
	Mon,  2 Sep 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273129; cv=none; b=t8e0Ius3JV2qVy67wxJD4XeiOeB+ulWWiu+A6Wwr6lP4zgW9z4B+A6TZD44dapoCGuzwDhBL6M9zRxkouDrw01sAI4SWJNFT+mjc8iAiuaAO5BQDAxPBTDRDLTocT7LXG37v9O9xcFYv16nMvt7aAbVll0H4BOccCDtAOapFIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273129; c=relaxed/simple;
	bh=jZjhEBU5FQog1FLUJFw1J2X/3FkPxfJViPZUcyhQ9dE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fsToTePCj8Yym19Vl3G2mJlU3+P0E/1Dqe7SwoJMu45fQe6uri1UH7t6i1UchUjKpWYUaW/yNsfX1rWQ8GWHHJPVH9Y1C42Kr6/RHETYv3ep+WIR4vjfIY8ls+h2IVJU67MIlPlDHy85s8mR3AHJ1SHIK78edDOr8/zF+WreqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+KvHMF+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725273129; x=1756809129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jZjhEBU5FQog1FLUJFw1J2X/3FkPxfJViPZUcyhQ9dE=;
  b=l+KvHMF+n3TeQ5N+QYt18i3hW3FGwi/EqZvFGBpuu938HZvaxZ9d7LwV
   DxBmA4zfbgY0/HAQEsVQE0E47C3NfR5+qWko8v9OiD7Qsqgoy1REnO+nJ
   DofdYjxrozCz2vYciuIbtJdVuVwlAGf1qMkVcvDeiFvGLtXP+bONRfchQ
   PI/3DaikZgMg1fkq8VeVgjrZxTgOcllpwU0mvCq2LhnlZ20l8Q+Ttd9X9
   QTx+/qLSSqBUS4WxyCdAcf+jnrDCSqbqpW/WXGjPFsT7hD7LZYLqAFO8Z
   LcLkjfnu+J+KrSRoeR8EuTrfqfKZYKItcEhJHAkkrL9N2HG53dkTkPfZ3
   g==;
X-CSE-ConnectionGUID: vaNxsOVDTJO6Rbn1Pi/f7w==
X-CSE-MsgGUID: LG38Nxk2Tc+fVTF8Y9xF9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="35213029"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="35213029"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:32:08 -0700
X-CSE-ConnectionGUID: iTIKuNVKTkO6479QdoWbzw==
X-CSE-MsgGUID: nxNBUj7rSfKus3M135zctg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="95377698"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 02 Sep 2024 03:32:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B3C95233; Mon, 02 Sep 2024 13:32:04 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: ppc4xx: Sort headers
Date: Mon,  2 Sep 2024 13:30:41 +0300
Message-ID: <20240902103203.2476576-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

As one of the recent patches showed exactly why this change is useful.
e3de1d8deb9f ("spi: spi-ppc4xx: Remove duplicate included header file linux/platform_device.h")

 drivers/spi/spi-ppc4xx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 2c43b498432f..4a64ea0f596f 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -20,21 +20,21 @@
  * during SPI transfers by setting max_speed_hz via the device tree.
  */
 
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
-#include <linux/wait.h>
-#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 
-#include <linux/io.h>
 #include <asm/dcr.h>
 #include <asm/dcr-regs.h>
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


