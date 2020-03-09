Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D015A17EADC
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 22:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCIVIt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 17:08:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33136 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgCIVIq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 17:08:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id r7so898999wmg.0;
        Mon, 09 Mar 2020 14:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CfDH5kEUG81plCORDpkFLQzd1G9WILL1xGRX2zS0AUk=;
        b=CrwxY7ZR6In1d7iROlEuUzpfNKBFDbpZPqCUkocPVZNOENXBw4jC/JJtoLAnjKMBmS
         mzYGwac2GkF2j7iRFopyVzjbnAhAHPHOMBo6CR89ffaUr05/kAXqILQsylkErvr2d6vg
         JZxTUVFytnkEXDKTZXxEjMrZSiUlztjjRzrUGMYKgkD6GWVlfrgeAf9urCwk5u7dcBDh
         xJunIrKr7TLh3yJfcBDfz1vBuiPdqH2KE3D8vtbUXFg+JcDcmAkfTzrXz0/eFs1hlMWB
         rAV5o4AkQun/4Ggpwlnaxxj4+0JSZts6v20CzvIE0wzDgH0Vu0T6YDkY18qRgmNhCgm2
         suKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CfDH5kEUG81plCORDpkFLQzd1G9WILL1xGRX2zS0AUk=;
        b=ebTHPyk+sF0OyNcP1D0fh3ftdNjz2rJoKLGIyBBGWC8bOZeDlycTdM4sskAk3+HwQe
         h5PlhagrFBLm2KVb7qSXbtIk7zJrf2k11H2KL0MUogFrpIWYssgw3KpVYsttgnICpXyR
         g8x1D7JYxoQF3CvdupJYSZwWTz01NXt1dMTvxxS/nbfx18m17/S0rk1n80rWhXyVQb+e
         W8mAXDucv3rtP9euaCQe/sxOWOFFoW0KwU05ycw/Jdyv/gmkagDPv96CYii03KggJiul
         Krjk6/ciFwMz+A5awJvwzCKyNNglBM92qaA8hQtxbjVa3/IZOIHDWenoEca9kMI1w+vk
         r3lg==
X-Gm-Message-State: ANhLgQ29Hz68a3e8r4v7k3kJ+LyqZBEnbIkbKpC1g6V3AdhIZX+iiO63
        azS1YWQYB2rv39nJNwW2Nug=
X-Google-Smtp-Source: ADFU+vsumCQXCdxuwgBJelhAJ2sOygVZNVEmCBkTrHMsyvrvvC9USb/FjvggJwneWGdkvyCY/dJ6CQ==
X-Received: by 2002:a05:600c:4107:: with SMTP id j7mr1044307wmi.169.1583788124508;
        Mon, 09 Mar 2020 14:08:44 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id j205sm1016275wma.42.2020.03.09.14.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:08:44 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v2 1/6] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
Date:   Mon,  9 Mar 2020 23:07:50 +0200
Message-Id: <20200309210755.6759-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309210755.6759-1-olteanv@gmail.com>
References: <20200309210755.6759-1-olteanv@gmail.com>
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
Changes in v2:
Remove duplicate phrase in commit message.

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

