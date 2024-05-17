Return-Path: <linux-spi+bounces-2937-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E53128C8D13
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1454E1C2310D
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1401428E0;
	Fri, 17 May 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwvGRjHG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9661422A4;
	Fri, 17 May 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975634; cv=none; b=ENUSZSLMUztPDvj0Yr9I+VnWd8lyaD8+MqE41JZvclILhEGdspEza5ZCnm4RwGZ8q/jw7SqRELe+YqRD4GluAo7C/mq99UoV5O7CgeqBVj+WfIeazBx2iLDxgWtzo/rSw8/7t8u+Rny7EcRiw4Iphperg1aiUSzRySI4tTjGb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975634; c=relaxed/simple;
	bh=y0fN4jjiP8CI1asO2p9oSxaF0MzR6arWo4rn+6QIULI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itblkTHLy/Ebh6Kn4T/FGc0Df9DhnSWcyUXH9FQwJOnDtwwaYU2z9Yft/0Quulmd1f39wpjOufTzhQZ3TCsVbPbHzrrC89LBJoBbMo0cqbVcGQdcSanVcVA5ABhnQJZX/CoXI0J7MnYYbNTnsYAJxZMzQ0G+lOXyEOIW0tOFjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwvGRjHG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715975633; x=1747511633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y0fN4jjiP8CI1asO2p9oSxaF0MzR6arWo4rn+6QIULI=;
  b=RwvGRjHGgiw/tu+QPvI5IKtewo67YGbMhGg40JVd98TcIS+bdBnFKuPZ
   5SRRyvLxZQV0RrxHpyHmtE7sM0B3HaINS29nq6qDA79vSx8sXg8Iu0SkV
   gP2kxEi92Fo6bqurHLpnyCsiPvztVzWfWK9cfaFpbgg+8L625Ibl56RB4
   8M8RR3vT0UH+MxPrQS5KvLeL6z3sghwBKE+lfcDD6MncuFIFzS/Qz6KrU
   bvyVzYUHvQQ6svFpAuQOfUDWyFYj9YDXIw78RpFP27uA2LGOVrOjzPzJT
   kAeepbZQh1CeBeGiV6RdSUyMmZmEMKdfw9SvyejQu23+2rwXtkllZqj+2
   w==;
X-CSE-ConnectionGUID: jfCCpSd2Ts2JWp4IoqElzw==
X-CSE-MsgGUID: Ni+KzhoESdyBFNa/uBl8+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12348679"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12348679"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:53:52 -0700
X-CSE-ConnectionGUID: cp0OGmhWSwOiPsy7hw7/TA==
X-CSE-MsgGUID: 44wEwEV0SbmoZyp3eCNvrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31915017"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 May 2024 12:53:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 665A455A; Fri, 17 May 2024 22:53:45 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 07/10] spi: pxa2xx: Remove superflous check for Intel Atom SoCs
Date: Fri, 17 May 2024 22:47:41 +0300
Message-ID: <20240517195344.813032-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240517195344.813032-1-andriy.shevchenko@linux.intel.com>
References: <20240517195344.813032-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxa2xx_spi_fw_translate_cs() checks for the ACPI companion device
presence along with the SSP type. But the SSP type is uniquely
determines the case. Hence remove the superflous check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index cd28b798b53b..3ea4b9821a8e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1371,23 +1371,19 @@ static int pxa2xx_spi_fw_translate_cs(struct spi_controller *controller,
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
-	if (has_acpi_companion(drv_data->ssp->dev)) {
-		switch (drv_data->ssp_type) {
-		/*
-		 * For Atoms the ACPI DeviceSelection used by the Windows
-		 * driver starts from 1 instead of 0 so translate it here
-		 * to match what Linux expects.
-		 */
-		case LPSS_BYT_SSP:
-		case LPSS_BSW_SSP:
-			return cs - 1;
+	switch (drv_data->ssp_type) {
+	/*
+	 * For some of Intel Atoms the ACPI DeviceSelection used by the Windows
+	 * driver starts from 1 instead of 0 so translate it here to match what
+	 * Linux expects.
+	 */
+	case LPSS_BYT_SSP:
+	case LPSS_BSW_SSP:
+		return cs - 1;
 
-		default:
-			break;
-		}
+	default:
+		return cs;
 	}
-
-	return cs;
 }
 
 static size_t pxa2xx_spi_max_dma_transfer_size(struct spi_device *spi)
-- 
2.43.0.rc1.1336.g36b5255a03ac


