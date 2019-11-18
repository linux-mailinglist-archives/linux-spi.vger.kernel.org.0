Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA876FFD34
	for <lists+linux-spi@lfdr.de>; Mon, 18 Nov 2019 03:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfKRCtA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 17 Nov 2019 21:49:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37136 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfKRCs7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 17 Nov 2019 21:48:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id b10so355854pgd.4;
        Sun, 17 Nov 2019 18:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LY0ciWZ7+/HWoOPqeE3fOE/KjwyTIZZkb5n5YhlaRJk=;
        b=IFQomFFd376wV893dfuRQSFo6YfIrqUTyUNBbHCHuOkQ5xaMAc3en/4gtkXJqZDO8S
         dxsWJGGbL6cOvN4qT5XUIsu6Drl2ucEq4jmrSiBoCNFYS8GPH4j8mWAVE6SVAHJSGgWC
         2mU/Zyu46UvlQ1Z5LOgR4QctEr/QQIKPR2TZQScR91mp+5YxeTO3mRH4vWzgqDumq4D4
         Rth1GqmAZdEDIacmM0WoKo0rjmrWeO/KNNQBejuqvgdH/FB9nswQ8T8jgnyZVuPKX7cl
         +PH5m4rIJ9/arOzsfPktqjk3yll3gbTvjXjGyMrntNJfnogtxUL8hNTsKAAuRXk/426f
         lAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LY0ciWZ7+/HWoOPqeE3fOE/KjwyTIZZkb5n5YhlaRJk=;
        b=Y/WCHyZWUK/F997BKr8NZsObW/yudQHwef+372QC8nxPN6j88V0bdzdBRCMVChDBNK
         NguxLoHecrEVLKmDeY8FDW1PszZoTEws0bxxttQSfMWIRSFi4G/VQ5Axul4EPR8Q2V72
         ZdCGpBOboE/eSBtb34Sa8U9DCg7lzA2tKI32R4fml9DLjCbaZK6SQ+DEJzYy0nRwYlv1
         M+XqJyQhRwXew51WZI2FLRFnPRsCKmdgSATGk+6O3k6/JuWAfr/jenN33TArg9Bp37WD
         Ae+8e5KQQTA1mxh0bJobtn5wJbPkh9gbUbGVWa5dQwnR8p9yMzKvqyCeawc4h/rsLlws
         OxRQ==
X-Gm-Message-State: APjAAAVKXwDxdvAydStYZqnPv0WbPnJ5X5W0N1dYesZoVDFjNBXidwp5
        3c5J+VieyxX7XJnHdFtiU04=
X-Google-Smtp-Source: APXvYqxi8pFJQRP6n7Wkg+KGy1ZCT0Nr6cre6xagurHdcY9EdUtzZwFHL0IVgvO+4zKFHvHSmMExuw==
X-Received: by 2002:a63:588:: with SMTP id 130mr30852672pgf.148.1574045339235;
        Sun, 17 Nov 2019 18:48:59 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id h5sm17286589pjc.9.2019.11.17.18.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 18:48:58 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] spi: st-ssc4: add missed pm_runtime_disable
Date:   Mon, 18 Nov 2019 10:48:48 +0800
Message-Id: <20191118024848.21645-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver forgets to call pm_runtime_disable in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/spi/spi-st-ssc4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 0c24c494f386..77d26d64541a 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -381,6 +381,7 @@ static int spi_st_probe(struct platform_device *pdev)
 	return 0;
 
 clk_disable:
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(spi_st->clk);
 put_master:
 	spi_master_put(master);
@@ -392,6 +393,8 @@ static int spi_st_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct spi_st *spi_st = spi_master_get_devdata(master);
 
+	pm_runtime_disable(&pdev->dev);
+
 	clk_disable_unprepare(spi_st->clk);
 
 	pinctrl_pm_select_sleep_state(&pdev->dev);
-- 
2.24.0

