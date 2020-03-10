Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912E317FD2E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 14:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgCJMzz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 08:55:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52102 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbgCJMzy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 08:55:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id a132so1283751wme.1;
        Tue, 10 Mar 2020 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3v9UPmq+Vv3cSCddZuyv3HLidzutYMcEu/49JcrOcIE=;
        b=PL1RRnyU8o1JjP4q4TIN9i5MglbS9kvc8FuTTvogHkYgVu1hjhA2kjZ/9gjjooSuTi
         gbW0LOkqH3Q7tNZhBpMniHLELwYo/PQpgO65YKE0KCs2VZePhPhebSbZI7kqbapSvvoq
         pbXONeKVT4dWeAulH2jxX2e0woTibV+rSCMFR8vZUi/V2bEPMUnLF6bjGCoM+L9nchwM
         1FTKojKRH71p+gJj2d20yVvVXuJ9+tbtqg0JopB1c045k+lUnKT+w7UFoGD1WrIZHvcD
         K9VTtt2L6/XbjrA6L/MvmsLHTlbgLKcfCMOiNjOBu6edzBLwk4FSLyE0H/lVWwLUVx7h
         hytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3v9UPmq+Vv3cSCddZuyv3HLidzutYMcEu/49JcrOcIE=;
        b=gTemCBAAMKRpxwfeuIDJ2CfpgeudlV+YuHJpnh55IMO4qujpTrZOUFs3BFLqJuF3Ur
         IqtYmYMJRmszgRU7G5Z/Rz37vetIs5L66rXGVZKjbJq7WCycx5tvwDur9RNG5JsLD6z+
         xMlnOdKwWn3QnTlP1IIQYSUNQBoOKCkE0WXx0tWKscak89ojgRRp8bxqL5/qEJktBbOL
         0CxI1zB6rj4MlOLvOpwaM8sxzr3IM73mpnHIbuOPFymvxdGIugTPk59dfqZynB/iAGd9
         7aTqDg7eXXAFtZR4Gy/Pk5b7eljBS2NQErO1ebYPzBPJoUXrLOPefM69ixx7ITuaTk66
         em7w==
X-Gm-Message-State: ANhLgQ2kZ8ORKnb1HtUXnpuf6jYgqZY8LMMSgZMhtycokuZn6yRcm3a3
        YlgxFnsRW4RAUAUqUEPpsgs=
X-Google-Smtp-Source: ADFU+vtJvj9IRuqR/RlXga3fZvDzZE/RQZkdUuZqMDXj7+/VqIfX7CJZ55FZ1+ndPPbFbBGcsyi49A==
X-Received: by 2002:a1c:68c2:: with SMTP id d185mr2116200wmc.150.1583844951394;
        Tue, 10 Mar 2020 05:55:51 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id t81sm4018594wmb.15.2020.03.10.05.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 05:55:50 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 1/7] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
Date:   Tue, 10 Mar 2020 14:55:36 +0200
Message-Id: <20200310125542.5939-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310125542.5939-1-olteanv@gmail.com>
References: <20200310125542.5939-1-olteanv@gmail.com>
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
Changes in v3:
None.

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

