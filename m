Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFD337DF5
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCKTWY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCKTVs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:21:48 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3BDC061760;
        Thu, 11 Mar 2021 11:21:48 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f1so41650828lfu.3;
        Thu, 11 Mar 2021 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgYus6DBQosirfGlNEj0LdZlOnHUTyxoaJZjhLGd/L0=;
        b=iG68xEJ1rPKedzgVFT+WFb3HOW7Gq+Djdt4N7bEIPXrY9qQ81UtM3SGWhY7lko0aKU
         ZBXk8wrYsxuXPbR3wY0UYjlzy4Si8tI8r8Enwl8FISf93ghhhdhVLGL/ws9liY2n0ytH
         jG1n80WJrja62xahZ9IxijE7hDRWWUmqZzfASYmKSN7bRiytOZYdcZAC+bC2aZ5gRKTR
         t/uzxRhHJllBBM89fni9KjIZOLgofci5BXjngnoHCLSY07o0IYFa8lb6SY7ASr/PpIP6
         bciNluyH5C4JrVZvso0u0rpIp7RAUMiEgTS1miIbDSfgjw3TXyWqq/uCFOXJwb5ktcUF
         Islg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgYus6DBQosirfGlNEj0LdZlOnHUTyxoaJZjhLGd/L0=;
        b=k2N4caM/0hafbG2OzBK3CkCJIjJ41yVsZem1SDEETeZ2WOWr1+LaaEe2Nv18FpYgHp
         4O8z9sBkiOE/1wSOKuU0TxEdV7TUqHVY6/NUh9zhUZpZqo65cfduMEvG1Orvva44f0fr
         JjCGfLM5PL1Lv8r2ZLMKG6Rg2M5GDNIK8IevJX4UhH9zPyol/+S8hxOedbf4Gl1+1kQX
         4atSuQWd+M+j8pFqf7Jovdxr9Bf9w7EUH8FDar48jTCLRVBPzUw+Awiy8ukRLOXA8qit
         Grk0kazoXHiLRiGcvLTVsgxwriXHtU0lwU3+wxhV0cT9bxnd71L4Pk7jPm1gDhIJ482l
         dQuA==
X-Gm-Message-State: AOAM531FsRrWrYW5oZnrTsSfppEuqVuYqeUWY7KivMAIjXNHM/V1k5il
        jeEqBEBaYhcVAiGSo29y63U=
X-Google-Smtp-Source: ABdhPJygLYQbFH51/pquuKZaD25I4ennvq32DKK7qa95SUOL6itcbaAkb19H3NvAx4bH2GUqkfVBog==
X-Received: by 2002:ac2:53a1:: with SMTP id j1mr3121899lfh.298.1615490506564;
        Thu, 11 Mar 2021 11:21:46 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id u14sm1121153lfl.40.2021.03.11.11.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:21:46 -0800 (PST)
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
Subject: [PATCH v2 08/14] spi: spi-qcom-qspi: Convert to use resource-managed OPP API
Date:   Thu, 11 Mar 2021 22:20:59 +0300
Message-Id: <20210311192105.14998-9-digetx@gmail.com>
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
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/spi/spi-qcom-qspi.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 1dbcc410cd35..f14801dd5120 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -142,7 +142,6 @@ struct qcom_qspi {
 	struct clk_bulk_data *clks;
 	struct qspi_xfer xfer;
 	struct icc_path *icc_path_cpu_to_qspi;
-	struct opp_table *opp_table;
 	unsigned long last_speed;
 	/* Lock to protect data accessed by IRQs */
 	spinlock_t lock;
@@ -459,6 +458,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	struct device *dev;
 	struct spi_master *master;
 	struct qcom_qspi *ctrl;
+	struct opp_table *opp_table;
 
 	dev = &pdev->dev;
 
@@ -530,14 +530,14 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->handle_err = qcom_qspi_handle_err;
 	master->auto_runtime_pm = true;
 
-	ctrl->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
-	if (IS_ERR(ctrl->opp_table))
-		return PTR_ERR(ctrl->opp_table);
+	opp_table = devm_pm_opp_set_clkname(&pdev->dev, "core");
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
 	/* OPP table is optional */
-	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	ret = devm_pm_opp_of_add_table(&pdev->dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
-		goto exit_probe_put_clkname;
+		return ret;
 	}
 
 	pm_runtime_use_autosuspend(dev);
@@ -549,10 +549,6 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return 0;
 
 	pm_runtime_disable(dev);
-	dev_pm_opp_of_remove_table(&pdev->dev);
-
-exit_probe_put_clkname:
-	dev_pm_opp_put_clkname(ctrl->opp_table);
 
 	return ret;
 }
@@ -560,14 +556,11 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 static int qcom_qspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
-	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
 
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
 	spi_unregister_master(master);
 
 	pm_runtime_disable(&pdev->dev);
-	dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_clkname(ctrl->opp_table);
 
 	return 0;
 }
-- 
2.29.2

