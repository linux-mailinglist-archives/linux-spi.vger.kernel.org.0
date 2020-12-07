Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D672D0BD9
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgLGIiH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:38:07 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:43807 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgLGIiH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:38:07 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9E98A30000D04;
        Mon,  7 Dec 2020 09:36:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 22A8410DB; Mon,  7 Dec 2020 09:37:26 +0100 (CET)
Message-Id: <d5f715527b894b91d530fe11a86f51b3184a4e1a.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:11 +0100
Subject: [PATCH 11/17] spi: sc18is602: Don't leak SPI master in probe error
 path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
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
2.29.2

