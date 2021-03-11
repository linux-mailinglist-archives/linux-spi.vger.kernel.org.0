Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D34B337DE3
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhCKTWS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCKTVm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:21:42 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4687C061574;
        Thu, 11 Mar 2021 11:21:41 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f16so3612465ljm.1;
        Thu, 11 Mar 2021 11:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ov6L/wi+7+c3LJQtnAfH1iT/wWmTs9arji1NNjI5w4w=;
        b=Yb2xQLauQk9/iW9wuQpdmmzQth3lijiwwro7aLkL5nw59+KYnhhGwe+WIsASJe2cBr
         of7MVf0dwHgmm84nllvZVdfbbSiTFGCdTKGpaQSwxJ+1mQNO8nd9dFIg901Ya3V8mjHa
         V3cjPw39w//0pzFRjKGn8TBsMyNb7IVbLBg4vmO5wOyP6grDoA/orJvrEIXjZitenosh
         65JY/acJLBixVB+TAd71beQ7dZXUBG+OVI7t28wEBifdeUjo15dx4B5AwMHn4yqGi0NZ
         EDjwMWYGla6li8QVOIPfR3DcF8njHOcUzDeuNpgxKkY9NVrmmTtNQBAN9TEqRiUQUkIE
         NaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ov6L/wi+7+c3LJQtnAfH1iT/wWmTs9arji1NNjI5w4w=;
        b=GRscBF8qmw4jQuBo4hGtvavWFlFNXoce0mdwfP2MrjIClxFhEeUiV+6p6/ppWtyawg
         03sIa1MO2gyM9HTfVLzQzkOVUbVMvCOcnQVAQCel4wqz+aPyHHe1ERoSmYhyo2zKLcQe
         IP0O7HyHzUiq3qbXw0orSShPXO+vZuYQ7AmYdOU2jXocMm7wbHaXkA5HKivNcciCWJhM
         Q5+JdlCx4G4N6gxNWtW+2TThdRfNC+OVRiANxQTrChGq7ik9xKVCV+wq3fkwhTDOJlHG
         rYNXAQmvrM/UvYlto7ShuwJhzCg9TFlZOq1/Nt1qXUNlCozsx6R5MiUBQGgfGALAALYq
         wiSA==
X-Gm-Message-State: AOAM531enb/LcFoitaBvvPWx7+151eg6cWSltYxuNwgBmx6jxyVXLe5D
        Ff069D2gJBkuau0B5fK76W8=
X-Google-Smtp-Source: ABdhPJz+liOGeJUMZvP/rB0AsK2HT9znbIStPC1d8LC453bn0G05ViKsvD2ssCnu0cxW5E/Wbnfj7A==
X-Received: by 2002:a05:651c:124b:: with SMTP id h11mr213713ljh.401.1615490500164;
        Thu, 11 Mar 2021 11:21:40 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id u14sm1121153lfl.40.2021.03.11.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:21:39 -0800 (PST)
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
Subject: [PATCH v2 03/14] opp: Add devres wrapper for dev_pm_opp_set_supported_hw
Date:   Thu, 11 Mar 2021 22:20:54 +0300
Message-Id: <20210311192105.14998-4-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311192105.14998-1-digetx@gmail.com>
References: <20210311192105.14998-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Add devres wrapper for dev_pm_opp_set_supported_hw() to simplify driver
code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  8 ++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 32fa2bff847b..f9e4ebb7aad0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1857,6 +1857,44 @@ void dev_pm_opp_put_supported_hw(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
 
+static void devm_pm_opp_supported_hw_release(void *data)
+{
+	dev_pm_opp_put_supported_hw(data);
+}
+
+/**
+ * devm_pm_opp_set_supported_hw() - Set supported platforms
+ * @dev: Device for which supported-hw has to be set.
+ * @versions: Array of hierarchy of versions to match.
+ * @count: Number of elements in the array.
+ *
+ * This is required only for the V2 bindings, and it enables a platform to
+ * specify the hierarchy of versions it supports. OPP layer will then enable
+ * OPPs, which are available for those versions, based on its 'opp-supported-hw'
+ * property.
+ *
+ * The opp_table structure will be freed after the device is destroyed.
+ */
+struct opp_table *devm_pm_opp_set_supported_hw(struct device *dev,
+					       const u32 *versions,
+					       unsigned int count)
+{
+	struct opp_table *opp_table;
+	int err;
+
+	opp_table = dev_pm_opp_set_supported_hw(dev, versions, count);
+	if (IS_ERR(opp_table))
+		return opp_table;
+
+	err = devm_add_action_or_reset(dev, devm_pm_opp_supported_hw_release,
+				       opp_table);
+	if (err)
+		opp_table = ERR_PTR(err);
+
+	return opp_table;
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_set_supported_hw);
+
 /**
  * dev_pm_opp_set_prop_name() - Set prop-extn name
  * @dev: Device for which the prop-name has to be set.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 284d23665b15..e68c3c29301e 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -144,6 +144,7 @@ int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb
 
 struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
+struct opp_table *devm_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
@@ -321,6 +322,13 @@ static inline struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
 
 static inline void dev_pm_opp_put_supported_hw(struct opp_table *opp_table) {}
 
+static inline struct opp_table *devm_pm_opp_set_supported_hw(struct device *dev,
+							     const u32 *versions,
+							     unsigned int count)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 			int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
-- 
2.29.2

