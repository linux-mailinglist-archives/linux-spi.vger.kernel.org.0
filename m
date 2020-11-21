Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BBE2BBCC0
	for <lists+linux-spi@lfdr.de>; Sat, 21 Nov 2020 04:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgKUDn7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Nov 2020 22:43:59 -0500
Received: from mail.loongson.cn ([114.242.206.163]:53432 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbgKUDn7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Nov 2020 22:43:59 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWtD3jLhf8zMUAA--.32195S2;
        Sat, 21 Nov 2020 11:43:53 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: amd: Use devm_platform_ioremap_resource() in amd_spi_probe
Date:   Sat, 21 Nov 2020 11:43:51 +0800
Message-Id: <1605930231-19448-1-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxWtD3jLhf8zMUAA--.32195S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr45Kw15Cw17Zw17uFW8tFb_yoWkCrc_ZF
        48Cr93Kr45trnYq34Utr1S9ryavFWqgF1F93Z0gFZYq3y5Ja1xA34Dur4DAFyDZwsxJrZ0
        kFs3Zr4FkwnxCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwxYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
        IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc_-PUUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Simplify this function implementation by using a known wrapper function.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 drivers/spi/spi-amd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 7f62954..3cf7609 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -250,7 +250,6 @@ static int amd_spi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct spi_master *master;
 	struct amd_spi *amd_spi;
-	struct resource *res;
 	int err = 0;
 
 	/* Allocate storage for spi_master and driver private data */
@@ -261,9 +260,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	}
 
 	amd_spi = spi_master_get_devdata(master);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	amd_spi->io_remap_addr = devm_ioremap_resource(&pdev->dev, res);
+	amd_spi->io_remap_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(amd_spi->io_remap_addr)) {
 		err = PTR_ERR(amd_spi->io_remap_addr);
 		dev_err(dev, "error %d ioremap of SPI registers failed\n", err);
-- 
2.1.0

