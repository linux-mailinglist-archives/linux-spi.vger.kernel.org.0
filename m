Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3433A654
	for <lists+linux-spi@lfdr.de>; Sun, 14 Mar 2021 17:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhCNQfM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Mar 2021 12:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbhCNQeo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Mar 2021 12:34:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DC9C061574;
        Sun, 14 Mar 2021 09:34:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d15so7478209wrv.5;
        Sun, 14 Mar 2021 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/5Ng/DtkoydDqBvZq8AbYfbXEoAPbsENXRNj6fGs4M=;
        b=AZIjeihL2yluu7+ziQ9v+nQ1dEmp58/PiHa0qg4i1Vn3Us0fHEIXwilYfY2Mz+8lLz
         c0juj89+qh1eRLRy5OMe/Jc0YneZIEpze02hLIQDNsNBds7JdxWpqbbstGB5knFg9k6u
         4aBoy9+aqAMV/zw4Y++14Ku4isUFAILx12+GIfbpZ8ByRBABxrTKObpDvkf/ykkr2FaM
         IPxLz8UE1vQ68mW6wRIOz4EbI8tzujeA0Uu/zc1thT/j9I+8ZI0y6pR8ZqFxc+P9y8Yf
         nkHE2w3spY5YhLMok/47iL83KVGZ9r8YxpSc6TDfDdTuqNkCBpRiZrHzRt5Fz7dxuqZC
         XkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/5Ng/DtkoydDqBvZq8AbYfbXEoAPbsENXRNj6fGs4M=;
        b=nmH8BL8DK99DCw6hwaNeXgNbXxJURrkohanxLSBfrOiRDBsnSnLzXMLmU3f8pry0//
         NFfkEOEBnjwkB7kCFFrjB6UlDqOOznLLakgcKzfnjQpPwjQ/0LRK8dBDyO1ntm4PDGWQ
         1gqUfrDqkeH25OsvwFI4h3kEocklAKoOcaWf+zIGrZPQ0gK7nw1X9uax51syKOIRwQux
         sl3Xgh2oN9N1bJMb/iBoaaAv/JH+6xNQGdgThqjcgDjpUqpG67s/HeIsNjxCDFmYvI/2
         CeA0nm3p211ZB/jyTpJ7no+9s4eRdrjv4Zgwlu4dND+zi5Ay2qahz0s7STjBxPtkh6GE
         dahQ==
X-Gm-Message-State: AOAM531Ns8pCUD++dl4gx9OJCBlpzxwI1+8eE+uT2eo9lprqfLct1VQO
        GSPujxRi1yODawpdqmkQN+c=
X-Google-Smtp-Source: ABdhPJwTslpY31/qqM5Kj4SW4qqIUgqTVjIObWqN26uqLWPcyfaojPCdZoyfNAhylicplEYulZuQuQ==
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr23285997wrw.323.1615739682317;
        Sun, 14 Mar 2021 09:34:42 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id o7sm15723239wrs.16.2021.03.14.09.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:34:42 -0700 (PDT)
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
Subject: [PATCH v3 06/15] opp: Change return type of devm_pm_opp_attach_genpd()
Date:   Sun, 14 Mar 2021 19:33:59 +0300
Message-Id: <20210314163408.22292-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314163408.22292-1-digetx@gmail.com>
References: <20210314163408.22292-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Make devm_pm_opp_attach_genpd() to return error code instead of
opp_table pointer in order to have return type consistent with the
other resource-managed OPP helpers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 18 ++++++------------
 include/linux/pm_opp.h |  9 +++++----
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4f44f02e6049..2076b12c039b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2460,25 +2460,19 @@ static void devm_pm_opp_detach_genpd(void *data)
  *
  * This is a resource-managed version of dev_pm_opp_attach_genpd().
  *
- * Return: pointer to 'struct opp_table' on success and errorno otherwise.
+ * Return: 0 on success and errorno otherwise.
  */
-struct opp_table *
-devm_pm_opp_attach_genpd(struct device *dev, const char **names,
-			 struct device ***virt_devs)
+int devm_pm_opp_attach_genpd(struct device *dev, const char **names,
+			     struct device ***virt_devs)
 {
 	struct opp_table *opp_table;
-	int err;
 
 	opp_table = dev_pm_opp_attach_genpd(dev, names, virt_devs);
 	if (IS_ERR(opp_table))
-		return opp_table;
-
-	err = devm_add_action_or_reset(dev, devm_pm_opp_detach_genpd,
-				       opp_table);
-	if (err)
-		return ERR_PTR(err);
+		return PTR_ERR(opp_table);
 
-	return opp_table;
+	return devm_add_action_or_reset(dev, devm_pm_opp_detach_genpd,
+					opp_table);
 }
 EXPORT_SYMBOL_GPL(devm_pm_opp_attach_genpd);
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 865426b525a8..a5ae69c40ea7 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -158,7 +158,7 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
-struct opp_table *devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
+int devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -384,10 +384,11 @@ static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, cons
 
 static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
 
-static inline struct opp_table *devm_pm_opp_attach_genpd(struct device *dev,
-				const char **names, struct device ***virt_devs)
+static inline int devm_pm_opp_attach_genpd(struct device *dev,
+					   const char **names,
+					   struct device ***virt_devs)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
-- 
2.30.2

