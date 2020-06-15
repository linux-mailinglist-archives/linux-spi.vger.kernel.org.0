Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB21F95FD
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 14:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgFOMDq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 08:03:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16186 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbgFOMDd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 08:03:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592222613; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Ja7P+CGGeWgD0X9kD8Gyyp0YvmoG5J4vqzYFmgNyLEk=; b=gH/JFi669j2mFaR/vs9YugcIyDdFlfMyqcsfvXWJCTrpmeYwn0dV+gwN0HL2tMWpi7Y8f/SB
 DYvuBEAgt+IzzQ5V20l99RNuHQ4yTHmJZONWq9hxShX/QznSe4W7VpuAIwoNgDE61Epkmnol
 G9uaEb5XJHE7cdaB4QPo6+kuTvs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5ee76386c76a4e7a2a060e27 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 12:03:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5FBE8C43391; Mon, 15 Jun 2020 12:03:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61850C433CB;
        Mon, 15 Jun 2020 12:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61850C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, robdclark@gmail.com,
        robdclark@chromium.org, stanimir.varbanov@linaro.org
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH v6 2/6] spi: spi-geni-qcom: Use OPP API to set clk/perf state
Date:   Mon, 15 Jun 2020 17:32:40 +0530
Message-Id: <1592222564-13556-3-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

geni spi needs to express a perforamnce state requirement on CX
depending on the frequency of the clock rates. Use OPP table from
DT to register with OPP framework and use dev_pm_opp_set_rate() to
set the clk/perf state.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Akash Asthana <akashast@codeaurora.org>
Cc: linux-spi@vger.kernel.org
---
This patch needs to land via the msm tree. Mark has acked v5, so
this is good to land I think. v6 is just rebased on 5.8-rc1.

 drivers/spi/spi-geni-qcom.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c397242..0d7ead1 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -7,6 +7,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/qcom-geni-se.h>
 #include <linux/spi/spi.h>
@@ -95,7 +96,6 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 {
 	unsigned long sclk_freq;
 	unsigned int actual_hz;
-	struct geni_se *se = &mas->se;
 	int ret;
 
 	ret = geni_se_clk_freq_match(&mas->se,
@@ -112,9 +112,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 
 	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
 				actual_hz, sclk_freq, *clk_idx, *clk_div);
-	ret = clk_set_rate(se->clk, sclk_freq);
+	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
 	if (ret)
-		dev_err(mas->dev, "clk_set_rate failed %d\n", ret);
+		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
 	return ret;
 }
 
@@ -561,6 +561,17 @@ static int spi_geni_probe(struct platform_device *pdev)
 	mas->se.wrapper = dev_get_drvdata(dev->parent);
 	mas->se.base = base;
 	mas->se.clk = clk;
+	mas->se.opp_table = dev_pm_opp_set_clkname(&pdev->dev, "se");
+	if (IS_ERR(mas->se.opp_table))
+		return PTR_ERR(mas->se.opp_table);
+	/* OPP table is optional */
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (!ret) {
+		mas->se.has_opp_table = true;
+	} else if (ret != -ENODEV) {
+		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
+		return ret;
+	}
 
 	spi->bus_num = -1;
 	spi->dev.of_node = dev->of_node;
@@ -596,6 +607,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 spi_geni_probe_runtime_disable:
 	pm_runtime_disable(dev);
 	spi_master_put(spi);
+	if (mas->se.has_opp_table)
+		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_put_clkname(mas->se.opp_table);
 	return ret;
 }
 
@@ -609,6 +623,9 @@ static int spi_geni_remove(struct platform_device *pdev)
 
 	free_irq(mas->irq, spi);
 	pm_runtime_disable(&pdev->dev);
+	if (mas->se.has_opp_table)
+		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_put_clkname(mas->se.opp_table);
 	return 0;
 }
 
@@ -617,6 +634,9 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 
+	/* Drop the performance state vote */
+	dev_pm_opp_set_rate(dev, 0);
+
 	return geni_se_resources_off(&mas->se);
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

