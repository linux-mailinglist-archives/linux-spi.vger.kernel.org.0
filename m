Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF95337DEA
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhCKTWT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCKTVn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:21:43 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E81AC061574;
        Thu, 11 Mar 2021 11:21:43 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a1so3610840ljp.2;
        Thu, 11 Mar 2021 11:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7dOV4uNWoySiVfi1U62XLNIjOEl4DQUJk7AsVchpY0=;
        b=jNzZ5bhFzRYwTGoQGRFZr6zS62/1FCJrLohl6shdMFzIMvJ9cnxiadM1oStpJhoEYa
         YCcxwfYd4JEkxZWExeIpo0vQ/F+5ARIaUbaLXJ4naL6G2C23qefVXtKwg/H3YCkYJwMC
         IUW2DuICeG5jN7ND+VmdViRmZ/XJQ00vfNBMxLFV7yU0x4uUqWyDC0H2QO4srri21zZL
         B9d0ZnwwMsIFkrDTAje/tBFbeHQsfgi5f/DHcvqFbwkuVLVCcANkIPpClAvX3v1FPyhu
         +Ti/rO4EW6vyd/D81w+cAOTP5lvhMKSUXx/NJhg8sBmlLFGspR/iKaphy+ta/665s5bq
         cFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7dOV4uNWoySiVfi1U62XLNIjOEl4DQUJk7AsVchpY0=;
        b=SAYEFf6BnZ7DFgXLAAXuENDOZNFe6ZrG0J3gGgamTa8cVU4cyBUxlXQ+QOE5xFURfz
         l1IgYe+CxWRBT0Kk8QbFrtaq6B4gEogsueCptqCBcFmLr65mp3LFmkoLpC1gH5LUSLee
         ea4+3Az8f8LTDr3mdP1Pf96oGSzL0D9gyVgBuJQJuWzP2YYPNV22wOWgnB9fCd8x+gVI
         Oj1e3zbjE0b9zajuJQJ8CLgdYR/M/WrRFcGCWg/DcuNoS3HKH6mD2CebnchHp8tcAGAk
         wJcJgDxRbPTE+pg6ZGBgPBxJcm0bRC1Meo0HbOzKqPK8AVFGVYxMpsRX8XM04xi7c6ZB
         shcQ==
X-Gm-Message-State: AOAM533k7vCO/wd9HhRc4tN9/eM38pX8D1UWShrETAzFekvrWgvOVy7o
        fWbI1PMuJAz3YAdEssNPQak=
X-Google-Smtp-Source: ABdhPJxKtt0/QNPAPokFtyrBLj9jSOu1ZxgRF4Tu4gWmrQeJALVgjaKWtCy+IAGZ2Sw/4/W0FVeyAg==
X-Received: by 2002:a2e:9101:: with SMTP id m1mr236037ljg.378.1615490501433;
        Thu, 11 Mar 2021 11:21:41 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id u14sm1121153lfl.40.2021.03.11.11.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:21:41 -0800 (PST)
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
Subject: [PATCH v2 04/14] opp: Add devres wrapper for dev_pm_opp_of_add_table
Date:   Thu, 11 Mar 2021 22:20:55 +0300
Message-Id: <20210311192105.14998-5-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311192105.14998-1-digetx@gmail.com>
References: <20210311192105.14998-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Add devres wrapper for dev_pm_opp_of_add_table() to simplify driver
code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/of.c       | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index f480c10e6314..c582a9ca397b 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1104,6 +1104,42 @@ static int _of_add_table_indexed(struct device *dev, int index, bool getclk)
 	return ret;
 }
 
+static void devm_pm_opp_of_table_release(void *data)
+{
+	dev_pm_opp_of_remove_table(data);
+}
+
+/**
+ * devm_pm_opp_of_add_table() - Initialize opp table from device tree
+ * @dev:	device pointer used to lookup OPP table.
+ *
+ * Register the initial OPP table with the OPP library for given device.
+ *
+ * The opp_table structure will be freed after the device is destroyed.
+ *
+ * Return:
+ * 0		On success OR
+ *		Duplicate OPPs (both freq and volt are same) and opp->available
+ * -EEXIST	Freq are same and volt are different OR
+ *		Duplicate OPPs (both freq and volt are same) and !opp->available
+ * -ENOMEM	Memory allocation failure
+ * -ENODEV	when 'operating-points' property is not found or is invalid data
+ *		in device node.
+ * -ENODATA	when empty 'operating-points' property is found
+ * -EINVAL	when invalid entries are found in opp-v2 table
+ */
+int devm_pm_opp_of_add_table(struct device *dev)
+{
+	int ret;
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pm_opp_of_table_release, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_opp_of_add_table);
+
 /**
  * dev_pm_opp_of_add_table() - Initialize opp table from device tree
  * @dev:	device pointer used to lookup OPP table.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index e68c3c29301e..2f5dc123c1a0 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -441,6 +441,7 @@ int dev_pm_opp_of_add_table(struct device *dev);
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index);
 int dev_pm_opp_of_add_table_noclk(struct device *dev, int index);
 void dev_pm_opp_of_remove_table(struct device *dev);
+int devm_pm_opp_of_add_table(struct device *dev);
 int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -473,6 +474,11 @@ static inline void dev_pm_opp_of_remove_table(struct device *dev)
 {
 }
 
+static inline int devm_pm_opp_of_add_table(struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 {
 	return -EOPNOTSUPP;
-- 
2.29.2

