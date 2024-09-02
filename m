Return-Path: <linux-spi+bounces-4518-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF51C968DDB
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 20:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7D81C21E64
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814351A3A85;
	Mon,  2 Sep 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR0etx+j"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198CF1A3A80
	for <linux-spi@vger.kernel.org>; Mon,  2 Sep 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302827; cv=none; b=s4yjq03mri7jQDv7hclJY+Bl5bjtFyuFWzXEKQtnXY67aqPBdKu7ZtwUXGPSgyaVX4/E/KERP+sZnu3KnOaJ/FwbLal5OwpF1J9hQOSyfOIoPhPcHbc58UiBOngtwjoiF2YBqCgTTl8IDi3Z136HhPH0FRkySKaI3de+Z0UncNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302827; c=relaxed/simple;
	bh=WzfOorR9rs38oAivP64itob6zyXqvmm1O4LO6H46oV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B6iF6YdgnyslpD9Aynj12pigNY9o7/IFQSWBoSUzn2GFSYM9mOaEFn6mR6hMcKLG52FHMl0t9jZigToeI9C3ttVVuz+5NP3RUH3tpglL0/XkqYzXQx/em9Tyk9acU46fOkhedKSEyyIwiGsfLudyvjpwbqtWfvVjOaFBKg+pGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR0etx+j; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71431524f33so3607361b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Sep 2024 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302825; x=1725907625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RFBEQJFEz9rEcx4rFmzQZ/3g21L+K6TcjCrFH+Eq+lg=;
        b=CR0etx+jmCSdYQQT/+u5wQYuKKT2eURn+3frA/FBo3Mf8YJLAEHj/wSo2PZwzH9ocV
         ZbP9jzhyju3RTsrUbMew44h2TlW3kBPCYlP8me1ctQQQF47epGfCIJQ+YIj4vklGVKaq
         4McZAKAm48w4tybWZCygUC8JZLzJA9aUKC4LzzOo0qPjWspa9ea46mnJEswPWjDL6uJO
         lIoLv4gjpyJ/2nSP6grpWvT1pUiC8SXrwdUI3/FEdus4E1Y3GNbpXIrgBYutxxnbQBw7
         Rw45HCtZ9b55M0n1gPLOVa+IVETv/adwz4mxwvTDeN6XH3O7nFOIhNbEqgPf4LGdMOjE
         9S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302825; x=1725907625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFBEQJFEz9rEcx4rFmzQZ/3g21L+K6TcjCrFH+Eq+lg=;
        b=fNJbUMEgnU5LxuzNmzFSixqN/pUExHmFSQRCA32hNdb3lY0SVhACpqe89J2GSiFGt2
         YwQ47g+6SEGMcygvvQAfZIT82Itx3HYO1Dddvx/0rfbzexIpLvKxNDg+nL4cJ/BHzr/K
         hOgeV8FSJtLqdqYpbdnob/8R7E41Js1g//J4ttc3/vbb/4/jasDq14rKtjDM5ePlv69j
         9DPa0kJUKkVjqTRoFdKHrbSny8XRy7G4X56PkdCeOYp1zks6JUnzMECgQqDE1z0YCQjQ
         9KXIyPqD568SmTILoLKazL7gzgaaEc+ANnI/2NeDaRPFhSdjmiaZmUXy61jA+rSJxnGW
         53hA==
X-Gm-Message-State: AOJu0Yyvws4etZm5BAeeARfHdGcR2/0C5eTI4zkt4nc3F8qrd0hclRIu
	hdv/0Uo0qPdGtqk3qaQ9v04Na+hsko6ae+phcRkH3B7RNeBBx6N3
X-Google-Smtp-Source: AGHT+IHtnRBFXDrvQgD7xC6q9UmxqSgVyu2ctCsH7lePBEgC1U+NAvUiUCf+vjJSF0WH+ukAQi+EDA==
X-Received: by 2002:a05:6a21:6b0c:b0:1cc:d4a0:2675 with SMTP id adf61e73a8af0-1cecf49aeedmr9857455637.3.1725302825297;
        Mon, 02 Sep 2024 11:47:05 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9956:477a:b751:c148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576cc7sm7171228b3a.32.2024.09.02.11.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:47:04 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] spi: mxs: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
Date: Mon,  2 Sep 2024 15:46:55 -0300
Message-Id: <20240902184655.932699-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Replace SET_RUNTIME_PM_OPS()/SET SYSTEM_SLEEP_PM_OPS() with their modern
RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() alternatives.

The combined usage of pm_ptr() and RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
allows the compiler to evaluate if the runtime suspend/resume() functions
are used at build time or are simply dead code.

This allows removing the __maybe_unused annotations from the
suspend/resume() functions.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/spi/spi-mxs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 88cbe4f00cc3..3e341d1ff3b6 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -477,7 +477,7 @@ static int mxs_spi_runtime_resume(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused mxs_spi_suspend(struct device *dev)
+static int mxs_spi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
@@ -492,7 +492,7 @@ static int __maybe_unused mxs_spi_suspend(struct device *dev)
 		return 0;
 }
 
-static int __maybe_unused mxs_spi_resume(struct device *dev)
+static int mxs_spi_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
@@ -512,9 +512,8 @@ static int __maybe_unused mxs_spi_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops mxs_spi_pm = {
-	SET_RUNTIME_PM_OPS(mxs_spi_runtime_suspend,
-			   mxs_spi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(mxs_spi_suspend, mxs_spi_resume)
+	RUNTIME_PM_OPS(mxs_spi_runtime_suspend, mxs_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(mxs_spi_suspend, mxs_spi_resume)
 };
 
 static const struct of_device_id mxs_spi_dt_ids[] = {
@@ -662,7 +661,7 @@ static struct platform_driver mxs_spi_driver = {
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.of_match_table = mxs_spi_dt_ids,
-		.pm = &mxs_spi_pm,
+		.pm = pm_ptr(&mxs_spi_pm),
 	},
 };
 
-- 
2.34.1


