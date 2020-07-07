Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8355421689C
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGIux (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 04:50:53 -0400
Received: from mail.loongson.cn ([114.242.206.163]:42582 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbgGGIux (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 Jul 2020 04:50:53 -0400
Received: from ticat.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxFupjNwRfLCtRAA--.918S2;
        Tue, 07 Jul 2020 16:50:44 +0800 (CST)
From:   Peng Fan <fanpeng@loongson.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: atmel: No need to call spi_master_put() if spi_alloc_master() failed
Date:   Tue,  7 Jul 2020 16:50:42 +0800
Message-Id: <1594111842-9468-1-git-send-email-fanpeng@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxFupjNwRfLCtRAA--.918S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4xJF48GF43Cw1xJr48Xrb_yoW3ZFXEkw
        48urn7Wr45trsFk3Wag34fZry29a4rXrs29FnIqayfX34Dtr1UJrWDXF1Dua1UZw4xArWD
        Cr1DWrySkrWfWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwkYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC2
        0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
        0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
        14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
        vaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8CJmUUUUUU==
X-CM-SenderInfo: xidq1vtqj6z05rqj20fqof0/
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no need to call spi_master_put() if spi_alloc_master()
failed, it should return -ENOMEM directly.

Signed-off-by: Peng Fan <fanpeng@loongson.cn>
---
 drivers/spi/spi-atmel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 57ee8c3..6ed7abd 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1546,10 +1546,9 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 
 	/* setup spi core then atmel-specific driver state */
-	ret = -ENOMEM;
 	master = spi_alloc_master(&pdev->dev, sizeof(*as));
 	if (!master)
-		goto out_free;
+		return -ENOMEM;
 
 	/* the spi->mode bits understood by this driver: */
 	master->use_gpio_descriptors = true;
-- 
2.1.0

