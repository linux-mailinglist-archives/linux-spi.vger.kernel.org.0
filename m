Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A38C2E84A0
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 17:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbhAAQ6i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 11:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbhAAQ6g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 11:58:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A690FC0613C1;
        Fri,  1 Jan 2021 08:57:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e2so11239376plt.12;
        Fri, 01 Jan 2021 08:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F/WPpPl1Y2V+ZuQ/3f5gGliaIHp/D14siqwLKMznygY=;
        b=ENVma3D0wKYDd0nhKbTeMlxg5anuR2s5IWLvunZO/1fBJgKY5iNCetO+aqVXUivOnw
         qlAaOGctYK5f8YLteGp1y+os+ACP4lTYrmUW+jVcnd198hEQSVBPTmylm6Nyl3mMd0X/
         2cnxylfaWb0KdeQV/K4LTwp3elEVWu7njUlFVAf8sqsWY4wpx1tGe8ZkjY+1kK/V1lzd
         lNebxa4G90GYtHFb2C/pZpw3aVjSiaZntZFUCk9Hqmu5wa9dNEBhE3BBHx9mRxGIeaRd
         4/6gDJ3/n4IG82Jzcy5e8W66PUMONsn4PvUo1OMtymZP80gSW4ARkXZbSlLcXthfqm3o
         PAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F/WPpPl1Y2V+ZuQ/3f5gGliaIHp/D14siqwLKMznygY=;
        b=iYODG+ycFkVlbWILQC4epLVH1JkY/2QNY0kVR3V4NSO6Vs+QDW2VQVWilzvpTjU9rV
         vtayT9LHZjzzeb2XwNFd/VT52jJ02mC/5SXiB/hAf1o0Ov0k1TW2CwcfJOM8Ks5n+Vos
         94c/b1J98m3XmsxLcK2xSoakqg6bpWECz3/AEyjz0IslL0QQeP4jOFrR2K7kTi/lBGG9
         C3V/Bj+OJllyRTkRNOYUfTpBwr6ZDaKRCWgY8kTV0AfcmP5pqCvhHEKqChwg149CNk+g
         oX8U7Mt1uk3veVk2p4bxDzOf5/GXI06RC5qZ6mn+rkUTAqqwe0ZDA7e4w4EAfGc35POK
         UVeA==
X-Gm-Message-State: AOAM530YICrXKzs7k4cxluzYDh4fSDM7qNMat1Oc3vpGiN0a6muYZ5p8
        DxVBkaLHuCOiJycKYYfqKWo=
X-Google-Smtp-Source: ABdhPJwN3a+tylYYOkBWZhvnWgkugep3Fs+zAJ5RKRkuMyfw7Ml6JnvpNbMtmrf2eIesHL27ttl/Ug==
X-Received: by 2002:a17:90b:224a:: with SMTP id hk10mr18256443pjb.81.1609520276252;
        Fri, 01 Jan 2021 08:57:56 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:57:55 -0800 (PST)
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
Subject: [PATCH 11/31] mmc: sdhci-msm: fix potential mem leak in sdhci_msm_probe()
Date:   Fri,  1 Jan 2021 16:54:47 +0000
Message-Id: <20210101165507.19486-12-tiny.windzz@gmail.com>
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
 drivers/mmc/host/sdhci-msm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 9c7927b03253..094ef95f5ecc 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2291,9 +2291,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (ret && ret != -ENODEV) {
-		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
-		goto opp_put_clkname;
+	if (ret) {
+		dev_pm_opp_put_clkname(msm_host->opp_table);
+		if (ret != -ENODEV) {
+			dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
+			goto bus_clk_disable;
+		}
 	}
 
 	/* Vote for maximum clock rate for maximum performance */
@@ -2461,7 +2464,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 				   msm_host->bulk_clks);
 opp_cleanup:
 	dev_pm_opp_of_remove_table(&pdev->dev);
-opp_put_clkname:
 	dev_pm_opp_put_clkname(msm_host->opp_table);
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
-- 
2.25.1

