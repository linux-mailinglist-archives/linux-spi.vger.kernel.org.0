Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA086322D55
	for <lists+linux-spi@lfdr.de>; Tue, 23 Feb 2021 16:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhBWPUJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Feb 2021 10:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbhBWPT5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Feb 2021 10:19:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D1EC06178C;
        Tue, 23 Feb 2021 07:18:57 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y17so1395248wrs.12;
        Tue, 23 Feb 2021 07:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VVd28ukkiNf74ssL9JqbPQSRVlXUhzl9Tn7fvTHWtHY=;
        b=KzERRjJLX86zYsWtBHnmkxT1WDbq5FWR+wZQPCpW9xgAW2bT8jJo4In3zG7ppvjp8M
         WTV0hKaDdDKb/hrUuO4YQ0k7ldZzwGCQzkxcGvYaXXNmUmekybNZwyBbJaTqXfNIoZk2
         Ex8+L5pfKsUtkA5d0z+MzilBFSmqtsz9zGXEuExSfFIeodp5tI0nzFOQrzUv1RQcA0xr
         UXizyAD6MCeVrd0JQGkNRL4IP51snhnwhIa3iXi7av9qeLorZ4WPrrQc+JTc62/d0HQM
         Rr9P5/xyNGq6WXmAtesMFc+beRd0R1X05leaM0AJLZe32r5kbycvslOcpe0w2nI0JkNV
         MFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVd28ukkiNf74ssL9JqbPQSRVlXUhzl9Tn7fvTHWtHY=;
        b=pxNQEpFVBkRkmFxGO8SOPteMdi9rqg//g67hlDWfUybsjjd6t0bDKRtpDkWW52fj8F
         c3T9RaIEXcwGE08LLWaDFOig88cQDri5aLLvQGKb5MdgnA2RhVsqLBh+LiHpA42eABN4
         Xkzu6NNqVLBhoQiMqWnezUKKPjuf4RLmin3xX/vB6CbRiEnJYxn1eIOfMAY2k/WmG8Sc
         cLvRxM7m0sa8YPSKc5ysIfMtEAjiSPBfjL8p59f74YsW9RELH9KtLnGENAeNSdDu0YqX
         d3YCpmchQULJsC3bkSxwNxMmVms2ixK79ft4/2JWry+or53BK52rdfs95dr/IiY8seXJ
         rpAw==
X-Gm-Message-State: AOAM533HjxR+v4epvwiUkJedb9GKwDxTK6W1NjGa3Ygkd5aiE3UkHIdI
        Tet09T9nqj8gJcKZwCqdJpP2gNd/I+kX9dU6
X-Google-Smtp-Source: ABdhPJyJ7As5wlQUT5W5m0iAAoD7gNJJ4/lM+5c4AaEQpyuF/D8PiZShtoxKYnYe7fVuDfrvI7ft+w==
X-Received: by 2002:adf:80e7:: with SMTP id 94mr26725351wrl.5.1614093535715;
        Tue, 23 Feb 2021 07:18:55 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id y6sm3018071wma.10.2021.02.23.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:18:55 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com, Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/2] spi: bcm63xx-hsspi: fix pm_runtime
Date:   Tue, 23 Feb 2021 16:18:51 +0100
Message-Id: <20210223151851.4110-3-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223151851.4110-1-noltari@gmail.com>
References: <20210223151851.4110-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver sets auto_runtime_pm to true, but it doesn't call
pm_runtime_enable(), which results in "Failed to power device" when PM support
is enabled.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 1f08d7553f07..b871fd810d80 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/reset.h>
+#include <linux/pm_runtime.h>
 
 #define HSSPI_GLOBAL_CTRL_REG			0x0
 #define GLOBAL_CTRL_CS_POLARITY_SHIFT		0
@@ -439,13 +440,17 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_put_master;
 
+	pm_runtime_enable(&pdev->dev);
+
 	/* register and we are done */
 	ret = devm_spi_register_master(dev, master);
 	if (ret)
-		goto out_put_master;
+		goto out_pm_disable;
 
 	return 0;
 
+out_pm_disable:
+	pm_runtime_disable(&pdev->dev);
 out_put_master:
 	spi_master_put(master);
 out_disable_pll_clk:
-- 
2.20.1

