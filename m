Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B933A63F
	for <lists+linux-spi@lfdr.de>; Sun, 14 Mar 2021 17:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhCNQfG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Mar 2021 12:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhCNQed (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Mar 2021 12:34:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A3C061574;
        Sun, 14 Mar 2021 09:34:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g8so6742911wmd.4;
        Sun, 14 Mar 2021 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suQTUJT95TToQZtvwJl+RSOWWo46pQcxeekooCpqVRE=;
        b=mWOhEWIIsc3g51/r4PPuTyVIq+fH9uyJTXCIr7ia4jxvUoOPc/NOBuXvxFpp37+sgM
         oWFUAvtO3jAmlc+Gh7AgygkSjZ3ZdAt9RnsigCjWBcz9qXNGbojGZYMx2MLYv63ioNUr
         kBcixmyyH2o612X49U7uUmIdbHOjwNNT+W/jZH7lULyWC6HofFScf3nELSuSnNeEgx+7
         c1LQLMTj0bHwnoJwjMCQgRzFXPsrqvDQDaUB3bSIPpPeyhndLfRs9bM6hCnL521qtyN+
         slSchI8ROdq4ZXLH6K5M2VnrvEwkx1s1Q0heBXBQFO3w6/7I3w89zIHK/wSRLWOCT3Cn
         v/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suQTUJT95TToQZtvwJl+RSOWWo46pQcxeekooCpqVRE=;
        b=GxYurg1YWwqgAfPcHrM+Pzj0dCKNFKBkzVFDWAoeg5ASIF0ln2lJqsIgdmvTEsaGI+
         Nx3TmhFZv0tAlZ0YD/zNe7ESo8TRNI/Yji+IyqMuO8Oxm5vTGUqUKjAYhy5gyBxplAdQ
         sbPJQLa0AqiUPZ/t/IBHw/wbv3svZ6Q55Uw8M/txzUo+H5m6YC7w+notBX0UQg703bFh
         YqjRvypmBbLSfHgeUiV7HdFtVf6+B9j80CxuybcgHNUuLyJ7wuVdnRhK6zeeQiCeHoS9
         FM7c1iSEUnjml06UTQlm4306i5KTvEITPf2agohestsdkZcHHBrS1oNsompyMYCCa2dP
         aYKw==
X-Gm-Message-State: AOAM530UpvV6ErfI29Y2uNgpsA6f3hZ+w3zIBI2lzetQQkZFOCKZoXBy
        R6NCh1OaiEdggrqaeHPnOZU=
X-Google-Smtp-Source: ABdhPJz0vqh5YDNEcDycdMN9ARg89KMLgBV4wfAIgwa+5wl5vspiGMEYEGXjVQ+So4rOyxhou3mWFw==
X-Received: by 2002:a1c:61c5:: with SMTP id v188mr21841943wmb.20.1615739671508;
        Sun, 14 Mar 2021 09:34:31 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id o7sm15723239wrs.16.2021.03.14.09.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:34:31 -0700 (PDT)
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
Subject: [PATCH v3 01/15] opp: Add devres wrapper for dev_pm_opp_set_clkname
Date:   Sun, 14 Mar 2021 19:33:54 +0300
Message-Id: <20210314163408.22292-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314163408.22292-1-digetx@gmail.com>
References: <20210314163408.22292-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Add devres wrapper for dev_pm_opp_set_clkname() to simplify drivers code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 27 +++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 150be4c28c99..02e46508a3a2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2119,6 +2119,33 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
 
+static void devm_pm_opp_clkname_release(void *data)
+{
+	dev_pm_opp_put_clkname(data);
+}
+
+/**
+ * devm_pm_opp_set_clkname() - Set clk name for the device
+ * @dev: Device for which clk name is being set.
+ * @name: Clk name.
+ *
+ * This is a resource-managed variant of dev_pm_opp_set_clkname().
+ *
+ * Return: 0 on success and errorno otherwise.
+ */
+int devm_pm_opp_set_clkname(struct device *dev, const char *name)
+{
+	struct opp_table *opp_table;
+
+	opp_table = dev_pm_opp_set_clkname(dev, name);
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
+
+	return devm_add_action_or_reset(dev, devm_pm_opp_clkname_release,
+					opp_table);
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_set_clkname);
+
 /**
  * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
  * @dev: Device for which the helper is getting registered.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index c0371efa4a0f..0583d775aa5a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -150,6 +150,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * con
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
+int devm_pm_opp_set_clkname(struct device *dev, const char *name);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 struct opp_table *devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
@@ -355,6 +356,11 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
 
 static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
 
+static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs)
 {
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.30.2

