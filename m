Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B2337DEC
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhCKTWT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCKTVq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:21:46 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15AEC061574;
        Thu, 11 Mar 2021 11:21:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v9so41664077lfa.1;
        Thu, 11 Mar 2021 11:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHoS/NDYFORjyzzTgThoswp953REgCaZA6oZyehzPtM=;
        b=h362kHxm7AXBGWNXuqvqq9EOyjYzGfY6Mte8IJOtpFAmZ0dUmAscX0n1qSCmm1AO5V
         LDVuZ7MCuOb6qm3QPdlkBHauuyzyTvwar/8pMq/M5FiHeylVt6gNNuy5IpiaLbE7cmGt
         oy6/Nvhz/BLeMEZBTmaF3LlEpKxOsDX/wpNY7yNN/9I/li514FvvGEZg56ss+wjoBlL+
         FnS0QMw6K4sJj/2Nlnikr3D4Gf4KfDUb5O41f43pOhUlPhphqJt5brgOA6bvlDeRsSzr
         q5X2w6ocCZ70dwyzwKqoe3wUvscbuEofHhe27NBvxBXuMpnNnJc5fh5ahJY4o82s6muT
         PUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHoS/NDYFORjyzzTgThoswp953REgCaZA6oZyehzPtM=;
        b=py0pahLQbAxKPBzdUPJOdabp9pdA1tEAQIzlkfbz+6R1/wi2xB1sMTlcTWUFBekjZo
         qBEwDzsBqhtj2gkMNtCIX7JidiFMentTGAGPzCyNIzGR9NmvKx4/h37QdrJNFQL41LdJ
         2x0aaRdckbqgO+C3Ouox2SXfOtqukWPEP1ZkqVI1LOg6J2jk3JImWZ6oRYLAhnISQzg/
         bCvDXaxeRe885zGUJuzVPc34TdKM9KXNo9MAswb2ewnVqXj/WO3gBCKqfREviryvNfY+
         +fS3aki5SVqwTlP3AF2Po0VtKDofmKY/JuNYJbnA24mX2aO+UbHmQv3f8tKCRk80Bnrv
         iaFw==
X-Gm-Message-State: AOAM530bsw0DfPYFH8bYfxC0Xv69OwhDCxT3DR/sscdbVPvuLIVTnLv8
        bIKbxk5mL22HHpXRbUUMTYo=
X-Google-Smtp-Source: ABdhPJy7MNztyPSIi0lioGZtVc9/WU9dKO5Scs7kPni8BUiZ6lSUAxqLXijElOwcoQF/pJhUu1yqUg==
X-Received: by 2002:a05:6512:696:: with SMTP id t22mr3085939lfe.631.1615490502700;
        Thu, 11 Mar 2021 11:21:42 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id u14sm1121153lfl.40.2021.03.11.11.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:21:42 -0800 (PST)
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
Subject: [PATCH v2 05/14] opp: Add devres wrapper for dev_pm_opp_register_notifier
Date:   Thu, 11 Mar 2021 22:20:56 +0300
Message-Id: <20210311192105.14998-6-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311192105.14998-1-digetx@gmail.com>
References: <20210311192105.14998-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Add devres wrapper for dev_pm_opp_register_notifier() to simplify driver
code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index f9e4ebb7aad0..509b2e052f3c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2899,6 +2899,44 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
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
index 2f5dc123c1a0..7088997491b2 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -141,6 +141,7 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
+int devm_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 
 struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
 void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
@@ -313,6 +314,11 @@ static inline int dev_pm_opp_unregister_notifier(struct device *dev, struct noti
 	return -EOPNOTSUPP;
 }
 
+static inline int devm_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
 							    const u32 *versions,
 							    unsigned int count)
-- 
2.29.2

