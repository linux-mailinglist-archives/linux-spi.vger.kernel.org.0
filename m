Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A30917B8A7
	for <lists+linux-spi@lfdr.de>; Fri,  6 Mar 2020 09:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgCFIvu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Mar 2020 03:51:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46603 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgCFIvu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Mar 2020 03:51:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id o24so773178pfp.13;
        Fri, 06 Mar 2020 00:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1MJfeELIuC6LsKgfyfQqa0z3Waht5G7PSNrYy3Wi+08=;
        b=msCi53q/ygvF5LxsC0mewd4cbGjJiaaBtvneNNCWDGd/w0WAoNfXuxHc6Lk5GHdaFS
         a1Ns/9mJlE5THiwNGi2R39qyvu2zYxQM7zinWhETTsZT+/7NceUy7RmhQ21ViWyf0yzu
         Y94sPYIzEdkQxDie5d9dBtaRnQHxmU2QoZmxBfht/O+w1Q0v2Xqneeb768RMigZvKnrG
         CcBWckHero/W8loNJJDYI/sf1SpsjucE2WeHJiNartnlcrUuoQZ0LPU8Cp1FY73JvXsL
         xBKGh3fHhtsRchNreq5rPydEcRRojCIuoEkgATinxKkygPaIokRVHb/p99SWM0dTVeux
         F9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1MJfeELIuC6LsKgfyfQqa0z3Waht5G7PSNrYy3Wi+08=;
        b=onILw0FQMkgPlYaDIfQrEwr40Lt5mH1W2k/YQU+LltKQCuAGlii2K29m1K2GQRMZkA
         CMrIJl76U8DfZRIT25w8fjXQWlo1IrgOCQJhlEu6CuhTJ7soK+iTL9Yui66qu2MJ14/R
         msS8H+bVvekqJm+opFxvsTnUKPFyIT8wnH5R33VQRjuxzXWESdmT+bUtILdCQ0rZiws8
         viFzPS+pkS2dTsW/LAAPO0YDT4WySBE67lEbfCvz0vzs+zMuowJtLuk9tRl6JVyj7iB7
         MWPvE3J9WWNPeboyw9LqEBwtGJKkmcTP/OdUBqUE4qcZeYmJsLTJE3Kclk9ay5Qq7Zuq
         jHoQ==
X-Gm-Message-State: ANhLgQ29aumnMcQZ3nPG8zVzrAg8J/ntfsopkakkUwcrGgfEbNF2eSJF
        KaWzt3F2ihXrkkB0uj/T4qk=
X-Google-Smtp-Source: ADFU+vvZtzx9vJU2zlECVhWq1gy1fL6yFa1ebwPi96Uawcx+c3SfXqdhvrpCHJ8ubSGB0rbU3cqkfg==
X-Received: by 2002:a63:1245:: with SMTP id 5mr2267008pgs.55.1583484709301;
        Fri, 06 Mar 2020 00:51:49 -0800 (PST)
Received: from guoguo-omen.lan ([240e:379:94a:b53:8200:7767:6b7e:4da3])
        by smtp.gmail.com with ESMTPSA id s23sm8527334pjp.28.2020.03.06.00.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 00:51:48 -0800 (PST)
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
Subject: [PATCH v3 1/4] spi: make spi-max-frequency optional
Date:   Fri,  6 Mar 2020 16:50:49 +0800
Message-Id: <20200306085052.28258-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200306085052.28258-1-gch981213@gmail.com>
References: <20200306085052.28258-1-gch981213@gmail.com>
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
Change since v2:
 none

Change since v1:
 new patch

 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 22baf204a09d..e317fb30329f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1951,13 +1951,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
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

