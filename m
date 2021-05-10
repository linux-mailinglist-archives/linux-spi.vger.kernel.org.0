Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF99377CA5
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 08:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhEJG7j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 02:59:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2610 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhEJG7j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 02:59:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FdsKK5zM0zmVTS;
        Mon, 10 May 2021 14:56:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 14:58:24 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>
Subject: [PATCH 2/4] spi: omap-100k: Clean the value of 'status' is not used
Date:   Mon, 10 May 2021 14:58:21 +0800
Message-ID: <1620629903-15493-3-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620629903-15493-1-git-send-email-f.fangjian@huawei.com>
References: <1620629903-15493-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

An error code is set to 'status' before exiting list_for_each_entry()
loop, but the value of 'status' is not used as below:

  list_for_each_entry(t, &m->transfers, transfer_list) {
  	if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
  		status = -EINVAL;
  		break;
  	}
  	...
  }

  status = omap1_spi100k_setup_transfer(spi, NULL);

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
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

