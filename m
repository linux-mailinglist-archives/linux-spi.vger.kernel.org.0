Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0DD2E844E
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 17:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbhAAQ4p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 11:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbhAAQ4o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 11:56:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E495C061757;
        Fri,  1 Jan 2021 08:56:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n3so3609649pjm.1;
        Fri, 01 Jan 2021 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OISCRAIgQmaekeb9pf1t/tmPDqoCnBDMBSksrG4GFjQ=;
        b=SdIQDlcoDtgHtyDHDnSCVrgkjZUXLuGMDtJBgcxPckF3bM3N7WFG+QUvJvtKkQn8FB
         0XOT8LcmsVwrgSwqZBQD5A3Fk5y4rpO6RMOthoajgzuYMlfHV8PbAg1ISwDfizb0E1Dx
         RFJXJXXDg2jboqZzG7Uor5ZyG8At4d8RnMDBue4iAX/IWH4tvHrabbwlppogJ2+LUVVS
         XOsiNRcEI/PNPQks0BJRVln6KmJYtEjsnCWuFZFF0kjmZKfW0DoUMlyYEdd7x3LnkJbE
         RIh27d2EFEpoA1RZkAm8iwXAVHMkuoEblNhw/kRM1uUdR333xCx9fkNzAVyNHkm58jqW
         zlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OISCRAIgQmaekeb9pf1t/tmPDqoCnBDMBSksrG4GFjQ=;
        b=Uae/hCqWHJj9ABXF7MlyW50z08lbsLLZTVtSJrX8Kix8U/T4Hg1tKkUglU+7nLqRyr
         zbHAdkCnEvkTZVFuX42G3RfA3EeiDkw6kTY6dG68iWEgPS8SW1+0xgcKtbKRaCqpyp+q
         pzGonpfG8FeENJZg7QlfsYZKlopvqwP8Gz+A/Oq55r3NhIP3TdQYPkoN5Q7SRZB+7bSr
         zF9G0qWJQIbAXADkIntRV9eBlJziN4/cf7EtFJcIxigrruETLIggYZCp7P30ZEd7P6Zh
         g8V4pQYuDDITIYmfylEAdZxyUq0GMIj6CNGOEQtSrJgGvPE9CcgO95TcHc28sxp9/Hu1
         YyFw==
X-Gm-Message-State: AOAM530FwGTgx1jFEZ/s+SiIDsYR65/u2OMkzvctBeSnHkW+gx1W0MyQ
        31Fx18xP9H0jFLfTXOJnmFQ=
X-Google-Smtp-Source: ABdhPJwjb4xwfxDXKA1dorvp6qFeN5ipKmunmnSI1p5KjVMGdvQDbupPU2QPQakI04ZRhL5vbcnZWA==
X-Received: by 2002:a17:90b:46ca:: with SMTP id jx10mr18747568pjb.208.1609520163922;
        Fri, 01 Jan 2021 08:56:03 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:56:03 -0800 (PST)
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
Subject: [PATCH 02/31] opp: Add devres wrapper for dev_pm_opp_set_regulators and dev_pm_opp_put_regulators
Date:   Fri,  1 Jan 2021 16:54:38 +0000
Message-Id: <20210101165507.19486-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add devres wrapper for dev_pm_opp_set_regulators()
dev_pm_opp_put_regulators () to simplify driver code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/opp/core.c     | 50 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  9 ++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 53fdf33732d5..8709689a7152 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1878,6 +1878,56 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulators);
 
+static void devm_pm_opp_regulators_release(void *data)
+{
+	dev_pm_opp_put_regulators(data);
+}
+
+/**
+ * devm_pm_opp_set_regulators() - Set regulator names for the device
+ * @dev: Device for which regulator name is being set.
+ * @names: Array of pointers to the names of the regulator.
+ * @count: Number of regulators.
+ *
+ * In order to support OPP switching, OPP layer needs to know the name of the
+ * device's regulators, as the core would be required to switch voltages as
+ * well.
+ *
+ * This must be called before any OPPs are initialized for the device.
+ *
+ * The opp_table structure will be freed after the device is destroyed.
+ */
+struct opp_table *devm_pm_opp_set_regulators(struct device *dev,
+					    const char * const names[],
+					    unsigned int count)
+{
+	struct opp_table *opp_table;
+	int err;
+
+	opp_table = dev_pm_opp_set_regulators(dev, names, count);
+	if (IS_ERR(opp_table))
+		return opp_table;
+
+	err = devm_add_action_or_reset(dev, devm_pm_opp_regulators_release,
+				       opp_table);
+	if (err)
+		opp_table = ERR_PTR(err);
+
+	return opp_table;
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_set_regulators);
+
+/**
+ * devm_pm_opp_put_regulators() - Releases resources blocked for regulator
+ * @dev: Device for which we do this operation.
+ * @opp_table: OPP table returned from dev_pm_opp_set_regulators().
+ */
+void devm_pm_opp_put_regulators(struct device *dev, struct opp_table *opp_table)
+{
+	devm_release_action(dev, devm_pm_opp_regulators_release, opp_table);
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_put_regulators);
+
 /**
  * dev_pm_opp_set_clkname() - Set clk name for the device
  * @dev: Device for which clk name is being set.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 3418a2874f88..8a329247e08e 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -143,6 +143,8 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
+struct opp_table *devm_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
+void devm_pm_opp_put_regulators(struct device *dev, struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *devm_pm_opp_set_clkname(struct device *dev, const char *name);
@@ -321,6 +323,13 @@ static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, co
 
 static inline void dev_pm_opp_put_regulators(struct opp_table *opp_table) {}
 
+static inline struct opp_table *devm_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void devm_pm_opp_put_regulators(struct device *dev, struct opp_table *opp_table) {}
+
 static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.25.1

