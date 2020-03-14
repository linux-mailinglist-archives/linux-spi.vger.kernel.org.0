Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE018578C
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 02:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgCOBkQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 21:40:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38762 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgCOBkQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Mar 2020 21:40:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id t13so7888931wmi.3;
        Sat, 14 Mar 2020 18:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vJdE0AuVXiJ36mNfX/pKHsHI39Q9/zpf+j6FYiGSXMw=;
        b=QNrWWyWW8vK9IrfwwFeW4XuWps8p+RJtVmPpvgpuQGfC4AQfGYyorsuWKXMwspxsYV
         /iERMorGpvh5h06YA+N2JXtBYc+39BAByPxacsEiPex5gYjtLSepO1kZBWUZOPABXmoh
         t5onjH0u5uLBKUojMeHRuIhMpHBOndCMsSz4kqnbh7Q8SP9GPKPEyinFCQDw5wL0BVPq
         L8xlczCWo8xiyzCXTFvwlN4m4aJR2AQb5X4xVxy1IH0aSZ+ZvW/5GTvMEXjPuRwR48Hd
         Gns//wbii1ccl9zEvouIt/YPV9opXiy/uFYIxyJ9pHCzNwD73cbM0K5phsBKRF+EqrBm
         nQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vJdE0AuVXiJ36mNfX/pKHsHI39Q9/zpf+j6FYiGSXMw=;
        b=C6/Q7Qb+YjIEMSUvHT2cX5/TApfE33aFTwW9Kz0EVB0aInB9sId5ZcDLr05Q4Uw+jd
         iuY7pnrAORqjLQBWOwy0ysu3rk30jCjfi+BPBQC1txpC8EFXHxVMS874JojuhiEGkDz7
         g36frEs5LhMJbRjHig2CNdpAhCE7JwPt63BHupsUTG8ckjTX1fD6GsTiV2DIlZvkTBeE
         ZCJwnkiK3ZNLzG4ZmbGdhQsDVFii/AfEShPsi3Qn6q05K4AnIXBk1HxbVsbrJsQ0Gn/n
         7Zu3axchBEH9Ikek+nGrGJq3if2bLAf0KLO8NfrqEtB7+sCN6pA1Z09oORq7wsNtlmT2
         LThg==
X-Gm-Message-State: ANhLgQ3WiBo6RZgnMwcKsfaKabYJXPy/QZmTuUmNu03PJ+AxMygxppU2
        GDyo09fhxSasz6JuIgoLj/XqcERYeEo=
X-Google-Smtp-Source: ADFU+vufBtUCuRE+ffzHkeys6l4lqDPG6E7fO4lYTZBaecUbjAC0rlm634GlJErKYLxE5STnOjnifA==
X-Received: by 2002:a1c:8103:: with SMTP id c3mr17704074wmd.166.1584225837824;
        Sat, 14 Mar 2020 15:43:57 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id 133sm23690732wmd.5.2020.03.14.15.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:43:57 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 01/12] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
Date:   Sun, 15 Mar 2020 00:43:29 +0200
Message-Id: <20200314224340.1544-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314224340.1544-1-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The SPI_MCR_PCSIS macro assumes that the controller has a number of chip
select signals equal to 6. That is not always the case, but actually is
described through the driver-specific "spi-num-chipselects" device tree
binding. LS1028A for example only has 4 chip selects.

Don't write to the upper bits of the PCSIS field, which are reserved in
the reference manual.

Fixes: 349ad66c0ab0 ("spi:Add Freescale DSPI driver for Vybrid VF610 platform")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v4:
None.

Changes in v3:
None.

Changes in v2:
Remove duplicate phrase in commit message.

 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 50e3382f0c50..6ca35881881b 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -22,7 +22,7 @@
 
 #define SPI_MCR				0x00
 #define SPI_MCR_MASTER			BIT(31)
-#define SPI_MCR_PCSIS			(0x3F << 16)
+#define SPI_MCR_PCSIS(x)		((x) << 16)
 #define SPI_MCR_CLR_TXF			BIT(11)
 #define SPI_MCR_CLR_RXF			BIT(10)
 #define SPI_MCR_XSPI			BIT(3)
@@ -1200,7 +1200,10 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 
 static void dspi_init(struct fsl_dspi *dspi)
 {
-	unsigned int mcr = SPI_MCR_PCSIS;
+	unsigned int mcr;
+
+	/* Set idle states for all chip select signals to high */
+	mcr = SPI_MCR_PCSIS(GENMASK(dspi->ctlr->num_chipselect - 1, 0));
 
 	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
 		mcr |= SPI_MCR_XSPI;
-- 
2.17.1

