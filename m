Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D622E84A7
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbhAAQ6u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 11:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbhAAQ6t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 11:58:49 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587DBC061573;
        Fri,  1 Jan 2021 08:58:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x18so11262257pln.6;
        Fri, 01 Jan 2021 08:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7eakgo8QJNSQOzZIp+kIaMol/JySCEaf1ptbvEAaka0=;
        b=DHzNSUdvyWGgCdH/SvWiCsESLnMfgYC/Qbc8CIEcqHoxqaru1aKzzfk8A9sBn5wvsG
         MIDRwm0er7cZAcPNY2mE4+mtDbknzjXm43fnYcOb1U11EgHjgga4/gfufvavm0NBqP+y
         OcWjBDwLp+tHWtA+pBTwQCQYBVh4pUDGfLh54yMKewA0b7tWVjzCXHs8MuEiMC7Sg4bz
         Tslq0Xhmjp5WQDk/k4rROsXHti8aAqbazzO5SspRw+obRGrKxd3evdGHYCIGXGR8T0Vb
         Mf3gIEIos2/O2XKzc9f1WBkkXTA1APCm3M29sv3UqR95xy87Ng0dPz4TIAykuWWOz9D9
         xDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7eakgo8QJNSQOzZIp+kIaMol/JySCEaf1ptbvEAaka0=;
        b=rR8qaAlMvJfbF/MybotDyAs/YCdgb/fEroA6ZkNx/Zp0n55EHGocnjeqTA+VDYqloJ
         uNgKeiHhxy5AW3XoZ6qEmHboazKiE3pzSOAycfVbP1GxMFHUSFwtRb540X7c7pI1Ndg7
         D4GjM8wk68Ul71/8rb8bj0c1BXoV6CZy4Ibt8At/PwKTYue3f8FjKS0NGK1wvvCVj2gz
         kYSsb563fEZzU6b8nvCyI+d73Q6dzIR92UwaCiDP1/b29CRHQwz7G+VdfQuryyKFZB4Z
         Otc2fXpDWh6RAWFWEh4JUrl5La5p3EuRluHFTdfa3yfWPimdidhWs5JWOIRXS2ReYbEp
         WSAQ==
X-Gm-Message-State: AOAM5310SqVau4yqnMd2zm8glNnC3SIFeAc5bBOe5lyeA5ULqJkQMqqE
        72ujDoMt9u14OwaF4NOwlLQ=
X-Google-Smtp-Source: ABdhPJxj836hq8IHDM7wBHmGNMR++3q92xi77JSpCMFpBgRNCI8v5QOGIWumKF44tZ/O5Tx8//m4QA==
X-Received: by 2002:a17:90b:4b0a:: with SMTP id lx10mr18398745pjb.205.1609520288920;
        Fri, 01 Jan 2021 08:58:08 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:58:08 -0800 (PST)
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
Subject: [PATCH 12/31] mmc: sdhci-msm: convert to use devm_pm_opp_* API
Date:   Fri,  1 Jan 2021 16:54:48 +0000
Message-Id: <20210101165507.19486-13-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use devm_pm_opp_* API to simplify code, and remove opp_table
from sdhci_msm_host.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/mmc/host/sdhci-msm.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 094ef95f5ecc..490ba5d68f72 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -261,7 +261,6 @@ struct sdhci_msm_host {
 	struct clk_bulk_data bulk_clks[4]; /* core, iface, cal, sleep clocks */
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
-	struct opp_table *opp_table;
 	bool use_14lpp_dll_reset;
 	bool tuning_done;
 	bool calibration_done;
@@ -2215,6 +2214,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	const struct sdhci_msm_offset *msm_offset;
 	const struct sdhci_msm_variant_info *var_info;
 	struct device_node *node = pdev->dev.of_node;
+	struct opp_table *opp_table;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
 	if (IS_ERR(host))
@@ -2283,16 +2283,16 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (ret)
 		goto bus_clk_disable;
 
-	msm_host->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
-	if (IS_ERR(msm_host->opp_table)) {
-		ret = PTR_ERR(msm_host->opp_table);
+	opp_table = devm_pm_opp_set_clkname(&pdev->dev, "core");
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
 		goto bus_clk_disable;
 	}
 
 	/* OPP table is optional */
-	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	ret = devm_pm_opp_of_add_table(&pdev->dev);
 	if (ret) {
-		dev_pm_opp_put_clkname(msm_host->opp_table);
+		devm_pm_opp_put_clkname(&pdev->dev, opp_table);
 		if (ret != -ENODEV) {
 			dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
 			goto bus_clk_disable;
@@ -2317,7 +2317,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
 				      msm_host->bulk_clks);
 	if (ret)
-		goto opp_cleanup;
+		goto bus_clk_disable;
 
 	/*
 	 * xo clock is needed for FLL feature of cm_dll.
@@ -2462,9 +2462,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 clk_disable:
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
-opp_cleanup:
-	dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_clkname(msm_host->opp_table);
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
@@ -2483,8 +2480,6 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
-	dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_clkname(msm_host->opp_table);
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-- 
2.25.1

