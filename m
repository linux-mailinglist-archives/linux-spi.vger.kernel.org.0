Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233D12E84BE
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 18:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbhAAQ7Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 11:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbhAAQ7O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 11:59:14 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5A5C061757;
        Fri,  1 Jan 2021 08:58:34 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g15so14726065pgu.9;
        Fri, 01 Jan 2021 08:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yu74XuJH53c+EXvKWMencH3rXiKT1m6r0c1T0r676aY=;
        b=gh7RvhL62o/PSCpktmhn3EbfQ3dx1vvB+ZmqES+Jmm88swPVRtVyFOvVd2bYWOik29
         Tf2nXsdUR5mBpBYKLAXO6pceBAG+flQxPB2Jvy/vdpPe3hCYniRi2wVmyV6KljZidpIl
         7+ltUJSpOwmtrH+3uiSBW1XTFeAjnSeKy5Fhyn0mp8bJVgc1G0rxRm3FH1HR+zomceOW
         w/Zi0Kk1vApmR2ie30W9zO5+3nbEioG2IGELTxjHbYMIIzvzfngUncqFIwWUdgMXjiuU
         fmsVVrQWwoVQ40dUogwxdGBv2W0LcV1L+5Mgk0jrMk35BclmJuKCV9DZPpWeM4+osSWT
         pGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yu74XuJH53c+EXvKWMencH3rXiKT1m6r0c1T0r676aY=;
        b=q97Bj3IZGTqoz+JoHnpVbgCImEHTdo62xMnIA55A4cKH8HbwqI+21Oj0Y0XkD1T20f
         aewQwUu4p78zO1LfYAyYNMK2AtdMOpbmnS1fv7dmIczrzWyjfvu9WPK+3yAZpAI36S3Z
         8BQNVNOu3F52086Lv2/zXSXyBVOv+q477uPBUxNwsyXNd8l72dPSXfppsjILWD8pkQCp
         aKLD6ChgDI1VDOdaiyI2c+YKaNT3OC67LeJW2+wRbxWrAt9dPTYea2CFd3w5blNeLeph
         FwO7Qd/r8zl2/FzJUJCCOP47p5JH1WnUz+b2ALOh9VMqsv+2cKZKzZYqjSghxiZ1bNo/
         ogMA==
X-Gm-Message-State: AOAM531u+RToJ+aUjpG7Qtp0gaMSz5zfM/y+iTazD9NfPTawzhBUegyv
        VnJ/xYCP3p0bp1852nQ7RgQ=
X-Google-Smtp-Source: ABdhPJwOll/dMiWiDKZQBDwgbOKq3kdz6aVDzq67HtJRRsr7Oec5o4g1+GYjXRy8liLw+XYioZ4FhQ==
X-Received: by 2002:a63:5023:: with SMTP id e35mr61063976pgb.56.1609520313911;
        Fri, 01 Jan 2021 08:58:33 -0800 (PST)
Received: from localhost.localdomain ([43.255.31.23])
        by smtp.gmail.com with ESMTPSA id 84sm50002729pfy.9.2021.01.01.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 08:58:33 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, digetx@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yuq825@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robdclark@gmail.com, sean@poorly.run,
        robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, stanimir.varbanov@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        lukasz.luba@arm.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        hoegsberg@google.com, eric@anholt.net, tzimmermann@suse.de,
        marijn.suijten@somainline.org, gustavoars@kernel.org,
        emil.velikov@collabora.com, jonathan@marek.ca,
        akhilpo@codeaurora.org, smasetty@codeaurora.org,
        airlied@redhat.com, masneyb@onstation.org, kalyan_t@codeaurora.org,
        tanmay@codeaurora.org, tiny.windzz@gmail.com,
        ddavenport@chromium.org, jsanka@codeaurora.org,
        rnayak@codeaurora.org, tongtiangen@huawei.com,
        miaoqinglang@huawei.com, khsieh@codeaurora.org,
        abhinavk@codeaurora.org, chandanu@codeaurora.org,
        groeck@chromium.org, varar@codeaurora.org, mka@chromium.org,
        harigovi@codeaurora.org, rikard.falkeborn@gmail.com,
        natechancellor@gmail.com, georgi.djakov@linaro.org,
        akashast@codeaurora.org, parashar@codeaurora.org,
        dianders@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 14/31] spi: spi-qcom-qspi: convert to use devm_pm_opp_* API
Date:   Fri,  1 Jan 2021 16:54:50 +0000
Message-Id: <20210101165507.19486-15-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use devm_pm_opp_* API to simplify code, and remove opp_table
from qcom_qspi.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/spi/spi-qcom-qspi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 915ae115d8c1..1a1ab153ff59 100644
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
 
@@ -531,13 +531,13 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->handle_err = qcom_qspi_handle_err;
 	master->auto_runtime_pm = true;
 
-	ctrl->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
-	if (IS_ERR(ctrl->opp_table))
-		return PTR_ERR(ctrl->opp_table);
+	opp_table = devm_pm_opp_set_clkname(dev, "core");
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
 	/* OPP table is optional */
-	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	ret = devm_pm_opp_of_add_table(dev);
 	if (ret) {
-		dev_pm_opp_put_clkname(ctrl->opp_table);
+		devm_pm_opp_put_clkname(dev, opp_table);
 		if (ret != -ENODEV) {
 			dev_err(&pdev->dev, "invalid OPP table in device tree\n");
 			return ret;
@@ -553,8 +553,6 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return 0;
 
 	pm_runtime_disable(dev);
-	dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_clkname(ctrl->opp_table);
 
 	return ret;
 }
@@ -568,8 +566,6 @@ static int qcom_qspi_remove(struct platform_device *pdev)
 	spi_unregister_master(master);
 
 	pm_runtime_disable(&pdev->dev);
-	dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_clkname(ctrl->opp_table);
 
 	return 0;
 }
-- 
2.25.1

