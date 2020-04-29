Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82821BD1B1
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 03:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgD2BXU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 21:23:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41944 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbgD2BXT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Apr 2020 21:23:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A574EFFD5E8D30C82F5C;
        Wed, 29 Apr 2020 09:23:17 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 09:23:08 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <sanju.mehta@amd.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] spi: spi-amd: remove unused variable 'opcode'
Date:   Wed, 29 Apr 2020 09:30:18 +0800
Message-ID: <20200429013018.34046-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes gcc '-Wunused-variable' warning:

drivers/spi/spi-amd.c:171:17: warning: unused variable ‘opcode’ [-Wunused-variable]

It is introduced by commit bbb336f39efc ("spi: spi-amd:
Add AMD SPI controller driver support"), but never used,
so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 0d9debe1386e..c5a16dd44fa3 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -168,7 +168,7 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 {
 	struct spi_master *master = amd_spi->master;
 	struct spi_transfer *xfer = NULL;
-	u8 cmd_opcode, opcode = 0;
+	u8 cmd_opcode;
 	u8 *buf = NULL;
 	u32 m_cmd = 0;
 	u32 i = 0;
--
2.26.0.106.g9fadedd

