Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95990337DF3
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCKTWW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCKTVs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:21:48 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C40C061574;
        Thu, 11 Mar 2021 11:21:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x4so34935887lfu.7;
        Thu, 11 Mar 2021 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0YTDRKEg68ROrVXaToU8Wcjr+vVydQlVmQ/OWyjWgg=;
        b=dGAL4j4BsV5QyzEnqra3RC8Xbo9QxrUVyW20WZKTu5fZB8PcaLd6Q0dZfKCdvFFtGY
         ul0GrV226fObFyvFxQHdsMNbIofDBoWGFC/IrhPs5wnHg5gucqUusBLd7Y1rl3JiD7U+
         JfdvYKLKFmLHovCjDXyIZmbwMjZUW872AXXAZXScP0rtMTDL7ip7cViDIq9YBchS8pia
         vEy7cJ9JEDlA7hRLOJ8mB76vzymSptU7r4MgVPfw7koPVSZifFvV7TKQmNzIU3aAd62s
         npiqk8ynaCe2PDF+eZuyBa0Pa0p2uiw4VlxVTHH9yKD5DW7H0xEaMIV38sncrPcbRZcJ
         2RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0YTDRKEg68ROrVXaToU8Wcjr+vVydQlVmQ/OWyjWgg=;
        b=q1kJ7hwZZsmUW0g+6BfzfnVZ+CfMvwWDyBm+9vR50JN9EY+1XXcQJSqdS2leVgNjCo
         e1Ncq+n41xy4Rw8Z4+YnoNrdT3psUFtAb6FvVTG56qxkQymAp6NPc1CQs3Un8LSvRgNv
         r5//WxXfKeAMdPzt9T2Qpj07a2FrrHVSZeey7MZRdMWmC6c6/FPqa8Zv+M6dqOr520fo
         Mae3Y2yL8PUCxDmI23LUN4Ng6h0uXbrnKl8/SlpCX8rWfbI7otmcBlch4UJRk+rSSEqD
         0Y5CAqZ3RzMbHhaw8o7pKdbw/HHuEbrdtGLR3AGMVszSG3FYT6evxr3BxHI96UAb8u96
         D+KA==
X-Gm-Message-State: AOAM532xobjRf6ZPZt+GyP/fHEEV1+iBJg1MZ1QwJcH+mCsEOiXOcb+b
        rQMuD6kMwp9CpLTLoBVUds3EfmlM51s=
X-Google-Smtp-Source: ABdhPJwb8ysVVPvmoUCYBr2zwcOCS8CSTP0C/1S9MCVIrEL8VL8f1OZN/0+JiI5Ybm1C4mkALqUPWA==
X-Received: by 2002:a19:4c87:: with SMTP id z129mr3119098lfa.183.1615490503974;
        Thu, 11 Mar 2021 11:21:43 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id u14sm1121153lfl.40.2021.03.11.11.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:21:43 -0800 (PST)
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
Subject: [PATCH v2 06/14] serial: qcom_geni_serial: Convert to use resource-managed OPP API
Date:   Thu, 11 Mar 2021 22:20:57 +0300
Message-Id: <20210311192105.14998-7-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311192105.14998-1-digetx@gmail.com>
References: <20210311192105.14998-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Use resource-managed OPP API to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 291649f02821..7c6e029fdb2a 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1352,6 +1352,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	int irq;
 	bool console = false;
 	struct uart_driver *drv;
+	struct opp_table *opp_table;
 
 	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
 		console = true;
@@ -1433,14 +1434,14 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
 		port->cts_rts_swap = true;
 
-	port->se.opp_table = dev_pm_opp_set_clkname(&pdev->dev, "se");
-	if (IS_ERR(port->se.opp_table))
-		return PTR_ERR(port->se.opp_table);
+	opp_table = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
 	/* OPP table is optional */
-	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	ret = devm_pm_opp_of_add_table(&pdev->dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
-		goto put_clkname;
+		return ret;
 	}
 
 	port->private_data.drv = drv;
@@ -1450,7 +1451,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(drv, uport);
 	if (ret)
-		goto err;
+		return ret;
 
 	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
@@ -1458,7 +1459,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
 		uart_remove_one_port(drv, uport);
-		goto err;
+		return ret;
 	}
 
 	/*
@@ -1475,16 +1476,11 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		if (ret) {
 			device_init_wakeup(&pdev->dev, false);
 			uart_remove_one_port(drv, uport);
-			goto err;
+			return ret;
 		}
 	}
 
 	return 0;
-err:
-	dev_pm_opp_of_remove_table(&pdev->dev);
-put_clkname:
-	dev_pm_opp_put_clkname(port->se.opp_table);
-	return ret;
 }
 
 static int qcom_geni_serial_remove(struct platform_device *pdev)
@@ -1492,8 +1488,6 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
 	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
 	struct uart_driver *drv = port->private_data.drv;
 
-	dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_clkname(port->se.opp_table);
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
 	uart_remove_one_port(drv, &port->uport);
-- 
2.29.2

