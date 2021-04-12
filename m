Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B326635BADE
	for <lists+linux-spi@lfdr.de>; Mon, 12 Apr 2021 09:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbhDLHeA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Apr 2021 03:34:00 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:6606 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236898AbhDLHd7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Apr 2021 03:33:59 -0400
Received: from localhost.localdomain (unknown [10.192.139.175])
        by mail-app3 (Coremail) with SMTP id cC_KCgD34Dxq93Ng3rYJAQ--.16326S4;
        Mon, 12 Apr 2021 15:32:00 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
Date:   Mon, 12 Apr 2021 15:31:54 +0800
Message-Id: <20210412073154.25011-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgD34Dxq93Ng3rYJAQ--.16326S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfKw4kGryxtFykKFy5XFb_yoW8Gw1xpr
        4vqFW7Kr40q3yftF1jk3y0qFy3XFyF93yxJrWkt3WFv3saqa4rtF1xJFyftFZ7AF97AFWj
        gF48C3yS9as8ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
        XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
        6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgcNBlZdtTWazAAIsb
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is a PM usage counter decrement after zynqmp_qspi_init_hw()
without any refcount increment, which leads to refcount leak.Add
a refcount increment to balance the refcount. Also set
auto_runtime_pm to resume suspended spi controller.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
changelog:

v2: - Add a refcount increment to fix refcout leak instead of the
      refcount decrement on error.
      Set ctlr->auto_runtime_pm = true.
---
 drivers/spi/spi-zynqmp-gqspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index c8fa6ee18ae7..8b21c7b0e7eb 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1160,6 +1160,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
@@ -1187,6 +1188,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
+	ctlr->auto_runtime_pm = true;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
-- 
2.17.1

