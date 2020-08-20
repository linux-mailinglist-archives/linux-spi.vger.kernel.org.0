Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104F624B704
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 12:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgHTKqU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731520AbgHTKot (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 06:44:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEBDC061359
        for <linux-spi@vger.kernel.org>; Thu, 20 Aug 2020 03:44:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d22so826925pfn.5
        for <linux-spi@vger.kernel.org>; Thu, 20 Aug 2020 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uOWJI5P/ZjP6zythnGegEhVJsfmWoLZo0o+x47AYS0E=;
        b=E/zVjsh1o8if8+7pFUUiz4ZhecMs1/LIs7ui21OGEwUDDEWN5BncjVTkD2/mxtNAaS
         dcQBq6eMhvG3yCAs8AcgOvhwgYedg2Z6i8XzR0irtMGD70fqS6EJdJDlc9dVQfeKV/hz
         5DFDXnQdSZqG2BexgfHV7DCg49HINy8/IpHTYlDc5U9WHW3v/LArJaYTquRMEYrbQOFc
         Y5ZJ8PiOqHnOyREyUI0MI/KnHsjQAseurJS7FnldTzKFRUwL7OqYLNowieBRkhbz6W+E
         5v6fRtyff1yeAGbnzSV2ZFchTeTi0d9aOJzWYoZbOcXC/1VvkNfAf/7lE0XPElrau2QO
         8Ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uOWJI5P/ZjP6zythnGegEhVJsfmWoLZo0o+x47AYS0E=;
        b=ePxzqvB4z1cThg2boHIBQ9BCffQ6op6uQo6NFCOQR4gxuZacY+RdlU77b15xM6H8cV
         7fil3VGDqNWYD+OjkvCJrJA4aEClWNG9RwjM9uaHpZ/0rVtERn0OBJPoINs9ZFlRTbnL
         3/UkhF60mklS17+gh2wjU5r2H/r0jZE/9olHpHYgRY9k9P5E0cVRTFadmJeIvr0pPZl1
         MUZWrFwHxRACIdbBV4UiCvPmwug6eJW2Jca3TqCY/BdDUlpUgRAPS00NmI6eIMDE9YF9
         hOhz1XH6wjYpL56DQkuKZtJsIvLXqlWB/pTctSdli7bB7dBN/yZ4nLGmH7fQf7Exikpt
         dVfA==
X-Gm-Message-State: AOAM5331uMovQ+fijD9dPuvc9Dy2VFnutcwEFWiOe4dZZpoMoEBSrBzu
        gPKCU3nguJSmVLhJPfxEp2vxTQ==
X-Google-Smtp-Source: ABdhPJxeiVFtZ3ZkXtc4xAAHs9AvuJP9Q4J3dfZRuwjHdWNJYgaSoR+ZA2Bw6/XqrvFbTwFJYKFuRQ==
X-Received: by 2002:aa7:9569:: with SMTP id x9mr1955507pfq.16.1597920273884;
        Thu, 20 Aug 2020 03:44:33 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id i14sm2492512pfu.50.2020.08.20.03.44.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:44:33 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] spi: spi-qcom-qspi: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Thu, 20 Aug 2020 16:13:55 +0530
Message-Id: <4d255332a28db9d79e0bae2cb73786df9c22efd6.1597919647.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597919647.git.viresh.kumar@linaro.org>
References: <cover.1597919647.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
find the OPP table with error -ENODEV (i.e. OPP table not present for
the device). And we can call dev_pm_opp_of_remove_table()
unconditionally here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/spi/spi-qcom-qspi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index b8857a97f40a..7fd6f631dc17 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -143,7 +143,6 @@ struct qcom_qspi {
 	struct qspi_xfer xfer;
 	struct icc_path *icc_path_cpu_to_qspi;
 	struct opp_table *opp_table;
-	bool has_opp_table;
 	unsigned long last_speed;
 	/* Lock to protect data accessed by IRQs */
 	spinlock_t lock;
@@ -546,9 +545,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	}
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (!ret) {
-		ctrl->has_opp_table = true;
-	} else if (ret != -ENODEV) {
+	if (ret != -ENODEV) {
 		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
 		goto exit_probe_master_put;
 	}
@@ -562,8 +559,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return 0;
 
 	pm_runtime_disable(dev);
-	if (ctrl->has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	dev_pm_opp_put_clkname(ctrl->opp_table);
 
 exit_probe_master_put:
@@ -581,8 +577,7 @@ static int qcom_qspi_remove(struct platform_device *pdev)
 	spi_unregister_master(master);
 
 	pm_runtime_disable(&pdev->dev);
-	if (ctrl->has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	dev_pm_opp_put_clkname(ctrl->opp_table);
 
 	return 0;
-- 
2.25.0.rc1.19.g042ed3e048af

