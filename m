Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89132B3F07
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 09:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgKPIqX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 03:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgKPIqW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 03:46:22 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6864AC0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 00:46:22 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id ABE9F1002A0DA;
        Mon, 16 Nov 2020 09:46:20 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 786326035EEE;
        Mon, 16 Nov 2020 09:46:20 +0100 (CET)
X-Mailbox-Line: From 43babe4e6cd4a433dcdcf99aaabaa1a02ff44acd Mon Sep 17 00:00:00 2001
Message-Id: <43babe4e6cd4a433dcdcf99aaabaa1a02ff44acd.1605512876.git.lukas@wunner.de>
In-Reply-To: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Nov 2020 09:23:12 +0100
Subject: [PATCH for-5.10] spi: sc18is602: Don't leak SPI master in probe error
 path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Phil Reid <preid@electromag.com.au>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the call to devm_gpiod_get_optional() fails on probe of the NXP
SC18IS602/603 SPI driver, the spi_master struct is erroneously not freed.

Fix by switching over to the new devm_spi_alloc_master() helper.

Fixes: f99008013e19 ("spi: sc18is602: Add reset control via gpio pin.")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v4.9+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v4.9+
Cc: Phil Reid <preid@electromag.com.au>
---
 drivers/spi/spi-sc18is602.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index ee0f3edf49cd..297c512069a5 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -238,13 +238,12 @@ static int sc18is602_probe(struct i2c_client *client,
 	struct sc18is602_platform_data *pdata = dev_get_platdata(dev);
 	struct sc18is602 *hw;
 	struct spi_master *master;
-	int error;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
 				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
 		return -EINVAL;
 
-	master = spi_alloc_master(dev, sizeof(struct sc18is602));
+	master = devm_spi_alloc_master(dev, sizeof(struct sc18is602));
 	if (!master)
 		return -ENOMEM;
 
@@ -298,15 +297,7 @@ static int sc18is602_probe(struct i2c_client *client,
 	master->min_speed_hz = hw->freq / 128;
 	master->max_speed_hz = hw->freq / 4;
 
-	error = devm_spi_register_master(dev, master);
-	if (error)
-		goto error_reg;
-
-	return 0;
-
-error_reg:
-	spi_master_put(master);
-	return error;
+	return devm_spi_register_master(dev, master);
 }
 
 static const struct i2c_device_id sc18is602_id[] = {
-- 
2.28.0

