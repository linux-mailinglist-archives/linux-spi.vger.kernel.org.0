Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710873F58A3
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 09:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhHXHDQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 03:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbhHXHDP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 03:03:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34837C061760;
        Tue, 24 Aug 2021 00:02:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fz10so2199917pjb.0;
        Tue, 24 Aug 2021 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oBX4YIAIW1Lbo+DKwuinsj3XFa4b7I197fWtFrroOkw=;
        b=Iz1l+BKZmk6rvR1qvQTI85Ev1PiVlrZf1SE+mkwOi1sUT8BNYOib3RU2srJLPcwBdn
         14+j4oKjZB09b6avirzYaM9tnM2QgDj3vBgry2ie9GVFkxLpOplcXXbplnkb0AUvGOvk
         N1RR8+rfdTHnoGBMjcwiVGyGxPKfuRTUZRQ2gfHfeD9R9FcjWH+ozhWF14b8yaZimM/n
         omSRz6CJFSaBs0XHj6t1Z6gCDuS5kjS9Osg1jNUCm+CskQFCydCofbhySdOvAPP4Rf4j
         aOGum/iDWCLy5zxfqPc0GPf6LVcN1UE6ZVXsxRv9OBNWPRmn32Zt4xnF0p8o0wcqkOFu
         8T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oBX4YIAIW1Lbo+DKwuinsj3XFa4b7I197fWtFrroOkw=;
        b=htj97ijesXGiK8z/hz/JR6dq5hBiW5er5Quvb34hu0fmVoYdB8SyHYlEqvmWdmrF6o
         bEzK0FYhzzbFEaxHTAcEJoQzFhgYCbPDICcBqhGD09lnh2t043i7i04GkFZFMcxj4pCV
         0sorE4RM9Jk+bNbXiN6YvSDkkpxY0WIleJJ6c4BqeDN5bNWCdG4UfW2WOEB3tUG5WqxA
         ZpoNIBG+Irr0LhIJnXmSTDkNz1p7DpVAg/r7a1IHqfEuo2ooGIterD0O2nO42UGDW4IF
         74uUzrep8JE9E6AyFLNi/8oIqrXXBJNkLQxmZYJPP1sfaSXngE3seeRwL3oyoFfVaKEe
         pnwA==
X-Gm-Message-State: AOAM531cT5f+mC+Vo8w8WBV259eypqH4LktBpltUeNFPkcPDGD3bC5YQ
        V/dJ3VTq24jIYvY5nZn2dU8=
X-Google-Smtp-Source: ABdhPJwjl2rOeOrASOTBv/k9TzyFpyQfE0/4jDUWDQXS1mVDn1bFA8mRNVVhpWP8U2vixbNKhL+R+g==
X-Received: by 2002:a17:90b:3608:: with SMTP id ml8mr2921425pjb.22.1629788550803;
        Tue, 24 Aug 2021 00:02:30 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b17sm20365340pgl.61.2021.08.24.00.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:02:30 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] spi: sprd: fill offset only to RD_CMD register for reading from slave device
Date:   Tue, 24 Aug 2021 15:02:12 +0800
Message-Id: <20210824070212.2089255-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824070212.2089255-1-zhang.lyra@gmail.com>
References: <20210824070212.2089255-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

RD_CMD can accept slave address offset only, higher bits are reserved.
Writing the whole slave address including slave base seems unnecessary.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 06af519c0b21..07f11b17bf20 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -159,7 +159,7 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg, u32 *read_val)
 {
 	int read_timeout = ADI_READ_TIMEOUT;
 	unsigned long flags;
-	u32 val, rd_addr, paddr;
+	u32 val, rd_addr;
 	int ret = 0;
 
 	if (sadi->hwlock) {
@@ -177,11 +177,10 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg, u32 *read_val)
 		goto out;
 
 	/*
-	 * Set the physical register address need to read into RD_CMD register,
+	 * Set the slave address offset need to read into RD_CMD register,
 	 * then ADI controller will start to transfer automatically.
 	 */
-	paddr = sadi->slave_pbase + reg;
-	writel_relaxed(paddr, sadi->base + REG_ADI_RD_CMD);
+	writel_relaxed(reg, sadi->base + REG_ADI_RD_CMD);
 
 	/*
 	 * Wait read operation complete, the BIT_RD_CMD_BUSY will be set
@@ -211,9 +210,9 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg, u32 *read_val)
 	 */
 	rd_addr = (val & RD_ADDR_MASK) >> RD_ADDR_SHIFT;
 
-	if (rd_addr != (paddr & REG_ADDR_LOW_MASK)) {
+	if (rd_addr != (reg & REG_ADDR_LOW_MASK)) {
 		dev_err(sadi->dev, "read error, reg addr = 0x%x, val = 0x%x\n",
-			paddr, val);
+			reg, val);
 		ret = -EIO;
 		goto out;
 	}
-- 
2.25.1

