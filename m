Return-Path: <linux-spi+bounces-2811-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D8C8C2B48
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 22:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849881F22DAC
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 20:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D2E45BEC;
	Fri, 10 May 2024 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuG6E/fO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE1FC0B;
	Fri, 10 May 2024 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374192; cv=none; b=UNvnpJJhRW54FUaugJTwi1cVpLC0OW7SgsE3NLc1j20Ng8IJXwEWMNUac9yE26He4AJW5qIGYqqKNI84ijqLtvIwhpOM2vWn2OGSAZkPt/rIQ5cPM07/6jC8GWkFvwyCEu7K+V7wi0zfgfVFur6RLIm/1WXoT0+SLnSkJS5l8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374192; c=relaxed/simple;
	bh=DjoTVfyC5WSEOMG6PqhyMYiCD5IbgfUCuXjFw0GOKgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NlY3H9fFj/yKtQvSi4YME6AeJeBs82cHQb2FL7sAtY+jTlNBTujbIAuUx2e5W+t3d5nsp4M5PAMyERSvlob9hKk66aPpyAU7E0YkrMudgA9QoGAqmu8jX3DhSKhmwbmrEb8L1e7KVK0Pj6K3m/NyMLvETyGYGv0tzjkhsAyTOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuG6E/fO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715374191; x=1746910191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DjoTVfyC5WSEOMG6PqhyMYiCD5IbgfUCuXjFw0GOKgg=;
  b=PuG6E/fOVIJhgaw/AabnCFO0bh7f76xI2mNSkG8O6Ygls/r8IG5WdC+O
   KB8Dq06F1CZyl4ZazE1ZozTteY0+zUoc1IO0CRhnb3UmJIQlqjmQZ/yMM
   JiFrveLMPgV53ajUIVm1doKaZKSFvVoNCV4kV4djmyTihZxKl+thQOLeP
   uDyHt8GxcdIZ5YtMr7vdhjwTF2XyDgSC1X5fbejGSDtn6Y9pZ5Y5bihv4
   ysNpR4hoWs86vRii8sfVs0zXwDwI277FTb+G7sxDPaShFZE03zbU8Pa6H
   dxFOYweXgPBbetys4GNNXx6Ewyzh91fgGuZjndF2u/VXwZn8jvDjQXr0o
   Q==;
X-CSE-ConnectionGUID: 6VfdvIWmRGyHpIakTXX4DA==
X-CSE-MsgGUID: mnxd1ouERsak+TOObA3j6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11227154"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11227154"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 13:49:50 -0700
X-CSE-ConnectionGUID: BShvMiHdQOyczc20M1dwJg==
X-CSE-MsgGUID: hIwmhA1VS0SJWFbOaAfG5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34404486"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 10 May 2024 13:49:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 11FBB1AC; Fri, 10 May 2024 23:49:46 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Refactor spi_stop_queue()
Date: Fri, 10 May 2024 23:49:45 +0300
Message-ID: <20240510204945.2581944-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refactoring makes code less verbose and easier to read.
Besides that the binary size is also reduced, which sounds
like a win-win case:

  add/remove: 0/1 grow/shrink: 2/2 up/down: 210/-226 (-16)
  Function                            old     new   delta
  spi_destroy_queue                    42     156    +114
  spi_controller_suspend              101     197     +96
  spi_unregister_controller           346     319     -27
  spi_register_controller            1834    1794     -40
  spi_stop_queue                      159       -    -159
  Total: Before=49230, After=49214, chg -0.03%

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 289feccca376..ef0027b9cae5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2207,11 +2207,8 @@ static int spi_start_queue(struct spi_controller *ctlr)
 
 static int spi_stop_queue(struct spi_controller *ctlr)
 {
+	unsigned int limit = 500;
 	unsigned long flags;
-	unsigned limit = 500;
-	int ret = 0;
-
-	spin_lock_irqsave(&ctlr->queue_lock, flags);
 
 	/*
 	 * This is a bit lame, but is optimized for the common execution path.
@@ -2219,20 +2216,18 @@ static int spi_stop_queue(struct spi_controller *ctlr)
 	 * execution path (pump_messages) would be required to call wake_up or
 	 * friends on every SPI message. Do this instead.
 	 */
-	while ((!list_empty(&ctlr->queue) || ctlr->busy) && limit--) {
+	do {
+		spin_lock_irqsave(&ctlr->queue_lock, flags);
+		if (list_empty(&ctlr->queue) && !ctlr->busy) {
+			ctlr->running = false;
+			spin_unlock_irqrestore(&ctlr->queue_lock, flags);
+			return 0;
+		}
 		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 		usleep_range(10000, 11000);
-		spin_lock_irqsave(&ctlr->queue_lock, flags);
-	}
+	} while (--limit);
 
-	if (!list_empty(&ctlr->queue) || ctlr->busy)
-		ret = -EBUSY;
-	else
-		ctlr->running = false;
-
-	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
-
-	return ret;
+	return -EBUSY;
 }
 
 static int spi_destroy_queue(struct spi_controller *ctlr)
-- 
2.43.0.rc1.1336.g36b5255a03ac


