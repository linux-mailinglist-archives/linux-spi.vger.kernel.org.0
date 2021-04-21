Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581503668F6
	for <lists+linux-spi@lfdr.de>; Wed, 21 Apr 2021 12:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhDUKOl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Apr 2021 06:14:41 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53724 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237878AbhDUKOk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Apr 2021 06:14:40 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LAC0N1006738;
        Wed, 21 Apr 2021 05:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=8PKCIyLI/XwT5pz7mmAeiIYSwcxW8SUzpJ3CHwP+Wf4=;
 b=UNSDWpFl+omSm2KgRlHuNgOEMaNst/H2+5C+cdc6rOvGF52xKLJBnqnxCxEqU6R/Srf+
 hOZf7A5nrXfMEc1/FlvhBcB0ctRUzVJpuFlSOwnKqcnR5dS7PMCRkto+mQ3SV8yUwkqG
 nGjSUDBImnz+fhI2pl0YJ18QWOr+R2NmknGMSVH9NTNfpZ2SwQRmrzMeG27PvThfrO2i
 qD4BD0o6bL6bmwXmvyEiC7uOP/klt0038Db8EZxIwvL1M0hODEwx1V8HrOcKyUC6/XvH
 rTYR/uiDqDyRSprTWCHpA8ytv0WzbCxfAX6tfwlVw0Pwc1Mk+5Q5rr5HquBTg4RKEFSi iA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 381a0rjwu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Apr 2021 05:14:03 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Apr
 2021 11:14:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 21 Apr 2021 11:14:02 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3071811D6;
        Wed, 21 Apr 2021 10:14:02 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <saravanak@google.com>
CC:     <linus.walleij@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: Make of_register_spi_device also set the fwnode
Date:   Wed, 21 Apr 2021 11:14:02 +0100
Message-ID: <20210421101402.8468-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: jaE5QS6eKnyKoiz_bMDSEtjZRJyeEvk_
X-Proofpoint-ORIG-GUID: jaE5QS6eKnyKoiz_bMDSEtjZRJyeEvk_
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210078
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently, the SPI core doesn't set the struct device fwnode pointer
when it creates a new SPI device. This means when the device is
registered the fwnode is NULL and the check in device_add which sets
the fwnode->dev pointer is skipped. This wasn't previously an issue,
however these two patches:

commit 4731210c09f5 ("gpiolib: Bind gpio_device to a driver to enable
fw_devlink=on by default")
commit ced2af419528 ("gpiolib: Don't probe gpio_device if it's not the
primary device")

Added some code to the GPIO core which relies on using that
fwnode->dev pointer to determine if a driver is bound to the fwnode
and if not bind a stub GPIO driver. This means the GPIO providers
behind SPI will get both the expected driver and this stub driver
causing the stub driver to fail if it attempts to request any pin
configuration. For example on my system:

madera-pinctrl madera-pinctrl: pin gpio5 already requested by madera-pinctrl; cannot claim for gpiochip3
madera-pinctrl madera-pinctrl: pin-4 (gpiochip3) status -22
madera-pinctrl madera-pinctrl: could not request pin 4 (gpio5) from group aif1  on device madera-pinctrl
gpio_stub_drv gpiochip3: Error applying setting, reverse things back
gpio_stub_drv: probe of gpiochip3 failed with error -22

The firmware node on the device created by the GPIO framework is set
through the of_node pointer hence things generally actually work,
however that fwnode->dev is never set, as the check was skipped at
device_add time. This fix appears to match how the I2C subsystem
handles the same situation.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cc6d43d7895f0..350c109f7547d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2038,6 +2038,7 @@ of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
 	/* Store a pointer to the node in the device structure */
 	of_node_get(nc);
 	spi->dev.of_node = nc;
+	spi->dev.fwnode = of_fwnode_handle(nc);
 
 	/* Register the new device */
 	rc = spi_add_device(spi);
-- 
2.11.0

