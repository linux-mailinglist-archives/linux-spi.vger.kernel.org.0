Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29B82E84D8
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 18:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbhAAQ7x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 11:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbhAAQ7w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 11:59:52 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E48C061575;
        Fri,  1 Jan 2021 08:59:11 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n25so14758720pgb.0;
        Fri, 01 Jan 2021 08:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nOrTUQDqcrp2yYz1ncMfAxE/wuO+TeNVbsnY/E5njVM=;
        b=FvhIcKL3gFiPC4MQWFrECdhBaInvbpXZajHPBTLO4leoKndbMVjn4PirVv/WrJBOWd
         gPiGbT+cLi0DEBGjhKn1pBYl+05SdRVH5gPrOY+ST5LgGpwDQIWF7ahuQ65u2CxR3GTk
         TZqaNidqcVUmoWXGnCk9YOAEE5ZUP1Hvbrj+Ke+oaTdDLfRiC06LnnxNv/rB43nh5zm1
         MMBCVkPeuFz0g3SbSJ4y85cNobRU37bLr+GAbX9CnuVVwbhPAgdttmqGThiT7vImAisd
         A4hDkGLn4Do9bCqON+9QKfOpz2a+px41iaIZyuV7Ul+YwTnUauP4UkGaBlCPNaEJMa5D
         gDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nOrTUQDqcrp2yYz1ncMfAxE/wuO+TeNVbsnY/E5njVM=;
        b=hQOv6TsSHKd+xjsRwHp3kSTLnKKqKwNvQxM+YT95ouv9Izxkjs0f4LQ64tAO00Yj6v
         Bjwcakebi0BBTNi+Icn5fItQ9IsDbi4GjS9ae8Xkl2dyeKtB0u5ObTtHQz2LQxSiszX1
         u6H3/PnakorY9i7SVaQRS4vgZ3oF5wLlq/vaL739+zme/SJ9ErpVNsMukoGj2jHZsdSC
         7MKG4gS9Z5ZcgApXGBB4pBQcqvjpLU+XOaLK5sk/qIHd0AogdsfB0SxMcUEjyVp6SHv7
         9LrmOcHo8trFNspfL28uXIbAvIj5ZtLwnBCJ9G7YXB6s+K1Q7ILNtFnTDQcypM8a7o5T
         PQ2w==
X-Gm-Message-State: AOAM530TE+gRhHLM+tIGP94cp7pDHocXZLDkxuZF+RberXkiQYfs2Zkw
        pacwfV6Nq7FpDUrH5PrSIjY=
X-Google-Smtp-Source: ABdhPJx9/a2A0liu3B7BHFV2hGRrEo3CW6/DaLKHJLACZdl+Eayk3FGJay3TkpxphgxWPoYQuCchfQ==
X-Received: by 2002:a05:6a00:1596:b029:19d:96b8:6eab with SMTP id u22-20020a056a001596b029019d96b86eabmr56106663pfk.38.1609520351287;
        Fri, 01 Jan 2021 08:59:11 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:59:10 -0800 (PST)
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
Subject: [PATCH 17/31] drm/lima: convert to use devm_pm_opp_* API
Date:   Fri,  1 Jan 2021 16:54:53 +0000
Message-Id: <20210101165507.19486-18-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use devm_pm_opp_* API to simplify code, and remove opp_table
from lima_devfreq.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/gpu/drm/lima/lima_devfreq.c | 40 ++++++++---------------------
 drivers/gpu/drm/lima/lima_devfreq.h |  2 --
 2 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index 5686ad4aaf7c..d5937cf86504 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -99,13 +99,6 @@ void lima_devfreq_fini(struct lima_device *ldev)
 		devm_devfreq_remove_device(ldev->dev, devfreq->devfreq);
 		devfreq->devfreq = NULL;
 	}
-
-	dev_pm_opp_of_remove_table(ldev->dev);
-
-	dev_pm_opp_put_regulators(devfreq->regulators_opp_table);
-	dev_pm_opp_put_clkname(devfreq->clkname_opp_table);
-	devfreq->regulators_opp_table = NULL;
-	devfreq->clkname_opp_table = NULL;
 }
 
 int lima_devfreq_init(struct lima_device *ldev)
@@ -125,15 +118,11 @@ int lima_devfreq_init(struct lima_device *ldev)
 
 	spin_lock_init(&ldevfreq->lock);
 
-	opp_table = dev_pm_opp_set_clkname(dev, "core");
-	if (IS_ERR(opp_table)) {
-		ret = PTR_ERR(opp_table);
-		goto err_fini;
-	}
-
-	ldevfreq->clkname_opp_table = opp_table;
+	opp_table = devm_pm_opp_set_clkname(dev, "core");
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
 
-	opp_table = dev_pm_opp_set_regulators(dev,
+	opp_table = devm_pm_opp_set_regulators(dev,
 					      (const char *[]){ "mali" },
 					      1);
 	if (IS_ERR(opp_table)) {
@@ -141,24 +130,20 @@ int lima_devfreq_init(struct lima_device *ldev)
 
 		/* Continue if the optional regulator is missing */
 		if (ret != -ENODEV)
-			goto err_fini;
-	} else {
-		ldevfreq->regulators_opp_table = opp_table;
+			return ret;
 	}
 
-	ret = dev_pm_opp_of_add_table(dev);
+	ret = devm_pm_opp_of_add_table(dev);
 	if (ret)
-		goto err_fini;
+		return ret;
 
 	lima_devfreq_reset(ldevfreq);
 
 	cur_freq = clk_get_rate(ldev->clk_gpu);
 
 	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
-	if (IS_ERR(opp)) {
-		ret = PTR_ERR(opp);
-		goto err_fini;
-	}
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
 
 	lima_devfreq_profile.initial_freq = cur_freq;
 	dev_pm_opp_put(opp);
@@ -167,8 +152,7 @@ int lima_devfreq_init(struct lima_device *ldev)
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
 	if (IS_ERR(devfreq)) {
 		dev_err(dev, "Couldn't initialize GPU devfreq\n");
-		ret = PTR_ERR(devfreq);
-		goto err_fini;
+		return PTR_ERR(devfreq);
 	}
 
 	ldevfreq->devfreq = devfreq;
@@ -180,10 +164,6 @@ int lima_devfreq_init(struct lima_device *ldev)
 		ldevfreq->cooling = cooling;
 
 	return 0;
-
-err_fini:
-	lima_devfreq_fini(ldev);
-	return ret;
 }
 
 void lima_devfreq_record_busy(struct lima_devfreq *devfreq)
diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
index 2d9b3008ce77..c3bcae76ca07 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.h
+++ b/drivers/gpu/drm/lima/lima_devfreq.h
@@ -15,8 +15,6 @@ struct lima_device;
 
 struct lima_devfreq {
 	struct devfreq *devfreq;
-	struct opp_table *clkname_opp_table;
-	struct opp_table *regulators_opp_table;
 	struct thermal_cooling_device *cooling;
 
 	ktime_t busy_time;
-- 
2.25.1

