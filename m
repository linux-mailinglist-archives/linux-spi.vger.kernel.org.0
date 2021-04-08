Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF731357F16
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhDHJ0Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 05:26:25 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:45120 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229618AbhDHJ0Y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 05:26:24 -0400
Received: from localhost.localdomain (unknown [10.192.24.118])
        by mail-app2 (Coremail) with SMTP id by_KCgAXEPgnzG5g5vTdAA--.47586S4;
        Thu, 08 Apr 2021 17:26:03 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
Date:   Thu,  8 Apr 2021 17:25:59 +0800
Message-Id: <20210408092559.3824-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgAXEPgnzG5g5vTdAA--.47586S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWkGw1ftF1xGr17Cr18uFg_yoW3Zrc_Cw
        4DWrn3GFsY9wnrJ3WkKr98ZF9F9rZ8Xr4DXr4vqayavrWDArsxCay8AF1DCr47Z3yxCr4k
        CrWqga97Ar13WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2z280
        aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07
        x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18
        McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIE
        Y20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5sjjDUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0JBlZdtTTcOgASs+
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When platform_get_irq() fails, a pairing PM usage counter
increment is needed to keep the counter balanced. It's the
same for the following error paths.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/spi/spi-zynqmp-gqspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index c8fa6ee18ae7..95963a2de64a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1197,6 +1197,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 clk_dis_all:
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
-- 
2.17.1

