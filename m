Return-Path: <linux-spi+bounces-3764-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79673928B55
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 17:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A38BB25789
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2B0168493;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXt7EOjI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461514A60C
	for <linux-spi@vger.kernel.org>; Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192367; cv=none; b=GOH8ml8ibUX1IctG/WKLwJOez2n2kZ67JUN6We74rXFvGEeIK9nYe5DkesQfTl/EQff608KxhYkks/7AZclvS1GWxThu8oNkgJ4W7P7KLq8SFPr7J3yjNLPvx8nQ/Y5oaKJCOeTbdaALUXPw/VH7SCx3dW7BGnzgxz/R5t4t73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192367; c=relaxed/simple;
	bh=LneVjNk5SRaJD6DqqwfYMbObYiZgeBxFsU4svVfyNrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEE0TVDq0SgLtYIbYsjk0nZR6OnJVcOQKRWn1jzjCmA4YuWHKYH4RohkMj8Y3uKBrSkbzmH25GfLXthVXmlluSv6CBuY2ugImd0VZ42g/Wz89riplWiqi2Almhbe4WUdHe2E4OcLsr21FXnjegy7Ztv+RddYZ1r8WEaLfGu7hj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXt7EOjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51120C4AF0B;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720192367;
	bh=LneVjNk5SRaJD6DqqwfYMbObYiZgeBxFsU4svVfyNrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pXt7EOjIvOCgl4v8erQ40Xa1y5hLr1mq06nKnQCU9AWPgmi5Q7Xpb8sEO3D4ld50K
	 69rti7Km7V9MJxVLRFhI66loAMpUblW37wy/V6fX6Q6xqYQ8Goh+tOg5l9GHX6ql42
	 ugeN6fmHLAMVXEGHcCmufLJCH3UIaTHzOUjd5hF++8UHmXu5pPp0AzwL9za4vdan4N
	 RPMujORymekQX+SiIXxjK/uyrBbBRRgw0Ntzv8O7VNDJPWLIp2emByyxAoYelmz+/h
	 5YhT3MEehmauzZV/bYGOK8An6tj6nnFXniogJtVJOvImrpSTnQZN/NYamMLs5t3iag
	 gZowLfqrfIxQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5F2C38150;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 05 Jul 2024 17:12:39 +0200
Subject: [PATCH v2 1/4] spi: xcomm: add gpiochip support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-dev-spi-xcomm-gpiochip-v2-1-b10842fc9636@analog.com>
References: <20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com>
In-Reply-To: <20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720192365; l=2456;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=sm/LUmqNmbQc+0zUV9BX4JH9pxe+vkMJ6Q/b4sAIHW4=;
 b=yLlJuu0yEz4OPzzx702Hne37YH8dzQSY5dtmF9bSEbVvw5OGG1j9V91OeZqVZ4skEp+vGmCdE
 xKZBJ34ZlbQB0S1+sxHoRrDl2hlV+CGRZAc20vqz2ZKWaqG8oK/Kd0A
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Michael Hennerich <michael.hennerich@analog.com>

The hardware can expose one pin as a GPO. Hence, register a simple
gpiochip to support it.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Co-developed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/spi/spi-xcomm.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 63354dd3110fc..063ce75af6504 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/gpio/driver.h>
 #include <linux/spi/spi.h>
 #include <asm/unaligned.h>
 
@@ -26,12 +27,15 @@
 
 #define SPI_XCOMM_CMD_UPDATE_CONFIG	0x03
 #define SPI_XCOMM_CMD_WRITE		0x04
+#define SPI_XCOMM_CMD_GPIO_SET		0x05
 
 #define SPI_XCOMM_CLOCK 48000000
 
 struct spi_xcomm {
 	struct i2c_client *i2c;
 
+	struct gpio_chip gc;
+
 	uint16_t settings;
 	uint16_t chipselect;
 
@@ -40,6 +44,42 @@ struct spi_xcomm {
 	uint8_t buf[63];
 };
 
+static void spi_xcomm_gpio_set_value(struct gpio_chip *chip,
+				     unsigned int offset, int val)
+{
+	struct spi_xcomm *spi_xcomm = gpiochip_get_data(chip);
+	unsigned char buf[2];
+
+	buf[0] = SPI_XCOMM_CMD_GPIO_SET;
+	buf[1] = !!val;
+
+	i2c_master_send(spi_xcomm->i2c, buf, 2);
+}
+
+static int spi_xcomm_gpio_get_direction(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int spi_xcomm_gpio_add(struct spi_xcomm *spi_xcomm)
+{
+	struct device *dev = &spi_xcomm->i2c->dev;
+
+	if (!IS_ENABLED(CONFIG_GPIOLIB))
+		return 0;
+
+	spi_xcomm->gc.get_direction = spi_xcomm_gpio_get_direction;
+	spi_xcomm->gc.set = spi_xcomm_gpio_set_value;
+	spi_xcomm->gc.can_sleep = 1;
+	spi_xcomm->gc.base = -1;
+	spi_xcomm->gc.ngpio = 1;
+	spi_xcomm->gc.label = spi_xcomm->i2c->name;
+	spi_xcomm->gc.owner = THIS_MODULE;
+
+	return devm_gpiochip_add_data(dev, &spi_xcomm->gc, spi_xcomm);
+}
+
 static int spi_xcomm_sync_config(struct spi_xcomm *spi_xcomm, unsigned int len)
 {
 	uint16_t settings;
@@ -227,7 +267,7 @@ static int spi_xcomm_probe(struct i2c_client *i2c)
 	if (ret < 0)
 		spi_controller_put(host);
 
-	return ret;
+	return spi_xcomm_gpio_add(spi_xcomm);
 }
 
 static const struct i2c_device_id spi_xcomm_ids[] = {

-- 
2.45.2



