Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8309A2F0F86
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 10:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbhAKJzl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 04:55:41 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:33284 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbhAKJzl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Jan 2021 04:55:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ULL6orQ_1610358890;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULL6orQ_1610358890)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Jan 2021 17:54:55 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     kdasu.kdev@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] spi: spi-bcm-qspi: style: Simplify bool comparison
Date:   Mon, 11 Jan 2021 17:54:48 +0800
Message-Id: <1610358888-88876-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix the following coccicheck warning:
./drivers/spi/spi-bcm-qspi.c:884:5-34:
WARNING: Comparison to bool

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci Robot<abaci@linux.alibaba.com>
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index c028446..d28d7bd 100644
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
@@ -892,7 +892,7 @@ static int bcm_qspi_bspi_exec_mem_op(struct spi_device *spi,
 	else
 		addr = from & 0x00ffffff;
 
-	if (bcm_qspi_bspi_ver_three(qspi) == true)
+	if (bcm_qspi_bspi_ver_three(qspi))
 		addr = (addr + 0xc00000) & 0xffffff;
 
 	/*
-- 
1.8.3.1

