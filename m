Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594C5696597
	for <lists+linux-spi@lfdr.de>; Tue, 14 Feb 2023 15:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjBNOAD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Feb 2023 09:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjBNOAA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Feb 2023 09:00:00 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EACE9EF6
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 05:59:49 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E9G6Wc000327;
        Tue, 14 Feb 2023 05:59:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=sa4VM77kocmO6jDnHuvvbbASNWzkZSv/YJO4LvLW854=;
 b=Ps8zLA1R/JF9pVZwKnB1UTDE2c85pC46QuzsM9yl+LnPaRMG0EHcONRxpK5wGJEy4lC9
 OOI/HG5iuARS9Ib324FY4ZNP6hVYlSG1ccgA35zaxNTU048sS+USnqFnCD16okXUSRIv
 F8CoMxUOaVBUxRjjzndOWvUjHKB9wDjCcsZsDqejx6r6DXkw9Zb1ZnQAm/Kbf6/28iE8
 VHWol1SzlXLiwPV5UI63/eUIdurC4hUm3BFYlKn3UUSw5r9EQwlt1leZ1cBZ+KGh8Ur3
 hCojN+JxPgF5yo/SrmqxF8sMqrEtHkzTeks6KpLiQxeESbIPY/P3QPBKzRW1BprvkoP9 KQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nqanm364g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Feb 2023 05:59:41 -0800
Received: from devvm1736.cln0.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server id
 15.1.2507.17; Tue, 14 Feb 2023 05:59:38 -0800
From:   Vadim Fedorenko <vadfed@meta.com>
To:     Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
CC:     Vadim Fedorenko <vadfed@meta.com>, <linux-spi@vger.kernel.org>,
        "Vadim Fedorenko" <vadim.fedorenko@linux.dev>
Subject: [PATCH v2] spi: xilinx: add force_irq for QSPI mode
Date:   Tue, 14 Feb 2023 05:59:28 -0800
Message-ID: <20230214135928.1253205-1-vadfed@meta.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a8:1b::d]
X-Proofpoint-ORIG-GUID: JS_y1zvP_NG4HFM_fThV6NCrJ9ZjPhC1
X-Proofpoint-GUID: JS_y1zvP_NG4HFM_fThV6NCrJ9ZjPhC1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_07,2023-02-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Xilinx PG158 page 80 [1] states that master transaction inhibit bit must
be set to properly setup the transaction in QSPI mode. Add the force_irq
flag to follow this sequence.

[1] https://docs.xilinx.com/r/en-US/pg153-axi-quad-spi/Dual/Quad-SPI-Mode-Transactions

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

---
This is a follow up on the work started by Jonathan Lemon 2 years ago
and ended up nowhere.
https://lore.kernel.org/linux-spi/20210507215319.3882138-1-jonathan.lemon@gmail.com/
We still have an issue with our hardware and it would be great to fix it
in upstream driver. According to the out-of-tree driver supported by
Xilinx it's the only to work with QSPI:
https://github.com/Xilinx/linux-xlnx/blob/master/drivers/spi/spi-xilinx.c#L397
---
 drivers/spi/spi-xilinx.c       | 9 +++++++--
 include/linux/spi/xilinx_spi.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 7377d3b81302..1411548f4255 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -83,7 +83,7 @@ struct xilinx_spi {
 	void __iomem	*regs;	/* virt. address of the control registers */
 
 	int		irq;
-
+	bool force_irq;		/* force irq to setup master inhibit */
 	u8 *rx_ptr;		/* pointer in the Tx buffer */
 	const u8 *tx_ptr;	/* pointer in the Rx buffer */
 	u8 bytes_per_word;
@@ -248,7 +248,8 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	xspi->rx_ptr = t->rx_buf;
 	remaining_words = t->len / xspi->bytes_per_word;
 
-	if (xspi->irq >= 0 &&  remaining_words > xspi->buffer_size) {
+	if (xspi->irq >= 0 &&
+	    (xspi->force_irq || remaining_words > xspi->buffer_size)) {
 		u32 isr;
 		use_irq = true;
 		/* Inhibit irq to avoid spurious irqs on tx_empty*/
@@ -393,6 +394,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, num_cs = 0, bits_per_word;
 	struct spi_master *master;
+	bool force_irq = false;
 	u32 tmp;
 	u8 i;
 
@@ -400,6 +402,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	if (pdata) {
 		num_cs = pdata->num_chipselect;
 		bits_per_word = pdata->bits_per_word;
+		force_irq = pdata->force_irq;
 	} else {
 		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
 					  &num_cs);
@@ -477,6 +480,8 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 				dev_name(&pdev->dev), xspi);
 		if (ret)
 			return ret;
+
+		xspi->force_irq = force_irq;
 	}
 
 	/* SPI controller initializations */
diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
index c15d69d28e68..3934ce789d87 100644
--- a/include/linux/spi/xilinx_spi.h
+++ b/include/linux/spi/xilinx_spi.h
@@ -15,6 +15,7 @@ struct xspi_platform_data {
 	u8 bits_per_word;
 	struct spi_board_info *devices;
 	u8 num_devices;
+	bool force_irq;
 };
 
 #endif /* __LINUX_SPI_XILINX_SPI_H */
-- 
2.30.2

