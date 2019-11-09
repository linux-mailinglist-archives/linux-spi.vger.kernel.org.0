Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F819F5DEC
	for <lists+linux-spi@lfdr.de>; Sat,  9 Nov 2019 08:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfKIHz1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 9 Nov 2019 02:55:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36007 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfKIHz0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 9 Nov 2019 02:55:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id v19so6710517pfm.3;
        Fri, 08 Nov 2019 23:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5y5F8DyE69ir1OM2CEfkdK02+fKl+DjTDmsukenqfiQ=;
        b=AjKVLIINbCyCGNErBDVArFPlefHe1A9QAXdVJsH4glXRTAM7nSeef9BnXN8p72bfa7
         corH8nuZlhOXK74kPezTad4pPF0AzamWbusEt5KjXcM/6Spcdh54y6IMT9UGO7YggpRH
         y92Bv3qegbd3qjWpZGkiTs/5O34uCH/sgdOQSgBIvC0dyV2Jls1v+fMW37D8eGBjrjSY
         WwXjYg7gkmJb2oajXjq8VXtPGGWOWjaLMYva6TwbNu8mKifVL8xFcTFQh7Gq1rQODDsx
         psfytab/67cpvJxKrzTbk9jtsBLj+vzMO3OIIy7JWYLprBiHWfoANVnPBNs3TIO84FdW
         6pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5y5F8DyE69ir1OM2CEfkdK02+fKl+DjTDmsukenqfiQ=;
        b=sfdZtWmza9Z20HUlVtwHw77RitybI39SXtRgWNdOSc1Kg2mvwdMLd1+ts743ZBpjEM
         6b28sIZop4v791GEIp2FTeo1IFBsPpybi4NgGafKvB6yGCAT43x158EldiC05MZB5B1L
         HS92IkuOcXwLdMQhR3NJfPIflOadpH4/IVOf53W+HADoQYvCPnqlL5XG4eMTk0J0XwjB
         thglGxpiECPqoEJvzabyWpuwgo9pztWim5UBynwTGkKu0dPXzbRlBMEjuFF90tWzsniG
         9sD/0VEHqSLVBdyG/0W9mJiiw1w2aY4iRiytm1CRmRAMbUjccGtnoFy3Q0dzAAutE1lu
         yu9Q==
X-Gm-Message-State: APjAAAUKhQ130DsRLjG6GKhSjriHlmp4z5cMzoDD9WKVP66lGObtNGxL
        Lohel+3bhzVALtgg1aRENrE=
X-Google-Smtp-Source: APXvYqx2cSGRXqlwVfsdvlPuBSmwxQE4SAkZEgfrpY6nWMX1WSSN1/90gegiaDpT10gY/JXx/Rzuxw==
X-Received: by 2002:a63:a747:: with SMTP id w7mr1130998pgo.310.1573286126256;
        Fri, 08 Nov 2019 23:55:26 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id b17sm9474030pfr.17.2019.11.08.23.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 23:55:25 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] spi: nxp-fspi: Use devm API to fix missed unregistration of controller
Date:   Sat,  9 Nov 2019 15:55:17 +0800
Message-Id: <20191109075517.29988-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver forgets to unregister controller when remove.
Use devm API to unregister it automatically to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 501b923f2c27..c36bb1bb464e 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1027,7 +1027,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
-	ret = spi_register_controller(ctlr);
+	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret)
 		goto err_destroy_mutex;
 
-- 
2.23.0

