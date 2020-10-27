Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867C029A88C
	for <lists+linux-spi@lfdr.de>; Tue, 27 Oct 2020 11:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896557AbgJ0J63 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Oct 2020 05:58:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40329 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896554AbgJ0J5b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Oct 2020 05:57:31 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kXLjK-0004UL-D8; Tue, 27 Oct 2020 10:57:26 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kXLjJ-0004ry-Pr; Tue, 27 Oct 2020 10:57:25 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH v2 1/2] spi: introduce SPI_MODE_X_MASK macro
Date:   Tue, 27 Oct 2020 10:57:23 +0100
Message-Id: <20201027095724.18654-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027095724.18654-1-o.rempel@pengutronix.de>
References: <20201027095724.18654-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Provide a macro to filter all SPI_MODE_0,1,2,3 mode in one run.

The latest SPI framework will parse the devicetree in following call
sequence: of_register_spi_device() -> of_spi_parse_dt()
So, driver do not need to pars the devicetree and will get prepared
flags in the probe.

On one hand it is good far most drivers. On other hand some drivers need to
filter flags provide by SPI framework and apply know to work flags. This drivers
may use SPI_MODE_X_MASK to filter MODE flags and set own, known flags:
  spi->flags &= ~SPI_MODE_X_MASK;
  spi->flags |= SPI_MODE_0;

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/spi/spi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 99380c0825db..8097f27702f3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -171,6 +171,7 @@ struct spi_device {
 #define	SPI_MODE_1	(0|SPI_CPHA)
 #define	SPI_MODE_2	(SPI_CPOL|0)
 #define	SPI_MODE_3	(SPI_CPOL|SPI_CPHA)
+#define	SPI_MODE_X_MASK	(SPI_CPOL|SPI_CPHA)
 #define	SPI_CS_HIGH	0x04			/* chipselect active high? */
 #define	SPI_LSB_FIRST	0x08			/* per-word bits-on-wire */
 #define	SPI_3WIRE	0x10			/* SI/SO signals shared */
-- 
2.28.0

