Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963B92137E7
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jul 2020 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgGCJoo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Jul 2020 05:44:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46420 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgGCJol (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 3 Jul 2020 05:44:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593769480; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=3jgDVug8jB+ncTVYJLduVsR8sn0fouFwbBmIBEloWGI=; b=I7Q2qDDDIon8U4R4AVn1DGTumtyZ1rjjpVG8lFum8OemD3QyDdWZRhdA4p1yKdCoJUpfawKz
 nlOKxQzFHykWzZWn5o7ZWybjbyAxe8Ft13GcyGEuyds5bbDFEcWm4IPF131CqxVHkmoFLcxH
 nTho2Da76fbNYkXEukkJQVBgeE4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-east-1.postgun.com with SMTP id
 5efefe07567385e8e7070687 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Jul 2020 09:44:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 26C78C433AF; Fri,  3 Jul 2020 09:44:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E475DC433A1;
        Fri,  3 Jul 2020 09:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E475DC433A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH 1/3] spi: spi-qcom-qspi: Use OPP API to set clk/perf state
Date:   Fri,  3 Jul 2020 15:11:31 +0530
Message-Id: <1593769293-6354-2-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
References: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

QSPI needs to vote on a performance state of a power domain depending on
the clock rate. Add support for it by specifying the perf state/clock rate
as an OPP table in device tree.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Akash Asthana <akashast@codeaurora.org>
Cc: linux-spi@vger.kernel.org
---
 drivers/spi/spi-qcom-qspi.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index b5b4cf6..18a59aa 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_opp.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
@@ -141,6 +142,8 @@ struct qcom_qspi {
 	struct clk_bulk_data *clks;
 	struct qspi_xfer xfer;
 	struct icc_path *icc_path_cpu_to_qspi;
+	struct opp_table *opp_table;
+	bool has_opp_table;
 	/* Lock to protect data accessed by IRQs */
 	spinlock_t lock;
 };
@@ -238,7 +241,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 		speed_hz = xfer->speed_hz;
 
 	/* In regular operation (SBL_EN=1) core must be 4x transfer clock */
-	ret = clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz * 4);
+	ret = dev_pm_opp_set_rate(ctrl->dev, speed_hz * 4);
 	if (ret) {
 		dev_err(ctrl->dev, "Failed to set core clk %d\n", ret);
 		return ret;
@@ -519,6 +522,20 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->handle_err = qcom_qspi_handle_err;
 	master->auto_runtime_pm = true;
 
+	ctrl->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
+	if (IS_ERR(ctrl->opp_table)) {
+		ret = PTR_ERR(ctrl->opp_table);
+		goto exit_probe_master_put;
+	}
+	/* OPP table is optional */
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (!ret) {
+		ctrl->has_opp_table = true;
+	} else if (ret != -ENODEV) {
+		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
+		goto exit_probe_master_put;
+	}
+
 	pm_runtime_enable(dev);
 
 	ret = spi_register_master(master);
@@ -526,6 +543,9 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return 0;
 
 	pm_runtime_disable(dev);
+	if (ctrl->has_opp_table)
+		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_put_clkname(ctrl->opp_table);
 
 exit_probe_master_put:
 	spi_master_put(master);
@@ -536,11 +556,15 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 static int qcom_qspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
+	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
 
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
 	spi_unregister_master(master);
 
 	pm_runtime_disable(&pdev->dev);
+	if (ctrl->has_opp_table)
+		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_put_clkname(ctrl->opp_table);
 
 	return 0;
 }
@@ -551,6 +575,8 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
 	int ret;
 
+	/* Drop the performance state vote */
+	dev_pm_opp_set_rate(dev, 0);
 	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
 
 	ret = icc_disable(ctrl->icc_path_cpu_to_qspi);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

