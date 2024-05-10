Return-Path: <linux-spi+bounces-2812-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207158C2B4A
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 22:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B410D1F25AB0
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 20:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD59B219FF;
	Fri, 10 May 2024 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VH1hnD/E"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B06502A4;
	Fri, 10 May 2024 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374197; cv=none; b=J1KwfbV1UK3vSvQ7X2HI+qI0M8FamDMwN/LtjGng2hvrGP2U1apscH5GEo+gB6npp79eEc2i8WkHo/KSm2rI9RxTQAvYSBdJdKV/Z64+/eI347cbUKujaIwaq0NyOUw24qAkdj8ByOLg+oDc3u2pBlQKevC44dNq7+iSQhkucuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374197; c=relaxed/simple;
	bh=Yoxu8R4D5J5wOW5Ijg3h7ziEYhdhvaInl9RinJXk/io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSY2oUKIW/8yT2h7UcSmzFl348tf6iE5lISJ+ERyR8S9ISOBZAl4g0VP/7dRqpy3zHxgG/OqXlThzcDB1NE88t798qdaTBKkBLAbRY+6LilOWs/Kry5RNaKhLSJ5R6+SGYKogdlYSldFDbirTqqXTtG4NNhHQCZyeAnUPtKPxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VH1hnD/E; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715374196; x=1746910196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yoxu8R4D5J5wOW5Ijg3h7ziEYhdhvaInl9RinJXk/io=;
  b=VH1hnD/ERE7f+BK4/jvHbKocIw/e9d9JEYPU+XlwqoX7LIrdlaVukcX3
   XTvmTyDkMfaXsHwGo+ERbdcAub28hbZVsaXnuFDrL4XS0l1DdeeJxfr9P
   jDrQq2IceAPimfvfd/B3Y3VZuvyFycwGUNnQQnIGvPcKQIHAs94qhU0H7
   sHj+/L67Jr2c0xVePHFo84rXT767i6R07WmN2YTGvIEqo0BTspMIAl4JX
   wETr0OTVTzaQZU8nDInardlRK37igR5O2h0AbzK7m4k1wPJ+nYQ6+x2B/
   T3LQ8gWekl85IJlWRXcUDgnDqoE33YnFHgZdOjSCUhnLTBIbEm02C+KVJ
   g==;
X-CSE-ConnectionGUID: jAfaQIF4RMqPkT445wR37g==
X-CSE-MsgGUID: LEBCyp7HSmSI0X+/5vZeMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="15208008"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15208008"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 13:49:56 -0700
X-CSE-ConnectionGUID: PMZnT4agQo+msyYF5DyFCA==
X-CSE-MsgGUID: aIxpdFNVSjORdayIO6dZzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30292540"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 10 May 2024 13:49:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 11E0B1AC; Fri, 10 May 2024 23:49:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Replace custom code with device_match_acpi_handle()
Date: Fri, 10 May 2024 23:49:52 +0300
Message-ID: <20240510204952.2582093-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since driver core provides a generic device_match_acpi_handle()
we may replace the custom code with it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ef0027b9cae5..b2efd4964f7c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2712,7 +2712,7 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 				return -ENODEV;
 
 			if (ctlr) {
-				if (ACPI_HANDLE(ctlr->dev.parent) != parent_handle)
+				if (!device_match_acpi_handle(ctlr->dev.parent, parent_handle))
 					return -ENODEV;
 			} else {
 				struct acpi_device *adev;
@@ -2811,7 +2811,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 
 	if (!lookup.max_speed_hz &&
 	    ACPI_SUCCESS(acpi_get_parent(adev->handle, &parent_handle)) &&
-	    ACPI_HANDLE(lookup.ctlr->dev.parent) == parent_handle) {
+	    device_match_acpi_handle(lookup.ctlr->dev.parent, parent_handle)) {
 		/* Apple does not use _CRS but nested devices for SPI slaves */
 		acpi_spi_parse_apple_properties(adev, &lookup);
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac


