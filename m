Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D83B2CED
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jun 2021 12:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhFXKyW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Jun 2021 06:54:22 -0400
Received: from m12-17.163.com ([220.181.12.17]:53635 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhFXKyW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Jun 2021 06:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pTZr7
        M934qJGS/p1VktboAnozAKaukgQzPAAMTI6ZEU=; b=UOUztijBMBM3Zq1mnCao5
        dW7/IisIuq7M2swceN4Rnbf5nery55FgRvjlpHerkwB+rQwFAG3jIcBIVYaOWKy/
        3piYjSZLqVX6BvycqPIoa+wqSTJGpg/H2uZRxJgfY7W+goGLoSMzAKUfsS14qgf0
        6BCMA8JuXxwo9UIB71T55c=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowAC31ZXNY9RgiGNQ9Q--.32474S2;
        Thu, 24 Jun 2021 18:51:58 +0800 (CST)
From:   lijian_8010a29@163.com
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] spi: spi-topcliff-pch: Fixed the possible null pointer exception issue
Date:   Thu, 24 Jun 2021 18:50:56 +0800
Message-Id: <20210624105056.167233-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAC31ZXNY9RgiGNQ9Q--.32474S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1xtw4UWry8Ar1fCryrtFb_yoW8GF1xpF
        WDGa1qyrWrAF4kJFnrXFWUuFn8W3s7WryUu342kwnIvr18tryDtF4Utr97trWayF4IqF4a
        yr4IvryYq3ZYyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bYL05UUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbi3w67UGB0GoFjRAAAsS
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: lijian <lijian@yulong.com>

The 'data->pkt_tx_buff' is used after called
‘kfree(data->pkt_tx_buff)’,it may be null when it is called,
and null pointer exception may occur,
so judgment is added when using 'data->pkt_tx_buff'.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/spi/spi-topcliff-pch.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index b8870784fc6e..a5ac59f2eb80 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -599,7 +599,7 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 	}
 
 	/* copy Tx Data */
-	if (data->cur_trans->tx_buf != NULL) {
+	if ((data->cur_trans->tx_buf != NULL) && (data->pkt_tx_buff != NULL)) {
 		if (*bpw == 8) {
 			tx_buf = data->cur_trans->tx_buf;
 			for (j = 0; j < data->bpw_len; j++)
@@ -621,8 +621,10 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 		__func__);
 	pch_spi_writereg(data->master, PCH_SSNXCR, SSN_LOW);
 
-	for (j = 0; j < n_writes; j++)
-		pch_spi_writereg(data->master, PCH_SPDWR, data->pkt_tx_buff[j]);
+	if (data->pkt_tx_buff != NULL) {
+		for (j = 0; j < n_writes; j++)
+			pch_spi_writereg(data->master, PCH_SPDWR, data->pkt_tx_buff[j]);
+	}
 
 	/* update tx_index */
 	data->tx_index = j;
-- 
2.25.1


