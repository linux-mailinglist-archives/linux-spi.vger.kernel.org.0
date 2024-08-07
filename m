Return-Path: <linux-spi+bounces-4150-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDC694B066
	for <lists+linux-spi@lfdr.de>; Wed,  7 Aug 2024 21:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27601C20E4F
	for <lists+linux-spi@lfdr.de>; Wed,  7 Aug 2024 19:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA33413CA95;
	Wed,  7 Aug 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALTd9NRF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249E1097B
	for <linux-spi@vger.kernel.org>; Wed,  7 Aug 2024 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723058377; cv=none; b=VuvI0xTzTLE7A+BZ4EhCnf+pCRR7sLQNfj7svqJBvdCLBqZmEgVA34xc8e/dvfTW39Ht8MYuAZCxp86ebwKOX2ONMM6kYPLU+B+FVRzcj4kSyI0Qq9o0WrE9+A6TYkvXK70SidIRg5Clt64dP7lwmkwF5K4XXO2dblu9zq/UF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723058377; c=relaxed/simple;
	bh=A2Dh3act+sBXKI4W4oSZ94tO/XZktIa8nWg69prwrJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pNdrJZeaJzITF7Uf++vDK2XO8Q9xpwT2ghKlGsNW4gMAmfhnN2arWT3pXdclhvbXDH57bvP3JOT+XpLSO37NGMMzDUHW4NjmM0FcLg7tNDV0oAeZOAt6m/Y06OWHJrwy21VvYC7eO7vGvnPEvQnd/jGBTRoPmcNlW03ge6qssD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALTd9NRF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7bc39eef24bso14312a12.0
        for <linux-spi@vger.kernel.org>; Wed, 07 Aug 2024 12:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723058375; x=1723663175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXbLbHuhZ6vEs8voEUJFD2MNowEEk22ukWx+zuBhP50=;
        b=ALTd9NRF2/gYpCUSwtHk8ImZ054/N8CNRif2S9cxi5QlWwokwbvqq9G18zvpU2L7qO
         9l+ZNDww2SLs/wbFhVmOcJ/A8IqtfVkLpOpG1vYX5ucRSRQmnXhrgzW/KEf6cxHl5K10
         Y7zwpA/hrwtPru25g3MJccF0ypcBvGWQ3RzRSjNZX5SVolsw5WwtgyzDe6BPEqWBkFNg
         TF9hmMzKycZDOAYmK8c5fLCxLAKTKXfzxre9EzP8Mb/+7Ihcw/Eawu4OxuxPQjnqgQsk
         S8xEjdXglz1KOPv77vggH8qDQUB5sq8iv8CX/o4+MpFclzK893Ysi4EGH3OUUCPvC2vh
         bQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723058375; x=1723663175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXbLbHuhZ6vEs8voEUJFD2MNowEEk22ukWx+zuBhP50=;
        b=uvanfensoEZukuJuEblavG/ElhcP9iSd5u2hBF/rVnhxIi1/KFrBMFKwNCCVlaH/oh
         zupGpp7ngFMTz+/8pd57UVdr3zlBPP9ltKiU/nn60bIFC+3CH+nwUUVBs0hpp7/wjizk
         escB9bWUE4IcgW0gpOUHvvFj0wgHgXF45Z3cmtP8NLwOeMb6Sc8B1XproCWncVGG5Rtb
         oJkVfwh5RoR9e/zalZYQsVBOHTvtp5dvv4e8QREsfaNVUT3HuEfzTf75+CbUjAIfu40U
         dJyFQ7Vo2WA6+yehuMp2AFTkLjF9vZMrN4WpHqr3wp7Su8ZN4jKeD0Euib0xVt3MUSVL
         Ndmw==
X-Gm-Message-State: AOJu0YzqNd305vTb01eosW8I56DJdKfXIdhIVQ7npHWHYPye8Q192fiD
	Ia1TDeQx/CvUpHtB1WQoZpUENvfd8jcooM2L09xYuLnT2eHr0T1sxlEj0w==
X-Google-Smtp-Source: AGHT+IGIf5zRBOeCJV6uMS7x5ZIXMSo+e0Jl4gFWUktegENqP6Nh9LbrCQzHixVz2aQbcqYqprgkLQ==
X-Received: by 2002:a05:6a20:a106:b0:1c2:8a9b:b18 with SMTP id adf61e73a8af0-1c69962430amr13168631637.5.1723058375457;
        Wed, 07 Aug 2024 12:19:35 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5e1c:17b4:a72d:e3b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdfe78sm8740375b3a.137.2024.08.07.12.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:19:34 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Cc: linux-spi@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] spi: mxs: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
Date: Wed,  7 Aug 2024 16:19:22 -0300
Message-Id: <20240807191922.97383-1-festevam@gmail.com>
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

This allows removing the __maybe_unused notation from the runtime
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


