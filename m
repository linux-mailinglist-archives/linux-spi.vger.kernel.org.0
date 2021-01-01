Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47C12E84C6
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 18:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbhAAQ73 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 11:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbhAAQ71 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 11:59:27 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E22C0613C1;
        Fri,  1 Jan 2021 08:58:46 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id h186so12675496pfe.0;
        Fri, 01 Jan 2021 08:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U36W0smHOpfrbDvJ1LTZufZA8+bqUZFQOq+xGSvEz0Q=;
        b=gKaKzWCjoMrxvhanzaf7tyCsDC/hfSnueuE8JW5m51OOp9Z6WvwF/9vPAZN7rMzBge
         URiLDqq57o/V3sk4oFnTbpTF6dTUDM071vmfcj+39aaweZske2Hmg7/xz6Agpup5MvhE
         VCTOBGdMDYWKKT3SSRBBBqzcBStN4t36/GnqgKjx7dpq6RneL6FgqY9pO5wzwvrNKhqy
         FN0LMPSXoDbAUhapYneJJIH2yRgbV0fyIKNjmx0yEVcyCFbUAQaUPi14s3gI9TzG7kbr
         5XkvuyB4qXKyvKfKF1Gw8IdLeTgbKRYYCaCx3fxt/AMk6UGti0Lm20Ll/jIh7L2BebN+
         jesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U36W0smHOpfrbDvJ1LTZufZA8+bqUZFQOq+xGSvEz0Q=;
        b=jTRUFpKGUuU34oXkDpU4GO3n9Ve2wKfliQLhVds+ZGS0oemORcRRBM70Xro36pIhFy
         oWqjWcoTb0qZvRYR6wgHgiBL0F45z9dW/VPRHFQDeXi9tWDLAxdjI/efegEG41EXB5Aj
         t/lVOvaXzckYKDP47SyDUhAbJbYZJ6nfrzBJQqlQLDVXEPjH8fJjZqfysN+b9b8fVHX2
         ia1RvBkKvCpMdU30mdy6F5LJIZJ3VG9UgDKgc4Ha2CyxNKrlDXtMqILsojsRBCWETOdl
         cii4MKM4c1Um4jVrMHra+mkZfO2fusVUJ2ypGtm4at9KKb848vrcuhvEmGFe6tQe1Qid
         0Z3w==
X-Gm-Message-State: AOAM5324R8AO+x38K0nXR2iV48iBsfYEHGjwNk75bRk85h9tpSPKmNpb
        w6Zb/UbIm8D1SzdtzyuHsuE=
X-Google-Smtp-Source: ABdhPJzx00BSeoHxNsLlnYUTpYihiZKk22bXxnJ8w2R+GCGYn3Ld1jNT8zpXeyfnV8iIpkFNwzyFcw==
X-Received: by 2002:aa7:9a07:0:b029:1a6:5f93:a19f with SMTP id w7-20020aa79a070000b02901a65f93a19fmr35843925pfj.21.1609520326359;
        Fri, 01 Jan 2021 08:58:46 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:58:45 -0800 (PST)
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
Subject: [PATCH 15/31] drm/msm: fix potential mem leak
Date:   Fri,  1 Jan 2021 16:54:51 +0000
Message-Id: <20210101165507.19486-16-tiny.windzz@gmail.com>
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 10 ++++++----
 drivers/gpu/drm/msm/dsi/dsi_host.c      |  8 +++++---
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 374b0e8471e6..6f19dfcb4965 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1093,9 +1093,12 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(dpu_kms->opp_table);
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(dev);
-	if (ret && ret != -ENODEV) {
-		dev_err(dev, "invalid OPP table in device tree\n");
-		goto put_clkname;
+	if (ret) {
+		dev_pm_opp_put_clkname(dpu_kms->opp_table);
+		if (ret != -ENODEV) {
+			dev_err(dev, "invalid OPP table in device tree\n");
+			return ret;
+		}
 	}
 
 	mp = &dpu_kms->mp;
@@ -1122,7 +1125,6 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 	return ret;
 err:
 	dev_pm_opp_of_remove_table(dev);
-put_clkname:
 	dev_pm_opp_put_clkname(dpu_kms->opp_table);
 	return ret;
 }
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index ab281cba0f08..a282307f2799 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1891,10 +1891,12 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 		return PTR_ERR(msm_host->opp_table);
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (ret && ret != -ENODEV) {
-		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
+	if (ret) {
 		dev_pm_opp_put_clkname(msm_host->opp_table);
-		return ret;
+		if (ret != -ENODEV) {
+			dev_err(&pdev->dev, "invalid OPP table in device tree\n");
+			return ret;
+		}
 	}
 
 	init_completion(&msm_host->dma_comp);
-- 
2.25.1

