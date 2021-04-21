Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A8E366D9D
	for <lists+linux-spi@lfdr.de>; Wed, 21 Apr 2021 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243275AbhDUOHd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Apr 2021 10:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243195AbhDUOHd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Apr 2021 10:07:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94D226144D;
        Wed, 21 Apr 2021 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619014020;
        bh=Skq855dn4Yk8ZwBtQx47eXayXzk9s74Sg6+dno+4Ebw=;
        h=From:To:Cc:Subject:Date:From;
        b=A2iwB8xHmmW52ko7lImxPer4TrHRy06TLUnEw5x6ZCLapRg+MKpq0k8GCJWPhrhqS
         Q9g5G+px+nMsU3Mpy2L3hSvfiZqVK/LQqW0CsG4O2eRavgFPxvCp1BNpWIhjgHKp+k
         qEBKaOGGWyecjdjYxkEgy/c81IJrYRxPqJGBkUz3JhrVFpVA+M7pSSTClzxmHwEBj3
         aQL/ka9VddIrzvTp10WI/PWuBStazHXfAvPxo7G5HrxA+PG2TplPQO2QJz8Q4q6uVH
         Hptw4ZIN/SWSF7PK4hTTxBuG4wDLUXT2/ljZeXu34PquS1z8ohCtcFeT3PNqHMoVM/
         N+G6bcwVfi/VQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: stm32-qspi: fix debug format string
Date:   Wed, 21 Apr 2021 16:06:48 +0200
Message-Id: <20210421140653.3964725-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Printing size_t needs a special %zd format modifier to avoid a
warning like:

drivers/spi/spi-stm32-qspi.c:481:41: note: format string is defined here
  481 |         dev_dbg(qspi->dev, "%s len = 0x%x offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);

Fixes: 18674dee3cd6 ("spi: stm32-qspi: Add dirmap support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-stm32-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index e2a99f054551..7e640ccc7e77 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -478,7 +478,7 @@ static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 * all needed transfer information into struct spi_mem_op
 	 */
 	memcpy(&op, &desc->info.op_tmpl, sizeof(struct spi_mem_op));
-	dev_dbg(qspi->dev, "%s len = 0x%x offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);
+	dev_dbg(qspi->dev, "%s len = 0x%zx offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);
 
 	op.data.nbytes = len;
 	op.addr.val = desc->info.offset + offs;
-- 
2.29.2

