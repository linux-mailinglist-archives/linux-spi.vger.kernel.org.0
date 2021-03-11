Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87975337DEB
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCKTWQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCKTVk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:21:40 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA26C061574;
        Thu, 11 Mar 2021 11:21:40 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id n16so41667939lfb.4;
        Thu, 11 Mar 2021 11:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8i2m6/lbGAJtR7Xwt+kU6jxv1RbA+nyvb63j6asz8nw=;
        b=MUE9yscja7aODDVELlQzIVChcBIY3VT343YpkiHtPvHUx3/KmJumGYJWGzCDGGbDYx
         lBnHjCeSfpKyO5cSrJOG01g1+pZVsw/kqlS9XYfHSsavbSfJQNirkFlTmm0BBYoqhcn7
         5iz5VS2e9/JCdqaJs4A0fJQ1Y9dAvGwQWXPllP4p/X+X7xwW78N9LTa7PCvIbiyirWcB
         UQAQAtNx3B39+lHCgLkfVK60Egvxa+6XepdgUXoq54LQhRPeoHmZiVA0mFwbNOXywdtt
         LDWFTT/gmDp54FCYjR2m7BuwX0hOjgzZFRsNX9GKOgXBhs40uN3GQKwReR3haMNd8+9Z
         /vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8i2m6/lbGAJtR7Xwt+kU6jxv1RbA+nyvb63j6asz8nw=;
        b=aT4bECvaiJbahj8P2ZF6PfJudyN1xkaZSzGU/W7voueEL20mnT3OzeDqNYBMgdAjR5
         k0aEbAcmgljJWlQu1rtTsAqyQEYUG8LneC0biTe8Fcvxkm0T/FPajXdv6x7D2vKixSQN
         Msxncbd1O1pNc5Dr7m12hjiNMeohkGYEXljh0lHuL4pyCTn9H6KwzKW7JGLOC72NJ+XT
         2riT0cvvqVp8UitGo/J/N1d+6FcQiXGk7M3yqlfJ9pXTKEDLednkJ5OD3MTDbEMOAs5v
         e2B4DRwDPZzX5TYhHvIeD0RinGuS1mXGh2PIk+YMWYEKJDmmGtm3LZT0PF7Pk9OARqOg
         K6zw==
X-Gm-Message-State: AOAM531JV+mDgv9CISN9Mqbo5RrEX7pExkhyth/8NKXIZxgmZZ6jtVU1
        MZDivJaoF474OqwrLAqvS+k=
X-Google-Smtp-Source: ABdhPJzyUMWCLGE0yuiOb/wr0yRnTsa8uCE3SwXolRlUCGlz7AcSAe4t/FII105i2sbhdr3WZ15zHg==
X-Received: by 2002:ac2:5052:: with SMTP id a18mr3025894lfm.55.1615490498881;
        Thu, 11 Mar 2021 11:21:38 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id u14sm1121153lfl.40.2021.03.11.11.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:21:38 -0800 (PST)
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
Subject: [PATCH v2 02/14] opp: Add devres wrapper for dev_pm_opp_set_regulators
Date:   Thu, 11 Mar 2021 22:20:53 +0300
Message-Id: <20210311192105.14998-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311192105.14998-1-digetx@gmail.com>
References: <20210311192105.14998-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Add devres wrapper for dev_pm_opp_set_regulators() to simplify drivers
code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3345ab8da6b2..32fa2bff847b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2047,6 +2047,45 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
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
+					     const char * const names[],
+					     unsigned int count)
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
 /**
  * dev_pm_opp_set_clkname() - Set clk name for the device
  * @dev: Device for which clk name is being set.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6fb992168f1e..284d23665b15 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -148,6 +148,7 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
+struct opp_table *devm_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *devm_pm_opp_set_clkname(struct device *dev, const char *name);
@@ -349,6 +350,13 @@ static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, co
 
 static inline void dev_pm_opp_put_regulators(struct opp_table *opp_table) {}
 
+static inline struct opp_table *devm_pm_opp_set_regulators(struct device *dev,
+							   const char * const names[],
+							   unsigned int count)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 {
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.29.2

