Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6006EBC6D
	for <lists+linux-spi@lfdr.de>; Sun, 23 Apr 2023 04:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDWCcF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 Apr 2023 22:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjDWCcE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Apr 2023 22:32:04 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D2D61717
        for <linux-spi@vger.kernel.org>; Sat, 22 Apr 2023 19:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GQP9Y
        0UdXINKE5voFtMMPDl1m29fvMt/Vmaw5XaxM60=; b=bl42mxwp4NezjE/c/7eRs
        lp35XRAdDD4bSb6W/uF4yxXr7A56e+Alx9T8doVEGyOw7YJ+YVbmiMLrMTaWzb+3
        n+5js1fiYUN1Hqd9Qh0GlxiaoEIpEirlNkVxe9aU5i7POVdWvTyIR9Iuwm6aLQr0
        z/Axef+OEpe8x7Shkl339k=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wDHncZfmERkdXTMCA--.30683S2;
        Sun, 23 Apr 2023 10:30:55 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-sunxi@lists.linux.dev, linux-spi@vger.kernel.org
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH] drivers: spi: sunxi: Enable irq after the initialization is done
Date:   Sun, 23 Apr 2023 10:30:56 +0800
Message-Id: <20230423023056.27929-1-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHncZfmERkdXTMCA--.30683S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrW7ury3AFWrXFWfJr4xJFb_yoW5Cw15pF
        WUAF4Fyr48WF1Y9F13Cws0v34ak3yIg3yxGrWqk3s3A3s0grykXF1rJa4avFs3tFWkGa43
        tFWqqr4Ska1jqaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziKFAJUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbBzgha7WI0Y8TkEQAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

Interrupts are opened prematurely before some initialization work is finished.
When some uninitialized variables are used in interrupt functions,
the kernel crashes.

A typical case is the second kernel loaded with kdump starting when the first
kernel transfering spi messages.

The kernel error messages is as follows:

[    1.362449] sun6i-spi 1c06000.spi: Failed to request RX DMA channel
[    1.369654] 8<--- cut here ---
[    1.372716] Unable to handle kernel paging request at virtual address fffffffc
[    1.379928] pgd = (ptrval)
[    1.382632] [fffffffc] *pgd=6bef6861, *pte=00000000, *ppte=00000000
[    1.388907] Internal error: Oops: 37 [#1] SMP ARM
...
[    1.784024] [<c0159c54>] (swake_up_locked.part.0) from [<c0159d9c>] (complete+0x30/0x40)
[    1.792114] [<c0159d9c>] (complete) from [<c0491ab0>] (sun6i_spi_handler+0x168/0x194)
[    1.799947] [<c0491ab0>] (sun6i_spi_handler) from [<c0169070>] (__handle_irq_event_percpu+0x50/0x120)
[    1.809168] [<c0169070>] (__handle_irq_event_percpu) from [<c0169170>] (handle_irq_event_percpu+0x30/0x78)
[    1.818818] [<c0169170>] (handle_irq_event_percpu) from [<c01691fc>] (handle_irq_event+0x44/0x68)
[    1.827687] [<c01691fc>] (handle_irq_event) from [<c016d96c>] (handle_fasteoi_irq+0xac/0x118)
[    1.836210] [<c016d96c>] (handle_fasteoi_irq) from [<c01689bc>] (handle_domain_irq+0x5c/0x78)
[    1.844731] [<c01689bc>] (handle_domain_irq) from [<c03bc058>] (gic_handle_irq+0x7c/0x90)
[    1.852910] [<c03bc058>] (gic_handle_irq) from [<c0100afc>] (__irq_svc+0x5c/0x78)

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 drivers/spi/spi-sun4i.c | 4 +++-
 drivers/spi/spi-sun6i.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 1fdfc6e6691d..2f797b903692 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -452,7 +452,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun4i_spi_handler,
-			       0, "sun4i-spi", sspi);
+			       IRQF_NO_AUTOEN, "sun4i-spi", sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
 		goto err_free_master;
@@ -506,6 +506,8 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
+	enable_irq(irq);
+
 	return 0;
 
 err_pm_disable:
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 1151d8592656..0eec2d0e312b 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -583,7 +583,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun6i_spi_handler,
-			       0, "sun6i-spi", sspi);
+			       IRQF_NO_AUTOEN, "sun6i-spi", sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
 		goto err_free_master;
@@ -675,6 +675,8 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
+	enable_irq(irq);
+
 	return 0;
 
 err_pm_disable:
-- 
2.25.1

