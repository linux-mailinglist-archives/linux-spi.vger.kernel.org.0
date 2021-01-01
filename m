Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C1B2E8517
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 18:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbhAARBU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 12:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbhAARBT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 12:01:19 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7E8C061573;
        Fri,  1 Jan 2021 09:00:39 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v1so6300300pjr.2;
        Fri, 01 Jan 2021 09:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8tu+qmTBn19dJ5gPJsn24LjDSvHBfNF8Z6WeRyPnF0o=;
        b=mtSShWOVItM7MqI3Ko7jFbYK4A8hl8pYqozq5KjocZVA23lW9QNonT8PJHA8dcPpTT
         hLP9GVa6SmvfValVy1c405ZwzEV0OL2w8EJvYuIXLPZD3567ExhOEf1QTA05xlhKsnlM
         CdAiTFViPyb7B88OR5kDre0PQPAl/MVnvcCHw2erWjrZtZCkqQKVwutd47duJlNxQSIX
         uE9ZZYKMgni5Z5Oli1DM/qZA/Gbmg0iVW/cWOXgZWa4M4npQ6m2tKmWgL7TKn2N2Nsdv
         uQY1BK6fWL6j/nVNJ+loYM+pc2TfwSMBKRZoWz+r9WXKAB71He02AHNrxbpUVW0AoF6S
         4B5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8tu+qmTBn19dJ5gPJsn24LjDSvHBfNF8Z6WeRyPnF0o=;
        b=DVy5D/1FDfbWfqMXee4TjcnLts6uV8rwFOvxTMTmFhni7bU2z/pOAdyGjzXQa5XE7Q
         5Tuj8mL8zWmyZF3d6B8RZOJIBc2nbFsm2+vps32ufUXCosy9HN9LRCgNXDfVzSSmQm0G
         o+S5UiVoa/Hkp/9eOyDsLdwBX28pRX6qRxN2wQsm5vCP46T03Y0OCQ6PS5OYQ1fHaDjc
         gZdfWelmhW5LUswTOK8/JIxzAPFq2Avrl2wFbtfJFIAIDH8vhkyLn6k6/Ij6y7yY875b
         YPKjb3oihatGA0UPQXGRHsf79OIWN5oJDnCyoe6aAfFqNWbpA4hCzVtMafExNd3u6zj5
         QOcQ==
X-Gm-Message-State: AOAM531Ad2yEZTxTxDtEf4y3ZXxDucpau4mCTGCd4YPoy22yFFcTyS85
        0OYdEOo/XY/qBirFHi/37Mc=
X-Google-Smtp-Source: ABdhPJxdcJSkAjLz7kwVtZIMVT7S93VrpqFpUMA6/+FN8KvXEJO8cvrLmP3NDvFgN9RfnewK7jzAFg==
X-Received: by 2002:a17:90b:46ca:: with SMTP id jx10mr18760999pjb.208.1609520438671;
        Fri, 01 Jan 2021 09:00:38 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.09.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 09:00:38 -0800 (PST)
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
Subject: [PATCH 24/31] memory: tegra20: convert to use devm_pm_opp_* API
Date:   Fri,  1 Jan 2021 16:55:00 +0000
Message-Id: <20210101165507.19486-25-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use devm_pm_opp_* API to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 686aaf477d8a..223d9d97eb8f 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -911,31 +911,31 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 {
 	u32 hw_version = BIT(tegra_sku_info.soc_process_id);
-	struct opp_table *clk_opp_table, *hw_opp_table;
+	struct opp_table *opp_table;
 	int err;
 
-	clk_opp_table = dev_pm_opp_set_clkname(emc->dev, NULL);
-	err = PTR_ERR_OR_ZERO(clk_opp_table);
+	opp_table = devm_pm_opp_set_clkname(emc->dev, NULL);
+	err = PTR_ERR_OR_ZERO(opp_table);
 	if (err) {
 		dev_err(emc->dev, "failed to set OPP clk: %d\n", err);
 		return err;
 	}
 
-	hw_opp_table = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
-	err = PTR_ERR_OR_ZERO(hw_opp_table);
+	opp_table = devm_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
+	err = PTR_ERR_OR_ZERO(opp_table);
 	if (err) {
 		dev_err(emc->dev, "failed to set OPP supported HW: %d\n", err);
-		goto put_clk_table;
+		return err;
 	}
 
-	err = dev_pm_opp_of_add_table(emc->dev);
+	err = devm_pm_opp_of_add_table(emc->dev);
 	if (err) {
 		if (err == -ENODEV)
 			dev_err(emc->dev, "OPP table not found, please update your device tree\n");
 		else
 			dev_err(emc->dev, "failed to add OPP table: %d\n", err);
 
-		goto put_hw_table;
+		return err;
 	}
 
 	dev_info(emc->dev, "OPP HW ver. 0x%x, current clock rate %lu MHz\n",
@@ -943,19 +943,8 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 
 	/* first dummy rate-set initializes voltage state */
 	err = dev_pm_opp_set_rate(emc->dev, clk_get_rate(emc->clk));
-	if (err) {
+	if (err)
 		dev_err(emc->dev, "failed to initialize OPP clock: %d\n", err);
-		goto remove_table;
-	}
-
-	return 0;
-
-remove_table:
-	dev_pm_opp_of_remove_table(emc->dev);
-put_hw_table:
-	dev_pm_opp_put_supported_hw(hw_opp_table);
-put_clk_table:
-	dev_pm_opp_put_clkname(clk_opp_table);
 
 	return err;
 }
-- 
2.25.1

