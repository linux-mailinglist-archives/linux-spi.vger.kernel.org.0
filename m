Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5778D172FE1
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 05:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgB1Eii (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 23:38:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34199 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbgB1Eii (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 23:38:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so1058970pfc.1;
        Thu, 27 Feb 2020 20:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCI1h6XDepXvM9SY2yPFBOaTm7J4GLR1VLmmf1BO1BQ=;
        b=hgFIB8G5XahI8txUYsDG5MShh+0AatjMli8EcASbn9w8027Uc/WNZUIeppsDE5nxwu
         8k1V9RFPmVegaSjuOx5NqPNXyhYFevqXge3mJywpLSUkweXuhEEPympdpxPUfv4+hb7M
         yVr3nweqvyatKHlLAGD5cGjE6180bkWLkRKuZ8d+BlAN7LXt6IsJ7ZOMRZy65LpEx7Ui
         S718KkrhH+sJwpIEeL74ndAs5kA5oN9ZUNx2dNeEdTEWXtc6ryrHznrwd0AtPIkTM4Sl
         YduGSO7MjAqAtPPPGBwrs4jG57l+x4oS+9uKRGtDuTu/gKF8UiMV8AVR31WyIdX3Axb3
         SM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCI1h6XDepXvM9SY2yPFBOaTm7J4GLR1VLmmf1BO1BQ=;
        b=t6kDudtEznsH/lHYdAMKvyMVbufceRCvjSuUc30uZYiNotNyNS8TCOZJCDrFMMEsoQ
         y5UVIFZDgxY6nRgJhf1xSc4/SkgmBI9zBSfQuBcGDTPACdy0uqJz7Jt/cPkGgcTurabx
         XN9ILPJzAOUzF+2rpRdAhbL5XAMxzLzrFHtqXwD3qo/KjT77LMXKjLyeaoNks5gDFDgT
         3+zawyxJNgHGUiG5CrimXglAFiMVaCenDf3YOmCoynWWHjJsLJ++ECZzPhDpESXG6Bdp
         dctgeTpBYRCX92OHu9lMWNKaBN74R1/d1XUXNNOX2nJ9JYpGjBMKcuB0IjCrk/mPGQMI
         mCbg==
X-Gm-Message-State: APjAAAXm04d+VJL8D8HArsagtNs68N3OGHnmvzmUi1AUymljJLyrA4Yk
        mraEaxlYpqesh+M2C8CD4oY=
X-Google-Smtp-Source: APXvYqyZ42VI70e6J50zsTaVBDtxBfufPRxVENg+DF+2e5lxd6dM8CgG2DAIqrDLFaRgxCHGRfp6tQ==
X-Received: by 2002:a62:7681:: with SMTP id r123mr2516296pfc.169.1582864715674;
        Thu, 27 Feb 2020 20:38:35 -0800 (PST)
Received: from localhost.localdomain ([240e:379:962:6595:7b84:9990:1a82:371c])
        by smtp.gmail.com with ESMTPSA id 196sm9069047pfy.86.2020.02.27.20.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 20:38:35 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/4] spi: make spi-max-frequency optional
Date:   Fri, 28 Feb 2020 12:36:33 +0800
Message-Id: <20200228043636.559915-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228043636.559915-1-gch981213@gmail.com>
References: <20200228043636.559915-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We only need a spi-max-frequency when we specifically request a
spi frequency lower than the max speed of spi host.
This property is already documented as optional property and current
host drivers are implemented to operate at highest speed possible
when spi->max_speed_hz is 0.
This patch makes spi-max-frequency an optional property so that
we could just omit it to use max controller speed.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Change since v1:
 new commit

 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 38b4c78df506..c0c55dc79972 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1955,13 +1955,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_CS_HIGH;
 
 	/* Device speed */
-	rc = of_property_read_u32(nc, "spi-max-frequency", &value);
-	if (rc) {
-		dev_err(&ctlr->dev,
-			"%pOF has no valid 'spi-max-frequency' property (%d)\n", nc, rc);
-		return rc;
-	}
-	spi->max_speed_hz = value;
+	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
+		spi->max_speed_hz = value;
 
 	return 0;
 }
-- 
2.24.1

