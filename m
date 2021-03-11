Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D0337E14
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhCKTW3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhCKTV4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:21:56 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E4EC061574;
        Thu, 11 Mar 2021 11:21:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m22so41607188lfg.5;
        Thu, 11 Mar 2021 11:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqKfei5o+p1LDmMPic3/GGcfRGKV9mArN/Kd0be+sRk=;
        b=iiXXfpB1C+gnbK0/DeT43KLI/fORWdk2wUnK2WbfXh1yfxR6laQU0kdWW9RB9j/u2B
         +iWWZnNjK92tl5VaWjTwR6B44ECS+loZ74TlWriWfCEo4x34cX20+DAK0Z1yWbk04E1f
         ykCJ56ZNamFlTXptrAN+d6XLxlaJZKnYdg7Ap3ee/6prcStBNurIfldD+vWg56ijpX+h
         vWzU8iilkhQqhmL6p8UuEdQphJl4t6wFggy8TATlvH+3hnBz4aZ+NLBzVi03+lB3FFAY
         xIlmwo/13YpOTDAip7ZeKkJj7mb+NA5I3J4+5/nfz956+QWxhOOatqRWDWgV5TlGblul
         FPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqKfei5o+p1LDmMPic3/GGcfRGKV9mArN/Kd0be+sRk=;
        b=G3GvTBoYxs8iy4SyOdpGoVz0DQj1wUxSFk3SZHvNjeoSUt1/TmdP25yw/rAw8ypQdn
         WQo8+AtCrg6XVD2RkooynK5u2lWhzxTMBPDGWHdQdkHtro/xYnlzbaigkl0cE0Dn1mGS
         EjrAXd87ZULczaSn+R2S5Fsm0CZT47Ss1PjVAGshl2qYfpkRc/YDB5hbCb2nP1ssYBUq
         Y1pVEq5bcQI2avk3UB1jOPhc8Q7zkMO+tr7+HKQDyG+YNvCel2VBrfj50M8vCpfw+bV6
         Q2quqypdOlcLXkLvfuCE726XH8ygLpxq3kfWnXgKmcXrpbTjFtfvW4pvplmK0l6BZOdb
         FlKA==
X-Gm-Message-State: AOAM5313xMXRXcSR9/Y/iqkEKiFEbOWfmPCV3awkXGVeafI8Hw++cpNY
        sK6PJ3RI0XV2W+tH6vUJ+ck=
X-Google-Smtp-Source: ABdhPJxHhzSO5qkov352chgUZ1noI4EztWWaTwMtjW0L+gOi4Y6lGvXdtI/aQNvF79jf49rIBHoPxQ==
X-Received: by 2002:a05:6512:1192:: with SMTP id g18mr3233341lfr.102.1615490514041;
        Thu, 11 Mar 2021 11:21:54 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id u14sm1121153lfl.40.2021.03.11.11.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:21:53 -0800 (PST)
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
Subject: [PATCH v2 14/14] memory: samsung: exynos5422-dmc: Convert to use resource-managed OPP API
Date:   Thu, 11 Mar 2021 22:21:05 +0300
Message-Id: <20210311192105.14998-15-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311192105.14998-1-digetx@gmail.com>
References: <20210311192105.14998-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Use resource-managed API to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 1dabb509dec3..56f6e65d40cd 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -343,7 +343,7 @@ static int exynos5_init_freq_table(struct exynos5_dmc *dmc,
 	int idx;
 	unsigned long freq;
 
-	ret = dev_pm_opp_of_add_table(dmc->dev);
+	ret = devm_pm_opp_of_add_table(dmc->dev);
 	if (ret < 0) {
 		dev_err(dmc->dev, "Failed to get OPP table\n");
 		return ret;
@@ -354,7 +354,7 @@ static int exynos5_init_freq_table(struct exynos5_dmc *dmc,
 	dmc->opp = devm_kmalloc_array(dmc->dev, dmc->opp_count,
 				      sizeof(struct dmc_opp_table), GFP_KERNEL);
 	if (!dmc->opp)
-		goto err_opp;
+		return -ENOMEM;
 
 	idx = dmc->opp_count - 1;
 	for (i = 0, freq = ULONG_MAX; i < dmc->opp_count; i++, freq--) {
@@ -362,7 +362,7 @@ static int exynos5_init_freq_table(struct exynos5_dmc *dmc,
 
 		opp = dev_pm_opp_find_freq_floor(dmc->dev, &freq);
 		if (IS_ERR(opp))
-			goto err_opp;
+			return PTR_ERR(opp);
 
 		dmc->opp[idx - i].freq_hz = freq;
 		dmc->opp[idx - i].volt_uv = dev_pm_opp_get_voltage(opp);
@@ -371,11 +371,6 @@ static int exynos5_init_freq_table(struct exynos5_dmc *dmc,
 	}
 
 	return 0;
-
-err_opp:
-	dev_pm_opp_of_remove_table(dmc->dev);
-
-	return -EINVAL;
 }
 
 /**
@@ -1567,8 +1562,6 @@ static int exynos5_dmc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(dmc->mout_bpll);
 	clk_disable_unprepare(dmc->fout_bpll);
 
-	dev_pm_opp_remove_table(dmc->dev);
-
 	return 0;
 }
 
-- 
2.29.2

