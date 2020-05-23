Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530531DF749
	for <lists+linux-spi@lfdr.de>; Sat, 23 May 2020 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgEWMsN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 May 2020 08:48:13 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:24630 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726671AbgEWMsN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 23 May 2020 08:48:13 -0400
Received: from localhost.localdomain (unknown [222.205.77.158])
        by mail-app4 (Coremail) with SMTP id cS_KCgB3zwl+G8leagsTAg--.11847S4;
        Sat, 23 May 2020 20:48:02 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] spi: tegra20-sflash: Fix runtime PM imbalance on error
Date:   Sat, 23 May 2020 20:47:58 +0800
Message-Id: <20200523124758.28604-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgB3zwl+G8leagsTAg--.11847S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW7ZFW3Gr18JF1xWF4UArb_yoWfZrg_Cr
        s0qr9rGr4fKFWkW3WUG343ZrySvFZ8Zr1vqrs2yFy3K39YvF1Uu34kXrs8Cr18u3yjyr1q
        yr95KFyxArn8CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUID73UUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEJBlZdtORShQADsD
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus a pairing decrement is needed on
the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Use pm_runtime_put_noidle() instead of pm_runtime_put().
---
 drivers/spi/spi-tegra20-sflash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 514429379206..02cf5f463ba6 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -491,6 +491,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
+		pm_runtime_put_noidle(&pdev->dev);
 		goto exit_pm_disable;
 	}
 
-- 
2.17.1

