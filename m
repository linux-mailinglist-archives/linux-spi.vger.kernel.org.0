Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8534A1892BD
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCRARL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56308 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgCRARJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so1303211wmi.5;
        Tue, 17 Mar 2020 17:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J+e5SK2e2LZ4MyHO9wWSsa40xkOFSDNcY+p2H5PaU+M=;
        b=Ynp2qMHIuiwOUtZ3QM8+AfwnmcGnkCuk4FQFn8Eto1QVXv7jYR2Ss/sb/kVH738oZu
         iVSOpVaIA3MIQ9KszW2EfUIRrEVCRZxabMXD6e0/3RWxKSJwpmkhMqahTD2z67QrqIAt
         gmWybPGOIHi07H1rdM/5kDntw1zPNAO13wjimFtPB0vTj0zJ/NEbZzokcBs8y67xS4K/
         E4r+cJRajOj34rWb3sTLI1MComoF6+ZidtBCfffijh2DpqsExKSQ9vxEWrZZKlJq/Ber
         dtCbdZs6DubENgqC17ljQPdrq0b64t+d5JUIAVkP/sAVuHigFfgmgz80+HWQWMWIU+TR
         XQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J+e5SK2e2LZ4MyHO9wWSsa40xkOFSDNcY+p2H5PaU+M=;
        b=DJK1t+T0p3LcwI7wbX510gBBQMgUG6f/uTrLOCSkAxP8RZXD2ZVX44DkyTuYrOzzuf
         DTiMyY7oyzSYJvbcluu9S8eRLxxZjE5NJNH2Xauynj58M5m1kQOxNGnJIj18Bsk8PNk7
         CvwSP9Lg29c3og88v9C8vIjx8fixGxc4bUa0nLZu4kTSwDx+8mR/kaj+IRYKeOPeuNR+
         +ShzdkNl4dkKCkcJ4/l1ktcNZeLymCNczLXu9tIpl3m+gxpcTVADy9YaUj4UE0DXhBlt
         4wiMsE6M7k5yJkoosF+bDZjuUFkD2DWg7vk8EtRhno0rocbMpd9fkvxGoS8vTInZzy13
         58Pw==
X-Gm-Message-State: ANhLgQ1tzsIY/fFgcguJ4tugBC6goYL8oRnbyJGuMBbQTa5nxo41NAWl
        Cv5IwkQFjBncWqeD/4W5z8k=
X-Google-Smtp-Source: ADFU+vs7XKqVjr0PgUql0X5CC6cLuNW6Uv2W1EblIurQKjusZ+ze0jq2S+qyuUiW+Blezf+J0pNwSw==
X-Received: by 2002:a05:600c:4145:: with SMTP id h5mr1529450wmm.3.1584490628310;
        Tue, 17 Mar 2020 17:17:08 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:07 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 01/12] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
Date:   Wed, 18 Mar 2020 02:15:52 +0200
Message-Id: <20200318001603.9650-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
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
Changes in v5:
None.

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

