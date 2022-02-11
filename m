Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EE24B1D12
	for <lists+linux-spi@lfdr.de>; Fri, 11 Feb 2022 04:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiBKDtw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Feb 2022 22:49:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiBKDtw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Feb 2022 22:49:52 -0500
Received: from mail-m17664.qiye.163.com (mail-m17664.qiye.163.com [59.111.176.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2252755AF;
        Thu, 10 Feb 2022 19:49:52 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17664.qiye.163.com (Hmail) with ESMTPA id 526611401B5;
        Fri, 11 Feb 2022 11:49:50 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [RFC PATCH v1 6/6] spi: rockchip: clear interrupt status in error handler
Date:   Fri, 11 Feb 2022 11:49:38 +0800
Message-Id: <20220211034938.25097-7-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211034938.25097-1-jon.lin@rock-chips.com>
References: <20220211034938.25097-1-jon.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpJHU9WSE8dQxkaQk8aH0
        keVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxw6CQw5Qj5LFh5JCE9LDTAt
        DDwwCShVSlVKTU9PTk5KSEJLTEhDVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0pMNwY+
X-HM-Tid: 0a7ee6e6c51ada2fkuws526611401b5
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The interrupt status bit of the previous error data transmition will
affect the next operation and cause continuous SPI transmission failure.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 3d4e95eda4a6..bc547b79a2a1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -278,8 +278,9 @@ static void rockchip_spi_handle_err(struct spi_controller *ctlr,
 	 */
 	spi_enable_chip(rs, false);
 
-	/* make sure all interrupts are masked */
+	/* make sure all interrupts are masked and status cleared */
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
+	writel_relaxed(0xffffffff, rs->regs + ROCKCHIP_SPI_ICR);
 
 	if (atomic_read(&rs->state) & TXDMA)
 		dmaengine_terminate_async(ctlr->dma_tx);
-- 
2.17.1

