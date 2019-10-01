Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B08C3F24
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbfJAR5N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 13:57:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52212 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731374AbfJAR5G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 13:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TEqrWJlydl/LJ/NEbAy7qWhWY6Kvs3fyXEgyW+lKv6Q=; b=szJMXQiwligC
        rrKJgYaWPIHn2NmrRg4bVyJr10GIQqsMlErQZIgPnCIwMJbcHWm7yTpJYJVAxxW5gjI4ep1MbCcvH
        cKHQEk6YDwOod5nYjou2Wxp9KBuXSI+DrVrq/CqR4VBHWOrkxpraDQC05XyqK71gjVuXe2jkfZlL6
        c5lj4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFMOU-0005vC-49; Tue, 01 Oct 2019 17:57:02 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A2CF127429C0; Tue,  1 Oct 2019 18:57:01 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     "Cc:"@sirena.co.uk, "Cc:"@sirena.co.uk, emamd001@umn.edu,
        kjlu@umn.edu, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        smccaman@umn.edu
Subject: Applied "spi: gpio: prevent memory leak in spi_gpio_probe" to the spi tree
In-Reply-To: <20190930205241.5483-1-navid.emamdoost@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001175701.A2CF127429C0@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 18:57:01 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: gpio: prevent memory leak in spi_gpio_probe

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From d3b0ffa1d75d5305ebe34735598993afbb8a869d Mon Sep 17 00:00:00 2001
From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Mon, 30 Sep 2019 15:52:40 -0500
Subject: [PATCH] spi: gpio: prevent memory leak in spi_gpio_probe

In spi_gpio_probe an SPI master is allocated via spi_alloc_master, but
this controller should be released if devm_add_action_or_reset fails,
otherwise memory leaks. In order to avoid leak spi_contriller_put must
be called in case of failure for devm_add_action_or_reset.

Fixes: 8b797490b4db ("spi: gpio: Make sure spi_master_put() is called in every error path")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Link: https://lore.kernel.org/r/20190930205241.5483-1-navid.emamdoost@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 1d3e23ec20a6..f9c5bbb74714 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -371,8 +371,10 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
-	if (status)
+	if (status) {
+		spi_master_put(master);
 		return status;
+	}
 
 	if (of_id)
 		status = spi_gpio_probe_dt(pdev, master);
-- 
2.20.1

