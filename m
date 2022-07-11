Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EB9562DE2
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jul 2022 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiGAIXK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jul 2022 04:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbiGAIWe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jul 2022 04:22:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9012E72EF5
        for <linux-spi@vger.kernel.org>; Fri,  1 Jul 2022 01:21:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p14so1779318pfh.6
        for <linux-spi@vger.kernel.org>; Fri, 01 Jul 2022 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RyxNHb/WQ8LrNXSqNKNJKWjupHwbyKneSV+LOjKKPXE=;
        b=uOVQ4n4h08T7IuN6KoAE+gQY7eWAHlRu5SCNDJLjFwYc5drt5YI6uQaz8KcufNiKYo
         ReQ9iDTSUK6OYYym6wlYwFFWXMXQKoYXLa9JzGzdGN4LHUeN2bllMjQZpGGOR0IdPaBT
         CkMH1PSTSlpDWIM4FG5C8nfWbqI4yKAr9TPy8mQnKY2wwRXaFEUoDegc5dj+8B13E4YE
         tS1IUkWYhr8gJdRQnSiunLrXqtLhEyhOTNyf/Bv2kdZ/POyi8Rvi3s8EJ6RfPR754XoE
         IqUMnYlSo+xUHUVmR4/7HTK4HJWHUCfWXWxk4CktXB42mQit+a8gjc2yWOqogvALGr90
         4yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RyxNHb/WQ8LrNXSqNKNJKWjupHwbyKneSV+LOjKKPXE=;
        b=ZtfMDptHQDugzXRC+NZ/SSjd/TzwIyGtXRP5eOWjT7u/HVmzZKMsEk8319nac5G7Xb
         2hn0yw1ZCMmjflObAANj/h03mrxxn9T05CkQlTlp3CVV2KzeJ1+4a9I+AAmNZNscwe3C
         I3A8r1h82bM1pm421jSHSiChPLEASJDDsHiqwUWLjdSTisYy8zKK3Ntfox9NcS8SP941
         nBmAxo0yc73s3BjGQ4k+CYdz6cKosmuFgn/ZjyFZ4I+6aGfJMQuLM1bzSXlDGeq5VQp5
         jFY4UumcLtNJtouf1DNJ3e2WLZ66JZ5PUIsCC6hmjK4meq5GUmk4itrLEMgAiD6b9G0G
         gz3w==
X-Gm-Message-State: AJIora9vh8KOF0KIE2knENPCCNJKeBtu4oIgxn4FI9uGZFSVtSMOUQAM
        x5VWrQkxAkEkK6RVn/AhjXvKkQ==
X-Google-Smtp-Source: AGRyM1uSv2NbtHLEM0xY2pfQz10qfkB5qmBDotngIRAO8ceMzGxHfOY0DUW/Ub5fB+AniWRE/Wqv6w==
X-Received: by 2002:a63:7448:0:b0:40c:7d4b:e7c6 with SMTP id e8-20020a637448000000b0040c7d4be7c6mr11292239pgn.140.1656663709116;
        Fri, 01 Jul 2022 01:21:49 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b00163f5028fd6sm14979185plj.5.2022.07.01.01.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 23/30] spi: qcom: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:18 +0530
Message-Id: <b89064460c8b0e5366f29b22c6c5bce1258dd495.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Mark, I have kept your Ack as the diff is really small, clk_names is an array
now.

 drivers/spi/spi-geni-qcom.c | 6 +++++-
 drivers/spi/spi-qcom-qspi.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 4e83cc5b445d..428585bae6a8 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -892,6 +892,10 @@ static int spi_geni_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct clk *clk;
 	struct device *dev = &pdev->dev;
+	struct dev_pm_opp_config config = {
+		.clk_names = (const char *[]){ "se" },
+		.clk_count = 1,
+	};
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -922,7 +926,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	mas->se.base = base;
 	mas->se.clk = clk;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	ret = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (ret)
 		return ret;
 	/* OPP table is optional */
diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index c334dfec4117..7e7732d61b25 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -458,6 +458,10 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	struct device *dev;
 	struct spi_master *master;
 	struct qcom_qspi *ctrl;
+	struct dev_pm_opp_config config = {
+		.clk_names = (const char *[]){ "core" },
+		.clk_count = 1,
+	};
 
 	dev = &pdev->dev;
 
@@ -529,7 +533,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->handle_err = qcom_qspi_handle_err;
 	master->auto_runtime_pm = true;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
+	ret = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (ret)
 		return ret;
 	/* OPP table is optional */
-- 
2.31.1.272.g89b43f80a514

