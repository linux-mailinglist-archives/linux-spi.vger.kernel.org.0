Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FCA755ED6
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jul 2023 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGQI7z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jul 2023 04:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGQI7x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jul 2023 04:59:53 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7C2E58
        for <linux-spi@vger.kernel.org>; Mon, 17 Jul 2023 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689584391; x=1721120391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pe+J8Ph/L1AS+x+SkGE3jMZdvxTA0GLnex7gb2D1+Xc=;
  b=EIBPagrKj66sKkgdyt2IbrUz2LZUBXFCS3Xjv15RkpzIwOxn//2qfJOF
   X43OAVx8ymqKq/fCMRu0sKCkiSO62Nzoa5Occ+SrFS/hQYo+MEgA0qb/C
   0mhUL5AkRuWofu5KqOV+0/YqZp89ZenLpmmqH0DyyHU85n8xYGXmBvXfo
   myDUQFm0B9nJ0yl0IH10b5JrhlWXQydobx6aVGj/FQQuTmRO55eNQ3Qjc
   WCU+v4RDCeQ8v5Nupxaz7fV6rAFJWw87w9X1btlXZf2lhg8VbdJzPgdXx
   eZkeSYdrbajEbG483C41pALKBbLr592RHIR1U7Dbk9n9MzfGsu9uKWBwJ
   g==;
X-IronPort-AV: E=Sophos;i="6.01,211,1684792800"; 
   d="scan'208";a="31958425"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Jul 2023 10:59:47 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 37BEE280085;
        Mon, 17 Jul 2023 10:59:47 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH v2 3/3] spi: spi-fsl-lpspi: Read chip-select amount from hardware for i.MX93
Date:   Mon, 17 Jul 2023 10:59:34 +0200
Message-Id: <20230717085934.409476-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717085934.409476-1-alexander.stein@ew.tq-group.com>
References: <20230717085934.409476-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
* Rebase to next-20230717 (no change on the diff though)

 drivers/spi/spi-fsl-lpspi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index f3b7bb1e52eb..e32e8cab5aa8 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -896,8 +896,12 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
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

