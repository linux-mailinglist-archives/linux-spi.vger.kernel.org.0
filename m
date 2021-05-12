Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A64437B3B7
	for <lists+linux-spi@lfdr.de>; Wed, 12 May 2021 03:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhELB42 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 21:56:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2708 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELB41 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 May 2021 21:56:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfyTz2pz0z1BKDj;
        Wed, 12 May 2021 09:52:39 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 09:55:10 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] spi: omap-100k: remove set but not used variable
Date:   Wed, 12 May 2021 09:55:12 +0800
Message-ID: <1620784512-46828-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The assignment to status on lines 296 and 315 is meaningless and will
rewriten, so just delete.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/spi/spi-omap-100k.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 7062f29..dc9b86b 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -296,7 +296,6 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
-			status = -EINVAL;
 			break;
 		}
 		status = omap1_spi100k_setup_transfer(spi, t);
@@ -315,7 +314,6 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 			m->actual_length += count;
 
 			if (count != t->len) {
-				status = -EIO;
 				break;
 			}
 		}
-- 
2.7.4

