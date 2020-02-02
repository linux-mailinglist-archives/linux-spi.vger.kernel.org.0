Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E0614FD1C
	for <lists+linux-spi@lfdr.de>; Sun,  2 Feb 2020 14:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgBBNAD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 Feb 2020 08:00:03 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43336 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBBNAD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 2 Feb 2020 08:00:03 -0500
Received: by mail-yw1-f68.google.com with SMTP id f204so9471670ywc.10;
        Sun, 02 Feb 2020 05:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AH44IHY8LM9hNPEbRtsEm9RIhekLfcrQmhRGmajQBHY=;
        b=JgIz0s5wSKGBK+tfeB5/vDAeI091XJabpzldKR9UAgT7pUXlJhhRG5HCDBI5LeKfic
         Czkl7Js+nI6YwGu4UXoN9oPjZqLGLeDYTnn+m2bo3FGLo4OzdYElucGW886I+Rz3JdC9
         OX1yzKc/bUZyKyP3MdPowqOhhdcpiN+8WIHZ1l5quntT1INEmQ2oaeLEOBBMBegZbvbc
         jHlXkx4UL7Snn9psqzZa+EPnLs7z1hbAaU4xuxTWP0t9VgawcsH3vtNergQT5pFOER57
         aOmCkJpKdgjgN0JpMWCwHkid8uEPyhFBjusCkDfrShvbsvthHYTMKNbX33rnbe5f99g6
         qgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AH44IHY8LM9hNPEbRtsEm9RIhekLfcrQmhRGmajQBHY=;
        b=UGtYqyJNqisoB3+OX6VQGEqtWroxiJwJB6Wh3RWfanYpvqOXIjU9nxxX0eFVCiz3Fg
         +6AobjhDwUNQaz3+W34yMBL1wNzbcZnmkRaq2cB+MhlvLSQjxmCg+F4IOfiPeVb5nc/B
         EH6f3BeQMl5kEdQar83kCOQrOHH2HpKhExS+jwP+Yo4Xd9RzC0RbksRtDF4n8v35eZed
         CpNPy4H5S0WlgYtAmMacyduouHa4Q/Gw87TKdoGUrF5Oui8cSZXLCDehiBBK41xd6V4x
         jJh1p+BnWo2z+DjOkl7sAqkFF42tRTmAAcgA9kV2VLKEo8i7vCPhds3KMqALtUt0rASK
         v7Gw==
X-Gm-Message-State: APjAAAUy+vMIWljeBI7+2OaxLg2W/PfqyOoIRGIgo1zmrHC8c+BIOqak
        1Ks5BlFvVlWjxjsmoVnkkgGuisYaMHI=
X-Google-Smtp-Source: APXvYqy+sjtTqD37PK/Ym1JLqM0bJO+tVP/hDjqdMipCl/DoBz8JAHptrKJ0YAzBNhEkhgjpLJA9RA==
X-Received: by 2002:a0d:d1c6:: with SMTP id t189mr14350608ywd.393.1580648401835;
        Sun, 02 Feb 2020 05:00:01 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id m137sm7090013ywd.108.2020.02.02.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 05:00:01 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Han Xu <han.xu@nxp.com>, Adam Ford <aford173@gmail.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 1/5] spi: fspi: enable fspi on imx8qxp and imx8mm
Date:   Sun,  2 Feb 2020 06:59:46 -0600
Message-Id: <20200202125950.1825013-1-aford173@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

Pull in this patch from NXP's upstream repo to
enable fspi on imx8qxp and imx8mm

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2: Reorder s-o-b lines to give credit in proper order.

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 8c5084a3a617..00c7899428a1 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -324,6 +324,22 @@ static const struct nxp_fspi_devtype_data lx2160a_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
+static const struct nxp_fspi_devtype_data imx8mm_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.little_endian = true,  /* little-endian    */
+};
+
+static const struct nxp_fspi_devtype_data imx8qxp_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.little_endian = true,  /* little-endian    */
+};
+
 struct nxp_fspi {
 	void __iomem *iobase;
 	void __iomem *ahb_addr;
@@ -1076,6 +1092,8 @@ static int nxp_fspi_resume(struct device *dev)
 
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
+	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
+	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
-- 
2.24.0

