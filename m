Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31674358DE8
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 21:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhDHT5j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 15:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbhDHT5j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Apr 2021 15:57:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6B5C061760;
        Thu,  8 Apr 2021 12:57:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so1825608wmi.3;
        Thu, 08 Apr 2021 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pHid7b1osF0SpTWtp0Ym0Sv/8aucsroZP/wDvU5qRUY=;
        b=SDD77RRxaFIx6pnvEz8lN7D1kL7Sn5GoTa3dNZUubUCb93BqP4nTqhhci6lRfoEsII
         SxRKvuOgtDblZRWYQfC0QN/y+W+HLEVGTceTdV51m+4D4jo96HRbsA9TsMnOBwC4w4LG
         XVTDxyKDLhfJTf9jHbjTCm0BVq1Vz0pEedbrCWuqThKbw7HAftXTYa26QHkwsp5ab4JA
         gwsxSali9y8hG7caeSHE4ObRAsIuISWdLglO2MFIgik5JdIsRhYY9TrZQ7qbPM/BX4kH
         YXvYd9Xxf1lj3aL57hC35j7aasE1eb2L6ltfO2Ecwk9Nyd7afkvx0AONrJvTNGF+bSLs
         wJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pHid7b1osF0SpTWtp0Ym0Sv/8aucsroZP/wDvU5qRUY=;
        b=QLW7tLSIluQ+iQhG/BTnZb1ClRMOFU1MCF/GLvqHUrvLSLZDomXhqNLiLj3x9JSVIa
         V5LwieypOxJDF+/aJdKaXMpGHd/nsgvZqLDXHIKFjyZ6TP1Ph6zFG3AQ9IYWwtKCvlPz
         Fi1qGGjfyc8GgfNtDEEP0LaV53tMpYWueuE171IR4MoHjq2NDGXW2VD8N1nwDJac91+V
         LoGC8JNy3NsUJMScsjzpiAWfFjKhW6Sun67ue3eFoCemwBajIuJzZV1u1N38SaRtvYVd
         PhT8F5Yfx0ISqRDScf4FZ3FXoPkDXaJNKGalLMYvYJbh0YbOp2+FQedWGq/Yyjipszch
         moUw==
X-Gm-Message-State: AOAM531Tg6klLCxM6yXe6IQkVkInod+3e4CC4dJpkbCueaRaAZb0PxDO
        nEWcCS7TI1vMQ9Z452Lqw3Y=
X-Google-Smtp-Source: ABdhPJwumd9NyP++HS8c5TOLkkrMEBeTlEaV4aIyq1qCaTKCVHgdihqEgAPi3I5S0vnHubKWaorvIQ==
X-Received: by 2002:a1c:7409:: with SMTP id p9mr9787834wmc.153.1617911846245;
        Thu, 08 Apr 2021 12:57:26 -0700 (PDT)
Received: from LEGION ([39.46.7.73])
        by smtp.gmail.com with ESMTPSA id j30sm480579wrj.62.2021.04.08.12.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:57:25 -0700 (PDT)
Date:   Fri, 9 Apr 2021 00:57:18 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Tian Tao <tiantao6@hisilicon.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     musamaanjum@gmail.com, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com, dan.carpenter@oracle.com
Subject: [PATCH] spi: orion: set devdata properly as it is being used later
Message-ID: <20210408195718.GA3075166@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If device_get_match_data returns NULL, devdata isn't being updated
properly. It is being used later in the function. Both devdata and
spi->devdata should be updated to avoid NULL pointer dereference.

Addresses-Coverity: ("NULL pointer dereference")
Fixes: 0e6521f13c2 ("spi: orion: Use device_get_match_data() helper")
Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/spi/spi-orion.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index d02c5c9def20..34b31aba3981 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -676,7 +676,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 	spi->dev = &pdev->dev;
 
 	devdata = device_get_match_data(&pdev->dev);
-	spi->devdata = devdata ? devdata : &orion_spi_dev_data;
+	devdata = devdata ? devdata : &orion_spi_dev_data;
+	spi->devdata = devdata;
 
 	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
-- 
2.25.1

