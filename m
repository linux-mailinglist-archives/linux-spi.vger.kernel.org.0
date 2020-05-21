Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F51F1DC89B
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 10:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgEUIak (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 04:30:40 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:36105 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728643AbgEUIaj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 04:30:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590049838; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=aUu0HTuo5RwfXMNTMrDVhEl5UxLkoXaDz2EuM6uwJfI=; b=AdjfdaI1c2ekNOxds+aLtWiOGacc0yqIb6vN7AnbCWs8HOblLgJmq2GxmJ8BCcGw5bP5r0rK
 C3GHLb1j4ELMzYw+bfBrrvgvWpBoA4UDoiwFx7Wm1FTp7GfW6lk/o54W/VY2D10v4blS/IJR
 0bepQDrS6ouw6RH/sLMN37eOH0E=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec63c1f.7f49911ca3b0-smtp-out-n03;
 Thu, 21 May 2020 08:30:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66026C433C9; Thu, 21 May 2020 08:30:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akashast-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 883F1C433C8;
        Thu, 21 May 2020 08:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 883F1C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, msavaliy@codeaurora.org,
        evgreen@chromium.org, Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V6 5/7] tty: serial: qcom_geni_serial: Add interconnect support
Date:   Thu, 21 May 2020 13:59:22 +0530
Message-Id: <1590049764-20912-6-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590049764-20912-1-git-send-email-akashast@codeaurora.org>
References: <1590049764-20912-1-git-send-email-akashast@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Get the interconnect paths for Uart based Serial Engine device
and vote according to the baud rate requirement of the driver.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in V2:
 - As per Bjorn's comment, removed se == NULL check from geni_serial_icc_get
 - As per Bjorn's comment, removed code to set se->icc_path* to NULL in failure
 - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
   path handle
 - As per Matthias comment, added error handling for icc_set_bw call

Changes in V3:
 - As per Matthias comment, use common library APIs defined in geni-se
   driver for ICC functionality.

Changes in V4:
 - As per Mark's comment move peak_bw guess as twice of avg_bw if
   nothing mentioned explicitly to ICC core.
 - As per Matthias's comment select core clock BW based on baud rate.
   If it's less than 115200 go for GENI_DEFAULT_BW else CORE_2X_50_MHZ

Changes in V5:
 - Add icc_enable/disable to power on/off call.
 - Save some non-zero avg/peak value to ICC core by calling geni_icc_set_bw
   from probe so that when resume/icc_enable is called NOC are running at
   some non-zero value. No need to call icc_disable after BW vote because
   console devices are expected to be in active state from the probe itself
   and qcom_geni_serial_pm(STATE_OFF) will be called for non-console ones.

Changes in V6:
 - No change

 drivers/tty/serial/qcom_geni_serial.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 8c5d97c..2a1da36 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -944,6 +944,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	unsigned long clk_rate;
 	u32 ver, sampling_rate;
+	unsigned int avg_bw_core;
 
 	qcom_geni_serial_stop_rx(uport);
 	/* baud rate */
@@ -965,6 +966,16 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
+	/*
+	 * Bump up BW vote on CPU and CORE path as driver supports FIFO mode
+	 * only.
+	 */
+	avg_bw_core = (baud > 115200) ? Bps_to_icc(CORE_2X_50_MHZ)
+						: GENI_DEFAULT_BW;
+	geni_icc_bw_init(&port->se.icc_paths[GENI_TO_CORE], avg_bw_core, 0);
+	geni_icc_bw_init(&port->se.icc_paths[CPU_TO_GENI], Bps_to_icc(baud), 0);
+	geni_icc_set_bw(&port->se);
+
 	/* parity */
 	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
 	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
@@ -1202,11 +1213,14 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 	if (old_state == UART_PM_STATE_UNDEFINED)
 		old_state = UART_PM_STATE_OFF;
 
-	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
+	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
+		geni_icc_enable(&port->se);
 		geni_se_resources_on(&port->se);
-	else if (new_state == UART_PM_STATE_OFF &&
-			old_state == UART_PM_STATE_ON)
+	} else if (new_state == UART_PM_STATE_OFF &&
+			old_state == UART_PM_STATE_ON) {
 		geni_se_resources_off(&port->se);
+		geni_icc_disable(&port->se);
+	}
 }
 
 static const struct uart_ops qcom_geni_console_pops = {
@@ -1304,6 +1318,17 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
+	ret = geni_icc_get(&port->se, NULL);
+	if (ret)
+		return ret;
+	geni_icc_bw_init(&port->se.icc_paths[GENI_TO_CORE], GENI_DEFAULT_BW, 0);
+	geni_icc_bw_init(&port->se.icc_paths[CPU_TO_GENI], GENI_DEFAULT_BW, 0);
+
+	/* Set BW for register access */
+	ret = geni_icc_set_bw(&port->se);
+	if (ret)
+		return ret;
+
 	port->name = devm_kasprintf(uport->dev, GFP_KERNEL,
 			"qcom_geni_serial_%s%d",
 			uart_console(uport) ? "console" : "uart", uport->line);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
