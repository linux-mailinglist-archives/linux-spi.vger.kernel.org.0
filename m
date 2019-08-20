Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40D595F41
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfHTMzE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 08:55:04 -0400
Received: from mail-wr1-f100.google.com ([209.85.221.100]:35003 "EHLO
        mail-wr1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfHTMzD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 08:55:03 -0400
Received: by mail-wr1-f100.google.com with SMTP id k2so12292573wrq.2
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 05:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=RKXbUzu1kRheoPwSAkue89bMPLcxfeHfz/VAPnv9H28=;
        b=NNFH8gQEaNqyMWv9eOhGD4SCBHLxI7CkXqrQa5bo/Sauh60w92luKifgCAIxAR8e+y
         4AzWnt7iMnLmdM9mArHacWFlpynckrG0cZpYb+cI88poVkQgYjs0wqw7/u961OKrecrV
         6ZhNedIKIN7whzh5a+jD90bIhC+QBe+RVJgwprvEHrK4GOkGzRedxzmibY+9B+9LgC/r
         OA3Y9MLxRoPVo0R7SjwL4KmmduoBVWZ6/KLEpC/eTq7ubiZm9jdvum8bdGt2d4UrH+TT
         IdQYXLIORScMWN8K++zPLpk9PW6QwAmei+4iJDvrv42IfrvujEUv1djygwgre6F7D3Aq
         TyGg==
X-Gm-Message-State: APjAAAWbqC4h7pTWoLRzVobvWBhFMPFh1xbWSyWvQpnhUwmwRDxdypTa
        SWcpiEWZtJQG9yrwoSNtZ3RD31lOkapP9g/jpbsqcIE3hFOVAFOrt2EqWu0HmT7E2w==
X-Google-Smtp-Source: APXvYqzr6d7Jo1fLhXXIs7tv09nFOW/0aRO+946vXqOAFs7NCqricpsmUlH1EaGfhsDssInmBHVS9iBuZQqg
X-Received: by 2002:adf:cd11:: with SMTP id w17mr35742727wrm.297.1566305700607;
        Tue, 20 Aug 2019 05:55:00 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id o11sm305378wrx.68.2019.08.20.05.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 05:55:00 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03fA-0002Dq-Af; Tue, 20 Aug 2019 12:55:00 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B15E9274314C; Tue, 20 Aug 2019 13:54:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Applied "spi: zynq-qspi: Fix missing spi_unregister_controller when unload module" to the spi tree
In-Reply-To: <20190818095113.2397-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820125459.B15E9274314C@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 13:54:59 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: zynq-qspi: Fix missing spi_unregister_controller when unload module

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 8eb2fd00f65a96143ed1535bdbf4ca4e129d30d1 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 18 Aug 2019 17:51:13 +0800
Subject: [PATCH] spi: zynq-qspi: Fix missing spi_unregister_controller when
 unload module

Use devm_spi_register_controller to fix missing spi_unregister_controller
when unload module.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Link: https://lore.kernel.org/r/20190818095113.2397-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index c6bee67decb5..d812a215ae5c 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -695,7 +695,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ctlr->setup = zynq_qspi_setup_op;
 	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
 	ctlr->dev.of_node = np;
-	ret = spi_register_controller(ctlr);
+	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_master failed\n");
 		goto clk_dis_all;
-- 
2.20.1

