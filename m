Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114DF75FAA
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2019 09:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfGZHVl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jul 2019 03:21:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36278 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfGZHVk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jul 2019 03:21:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so24329871pgm.3
        for <linux-spi@vger.kernel.org>; Fri, 26 Jul 2019 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=NWVsUkkDHIuRmUj9QU93X+5+YMySiLs15Fa6SS5cpaE=;
        b=PV6UmmpTsl4qyL9YLpPEkrDLpNgZumlLqQgJL5tf2AhWNCYTaorte9k2Pj6IBUNSly
         P3k2AtwrjF3ASvtlPfbzMtob1Cg03Jd+goAm4I7kOQisa12ZR8ojvxgnuaesv3WCzKFe
         Pq4rBflmWmlGTT2BdXqwa0x25C5sGnY4r3dCX5ZxUlkDj23l8P1xT5sr2XjxSPYPgErI
         6schkzFTtMrRNHU3fT2UZrOgBpsicdyIYMZgQj3x1b4OkZNx911u9ycHBJuLm7pEVZda
         IlKXw2hSsZESskRI+3b+vVA34+9nm2QXl2cxQB7Nb6VGGObnFHwYVgBPu6WvUEsFzssY
         vvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NWVsUkkDHIuRmUj9QU93X+5+YMySiLs15Fa6SS5cpaE=;
        b=eCDmu9dI4Uc+G1RoxSlPpVzRhbbtWFVr5vRMLzcgvNUZQbCJ06T0g3VzdTBW0EtyMk
         0KekMEv6ojvaB4Vmn6Ppn2j48T2v5dQ7sFNBZl7q/yR+wQ1PBCZSjD8kjnJKh7u80thn
         O51OMhbTk4tqVk2aav/lxIx2YWHn60aK17tLYB0zn6uHk1/gY88ViT+X3diFYpCxuyzX
         yr7bMlY6DZS+TbdgJEUIsVIliIYzFFrTKIV0mB8LzqAI6huFqkYQfv4AHdFgrqLqmJB2
         8rLOa9LU+ArYOluJkZhPutGh3kx8yJ2ZVZl1XO5lZ5yoBc2fLtqSx1nDaWbXbz5HYXij
         zRWw==
X-Gm-Message-State: APjAAAVpiK5b0OVP91UqGIJIRjMUf0b7FckKEJ6tyccyO70st5SToHJC
        QAXcbrPwNSpfSdMIVOgyCgL87g==
X-Google-Smtp-Source: APXvYqyysUnX0wySMncWO4KIIl78EKADDoXzDUyhNNMPwEIaoBIbQZFiErLNKUuc3bxwyzllKRQx9Q==
X-Received: by 2002:a63:7358:: with SMTP id d24mr89898767pgn.224.1564125700079;
        Fri, 26 Jul 2019 00:21:40 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o12sm39216152pjr.22.2019.07.26.00.21.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 00:21:39 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     weicx@spreadst.com, sherry.zong@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] spi: sprd: adi: Change hwlock to be optional
Date:   Fri, 26 Jul 2019 15:20:52 +0800
Message-Id: <2abe7dcf210e4197f8c5ece7fc6d6cc1eda8c655.1564125131.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Now Spreadtrum ADI controller supplies multiple master accessing channel
to support multiple subsystems accessing, instead of using a hardware
spinlock to synchronize between the multiple subsystems.

To keep backward compatibility, we should change the hardware spinlock
to be optional. Moreover change to use of_hwspin_lock_get_id() function
which return -ENOENT error number to indicate no hwlock support.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |   68 +++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 0d767eb..9a05128 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -165,14 +165,16 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
 	int read_timeout = ADI_READ_TIMEOUT;
 	unsigned long flags;
 	u32 val, rd_addr;
-	int ret;
-
-	ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
-					  ADI_HWSPINLOCK_TIMEOUT,
-					  &flags);
-	if (ret) {
-		dev_err(sadi->dev, "get the hw lock failed\n");
-		return ret;
+	int ret = 0;
+
+	if (sadi->hwlock) {
+		ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
+						  ADI_HWSPINLOCK_TIMEOUT,
+						  &flags);
+		if (ret) {
+			dev_err(sadi->dev, "get the hw lock failed\n");
+			return ret;
+		}
 	}
 
 	/*
@@ -219,7 +221,8 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
 	*read_val = val & RD_VALUE_MASK;
 
 out:
-	hwspin_unlock_irqrestore(sadi->hwlock, &flags);
+	if (sadi->hwlock)
+		hwspin_unlock_irqrestore(sadi->hwlock, &flags);
 	return ret;
 }
 
@@ -230,12 +233,14 @@ static int sprd_adi_write(struct sprd_adi *sadi, u32 reg_paddr, u32 val)
 	unsigned long flags;
 	int ret;
 
-	ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
-					  ADI_HWSPINLOCK_TIMEOUT,
-					  &flags);
-	if (ret) {
-		dev_err(sadi->dev, "get the hw lock failed\n");
-		return ret;
+	if (sadi->hwlock) {
+		ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
+						  ADI_HWSPINLOCK_TIMEOUT,
+						  &flags);
+		if (ret) {
+			dev_err(sadi->dev, "get the hw lock failed\n");
+			return ret;
+		}
 	}
 
 	ret = sprd_adi_drain_fifo(sadi);
@@ -261,7 +266,8 @@ static int sprd_adi_write(struct sprd_adi *sadi, u32 reg_paddr, u32 val)
 	}
 
 out:
-	hwspin_unlock_irqrestore(sadi->hwlock, &flags);
+	if (sadi->hwlock)
+		hwspin_unlock_irqrestore(sadi->hwlock, &flags);
 	return ret;
 }
 
@@ -476,16 +482,26 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	sadi->slave_pbase = res->start + ADI_SLAVE_OFFSET;
 	sadi->ctlr = ctlr;
 	sadi->dev = &pdev->dev;
-	ret = of_hwspin_lock_get_id_byname(np, "adi");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "can not get the hardware spinlock\n");
-		goto put_ctlr;
-	}
-
-	sadi->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, ret);
-	if (!sadi->hwlock) {
-		ret = -ENXIO;
-		goto put_ctlr;
+	ret = of_hwspin_lock_get_id(np, 0);
+	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
+		sadi->hwlock =
+			devm_hwspin_lock_request_specific(&pdev->dev, ret);
+		if (!sadi->hwlock) {
+			ret = -ENXIO;
+			goto put_ctlr;
+		}
+	} else {
+		switch (ret) {
+		case -ENOENT:
+			dev_info(&pdev->dev, "no hardware spinlock supplied\n");
+			break;
+		default:
+			dev_err(&pdev->dev,
+				"failed to find hwlock id, %d\n", ret);
+			/* fall-through */
+		case -EPROBE_DEFER:
+			goto put_ctlr;
+		}
 	}
 
 	sprd_adi_hw_init(sadi);
-- 
1.7.9.5

