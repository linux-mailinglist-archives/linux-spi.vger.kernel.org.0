Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8633A6A1
	for <lists+linux-spi@lfdr.de>; Sun, 14 Mar 2021 17:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhCNQfx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Mar 2021 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbhCNQe7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Mar 2021 12:34:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4FC061574;
        Sun, 14 Mar 2021 09:34:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w11so7451409wrr.10;
        Sun, 14 Mar 2021 09:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yf+iKFcas/0uJoCP5/vtaWj8GnADCEOBO/yEczpj9kI=;
        b=ppsS1pK7H2N/OHPVt818su8ZmgPauDF+VE0HF6n30iy9PosMmhRbW+xFPtmKOHdsEf
         aXtWn7eRzpckEKaGNbtTvXoErtPQ9/zRLQ3HYUCbTQFSs1BEiYUkxAmkCwlb7mYcLSbR
         rTeCySKnUjuDcS0wtPKCqixjQfN8pwzCyoSxsU5iZRHWS2dfWWbfHw2MOoEw/W6tGK6s
         GrWUeJu9IsMAyYSnUhkBjLoF4T8IQb5XREczYr3d28EzqAKc/mOe0a5GFmDG0jTHUwEG
         Wni8zBOfBtfyTEsQTou3erE1gmwHrzwKzMvk7GGAAeXb/vB9hYcXICRMNhv/Gljz1VCK
         ffQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yf+iKFcas/0uJoCP5/vtaWj8GnADCEOBO/yEczpj9kI=;
        b=s7lSLZvVi8bf6EFeBSQaw+u54cl4mRvNOGVplJ515jFXTxg2bWMkxWda+5f4SVNuO5
         Mmk8GfHk7a+6x38Jq0x3Nv/Ra4mDZlvoyxNhqd8r9hfQokpqw0tEYxchyTXSBfqBDjIh
         6JixBlD5Y1R3x/R9ELFK+OoT9j1E/XO2JD4HE8ZMGCN7JXJ1mMbtp7ppy3znqcQ1Ctb8
         cEcYcWLghElhz6nulQw1XavKX994chwyo0Qxgj2GEudfEORzYswReg/5RrrxR6jd7Vcn
         J81m4nVZJiOXUJvNK6O9lvfU4obQY1p7iP+EdN3OZXcLtI2Qa+zov8VfbubO8sAcHzrC
         EU1w==
X-Gm-Message-State: AOAM533kQ+aq7dxTlCk+hBD3SFJ1hEqAXpbDqGcvN3+Zc3jVkdI25Pcn
        COg8LTv32/duVxxYMDDS2AY=
X-Google-Smtp-Source: ABdhPJyBQvV7xZv9vCfna5TuO6tJlXlewHlW50bnTQPbzuJunn1EI5WEi80mIYlzX20zsmb/XNcBXA==
X-Received: by 2002:a05:6000:10c5:: with SMTP id b5mr23293529wrx.347.1615739697207;
        Sun, 14 Mar 2021 09:34:57 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id o7sm15723239wrs.16.2021.03.14.09.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:34:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 13/15] drm/panfrost: Convert to use resource-managed OPP API
Date:   Sun, 14 Mar 2021 19:34:06 +0300
Message-Id: <20210314163408.22292-14-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314163408.22292-1-digetx@gmail.com>
References: <20210314163408.22292-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Use resource-managed OPP API to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 37 +++++----------------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  2 --
 2 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 56b3f5935703..c878391f3e8c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -89,29 +89,25 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	unsigned long cur_freq;
 	struct device *dev = &pfdev->pdev->dev;
 	struct devfreq *devfreq;
-	struct opp_table *opp_table;
 	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
-	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
-					      pfdev->comp->num_supplies);
-	if (IS_ERR(opp_table)) {
-		ret = PTR_ERR(opp_table);
+	ret = devm_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
+					 pfdev->comp->num_supplies);
+	if (ret) {
 		/* Continue if the optional regulator is missing */
 		if (ret != -ENODEV) {
 			DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
-			goto err_fini;
+			return ret;
 		}
-	} else {
-		pfdevfreq->regulators_opp_table = opp_table;
 	}
 
-	ret = dev_pm_opp_of_add_table(dev);
+	ret = devm_pm_opp_of_add_table(dev);
 	if (ret) {
 		/* Optional, continue without devfreq */
 		if (ret == -ENODEV)
 			ret = 0;
-		goto err_fini;
+		return ret;
 	}
 	pfdevfreq->opp_of_table_added = true;
 
@@ -122,10 +118,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	cur_freq = clk_get_rate(pfdev->clock);
 
 	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
-	if (IS_ERR(opp)) {
-		ret = PTR_ERR(opp);
-		goto err_fini;
-	}
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
 
 	panfrost_devfreq_profile.initial_freq = cur_freq;
 	dev_pm_opp_put(opp);
@@ -134,8 +128,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
 	if (IS_ERR(devfreq)) {
 		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
-		ret = PTR_ERR(devfreq);
-		goto err_fini;
+		return PTR_ERR(devfreq);
 	}
 	pfdevfreq->devfreq = devfreq;
 
@@ -146,10 +139,6 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		pfdevfreq->cooling = cooling;
 
 	return 0;
-
-err_fini:
-	panfrost_devfreq_fini(pfdev);
-	return ret;
 }
 
 void panfrost_devfreq_fini(struct panfrost_device *pfdev)
@@ -160,14 +149,6 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 		devfreq_cooling_unregister(pfdevfreq->cooling);
 		pfdevfreq->cooling = NULL;
 	}
-
-	if (pfdevfreq->opp_of_table_added) {
-		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
-		pfdevfreq->opp_of_table_added = false;
-	}
-
-	dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table);
-	pfdevfreq->regulators_opp_table = NULL;
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index db6ea48e21f9..210269944687 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -8,14 +8,12 @@
 #include <linux/ktime.h>
 
 struct devfreq;
-struct opp_table;
 struct thermal_cooling_device;
 
 struct panfrost_device;
 
 struct panfrost_devfreq {
 	struct devfreq *devfreq;
-	struct opp_table *regulators_opp_table;
 	struct thermal_cooling_device *cooling;
 	bool opp_of_table_added;
 
-- 
2.30.2

