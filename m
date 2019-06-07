Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7D939116
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2019 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbfFGP4i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jun 2019 11:56:38 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60348 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbfFGP4i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jun 2019 11:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559922996; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=a8OsSC6tBUyRL7Rw6Y2ayx+S6UhMMk7UJeWp8lYsTyk=;
        b=ea18d6SqUDvF322Q5XlIJkJ8SOw/fRDJaO4ca4BAygoy70Z9AchjCPZT0P+ZRJALM5etFJ
        DZ5qBo/8K2x+1Z9T7xoLq5gOd8fbC7NYL3+u5M1zYp671s3O1ZC2LDjFuN/R51HCeamWkb
        6n/mbEtccfzeELbNbTrOrytfeP7vy0A=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     od@zcrc.me, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] spi: spi-gpio: Make probe function __init_or_module
Date:   Fri,  7 Jun 2019 17:56:31 +0200
Message-Id: <20190607155631.15072-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/spi/spi-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index eca9d52ecf65..c242c962772d 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -358,7 +358,7 @@ static void spi_gpio_put(void *data)
 	spi_master_put(data);
 }
 
-static int spi_gpio_probe(struct platform_device *pdev)
+static int __init_or_module spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
 	struct spi_master		*master;
-- 
2.21.0.593.g511ec345e18

