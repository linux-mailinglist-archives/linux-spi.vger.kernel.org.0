Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8242E8507
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 18:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbhAARAz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 12:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbhAARAy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 12:00:54 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3BAC061757;
        Fri,  1 Jan 2021 09:00:13 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y8so11250880plp.8;
        Fri, 01 Jan 2021 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Esa4NiAtIZhtLWaWjJVhH3nVuZJ3eKXT+OiaiAMEdVc=;
        b=qlYytcJ/2MzwOV3LwrxaUFba/mYHC8CDBvxWd6lCkIkLlNH2mWUlKy84RDYOyqc31F
         feDOz7mxtwpZ8c+n4J7yHPUmEJscYGljtNpQWCyU/42ErQjS4h3r7u7WizYlfNyAqSh0
         HvkrQu7Egge2vU+w97NYle6WTOXuMkTV+bZ2U0c8ZGLof78QQHx49rc96OqBlstiLIgK
         OfHyKjExDM7ggqTdyGEs1fwAQxKfZRA/34C0Jkxk564+5S48gAmeuvzwmAQTjho2gQwh
         FlPiuRRvnqA4SkHgM/vAGL1u7cO9vpwSTZ4upa15WNR6gzeFbwCpqoCY2Ve/oXbHLcB/
         QLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Esa4NiAtIZhtLWaWjJVhH3nVuZJ3eKXT+OiaiAMEdVc=;
        b=t6V1nSNanqfjhsW1yxyYnOFvD0Q66YlkDh1WMSrizpxG4Ho8ZPniIv00uKml0gT1ff
         fYsKJmdJ6cKCOUFgkutGjA9pEmz77/SJZ2wpbjFqD+PQnoFMs+wpSHofj10V45FTkgqV
         5wZyIxq3ZOZHSc4pVQqfQJgmwMdvNAdpW2dP5UR96mNUoE2AtvfGlhxJxuHjAxgFQODP
         LIu5kshYoHKuaX4skuHd7lhjbKvcUMZf1lfrzEIOo1IxoS88BpcHIbzG3GSB9TGRVtew
         DpB2epaEAgAbEh9/rrFcRBW26Ocr8uiVHgv6FBKR4KeCKPolg5u387nGrMM92XLuVk0h
         FK1w==
X-Gm-Message-State: AOAM5307DASVezCa4SkhatPSLM/B5LcrvDV7vA+G9gMcvhzkF7IhZKGm
        dUhRiye1uMTTMRsXI9+k+EU=
X-Google-Smtp-Source: ABdhPJz6W2sQQ064VIhfp96RrbKHlDA3l3zB9C+asJD6z4ULlLYD2v0/5Cn/Jk4MSEeNZvNrJlXsqw==
X-Received: by 2002:a17:90a:a45:: with SMTP id o63mr18750005pjo.146.1609520413583;
        Fri, 01 Jan 2021 09:00:13 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.09.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 09:00:12 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, digetx@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yuq825@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robdclark@gmail.com, sean@poorly.run,
        robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, stanimir.varbanov@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        lukasz.luba@arm.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        hoegsberg@google.com, eric@anholt.net, tzimmermann@suse.de,
        marijn.suijten@somainline.org, gustavoars@kernel.org,
        emil.velikov@collabora.com, jonathan@marek.ca,
        akhilpo@codeaurora.org, smasetty@codeaurora.org,
        airlied@redhat.com, masneyb@onstation.org, kalyan_t@codeaurora.org,
        tanmay@codeaurora.org, tiny.windzz@gmail.com,
        ddavenport@chromium.org, jsanka@codeaurora.org,
        rnayak@codeaurora.org, tongtiangen@huawei.com,
        miaoqinglang@huawei.com, khsieh@codeaurora.org,
        abhinavk@codeaurora.org, chandanu@codeaurora.org,
        groeck@chromium.org, varar@codeaurora.org, mka@chromium.org,
        harigovi@codeaurora.org, rikard.falkeborn@gmail.com,
        natechancellor@gmail.com, georgi.djakov@linaro.org,
        akashast@codeaurora.org, parashar@codeaurora.org,
        dianders@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 22/31] memory: samsung: exynos5422-dmc: fix return error in exynos5_init_freq_table
Date:   Fri,  1 Jan 2021 16:54:58 +0000
Message-Id: <20210101165507.19486-23-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We can't always return -EINVAL, let's fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index c5ee4121a4d2..62a83633f837 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -353,16 +353,20 @@ static int exynos5_init_freq_table(struct exynos5_dmc *dmc,
 
 	dmc->opp = devm_kmalloc_array(dmc->dev, dmc->opp_count,
 				      sizeof(struct dmc_opp_table), GFP_KERNEL);
-	if (!dmc->opp)
+	if (!dmc->opp) {
+		ret = -ENOMEM;
 		goto err_opp;
+	}
 
 	idx = dmc->opp_count - 1;
 	for (i = 0, freq = ULONG_MAX; i < dmc->opp_count; i++, freq--) {
 		struct dev_pm_opp *opp;
 
 		opp = dev_pm_opp_find_freq_floor(dmc->dev, &freq);
-		if (IS_ERR(opp))
+		if (IS_ERR(opp)) {
+			ret = PTR_ERR(opp);
 			goto err_opp;
+		}
 
 		dmc->opp[idx - i].freq_hz = freq;
 		dmc->opp[idx - i].volt_uv = dev_pm_opp_get_voltage(opp);
@@ -375,7 +379,7 @@ static int exynos5_init_freq_table(struct exynos5_dmc *dmc,
 err_opp:
 	dev_pm_opp_of_remove_table(dmc->dev);
 
-	return -EINVAL;
+	return ret;
 }
 
 /**
-- 
2.25.1

