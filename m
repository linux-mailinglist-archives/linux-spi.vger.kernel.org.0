Return-Path: <linux-spi+bounces-3145-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9048D4EBC
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFC8285FC7
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E317F517;
	Thu, 30 May 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5O0iuE4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1292F186E38;
	Thu, 30 May 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081884; cv=none; b=LqNU0Cnrt1Dd/q9jXIfbRYEi8qR13uYZn4qrGLE2EyqR0biT9u5SOPY+fmT/VrNUYdKtQRnto/P8dj5RsIddgRFGhT3fK/f9w5D2fzuwlsrYMlhAVircTcE7yMp862GmVBwpELd1Ylvqa5FzBMS1k+RCbZUtNxU+EpQ61VmSPZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081884; c=relaxed/simple;
	bh=TQxj52QzB21T4oND+oGj5zj9iueR9JjcCvK8NiCC4XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzRAWMn07wZmKdHiJZIve5OyWm/NVleZTDt1hDof4rJxkX4oOQieib1sePRDs6jFbbKiZarT84QJfwlCM+AixsUjFyRne51sD73mU23rFDSLZ+QVkgBy96eSmG4ryTxgEJlwQOfyChdCD/0I9Z0Vwlm2bJ9uh4skq7dFCDz8zd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5O0iuE4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081883; x=1748617883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQxj52QzB21T4oND+oGj5zj9iueR9JjcCvK8NiCC4XM=;
  b=d5O0iuE4HOdEdVLfK7uYrohyvYml5731JHTwX70KjtnMlrJTmp20u53x
   6vqcGd+JMGRjdmyDmUt7u6y5EHwpu1VhEogHNWZqt/BBhG6+FuE7btdwp
   Vr651/wU9CTrGsWbBDLaVzIIgYHmZC98W71JzLts11ZBigyc1rmA+CUp+
   FYqZ1lRWfSzbCWY8G3EUMWF4Sdrb6TZzX+nHIscbDMxyeFwUgcrNgJ3Bo
   NBdGfE+jO70Xkos7w7fujoEu7Jv4GG/sy91DxTp5LcoriS9lrhREDRUY9
   QURNilHH+Ng/6NwGoZb6KWbtyNx6IH1sLD2B7uvb86uZiSYEcHzXuVks4
   Q==;
X-CSE-ConnectionGUID: 9ObHPrdaS8KW6hufCLRqBw==
X-CSE-MsgGUID: U9FPRV6MS3GcPsidT5PYzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31093031"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31093031"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:22 -0700
X-CSE-ConnectionGUID: /FZZb/pJSWy8TGVnqxXSMA==
X-CSE-MsgGUID: XT/+hSA9QyKUq3odAWBusg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="40288501"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 30 May 2024 08:11:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3D9C44DE; Thu, 30 May 2024 18:11:19 +0300 (EEST)
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
Subject: [PATCH v2 03/11] spi: pxa2xx: Remove no more needed driver data
Date: Thu, 30 May 2024 18:09:59 +0300
Message-ID: <20240530151117.1130792-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240530151117.1130792-1-andriy.shevchenko@linux.intel.com>
References: <20240530151117.1130792-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the ACPI enumerated devices provide a property with SSP type,
there is no more necessity to bear the copy of them in the ID table.
Drop the driver data in ACPI ID table.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f4dc113768cd..b62a613378e0 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1718,12 +1718,12 @@ static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
 };
 
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
-	{ "80860F0E", LPSS_BYT_SSP },
-	{ "8086228E", LPSS_BSW_SSP },
-	{ "INT33C0", LPSS_LPT_SSP },
-	{ "INT33C1", LPSS_LPT_SSP },
-	{ "INT3430", LPSS_LPT_SSP },
-	{ "INT3431", LPSS_LPT_SSP },
+	{ "80860F0E" },
+	{ "8086228E" },
+	{ "INT33C0" },
+	{ "INT33C1" },
+	{ "INT3430" },
+	{ "INT3431" },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
-- 
2.43.0.rc1.1336.g36b5255a03ac


