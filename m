Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C2A2F0F0E
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 10:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbhAKJ12 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 04:27:28 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:59684 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727819AbhAKJ12 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Jan 2021 04:27:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ULMRcOQ_1610357190;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULMRcOQ_1610357190)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Jan 2021 17:26:36 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     kdasu.kdev@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] spi: spi-bcm-qspi: style: Simplify bool comparison
Date:   Mon, 11 Jan 2021 17:26:29 +0800
Message-Id: <1610357189-60031-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix the following coccicheck warning:
./drivers/spi/spi-bcm-qspi.c:884:5-34: WARNING: Comparison to bool

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci Robot<abaci@linux.alibaba.com>
---
 drivers/spi/spi-bcm-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index c028446..707fe3a 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -881,7 +881,7 @@ static int bcm_qspi_bspi_exec_mem_op(struct spi_device *spi,
 	 * when using flex mode we need to send
 	 * the upper address byte to bspi
 	 */
-	if (bcm_qspi_bspi_ver_three(qspi) == false) {
+	if (!bcm_qspi_bspi_ver_three(qspi)) {
 		addr = from & 0xff000000;
 		bcm_qspi_write(qspi, BSPI,
 			       BSPI_BSPI_FLASH_UPPER_ADDR_BYTE, addr);
-- 
1.8.3.1

