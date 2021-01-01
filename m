Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8282E8485
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 17:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbhAAQ6A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 11:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbhAAQ57 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 11:57:59 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8FC061573;
        Fri,  1 Jan 2021 08:57:19 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i7so14725939pgc.8;
        Fri, 01 Jan 2021 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IV2zNN3s1AfACJeGsDqVwWi6DEirf5Jq6E3RccO1dz8=;
        b=Ai8tnh7FMLxYYFLHaBhX5U6plgk8yhFEVGcLAKcddIq/0TVgcrpzZlg95rL7L7JQzo
         xST9xnE0y1v7ro1sygyEU6gkm1UtSO1wlSNkgfcKBZhCkneMeuSV2a2fn+r3SH7+Z9Kf
         d5fc3BhOXaZ6s/w83nR2KkEYf/kBn1YMGyYiXbSNnTejHWb/cvihI1/KOJatQq18IfpH
         YciVBMjoCWz9icOJYX8NTbWzv2JQwhulBP2HhprEg2tGwIm2r00qCdU1qoGEOJlfw++G
         sPXzbA58an1PsZE3WtwYRI4r+xsTJ8YSWVwRticDxU9HakPD15nl+uvJCHGFig/gQmrV
         l7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IV2zNN3s1AfACJeGsDqVwWi6DEirf5Jq6E3RccO1dz8=;
        b=GVONkCunNWUJvbRQiSa8LPBG17R2pzHYdeL9t7JAkz+unwTGODkk9ISMpyV8jEElCK
         9vIzDlBSP+HyLlPRZe1hytK6tB6C0bttArd/5hGQN2AltK/AfQXpmhaasqE8/lF03POw
         0ny+RBwAAOPvAnB/L0LoqMlF7qFxTDgUJtEtDUu3rgpIrRcbohTZYmLnnE6PLJQPpwzf
         XXjdyu+8G5uIqWlmN2fHbODhJ9ZOQiv1dB1I8/QUfxr6j8mjuoOgHTBB1fkG0fQIGz4G
         ahQQiq97azym8HNB9GEm81Oxfwu0N0B8D2Kkb6oSSBhshS/FYDRtAEZoB6hz6BNOErb5
         H5gA==
X-Gm-Message-State: AOAM533gfsIYgbVOtxFXH4AEFuNC5foKwfkxQck8aFYSwQ9LgN+c1X5+
        QdIbuHkfyYSaSxVo1KWRI68=
X-Google-Smtp-Source: ABdhPJxTg/RBi911Rlkg8zUKuFA1fjgLtPzwql4Vs33cJaLZwo97jJ74E4kLqBotEgBqj10cnqCjdQ==
X-Received: by 2002:a63:5526:: with SMTP id j38mr13794107pgb.177.1609520238832;
        Fri, 01 Jan 2021 08:57:18 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:57:18 -0800 (PST)
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
Subject: [PATCH 08/31] spi: spi-qcom-qspi: fix potential mem leak in spi_geni_probe()
Date:   Fri,  1 Jan 2021 16:54:44 +0000
Message-Id: <20210101165507.19486-9-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We should use dev_pm_opp_put_clkname() to free opp table each time
dev_pm_opp_of_add_table() got error.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/spi/spi-geni-qcom.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 512e925d5ea4..2b5a164fecb9 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -620,9 +620,12 @@ static int spi_geni_probe(struct platform_device *pdev)
 		return PTR_ERR(mas->se.opp_table);
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (ret && ret != -ENODEV) {
-		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
-		goto put_clkname;
+	if (ret) {
+		dev_pm_opp_put_clkname(mas->se.opp_table);
+		if (ret != -ENODEV) {
+			dev_err(&pdev->dev, "invalid OPP table in device tree\n");
+			return ret;
+		}
 	}
 
 	spi->bus_num = -1;
@@ -675,7 +678,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 spi_geni_probe_runtime_disable:
 	pm_runtime_disable(dev);
 	dev_pm_opp_of_remove_table(&pdev->dev);
-put_clkname:
 	dev_pm_opp_put_clkname(mas->se.opp_table);
 	return ret;
 }
-- 
2.25.1

