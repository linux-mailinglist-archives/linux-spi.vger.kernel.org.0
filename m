Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4666BDAE
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jan 2023 13:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjAPMTE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Jan 2023 07:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjAPMS1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Jan 2023 07:18:27 -0500
X-Greylist: delayed 1598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Jan 2023 04:18:16 PST
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EA1F5F8
        for <linux-spi@vger.kernel.org>; Mon, 16 Jan 2023 04:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=kicherer.org; h=from:to
        :cc:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=k1; bh=ognniQE9ChrjBODibrrVAnhbmGc
        jV0oPAHmXkBNCQTQ=; b=Gg5Pfzown8A5ukGdmagKctY4tYz9ALSuFaxuKmPtTyi
        Ud9xoBNPNqTWqsGF+Q0NLbu5E69wfxj+W+kF06EPLmgjusSzT4hGG0mqQgyQqn+C
        OfnKABh81TG5qOG4aw+MwQxCgjwuGgXp/t0E4vXhEHI8hzSIT19UCmAIPgyyZk50
        =
Received: (qmail 669739 invoked from network); 16 Jan 2023 12:51:34 +0100
Received: by mail.zeus06.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Jan 2023 12:51:34 +0100
X-UD-Smtp-Session: l3s6476p2@KVj+M2Dy0crCtAHJ
From:   Mario Kicherer <dev@kicherer.org>
To:     linux-spi@vger.kernel.org
Cc:     han.xu@nxp.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Mario Kicherer <dev@kicherer.org>
Subject: [PATCH 2/2] spi: spi-fsl-qspi: support setting sampling delay through devicetree
Date:   Mon, 16 Jan 2023 12:50:50 +0100
Message-Id: <20230116115050.2983406-3-dev@kicherer.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116115050.2983406-1-dev@kicherer.org>
References: <20230116115050.2983406-1-dev@kicherer.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The internal sampling point of incoming data can be delayed by modifying
the QuadSPI_SMPR register. This patch enables setting this delay using a
device tree entry.

Signed-off-by: Mario Kicherer <dev@kicherer.org>
---
 drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 85cc71ba624a..10faaf57db28 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -722,6 +722,7 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
 	u32 reg, addr_offset = 0;
+	u8 sampling_delay;
 	int ret;
 
 	/* disable and unprepare clock to avoid glitch pass to controller */
@@ -756,10 +757,22 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 			    base + QUADSPI_FLSHCR);
 
 	reg = qspi_readl(q, base + QUADSPI_SMPR);
-	qspi_writel(q, reg & ~(QUADSPI_SMPR_FSDLY_MASK
-			| QUADSPI_SMPR_FSPHS_MASK
-			| QUADSPI_SMPR_HSENA_MASK
-			| QUADSPI_SMPR_DDRSMP_MASK), base + QUADSPI_SMPR);
+	reg = reg & ~(QUADSPI_SMPR_FSDLY_MASK
+		      | QUADSPI_SMPR_FSPHS_MASK
+		      | QUADSPI_SMPR_HSENA_MASK
+		      | QUADSPI_SMPR_DDRSMP_MASK);
+	ret = of_property_read_u8(q->dev->of_node,
+				   "fsl,qspi-sampling-delay",
+				   &sampling_delay);
+	if (!ret) {
+		if (sampling_delay <= 3)
+			reg = reg | (sampling_delay << 5);
+		else
+			dev_err(q->dev,
+				"fsl,qspi-sampling_delay %u greater than 3\n",
+				sampling_delay);
+	}
+	qspi_writel(q, reg, base + QUADSPI_SMPR);
 
 	/* We only use the buffer3 for AHB read */
 	qspi_writel(q, 0, base + QUADSPI_BUF0IND);
-- 
2.34.1

