Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086A21DC813
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 09:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgEUH6X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 03:58:23 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:46536 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728399AbgEUH6X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 03:58:23 -0400
Received: from localhost.localdomain (unknown [222.205.77.158])
        by mail-app3 (Coremail) with SMTP id cC_KCgDHz4uRNMZe_xjnAA--.1772S4;
        Thu, 21 May 2020 15:58:13 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: tegra114: Fix runtime PM imbalance on error
Date:   Thu, 21 May 2020 15:58:07 +0800
Message-Id: <20200521075807.23535-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgDHz4uRNMZe_xjnAA--.1772S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW7ZFW3Gr18JF1xWF4UArb_yoW3CFc_Gr
        s8Xr1xGF4fKFsrXF4jga43ZrySqFs8Xr1Fgr1vyFy3K3yq9r1UCrWDZr1qkF47uw47AF1q
        yFnxWF4Iyry5CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
        AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l
        42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
        wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JU67KsUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEHBlZdtOPItAARsz
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus a pairing decrement is needed on
the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/spi/spi-tegra114.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 83edabdb41ad..5b3faa29f945 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1398,6 +1398,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
+		pm_runtime_put(&pdev->dev);
 		goto exit_pm_disable;
 	}
 
-- 
2.17.1

