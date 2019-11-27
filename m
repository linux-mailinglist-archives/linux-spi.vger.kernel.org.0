Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A366E10B288
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 16:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfK0Pjn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 10:39:43 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:6216 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbfK0Pjm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 10:39:42 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARFbHET015595;
        Wed, 27 Nov 2019 09:39:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=qPhzR/tuKDv5EnvNIvPBDtlaic74fIMn+6iQRLHqAYY=;
 b=VY7B9ChhE82YvCEAvKqNftJ6UFvFu34THkDGLnEc03lK01/x8hZxR+zX2l9lmvT4Yc3j
 UoO0WXrAOfbX4Qs/09FPkv4zrIPoTLkwhKeaKADjHFWJ14zRmrOwbytvSSphKajFE9cb
 eVZi4xRRtVKSsDj68GlxuEGI8xGtHeApEIIVxGGxmCQ3wgWlEo/uDkeBUD4Olhe3rr6R
 ZkVCMTFYax7IWz3Loqzs2HEii3FSR5ZJkh+ZKy0iNwCoW5IVgfjjsmE4CFRIo9wTa+u3
 nNdbLX66guqT79RJHOvblSu0ftnMBJZJm6dLqR47jvn7lR+QaWDHLINIzmnneLIs1hbr qA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2whda3s7nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Nov 2019 09:39:38 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 27 Nov
 2019 15:40:30 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 27 Nov 2019 15:40:30 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C47F52C8;
        Wed, 27 Nov 2019 15:39:36 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <gregory.clement@bootlin.com>, <linus.walleij@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: dw: Correct handling of native chipselect
Date:   Wed, 27 Nov 2019 15:39:36 +0000
Message-ID: <20191127153936.29719-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270136
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch reverts commit 6e0a32d6f376 ("spi: dw: Fix default polarity
of native chipselect").

The SPI framework always called the set_cs callback with the logic
level it desired on the chip select line, which is what the drivers
original handling supported. commit f3186dd87669 ("spi: Optionally
use GPIO descriptors for CS GPIOs") changed these symantics, but only
in the case of drivers that also support GPIO chip selects, to true
meaning apply slave select rather than logic high. This left things in
an odd state where a driver that only supports hardware chip selects,
the core would handle polarity but if the driver supported GPIOs as
well the driver should handle polarity.  At this point the reverted
change was applied to change the logic in the driver to match new
system.

This was then broken by commit 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH
setting when using native and GPIO CS") which reverted the core back
to consistently calling set_cs with a logic level.

This fix reverts the driver code back to its original state to match
the current core code. This is probably a better fix as a) the set_cs
callback is always called with consistent symantics and b) the
inversion for SPI_CS_HIGH can be handled in the core and doesn't need
to be coded in each driver supporting it.

Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

This is only build tested on my end, and I really think it would
benefit for someone actually testing it incase I have missed
something.

Also I have updated the commit message a little over the Cadence
fix, to include some of the additional information from chatting
to Linus. So let me know if you would rather I did a respin of the
Cadence fix with an updated commit message as well.

Thanks,
Charles

 drivers/spi/spi-dw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5cd4fbe8..76d6b94a7597f 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -129,10 +129,11 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	struct chip_data *chip = spi_get_ctldata(spi);
 
+	/* Chip select logic is inverted from spi_set_cs() */
 	if (chip && chip->cs_control)
-		chip->cs_control(enable);
+		chip->cs_control(!enable);
 
-	if (enable)
+	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
 	else if (dws->cs_override)
 		dw_writel(dws, DW_SPI_SER, 0);
-- 
2.11.0

