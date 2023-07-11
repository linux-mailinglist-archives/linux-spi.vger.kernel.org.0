Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837CE74E9F6
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jul 2023 11:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGKJNz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jul 2023 05:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjGKJNx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jul 2023 05:13:53 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 02:13:49 PDT
Received: from smtpout2.mo529.mail-out.ovh.net (smtpout2.mo529.mail-out.ovh.net [79.137.123.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688F4122
        for <linux-spi@vger.kernel.org>; Tue, 11 Jul 2023 02:13:49 -0700 (PDT)
Received: from mxplan4.mail.ovh.net (unknown [10.109.156.206])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id D3C61209BE;
        Tue, 11 Jul 2023 09:06:19 +0000 (UTC)
Received: from vandamme.email (37.59.142.110) by DAG5EX2.mxp4.local
 (172.16.2.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 11:06:19 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-110S00441c1caea-27c1-4831-9bf8-8b99f5069e5e,
                    42C4D1DE23A36265E4C80AD40BF611DDAC8555CF) smtp.auth=kernel-org-500524@vandamme.email
X-OVh-ClientIp: 78.29.192.179
From:   Ruben Vandamme <kernel-org-500524@vandamme.email>
To:     <linux-spi@vger.kernel.org>
CC:     Ruben Vandamme <kernel-org-500524@vandamme.email>
Subject: [PATCH] spi: omap2-mcspi: fix memory leak on slave transfer abort
Date:   Tue, 11 Jul 2023 11:04:33 +0200
Message-ID: <20230711090546.654136-2-kernel-org-500524@vandamme.email>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG9EX1.mxp4.local (172.16.2.17) To DAG5EX2.mxp4.local
 (172.16.2.10)
X-Ovh-Tracer-GUID: 305f258d-3d32-48ea-98ce-85c5b70aa114
X-Ovh-Tracer-Id: 1984680063938802330
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfgtihesthekredtredttdenucfhrhhomheptfhusggvnhcugggrnhgurghmmhgvuceokhgvrhhnvghlqdhorhhgqdehtddthedvgeesvhgrnhgurghmmhgvrdgvmhgrihhlqeenucggtffrrghtthgvrhhnpeehvefggefhkeekvedutdeulefgvdeifeejgffgkeektdekudegieeltdehvdetvdenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddutddpjeekrddvledrudelvddrudejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehkvghrnhgvlhdqohhrghdqhedttdehvdegsehvrghnuggrmhhmvgdrvghmrghilheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpkhgvrhhnvghlqdhorhhgqdehtddthedvgeesvhgrnhgurghmmhgvrdgvmhgrihhlpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In case a slave mode transfer is aborted, the scatterlists need
to be freed before exiting the function.

Signed-off-by: Ruben Vandamme <kernel-org-500524@vandamme.email>
---
 drivers/spi/spi-omap2-mcspi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 8331e247bf5c..48800afc35b0 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -514,15 +514,16 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	omap2_mcspi_set_dma_req(spi, 1, 1);
 
 	ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_rx_completion);
+
+	for (x = 0; x < nb_sizes; x++)
+		kfree(sg_out[x]);
+
 	if (ret || mcspi->slave_aborted) {
 		dmaengine_terminate_sync(mcspi_dma->dma_rx);
 		omap2_mcspi_set_dma_req(spi, 1, 0);
 		return 0;
 	}
 
-	for (x = 0; x < nb_sizes; x++)
-		kfree(sg_out[x]);
-
 	if (mcspi->fifo_depth > 0)
 		return count;
 
-- 
2.41.0

