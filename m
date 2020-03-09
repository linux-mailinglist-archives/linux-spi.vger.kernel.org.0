Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B105D17E2E7
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 15:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCIO4l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 10:56:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55752 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgCIO4k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 10:56:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so10272763wmi.5;
        Mon, 09 Mar 2020 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z5r520EDIDhaxZmHIIO+qrao4EbtqZFBsAou2LDEw/8=;
        b=bCj1aRVc6Swl2ykd3h4RpfIeQAKIP5iD4RckEcXD8EGVbBSl+bdHXg9fOC0YkNp9P5
         zir7R18yZbd1R/dFBpeZI2wwIOsFaWQQowL3A98nUkNqf9ztgHN1EDHWIZgIz4rkal+e
         0mviBcPYVCvDsGF/1AL5FV+kmD2QpAfronwT5rR5NObjR0+vu3ouk4fu0Xu/tMO4ayBr
         tVF6T9iG5V7e5d3qwDgd2RI/2yYvjeV3Qg3dy/RLOEA6fRg32t2TfkU3ksLNJAYZzytI
         gxC1/Jstq3hvkywd/EI1UJPJjt/QfNa0HGBgFAiACs2WLhOaueTKKww2qHDvs/H5iYi5
         JAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z5r520EDIDhaxZmHIIO+qrao4EbtqZFBsAou2LDEw/8=;
        b=p2QiJ//fUSFX4GHW0pOj6XftDtrU0a5ULVEuKjSx6VMIp6guZ/lw0K+3jApwewjOp4
         tgl92o7rENmWfmKKnLa53qUd6ES12NlvTsihT5k4eCQn4YuCCDAA8N93RVFHyjIxcVVE
         BTr8ebhvp/bMzJwCYDt6dJeDnxW0lQIIKw++jZU7SUINm7Y30upKcxnMlurm7UnBM1pT
         B8qDndCCQ8U/nz+CHw9/+yOzO+W4nICTfjhmsHg6Q9k5IX5owMkWDXoyA8wAyGHW+RaV
         SWRfX7YWVoKHdBAHUNWi/CIofIu0ctwakbPf4A4btb7lVoopWkxqCxwESOXEKxM0IyWw
         nHgg==
X-Gm-Message-State: ANhLgQ2r9pa8e9AGuiKlX6GXUwN+6XcGHfBEuhQPF9YRt0jBMLaVZ0yo
        WOZsl1lP+RL4EQqNoSIAZs8=
X-Google-Smtp-Source: ADFU+vvrNmXm9glan0Q/anobVeTeMvcJhfSERKI+bQ7iw81v0s1OFAbG6BGtv7u2/qWP9VgKaqubvQ==
X-Received: by 2002:a7b:c30a:: with SMTP id k10mr20077911wmj.20.1583765798345;
        Mon, 09 Mar 2020 07:56:38 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id w22sm26905374wmk.34.2020.03.09.07.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 07:56:37 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH 1/6] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
Date:   Mon,  9 Mar 2020 16:56:19 +0200
Message-Id: <20200309145624.10026-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309145624.10026-1-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The SPI_MCR_PCSIS macro assumes that the controller has a number of chip
select signals equal to 6. That is not always the case, but actually is
described through the driver-specific " signals equal to 6. That is not
always the case, but actually is described through the driver-specific
"spi-num-chipselects" device tree binding. LS1028A for example only has
4 chip selects.

Don't write to the upper bits of the PCSIS field, which are reserved in
the reference manual.

Fixes: 349ad66c0ab0 ("spi:Add Freescale DSPI driver for Vybrid VF610 platform")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0683a3fbd48c..0ce26c1cbf62 100644
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
@@ -1197,7 +1197,10 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 
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

