Return-Path: <linux-spi+bounces-3743-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BDC927762
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 15:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C70B1F233CB
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D8C41A81;
	Thu,  4 Jul 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Cb8zQE0a"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C951AB8EC
	for <linux-spi@vger.kernel.org>; Thu,  4 Jul 2024 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100740; cv=none; b=Kac6EBK77Xw9e29JbRzmyn5YiDBpnGqdFmkBFjaMfkVDIC1I/PIptqDViERUXjJxlEBYqBJFhFOgtwyLbyQ0t0BTOT1hK+Zjn5/UL/VlHk5XDwG4QjdjEfZJTrBO2Zylklg/xIo/QYeUiihLWUK0n6zQF3KBxxCUvxaQLwnkAq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100740; c=relaxed/simple;
	bh=FRoksbWkdFTMpygH/8FiU5+DkCgqEbtWJFCYs/GlTcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LtIpGVR8oZE44nCGAf0nwyUp6jUdrztC0q9PagHGYicIuXAN+kI0AW1iSJPEIGUkekapRxqRlE6PUGy993WUygpe6Yx1tNkfPDSkqtEk5jkWZaxPAzqo1rDRN0uVG+y7j9vMBuOF2UwGPKlOAUk0kEiZ4Pp9+Wq29kg0e0ISCQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Cb8zQE0a; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464AeiT7006973;
	Thu, 4 Jul 2024 09:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r69CR
	OeUN+eBMHp2/UydgWo72gwsmm0DIvThB1Bqs9k=; b=Cb8zQE0a3Vk4Ryei5pk2Q
	4e8kdeBpSELdlru0spsudU4hj/3tswoWVw1BKtb2XPlXIILzZHF5vPmOGyzfGriK
	RvTOeYfIryna2nX1Dz70Yo037DzzQsrwtut36wsSzxAycwgk8wLtiB+ry5B/GVk5
	cb9AcQ67XIbRGd7DH3SChuZwHZonTJnm7swoGj/pMGIWSRZ8H8L+5r90vNzN/Ec8
	ZV7LkxVKpL3NayNtQg1fk/1npn7jrdj4Slmc+vvWgFCg0TdkdmImwWyD3+1tLOkD
	DJqAu2geY6SvoSAuTFSAvSx9iW6DR2Emj5JhrJerHrRZj+H6nq9mw+8K5a+BCjJr
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 405n2p1jyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 09:45:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 464DjZub000910
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 09:45:35 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 09:45:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 09:45:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Jul 2024 09:45:34 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 464DjPu0032622;
	Thu, 4 Jul 2024 09:45:30 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Jul 2024 15:49:12 +0200
Subject: [PATCH 1/4] spi: xcomm: add gpiochip support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240704-dev-spi-xcomm-gpiochip-v1-1-653db6fbef36@analog.com>
References: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
In-Reply-To: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
To: <linux-spi@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720100959; l=2791;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=QSLZ8CE6IkBdWtLT3KtLIXcFjkET8zoa0PHj3gIFGYU=;
 b=dwUe7a76vjswRmq4mTbSrU1nT6egFKg+RWqJyc9ADEjQSqUHYtNgFma2DXUFbVNEfCTlMTNCk
 1ph9KtRjn4MCpP1qsRIVB8MY9VzN7ce4hVKyPZ9J9jdFV3EeFbJWEfs
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: IxrE03UjnjZx-L9NOFzA4sHW7Ar_9Sc3
X-Proofpoint-GUID: IxrE03UjnjZx-L9NOFzA4sHW7Ar_9Sc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=705 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040098

From: Michael Hennerich <michael.hennerich@analog.com>

The hardware can expose one pin as a GPO. Hence, register a simple
gpiochip to support it.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Co-developed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/spi/spi-xcomm.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 63354dd3110f..358e0b84ee60 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/gpio/driver.h>
 #include <linux/spi/spi.h>
 #include <asm/unaligned.h>
 
@@ -26,12 +27,16 @@
 
 #define SPI_XCOMM_CMD_UPDATE_CONFIG	0x03
 #define SPI_XCOMM_CMD_WRITE		0x04
+#define SPI_XCOMM_CMD_GPIO_SET		0x05
 
 #define SPI_XCOMM_CLOCK 48000000
 
 struct spi_xcomm {
 	struct i2c_client *i2c;
 
+	struct gpio_chip gc;
+	int gpio_val;
+
 	uint16_t settings;
 	uint16_t chipselect;
 
@@ -40,6 +45,54 @@ struct spi_xcomm {
 	uint8_t buf[63];
 };
 
+static void spi_xcomm_gpio_set_value(struct gpio_chip *chip,
+				     unsigned int offset, int val)
+{
+	struct spi_xcomm *spi_xcomm = gpiochip_get_data(chip);
+	unsigned char buf[2];
+	int ret;
+
+	buf[0] = SPI_XCOMM_CMD_GPIO_SET;
+	buf[1] = !!val;
+	ret = i2c_master_send(spi_xcomm->i2c, buf, 2);
+	if (ret < 0)
+		return;
+
+	spi_xcomm->gpio_val = !!val;
+}
+
+static int spi_xcomm_gpio_get_value(struct gpio_chip *chip, unsigned int offset)
+{
+	struct spi_xcomm *spi_xcomm = gpiochip_get_data(chip);
+
+	return spi_xcomm->gpio_val;
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
+	spi_xcomm->gc.get = spi_xcomm_gpio_get_value;
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
@@ -227,7 +280,7 @@ static int spi_xcomm_probe(struct i2c_client *i2c)
 	if (ret < 0)
 		spi_controller_put(host);
 
-	return ret;
+	return spi_xcomm_gpio_add(spi_xcomm);
 }
 
 static const struct i2c_device_id spi_xcomm_ids[] = {

-- 
2.45.2


