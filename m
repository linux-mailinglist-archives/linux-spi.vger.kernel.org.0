Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA351DD611
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 20:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgEUShN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgEUShN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 14:37:13 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FD9C061A0E;
        Thu, 21 May 2020 11:37:13 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id l1so6301867qtp.6;
        Thu, 21 May 2020 11:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Cm9WwmO6RiWm9ZK5yI2ukZk8ZeEGuMcz9zIIlnr08g=;
        b=M5Q2f076kCpF06TJme6P4xJwoibe0mrexZkZQl1axltHUkG9YgTRUkp5LBfxpPj7Td
         tH5Yd10UZDF+2K8cfW2RrSLg8dW9faYYaBW69NoAm/3TbtEs1UhZ60XtfN5IK24TPY5c
         0286gCSoG5GIy5oy6ADFf8Y34zCSgM6F9HIMzwlMfKjX2D/jHBcNgv9ghMDhoJepsCxm
         PfezUgMFELQ4Yccop6/sXJMHsUvy5VaJSv7H+CHfPcHatlLxTlfhQ3ZC8mVmptftSCnS
         ZhmrbdBFPbax0dpKqiZ2EjzHK4/CAMCGY6buxddKa6DSuotrHa7tiOHC02u96shPz1UT
         sFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Cm9WwmO6RiWm9ZK5yI2ukZk8ZeEGuMcz9zIIlnr08g=;
        b=piqvxwZZvBmyOSOFY0g0MC+w4llClDJThM3JhLTK4xdi0dye/kp1M1Eozcd/1MYrEG
         S0URVJHXtEeUAhuJmsnddXyhpvYs24rrX3sagZ8ahm/PezJ1QuvYMAjXSscrbSzGuY4U
         LB5Bmgxky1Hj4aOFqs+4efiJ8KPTENJxLynacaxErIy5BfT6HPEk83kToy0QBcj4+sEG
         1vXRFu2RY/zfTC6mOSJHOOZ6X3duxzIU0YmaEB2hoDJDWMOdjxKrZPPg+tDUwZ/TrUJR
         EVprElRKvfIwJoJC5BddtHPRqHi6MBztjIr3AR6G4mbYd1cOVW/Y5Lm/zkKJgOpnXNLv
         i+uA==
X-Gm-Message-State: AOAM531vY3rjmduWi9Qwuu6kRFaDnq3QDNSycLhBjH8ep6au7TdDQqsq
        gWNZ3vgKL889uHbW1XJ/GM4=
X-Google-Smtp-Source: ABdhPJxlt2zmuYqWd4arNTJvcESzTnMY8R6O8Mlw2zctAHytHP8uv+Z3hyArowkZrikf5MZAn2bPJQ==
X-Received: by 2002:aed:2d02:: with SMTP id h2mr11263968qtd.83.1590086232527;
        Thu, 21 May 2020 11:37:12 -0700 (PDT)
Received: from lord-gnome.lan (pool-100-8-210-135.nwrknj.fios.verizon.net. [100.8.210.135])
        by smtp.gmail.com with ESMTPSA id z25sm5999723qtj.75.2020.05.21.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:37:11 -0700 (PDT)
From:   Christopher Hill <ch6574@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christopher Hill <ch6574@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: rb4xx: null pointer bug fix
Date:   Thu, 21 May 2020 14:36:29 -0400
Message-Id: <20200521183631.37806-1-ch6574@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch fixes a null pointer bug in the spi driver spi-rb4xx.c by
moving the private data initialization to earlier in probe

Signed-off-by: Christopher Hill <ch6574@gmail.com>
---
 drivers/spi/spi-rb4xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
index 4c9620e0d18c..17e1a77dc132 100644
--- a/drivers/spi/spi-rb4xx.c
+++ b/drivers/spi/spi-rb4xx.c
@@ -158,6 +158,11 @@ static int rb4xx_spi_probe(struct platform_device *pdev)
 	master->transfer_one = rb4xx_transfer_one;
 	master->set_cs = rb4xx_set_cs;
 
+	rbspi = spi_master_get_devdata(master);
+	rbspi->base = spi_base;
+	rbspi->clk = ahb_clk;
+	platform_set_drvdata(pdev, rbspi);
+
 	err = devm_spi_register_master(&pdev->dev, master);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register SPI master\n");
@@ -168,11 +173,6 @@ static int rb4xx_spi_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	rbspi = spi_master_get_devdata(master);
-	rbspi->base = spi_base;
-	rbspi->clk = ahb_clk;
-	platform_set_drvdata(pdev, rbspi);
-
 	/* Enable SPI */
 	rb4xx_write(rbspi, AR71XX_SPI_REG_FS, AR71XX_SPI_FS_GPIO);
 
-- 
2.25.1

