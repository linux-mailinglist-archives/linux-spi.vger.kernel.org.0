Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D394022ED
	for <lists+linux-spi@lfdr.de>; Tue,  7 Sep 2021 07:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhIGEzH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Sep 2021 00:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhIGEzH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Sep 2021 00:55:07 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7C4C061575;
        Mon,  6 Sep 2021 21:54:01 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so11268070otk.9;
        Mon, 06 Sep 2021 21:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwvMp5IA0hnYzD/MgD58P5n8j2xNmred2ctzvwoT1CU=;
        b=cZYwdPnb1b3umP57IStOfOejXuTnIqns8GGgRWhneEd4+B5/jxMyHZJubUZyE72LFw
         uHkv/zN0F8S3uhGH4GNKleFqIFy56ci7X3xQQ5UoXYGnFy6jsBlwIK9o5AkyTHTe+tmO
         Sy0NTdA0jIRt23iAdTM7/bELUq/rwxsurybr1xD4EG/kyu6Sxjd+Mx5A6fRtNRxP0Dmj
         1wLoO3KtCCMC9cKO7smVlqVgzrFFdAcuNbDlcaza89ceWVHqa5jmpapX06F/LCcOSOZx
         z65qw/LoR0J2rDs+XlxpMvAvr8eQ/L8Rlex6txLMzFJvbRH8zGLWi6CtTYs5zcVYET3/
         6IoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HwvMp5IA0hnYzD/MgD58P5n8j2xNmred2ctzvwoT1CU=;
        b=gFTWvdQU7Rz+VGCo3c7vg0ObVG0dA9dr2WS7aGaLugN67Jcpr3vDXMcUQC9VeSs7rE
         xsVeyagOWmF9KL2rCksnVR0Rs1Ksdmm+1Nswa9rYg9RFBRD5RkUCv1u47jf83xO+o3Tz
         rmzmjRMJ07mE3Fp5ik/JX7qXGpASOu7SMOuiotq32ic7TnzO1qRrW7CLkabVH5tQg1n2
         c2+h2AbEsKHDIwsZ42ncoyP9AKM+37gJ0XBLbdtRhYVpNktx+hYsIGN5r7U51TlA03Iy
         n/Uf3VNgZQVn2gAFuRkC0V2xYDpWtFAmMlQ+ci688fsFzed1GigKHgJWKI+bEBMmVMY2
         dc2w==
X-Gm-Message-State: AOAM5323x6e0TBLQciC8x+SMOxFFdX8GN4ZnO9GeTIlbYYenrj/CFJAQ
        zWCiGXbrj3KPYFZCGIvQuuk1fagK33M=
X-Google-Smtp-Source: ABdhPJztUXWHe1y/MwgJ82OrG6ipdHUyLDX7LpTXBUndg5E27UkvWxbxdqpuMUdkJgllcIWIZH6siw==
X-Received: by 2002:a9d:6c19:: with SMTP id f25mr14331759otq.192.1630990440828;
        Mon, 06 Sep 2021 21:54:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10sm2230807otp.25.2021.09.06.21.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 21:54:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Laxman Dewangan <ldewangan@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] spi: tegra20-slink: Declare runtime suspend and resume functions conditionally
Date:   Mon,  6 Sep 2021 21:53:58 -0700
Message-Id: <20210907045358.2138282-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following build error is seen with CONFIG_PM=n.

drivers/spi/spi-tegra20-slink.c:1188:12: error:
	'tegra_slink_runtime_suspend' defined but not used
drivers/spi/spi-tegra20-slink.c:1200:12: error:
	'tegra_slink_runtime_resume' defined but not used

Declare the functions only if PM is enabled. While at it, remove the
unnecessary forward declarations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/spi/spi-tegra20-slink.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index ebd27f883033..8ce840c7ecc8 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -204,9 +204,6 @@ struct tegra_slink_data {
 	struct dma_async_tx_descriptor		*tx_dma_desc;
 };
 
-static int tegra_slink_runtime_suspend(struct device *dev);
-static int tegra_slink_runtime_resume(struct device *dev);
-
 static inline u32 tegra_slink_readl(struct tegra_slink_data *tspi,
 		unsigned long reg)
 {
@@ -1185,6 +1182,7 @@ static int tegra_slink_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM
 static int tegra_slink_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
@@ -1210,6 +1208,7 @@ static int tegra_slink_runtime_resume(struct device *dev)
 	}
 	return 0;
 }
+#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops slink_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_slink_runtime_suspend,
-- 
2.33.0

