Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1864B4B4491
	for <lists+linux-spi@lfdr.de>; Mon, 14 Feb 2022 09:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbiBNIoO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Feb 2022 03:44:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbiBNIoN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Feb 2022 03:44:13 -0500
Received: from mail-m17664.qiye.163.com (mail-m17664.qiye.163.com [59.111.176.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839F34DF55;
        Mon, 14 Feb 2022 00:44:06 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17664.qiye.163.com (Hmail) with ESMTPA id 4636E140208;
        Mon, 14 Feb 2022 16:44:04 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v2 6/6] spi: rockchip: clear interrupt status in error handler
Date:   Mon, 14 Feb 2022 16:43:39 +0800
Message-Id: <20220214084339.18996-7-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214084339.18996-1-jon.lin@rock-chips.com>
References: <20220214084339.18996-1-jon.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMZTB9WHx1NTh0ZTB5IH0
        JIVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6Pww6Kz5LPBEhTjxIGQ1R
        Hi9PFApVSlVKTU9PQ0lDSU9OSkpLVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFJS05INwY+
X-HM-Tid: 0a7ef76739ddda2fkuws4636e140208
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
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

Changes in v2: None
Changes in v1: None

 drivers/spi/spi-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fd6a1f9de119..6751aafc382a 100644
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

