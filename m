Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15505347181
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 07:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhCXGRL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 02:17:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14445 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbhCXGQ2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 02:16:28 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4yd042fxzkf6D;
        Wed, 24 Mar 2021 14:14:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 14:16:15 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH 06/11] spi: dln2: Fix open brace following function definitions go on the next line
Date:   Wed, 24 Mar 2021 14:16:37 +0800
Message-ID: <1616566602-13894-7-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
References: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix checkpatch error:

  ERROR: open brace '{' following function definitions go on the next line
  #545: FILE: spi-dln2.c:545:
  +static int dln2_spi_rdwr(struct dln2_spi *dln2, const u8 *tx_data,
  +			 u8 *rx_data, u16 data_len, u8 attr) {

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-dln2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 75b33d7..3902ead 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -543,7 +543,8 @@ static int dln2_spi_read_write_one(struct dln2_spi *dln2, const u8 *tx_data,
  * single ones due to device buffer constraints.
  */
 static int dln2_spi_rdwr(struct dln2_spi *dln2, const u8 *tx_data,
-			 u8 *rx_data, u16 data_len, u8 attr) {
+			 u8 *rx_data, u16 data_len, u8 attr)
+{
 	int ret;
 	u16 len;
 	u8 temp_attr;
-- 
2.7.4

