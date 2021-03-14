Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821CF33A658
	for <lists+linux-spi@lfdr.de>; Sun, 14 Mar 2021 17:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhCNQfN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Mar 2021 12:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbhCNQeq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Mar 2021 12:34:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE370C061574;
        Sun, 14 Mar 2021 09:34:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y124-20020a1c32820000b029010c93864955so18824918wmy.5;
        Sun, 14 Mar 2021 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWkE1WsTkUBL6nZDojhWUmQnQSjSLYp0gyDUfjHX3tw=;
        b=cSRN2y/tFestNZrESCS+KzkQ57FoXybXRzZLeRHuPVB2i3UPQ3T0LMt8IYTS1MtSw3
         k7WXzZh1XLATuVEVwbHL7djV2gSVBx++Z5JLAS3gAfGoDt0sYVs8MWg+HYvgYjsyn6T4
         tI1eoDiYa61+/CCL8pvSFBl/wqpe3xS7UYtoMbT2jJJvGqkbAnTqdbC73psUVGasoTI9
         OJNkYM0JrO83EBXuM/zzwgNM2RCf2VjL8h4Q+hqyqJWvsnSrADr4kBW0ZGVTdTcrzbgv
         p00a9xQNc7hrR27z/yJrIEyCSpUsg9iO4FoUiGw7EON9ZgIM2LqG7bsd0oWFd90pRO6P
         X8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWkE1WsTkUBL6nZDojhWUmQnQSjSLYp0gyDUfjHX3tw=;
        b=kDs4qFsdMUet7yuSrYl4qDIG4KJlIAmRym3XOdm1O07gxuVOB6UlwXF8jDAD9e1IiG
         V5hlQkomnx49fJbVVZ/iCdXyEi/KZ+EfpReGxaTxs4dY/AOr38jE2IbI5a634REXob9b
         dw9kIAkujdcTSL+auuS9flffvteeRIqORqGiy15rl69iOsJ8mMuo/2ot3NxVQBLivseh
         n9MaPlD8YKna8QWawX0te3bMCe5L6vpnrW4hhSOCIkSJEL12P9uFuLqpnBKfG98PFEMO
         oDwZWs5ZObzPkQwXS44KTb+PdR+3Ef5CNsy/v6aTrLeaS4I0tl141YbUrzlcm+I7D+Hc
         GiRA==
X-Gm-Message-State: AOAM532k1L5hWjrQqwH92P8DUMXoaMJuFlGiiYdSzyTyskBjxiZK6OKZ
        fctm5k3Gv8wBclVaphf0UdY=
X-Google-Smtp-Source: ABdhPJzytN+oHophUDTCGClKZO9DIbz4gbFiuvi8oNRIXU4bqMoNeMMCp+cq4eL36pRbJLjGGBYMcg==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr22166814wmi.132.1615739684501;
        Sun, 14 Mar 2021 09:34:44 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id o7sm15723239wrs.16.2021.03.14.09.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:34:44 -0700 (PDT)
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
Subject: [PATCH v3 07/15] serial: qcom_geni_serial: Convert to use resource-managed OPP API
Date:   Sun, 14 Mar 2021 19:34:00 +0300
Message-Id: <20210314163408.22292-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314163408.22292-1-digetx@gmail.com>
References: <20210314163408.22292-1-digetx@gmail.com>
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
 drivers/tty/serial/qcom_geni_serial.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 291649f02821..3872bbfac24b 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1433,14 +1433,14 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
 		port->cts_rts_swap = true;
 
-	port->se.opp_table = dev_pm_opp_set_clkname(&pdev->dev, "se");
-	if (IS_ERR(port->se.opp_table))
-		return PTR_ERR(port->se.opp_table);
+	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	if (ret)
+		return ret;
 	/* OPP table is optional */
-	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	ret = devm_pm_opp_of_add_table(&pdev->dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
-		goto put_clkname;
+		return ret;
 	}
 
 	port->private_data.drv = drv;
@@ -1450,7 +1450,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(drv, uport);
 	if (ret)
-		goto err;
+		return ret;
 
 	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
@@ -1458,7 +1458,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
 		uart_remove_one_port(drv, uport);
-		goto err;
+		return ret;
 	}
 
 	/*
@@ -1475,16 +1475,11 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
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
@@ -1492,8 +1487,6 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
 	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
 	struct uart_driver *drv = port->private_data.drv;
 
-	dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_clkname(port->se.opp_table);
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
 	uart_remove_one_port(drv, &port->uport);
-- 
2.30.2

