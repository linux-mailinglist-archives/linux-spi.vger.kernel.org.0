Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83C933A653
	for <lists+linux-spi@lfdr.de>; Sun, 14 Mar 2021 17:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhCNQfL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Mar 2021 12:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbhCNQem (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Mar 2021 12:34:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A048BC061762;
        Sun, 14 Mar 2021 09:34:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e9so4486915wrw.10;
        Sun, 14 Mar 2021 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qS29V1BJSlNMqK4W3VtZ1MYGmSsW4VwhnDeOAdwAbvw=;
        b=cpESHBVt3ogqmVmqovwCZn1Ag4Z0WFHp1c7v/S1vqDt5xpVGRBRQSp3hdj6hYduwoW
         xwGGoudfu69sETSQWvPJAwqnraJugbB8M4h79Gcy6kRt+BBF8i7u8fExVH61Oxd7swVN
         3RxNgAJug2nueZJCGlp++UlnCrZ9BxYhQmR3zI9mYzX7OhCbpR4OxFTPfR2PEkEoXP05
         5c0g8NdyTdsvDH+VVAwEOwx289IIvY389tRFixFHI54GQWF9cP3uyZpepH7jW1jD/Loe
         bY2F33UJcx+BhojpDpWAPsARYYGAsuEcxAztWBmCxtRvcarqEVJP8bWKrVDOq+vgz2fl
         7Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qS29V1BJSlNMqK4W3VtZ1MYGmSsW4VwhnDeOAdwAbvw=;
        b=tV2Ml73XhiUrYd5TSWlWifEbzd7+ma3EghE5Pu7cqARGlracjzRCaVh8Z++VufkYGi
         X93fJySUGY9aJK7B2LPwzgTc8regHAQ82i4ax9yn+2BKtKC6TXZyX8K8NRCHOCns31pI
         IKRC4dxzzfK5O+hak4X008mKQ24Gw68FBxsAbhgdWlIeAiZVicJLS3i4cKdoS40Lq3EF
         poNDth8xZ7jk2JfJV26LdHT+Akl6TddykStXRdOioZg2eILpzyTVSZXsCpACEWyirFXw
         SxJ86sGA+csvUwFfIezj6R51MBHc/CSDMgLJ1XrYT3hqVWCXreDgqpIrq8BX67u6QrV0
         QjZw==
X-Gm-Message-State: AOAM5332qznujveRx9A094e82TlTE3CDhxD1h8FWJzNWcfvll3YKSkiJ
        6jACLC6Mg5C/wG/U98eJY8o=
X-Google-Smtp-Source: ABdhPJwqAJpoo+3WpdYcCXMr1WxDj94mxJyjdRzjlxT5Tk19OseUPJKhU3WGd48Tc+w6ggG6mD+4CQ==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr23825109wrw.292.1615739680210;
        Sun, 14 Mar 2021 09:34:40 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id o7sm15723239wrs.16.2021.03.14.09.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:34:40 -0700 (PDT)
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
Subject: [PATCH v3 05/15] opp: Change return type of devm_pm_opp_register_set_opp_helper()
Date:   Sun, 14 Mar 2021 19:33:58 +0300
Message-Id: <20210314163408.22292-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314163408.22292-1-digetx@gmail.com>
References: <20210314163408.22292-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Make devm_pm_opp_register_set_opp_helper() to return error code instead
of opp_table pointer in order to have return type consistent with the
other resource-managed OPP helpers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 18 ++++++------------
 include/linux/pm_opp.h |  6 +++---
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 34b054bbb28f..4f44f02e6049 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2295,25 +2295,19 @@ static void devm_pm_opp_unregister_set_opp_helper(void *data)
  *
  * This is a resource-managed version of dev_pm_opp_register_set_opp_helper().
  *
- * Return: pointer to 'struct opp_table' on success and errorno otherwise.
+ * Return: 0 on success and errorno otherwise.
  */
-struct opp_table *
-devm_pm_opp_register_set_opp_helper(struct device *dev,
-				    int (*set_opp)(struct dev_pm_set_opp_data *data))
+int devm_pm_opp_register_set_opp_helper(struct device *dev,
+					int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
 	struct opp_table *opp_table;
-	int err;
 
 	opp_table = dev_pm_opp_register_set_opp_helper(dev, set_opp);
 	if (IS_ERR(opp_table))
-		return opp_table;
-
-	err = devm_add_action_or_reset(dev, devm_pm_opp_unregister_set_opp_helper,
-				       opp_table);
-	if (err)
-		return ERR_PTR(err);
+		return PTR_ERR(opp_table);
 
-	return opp_table;
+	return devm_add_action_or_reset(dev, devm_pm_opp_unregister_set_opp_helper,
+					opp_table);
 }
 EXPORT_SYMBOL_GPL(devm_pm_opp_register_set_opp_helper);
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 3f8894012429..865426b525a8 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -155,7 +155,7 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 int devm_pm_opp_set_clkname(struct device *dev, const char *name);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
-struct opp_table *devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
+int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 struct opp_table *devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
@@ -337,11 +337,11 @@ static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device
 
 static inline void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table) {}
 
-static inline struct opp_table *
+static int
 devm_pm_opp_register_set_opp_helper(struct device *dev,
 				    int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
-- 
2.30.2

