Return-Path: <linux-spi+bounces-7111-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFF7A5F21D
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 12:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFB818895B8
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0E42661B9;
	Thu, 13 Mar 2025 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfKOpkIQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93C2661A4;
	Thu, 13 Mar 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864471; cv=none; b=J55WqyTn+cRn5+kLIOdbD5WuLBId9W0Z5ch1NDXmDzNNCGAtEyXs1KE88zTtuGZHYOfs9pDGHXwbwu4d03vJfjlwa2wecsO+8B3z4EbCzDtG1dWGuNdchDDQs2PAB3gjrQDAQNa3JAFWBewZoFYq0RkJZwmWuABHMPrI7gmfO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864471; c=relaxed/simple;
	bh=M99MqaY4yNuVRH4i9/ODrD8N6kgXiULLiUX1+DNTxns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMWnYU2JPs+0wcikP82L+RB9n5Y4I/hlvV9gKQ3CdswUpKeIsd7HfGn86F5JLtshWwl2l2v/+rYjtesokPEy8nbncO/DFCfzHcRRVlpu7ToN0R/cGnG++7VDDQE9PEaqfq/035yLgqm1cvvIlKYlrT0xQttoOruZituj9dTdOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfKOpkIQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741864470; x=1773400470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M99MqaY4yNuVRH4i9/ODrD8N6kgXiULLiUX1+DNTxns=;
  b=NfKOpkIQ3vo8iyCwLXBrcRqbp0FgbkcJEZc+DbEs0Yo3BfgWXrpUKpBw
   vLBRSxOsbBU1hLBXVggwPu0Un3a4Ep3yJhU/ZM9zaSYZlJlOC2dU3vTBv
   gZ94vaFyfzV8Jmkz22lGF1l58ouJKh/0lFyI5Gmmn+v0vpNsZ7usiBJGG
   R4iV9I6SxLyUl0v4MHhsch1g4GPeUSXJnq45xsw3/3K4FrzoRqWgGmnKP
   LOqE6TAZ6vHvXz2ilhg+LvSO1cXB0CWNh/reN0oV1ry19CSzDJExC3Jwi
   lEKKsRfCx3sngYaaZqKkzps5Veg2h3fIODDaSykTYl0yxHFZuqdSzuKg3
   Q==;
X-CSE-ConnectionGUID: kGi8IDPPQoC+rjBBv7Za/w==
X-CSE-MsgGUID: AL77EU65Q1OrL0GEwH1goQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="45746789"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="45746789"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:14:29 -0700
X-CSE-ConnectionGUID: iuwatj5xRFWLNo0zude5MQ==
X-CSE-MsgGUID: 6oQlyuJiQdayGOK0Ke603A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120719231"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 13 Mar 2025 04:14:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 010E326A; Thu, 13 Mar 2025 13:14:26 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Longbin Li <looong.bin@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/2] spi: sg2044-nor: Convert to dev_err_probe()
Date: Thu, 13 Mar 2025 13:13:00 +0200
Message-ID: <20250313111423.322775-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313111423.322775-1-andriy.shevchenko@linux.intel.com>
References: <20250313111423.322775-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the cases in sg2044_spifmc_probe() may be converted to use
dev_err_probe(). Do it.

While at it, use local device pointer in all such calls and drop
unneeded __func__ parameter as dev_err_probe() is assumed to be called
only during probe phase.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-sg2044-nor.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index 95822f2fc521..d3582c84538e 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -439,9 +439,7 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 
 	spifmc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(spifmc->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(spifmc->clk),
-				     "%s: Cannot get and enable AHB clock\n",
-				     __func__);
+		return dev_err_probe(dev, PTR_ERR(spifmc->clk), "Cannot get and enable AHB clock\n");
 
 	spifmc->dev = &pdev->dev;
 	spifmc->ctrl = ctrl;
@@ -465,10 +463,8 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 	sg2044_spifmc_init_reg(spifmc);
 
 	ret = devm_spi_register_controller(&pdev->dev, ctrl);
-	if (ret) {
-		dev_err(&pdev->dev, "spi_register_controller failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "spi_register_controller failed\n");
 
 	return 0;
 }
-- 
2.47.2


