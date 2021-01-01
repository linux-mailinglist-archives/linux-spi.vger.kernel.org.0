Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D732E846D
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 17:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbhAAQ5Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 11:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbhAAQ5V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 11:57:21 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB08CC061575;
        Fri,  1 Jan 2021 08:56:41 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e2so14740566pgi.5;
        Fri, 01 Jan 2021 08:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ubat3ts9FbAfreFZfiBfut7K86ikhtjfvpeWs7xXMEk=;
        b=J5Zl7BAcXm9OBOmHsB2ywSPSsP5FyZj1mInI7jaePvK/deKaOXY52OkOvVeosQOjvB
         Lu5eaT0gNcc3bMY/D726LmsCh2ZIqnZkqhVX37tsTZXLaF5xdxDt9+GfEOVXqG4LxgYs
         nTu+zD+7L4yuzwEQIf/LJU/XCkKUN1sJeew8plRjO8SesIOJG5jQoI5LhgWWW31YtGhG
         4YETODXP4Vo4nCl69trrf/MrslK+223YUxnjeqXbO+6blM4l4ZV0m7l48z+6MWyVh2ON
         /W0RqVC22XG9g6zBhvd0aItkxM5G4b/s2yFfsQ2A0RjaGj5zZ0qY991dz1LAc7uZMT6L
         +R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ubat3ts9FbAfreFZfiBfut7K86ikhtjfvpeWs7xXMEk=;
        b=cgUtPkWwDZzfc2vpxpaQQYgDL2ZnC4tSW7b+o0F0GUGjPd8qrtSGesHwzcQmVbwE1h
         lIvejYOuApMjLpCeUY5SLnNGgSg3j4NpaPR+P9YVxMKFuwAVE+Pw2zTcSc+hYWu57aYK
         iDRJtf5XUKbmXgOQjRrjjG/yigfTO6T+FoQ0M7hG6XCim74+QTSAJUR+b5fzWJBD7tA2
         T+PhqdVEtmuEpXNkQKvlu5+EbBmcq7dQ5etidNC69I1jRszRw/PMHxmj1Lgkg5JdWJxA
         H+1s/K/ysM+qP0hpCiHN/6EsfgAcMlF9CBO/l2oTfSRgblXp97hmmoT9ua681bIel24w
         qv4g==
X-Gm-Message-State: AOAM531pQy4KyT9mAHt3S5AC1qwBRiXaVXXsOfTU8ewVKZXluL8/TxqW
        Q8mRchWd+AhxOekmNMKprMI=
X-Google-Smtp-Source: ABdhPJwYfspmIkGNgMSm1eZOYHmkHpx4SDoHG3+f04ZQo0UnHylmSn2hZZkZjzhdjSLhB9FfLgcUEw==
X-Received: by 2002:a63:804a:: with SMTP id j71mr60757814pgd.307.1609520201310;
        Fri, 01 Jan 2021 08:56:41 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:56:40 -0800 (PST)
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
Subject: [PATCH 05/31] opp: Add devres wrapper for dev_pm_opp_register_notifier
Date:   Fri,  1 Jan 2021 16:54:41 +0000
Message-Id: <20210101165507.19486-6-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add devres wrapper for dev_pm_opp_register_notifier() to simplify driver
code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/opp/core.c     | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6b83e373f0d8..ef3544f8cecd 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2599,6 +2599,44 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
 }
 EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
 
+static void devm_pm_opp_notifier_release(struct device *dev, void *res)
+{
+	struct notifier_block *nb = *(struct notifier_block **)res;
+
+	WARN_ON(dev_pm_opp_unregister_notifier(dev, nb));
+}
+
+/**
+ * devm_pm_opp_register_notifier() - Register OPP notifier for the device
+ * @dev:	Device for which notifier needs to be registered
+ * @nb:		Notifier block to be registered
+ *
+ * Return: 0 on success or a negative error value.
+ *
+ * The notifier will be unregistered after the device is destroyed.
+ */
+int devm_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
+{
+	struct notifier_block **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_pm_opp_notifier_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = dev_pm_opp_register_notifier(dev, nb);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = nb;
+	devres_add(dev, ptr);
+
+	return 0;
+}
+EXPORT_SYMBOL(devm_pm_opp_register_notifier);
+
 /**
  * dev_pm_opp_remove_table() - Free all OPPs associated with the device
  * @dev:	device pointer used to lookup OPP table.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index e8bdac5f9555..c24bd34339d7 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -136,6 +136,7 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
+int devm_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 
 struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
@@ -288,6 +289,11 @@ static inline int dev_pm_opp_register_notifier(struct device *dev, struct notifi
 	return -ENOTSUPP;
 }
 
+static inline int devm_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
 static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb)
 {
 	return -ENOTSUPP;
-- 
2.25.1

