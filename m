Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13961C2C01
	for <lists+linux-spi@lfdr.de>; Sun,  3 May 2020 14:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgECMFF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 May 2020 08:05:05 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:25946 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728230AbgECMFE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 May 2020 08:05:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588507504; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=lJeH6WhvvJOWKBQ8I6y7Fc+5VmlJtLxc6UHy0dmcq38=; b=qY2ITY5WBQl8QyBH19ayGg/alFTM3FSgG46bDdCLGXLZDZ6g9/6RG8Sl5fTIJ5wvbKMLRJxc
 QTnmtxAGJRfhVXBhE2x2aJFWuLj6Zh4P4gOVNHTPWFvoNqjEeDMTcMKpzECMXrX26OUJ4T6L
 z8ma4r7yElUN+zYcTd4FmEasiDo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaeb36f.7f852fb8ca78-smtp-out-n03;
 Sun, 03 May 2020 12:05:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8CA20C433D2; Sun,  3 May 2020 12:05:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F4D8C43637;
        Sun,  3 May 2020 12:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F4D8C43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 2/6] spi: spi-geni-qcom: Use OPP API to set clk/perf state
Date:   Sun,  3 May 2020 17:34:25 +0530
Message-Id: <1588507469-31889-3-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588507469-31889-1-git-send-email-rnayak@codeaurora.org>
References: <1588507469-31889-1-git-send-email-rnayak@codeaurora.org>
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
Cc: Mark Brown <broonie@kernel.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Akash Asthana <akashast@codeaurora.org>
Cc: linux-spi@vger.kernel.org
---
This patch has a dependency on the 'PATCH 1/6' in this series,
due to the changes in include/linux/qcom-geni-se.h
Its ideal if this and the previous patch gets merged via the
msm tree (once reviewed and ack'ed)
Greg has already responded he is fine with it for serial.

 drivers/spi/spi-geni-qcom.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c397242..bc2916f 100644
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
 
@@ -604,6 +618,9 @@ static int spi_geni_remove(struct platform_device *pdev)
 	struct spi_master *spi = platform_get_drvdata(pdev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 
+	if (mas->se.has_opp_table)
+		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_put_clkname(mas->se.opp_table);
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
 	spi_unregister_master(spi);
 
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
