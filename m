Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C97748057
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 11:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGEJC2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 05:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjGEJCX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 05:02:23 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B271727
        for <linux-spi@vger.kernel.org>; Wed,  5 Jul 2023 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1688547722; x=1720083722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CCiU6JSUONVV+wche7PFnEEtldA36zBzDsC0Qvocb2Q=;
  b=LaNdklw0QFYY1vnmX2a7WhvzsO5T58t20TX46F1xT0pSEhEZXNJO4u3d
   5qdQU9nEhrLUYIwccvKqNdn1WBAvBugjfcGXS5c/+YnPVUvlqxRB+gpdU
   lnvJ8LCs4jdoBUyQU5dIu4vtgHlL/JLft4+pP3gvUPB7NBp3hSjSdyhSd
   wAI60jr388JA8Cr+m/wYO4wWylcScDe69XwDbq4zR1Qymiqu4c9OrMl44
   L6AJc2BWOW1ezVTSur8d3cv03X9eN/qFtTW+hSkmE3ZucJC0vCFQp7xe4
   /3Q9Fc8dD9vxnqT6X5MSzOKQQiNdJXatHPXNTKxMKfXIE+TDRyNEFapWI
   A==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684792800"; 
   d="scan'208";a="31764885"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Jul 2023 11:01:53 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 64E6028008A;
        Wed,  5 Jul 2023 11:01:53 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 3/3] spi: spi-fsl-lpspi: Read chip-select amount from hardware for i.MX93
Date:   Wed,  5 Jul 2023 11:01:45 +0200
Message-Id: <20230705090145.1354663-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705090145.1354663-1-alexander.stein@ew.tq-group.com>
References: <20230705090145.1354663-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

PARAM.PCSNUM register on i.MX93 indicates the number of supported
(hw) chip-selects. LPSPI4 has 3 while others have only 2.
Still allow overwriting from DT.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
I've checked i.MX7ULP and i.MX8QM reference manuals and only i.MX93 has
these PCSNUM bits defined in PARAM register.

 drivers/spi/spi-fsl-lpspi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 4b4d25e13ca4..540495dc4bc9 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -897,8 +897,12 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->txfifosize = 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
 	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
-				 &num_cs))
-		num_cs = 1;
+				 &num_cs)) {
+		if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx93-spi"))
+			num_cs = ((temp >> 16) & 0xf);
+		else
+			num_cs = 1;
+	}
 
 	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
 	controller->transfer_one = fsl_lpspi_transfer_one;
-- 
2.34.1

