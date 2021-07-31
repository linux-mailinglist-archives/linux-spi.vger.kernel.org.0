Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79F83DC623
	for <lists+linux-spi@lfdr.de>; Sat, 31 Jul 2021 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbhGaNoD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 31 Jul 2021 09:44:03 -0400
Received: from smtpbg587.qq.com ([113.96.223.105]:34733 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233245AbhGaNoC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 31 Jul 2021 09:44:02 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jul 2021 09:44:01 EDT
X-QQ-mid: bizesmtp49t1627738435t7gjx5lx
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 31 Jul 2021 21:33:53 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: D8iNkgpwlC9/P5c86WSBo4ku6rZX3Hujv5a2hHGeSDSWWjAiUfkaiFqyRQObe
        TraInq9qoOdytNauy/y1hC/dyvh9tBaRa4iLvx9IMVWFEa82s54QR2XlowU6b7ol0GcHyar
        eJhiN4XYYfmgI1yZRnq07FIKrSpZG/7c4Ex2hL6jy5BeGtxFGH+tao4MMAd84NS6r4/9gxg
        cEH3apgP/Q/Yg56v2PGGEQ7bftHaUpojUhzvWbw+Ghvj/Pj4q3FwVkSzGCg/nY0LT/eua1h
        pMJhTh7aR+gbEtRmcSvuTaTYKbvpAgCjbRUYZsGxZnx3FplXt/uH1X71g6wg3/BIWPBI/LF
        nevs5C86mRrHxTECuC6zp768I/t4w==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     nsaenz@kernel.org
Cc:     broonie@kernel.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] spi: bcm2835aux: use 'unsigned int' instead of 'unsigned'
Date:   Sat, 31 Jul 2021 21:33:42 +0800
Message-Id: <20210731133342.432575-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/spi/spi-bcm2835aux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 37eab100a7d8..7d709a8c833b 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -143,12 +143,12 @@ static void bcm2835aux_debugfs_remove(struct bcm2835aux_spi *bs)
 }
 #endif /* CONFIG_DEBUG_FS */
 
-static inline u32 bcm2835aux_rd(struct bcm2835aux_spi *bs, unsigned reg)
+static inline u32 bcm2835aux_rd(struct bcm2835aux_spi *bs, unsigned int reg)
 {
 	return readl(bs->regs + reg);
 }
 
-static inline void bcm2835aux_wr(struct bcm2835aux_spi *bs, unsigned reg,
+static inline void bcm2835aux_wr(struct bcm2835aux_spi *bs, unsigned int reg,
 				 u32 val)
 {
 	writel(val, bs->regs + reg);
-- 
2.32.0

