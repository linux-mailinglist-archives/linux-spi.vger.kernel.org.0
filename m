Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB5D220456
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 07:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgGOF04 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 01:26:56 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48594 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbgGOF0z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 01:26:55 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxCdWYkw5fPuQEAA--.6136S3;
        Wed, 15 Jul 2020 13:26:48 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] spi: coldfire-qspi: Use clk_prepare_enable and clk_disable_unprepare
Date:   Wed, 15 Jul 2020 13:26:47 +0800
Message-Id: <1594790807-32319-2-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1594790807-32319-1-git-send-email-zhangqing@loongson.cn>
References: <1594790807-32319-1-git-send-email-zhangqing@loongson.cn>
X-CM-TRANSID: AQAAf9CxCdWYkw5fPuQEAA--.6136S3
X-Coremail-Antispam: 1UD129KBjvdXoWrurWxur1UZrW3KFykXFy5Jwb_yoWkArbE9a
        n8Wrs5GF4Uurs7A3WkKwn8Xryj9FWku3ZrKrs2qr1Fq3srZws8CrWDZFs8Cr93Cw42kr4S
        yr4kCw17Ar4fGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfAYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CE
        w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE
        c7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4rMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8-6pJUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert clk_enable() to clk_prepare_enable() and clk_disable() to
clk_disable_unprepare() respectively in the spi-coldfire-qspi.c.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---

v2:
    -Modify the commit message
    -Split into two patches

 drivers/spi/spi-coldfire-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index f80e06c..8996115 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -387,7 +387,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 		status = PTR_ERR(mcfqspi->clk);
 		goto fail0;
 	}
-	clk_enable(mcfqspi->clk);
+	clk_prepare_enable(mcfqspi->clk);
 
 	master->bus_num = pdata->bus_num;
 	master->num_chipselect = pdata->num_chipselect;
@@ -425,7 +425,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	mcfqspi_cs_teardown(mcfqspi);
 fail1:
-	clk_disable(mcfqspi->clk);
+	clk_disable_unprepare(mcfqspi->clk);
 fail0:
 	spi_master_put(master);
 
-- 
2.1.0

