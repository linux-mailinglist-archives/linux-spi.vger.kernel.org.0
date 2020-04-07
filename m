Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26AB1A0D8C
	for <lists+linux-spi@lfdr.de>; Tue,  7 Apr 2020 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgDGM3N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Apr 2020 08:29:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44606 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgDGM3N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Apr 2020 08:29:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id n13so230123pgp.11;
        Tue, 07 Apr 2020 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vOQTjEsc/b9nWGCQMtsVYfPJl+HytGkwz1UpCx9vwX8=;
        b=MNBVjKjkXAaGGC+lGJMT5/YHMphzZ/i2GJoK2Vs0pV4BMdNwgyWmFrn2nPs24yAMGJ
         VXKWNoh7Tq2+SsQSnNksB1r/ZUKdvgd+ahRqmeC71sBlC1IikzKclwP+8qlOMR9T63mk
         QLbVUqEXCZJbp0p6YgQ3nkmX1DidzROnBaSxHa8PSWfH1RJh23rsl3U7IdLvTKKH2F3O
         7/qXeBRwIKJkRMzWae0vjLHG+eovzgzqc0rFwY5c29JGobY2CKRepLCoJUVXGaXUWKHv
         fK7GY0uhz3a7erjY3f8IdrCjL63ftba2Myvi6pIGzvasS+8dbBoyPzuMFN1cvWooRiOD
         f0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vOQTjEsc/b9nWGCQMtsVYfPJl+HytGkwz1UpCx9vwX8=;
        b=t9Mj1QPnccWZ8kiKvsUjSNb7LiHYk91gY9gpTxw/ykkhruHLXkd+afL2BpWohf05hB
         IKCJUAv7luPVvxdm0uw0VqLgNQy8afSFazS7/zWraB96kvUSt8RFNJGiN5Juk9+0oU7P
         Xqbx/zvlbWFlu4PzfH46TIMyk7SCwHk8+OHDy0fIsW7n4HI/F4o657kNqP4QCoLE+V5c
         EYx8xRa4AOl7ZyyvLlpxpCnSy9iPquy4jmtbnJNrors4xVzX+26Sjlv9ntRbXkVDoVRc
         4ra3sCnpGMhdCR+7ilCfLPx/Z+fntfzW4hAHJL4lplPahTQDCSytiqNIzaZ/2EmxUoPE
         Qs2Q==
X-Gm-Message-State: AGi0PuYlJIUUVTKe+749FNSLaufCI02+4CT0SvlxW1mE023CpGBYYvqP
        7/8euNR9sicgnsnFxcRiS2pHgzK0qo1j3CC2
X-Google-Smtp-Source: APiQypLEkKHjYIC1deoz+QQ8rx+ZY4YXbE5tVqk1ceCDuNWxjpvIjZpICuv5ce0ib1fz3VKkOSOl3Q==
X-Received: by 2002:a62:2b07:: with SMTP id r7mr2220138pfr.273.1586262551588;
        Tue, 07 Apr 2020 05:29:11 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:600d:c36b:d50:b01b:c4e4:35ad])
        by smtp.gmail.com with ESMTPSA id o11sm12966626pgh.78.2020.04.07.05.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 05:29:10 -0700 (PDT)
From:   Aishwarya R <aishwaryarj100@gmail.com>
Cc:     aishwaryarj100@gmail.com, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-fsl-spi: Fix checkpatch error "foo * bar" should be "foo *bar"
Date:   Tue,  7 Apr 2020 17:58:55 +0530
Message-Id: <20200407122855.5531-1-aishwaryarj100@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch fixes checkpatch error "foo * bar" should be "foo *bar"

Signed-off-by: Aishwarya R <aishwaryarj100@gmail.com>
---
 drivers/spi/spi-fsl-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 3b81772fea0d..67f022b8c81d 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -588,7 +588,7 @@ static void fsl_spi_grlib_probe(struct device *dev)
 	pdata->cs_control = fsl_spi_grlib_cs_control;
 }
 
-static struct spi_master * fsl_spi_probe(struct device *dev,
+static struct spi_master *fsl_spi_probe(struct device *dev,
 		struct resource *mem, unsigned int irq)
 {
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
-- 
2.17.1

