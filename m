Return-Path: <linux-spi+bounces-4188-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1BB951D94
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 16:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC47290BB0
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0561B32CB;
	Wed, 14 Aug 2024 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ob9Smt2F"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979B1B0120;
	Wed, 14 Aug 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646732; cv=none; b=drTbofh477PqTi1zcyNEhAFuBtePTtGsKoHv7n6C0NlNbU0vsbhxujR1bpWU5GXH+chWnNUPiGNaT++LiAPWqgsOatqsrmMX9u03OAXLdUA5t2Ys5UKH/4SUq9AbLgbEOnIxE2RolW0TuBTTLYUvuq/JbvpzsV92pfu502GTLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646732; c=relaxed/simple;
	bh=YvR2oqXHk/mwMfoEylXWNm2Mg/DFzBQEIoh8OjNQAqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AoDhf8b0VRI0vSMIH1169Xtz2GjxgO05MPg3z1gKBqLII1Yy6OIi2TraHkH/BswYqrmWGfdhSieiy61rgKzilfGuicO9mrDQR57X43C5t2GMNeAm09ypwp3j064osKk2SVi0Oy+H80AUMdPD2mteR4dug3tCJoA47BJ3/200MFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ob9Smt2F; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723646731; x=1755182731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YvR2oqXHk/mwMfoEylXWNm2Mg/DFzBQEIoh8OjNQAqc=;
  b=Ob9Smt2FA2pFXBX/yMh07NoIZ+VlnuMJ/4sthB+o8LLJhxsuB8QsIW7F
   +QI/2djodXUo8XlNhcM0QOIVnc9OceVZ93pDJSGKt15SwydLUJOeJQMRi
   KfuR6XuuiDVLg/pfNl1TEEPAomd4jY8YjEFab6c12WqxXcM5m+yZwhn8h
   HUNsYeDW4RbJ38+8VkXVTrB9As7RfthghEhsn4pEommvidfycFy+hvZB8
   Sd2e/vO7TNR9pITDPaJ6GgjyvkAEj59/2mdDGlclLE5SictVi+yhugqJi
   yQ74fLkWmJctACpHZGCAoWC+OM7D4zpkel/KD6BsHyuu5sM/LAqcaJmwc
   Q==;
X-CSE-ConnectionGUID: F/jA5Rs8ToK0XvDzayMfCQ==
X-CSE-MsgGUID: m4CooVLAR5KPDfqFa8K6Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="47271630"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="47271630"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 07:45:30 -0700
X-CSE-ConnectionGUID: K/T4QkfGR1qlWvN8rtGl9A==
X-CSE-MsgGUID: gl8bKR8RSuuwpNjDeCK/wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59037520"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 14 Aug 2024 07:45:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 070F617F; Wed, 14 Aug 2024 17:45:26 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ
Date: Wed, 14 Aug 2024 17:45:12 +0300
Message-ID: <20240814144525.2648450-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

0 is incorrect error code when failed to parse and map IRQ.
Replace OF specific old API for IRQ retrieval with a generic
one to fix this issue.

Fixes: 0f245463b01e ("spi: ppc4xx: handle irq_of_parse_and_map() errors")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: returned correct error code
 drivers/spi/spi-ppc4xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 01fdecbf132d..8f6309f32de0 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -27,7 +27,6 @@
 #include <linux/wait.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -412,9 +411,10 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	}
 
 	/* Request IRQ */
-	hw->irqnum = irq_of_parse_and_map(np, 0);
-	if (hw->irqnum <= 0)
+	ret = platform_get_irq(op, 0);
+	if (ret < 0)
 		goto free_host;
+	hw->irqnum = ret;
 
 	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
 			  0, "spi_ppc4xx_of", (void *)hw);
-- 
2.43.0.rc1.1336.g36b5255a03ac


