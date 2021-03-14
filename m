Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0F333A647
	for <lists+linux-spi@lfdr.de>; Sun, 14 Mar 2021 17:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhCNQfH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Mar 2021 12:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbhCNQef (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Mar 2021 12:34:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FCFC061574;
        Sun, 14 Mar 2021 09:34:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso18823645wma.4;
        Sun, 14 Mar 2021 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFjfvKJPz8sbDbBeOUgNkZKVwUwXHq+oQD2VCuoa4pw=;
        b=BllpC4pPefzxeU7jZI7bQnUlVgqXCHiKnM1jBT9h12ks6LuI8pvAMEuHNyTtfs1KAk
         Xeui5vrH+ietKxwFFUUQyQ43s61StZ1i5zdkz9T9FerQ7F/cQqJluw/dZ2dKG901hKKA
         X/itdsteel3yva0dSmOVeoh/nans62SxyomrLeLjqk53Eo5+IKXFuojDvt8kzvV7FR2B
         /kNh6+2NkCSqxw964oVPOM29hvK23u0aPuB6iUKvczNyHaEI6WPTBfIVsa8ZIR3dBKSs
         Ai5G5A0Meyqf7xWxXGd8yO06kW6f5vQdYZYSkfhkn+WmlK6WSHVfqVSViOJq4voYtM+L
         kN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFjfvKJPz8sbDbBeOUgNkZKVwUwXHq+oQD2VCuoa4pw=;
        b=TQYMCMiaH16TK1tkCKUDQTiQkkLMTaZbd2YLiVrnT27USJp4kF4B77+kTr3VQISx2c
         JLTjt4cmO8OKCnMwCLNClzapx841MewRYOITTeS3TVs/Nd82g7R3MknTJAveMxXvubqI
         nPUg4ACoZsWqxSdKwQzEi+/zq1F3YLeQIOClPsaQkjLE1bJjhNu5S83XODQiDC2SHbCh
         jHCeRNsWT19YDtcgNeSv1XVwg53e1BnhwJPVXvtUGRpK8LEHslvFiGHXFqQICLV7N7sH
         2HcrlLEIGWgfubPKxuKmnjOubgGVW83a6r6n6CcWI/HDVLsXwTXiigordeTmSkZCwxT/
         882g==
X-Gm-Message-State: AOAM532Fo53dI1rrjz2ADM7U8XZ4MyzBjhKeBm7EmFaQDoTnJePMOMwp
        9khefFGAGsT06EuLYEChJHA=
X-Google-Smtp-Source: ABdhPJyUcffwLSfcuDKZsqd4cFI+5GusDMa3Li6cgqYN//6b1wkOrcYQ0Xn0QIqzL4JghKStdfI5ww==
X-Received: by 2002:a1c:4145:: with SMTP id o66mr17710829wma.68.1615739673784;
        Sun, 14 Mar 2021 09:34:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id o7sm15723239wrs.16.2021.03.14.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:34:33 -0700 (PDT)
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
Subject: [PATCH v3 02/15] opp: Add devres wrapper for dev_pm_opp_set_regulators
Date:   Sun, 14 Mar 2021 19:33:55 +0300
Message-Id: <20210314163408.22292-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314163408.22292-1-digetx@gmail.com>
References: <20210314163408.22292-1-digetx@gmail.com>
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
 drivers/opp/core.c     | 30 ++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 02e46508a3a2..6217af05141f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2047,6 +2047,36 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
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
+ * This is a resource-managed variant of dev_pm_opp_set_regulators().
+ *
+ * Return: 0 on success and errorno otherwise.
+ */
+int devm_pm_opp_set_regulators(struct device *dev,
+			       const char * const names[],
+			       unsigned int count)
+{
+	struct opp_table *opp_table;
+
+	opp_table = dev_pm_opp_set_regulators(dev, names, count);
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
+
+	return devm_add_action_or_reset(dev, devm_pm_opp_regulators_release,
+					opp_table);
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_set_regulators);
+
 /**
  * dev_pm_opp_set_clkname() - Set clk name for the device
  * @dev: Device for which clk name is being set.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0583d775aa5a..3e667af57211 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -148,6 +148,7 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
+int devm_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 int devm_pm_opp_set_clkname(struct device *dev, const char *name);
@@ -349,6 +350,13 @@ static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, co
 
 static inline void dev_pm_opp_put_regulators(struct opp_table *opp_table) {}
 
+static inline int devm_pm_opp_set_regulators(struct device *dev,
+					     const char * const names[],
+					     unsigned int count)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 {
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.30.2

