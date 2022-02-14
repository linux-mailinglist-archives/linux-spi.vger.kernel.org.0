Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84B24B4488
	for <lists+linux-spi@lfdr.de>; Mon, 14 Feb 2022 09:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiBNIoF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Feb 2022 03:44:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiBNIoE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Feb 2022 03:44:04 -0500
Received: from mail-m17664.qiye.163.com (mail-m17664.qiye.163.com [59.111.176.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CE94DF55;
        Mon, 14 Feb 2022 00:43:57 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17664.qiye.163.com (Hmail) with ESMTPA id D0EBA14032D;
        Mon, 14 Feb 2022 16:43:55 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v2 0/6] New support and problem adjustment of SPI rockchip
Date:   Mon, 14 Feb 2022 16:43:33 +0800
Message-Id: <20220214084339.18996-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlJTUhWSkxJGR1NHRhDH0
        wYVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgg6SDo*Iz5LMBEITj4yGR9L
        KBIwFEhVSlVKTU9PQ0lDSUhNSE9CVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFKTUxDNwY+
X-HM-Tid: 0a7ef76718f2da2fkuwsd0eba14032d
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Changes in v2:
- Fix patches should be at the start of the series
- Fix patches should be at the start of the series
- Delete useless messages
- Limit cs-high presetting to the chip select n <= 1

Changes in v1:
- The origin patch

Jon Lin (5):
  spi: rockchip: Fix error in getting num-cs property
  spi: rockchip: terminate dma transmission when slave abort
  spi: rockchip: Stop spi slave dma receiver when cs inactive
  spi: rockchip: Preset cs-high and clk polarity in setup progress
  spi: rockchip: clear interrupt status in error handler

shengfei Xu (1):
  spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM
    ops

 drivers/spi/spi-rockchip.c | 132 ++++++++++++++++++++++++++++++++-----
 1 file changed, 115 insertions(+), 17 deletions(-)

-- 
2.17.1

