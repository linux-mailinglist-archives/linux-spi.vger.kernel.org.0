Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5D642C3D2
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhJMOsM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 10:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230474AbhJMOsI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 10:48:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1F0A61130;
        Wed, 13 Oct 2021 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634136365;
        bh=tnlyNPeaKQA137YlG0dTcTaPG0qN1bE9aYRHS7ILETY=;
        h=From:To:Cc:Subject:Date:From;
        b=eBF4cmnyJiOpA2Mo7Mqim5VBvj/Lp3x+c6/woJNklp1KH57CAKIoNC6MEMyf5ZPx/
         1B0iNyRb1HUg/1JI63jkZGkn/HVGYxddNyMh5y/m7lNNcG0hGQkSEc3v6osLuIb8QM
         cXpp8yIdKT5CV0Cl8hoUA6SFDcx46bDEphJJffkfEwsrFUCtK3d+Beftkc2WdE3GQK
         3vTuDD5ZM4U17ZHMzpnmIXENc7FPMszrHd1w9irJGsxjTKqH/L1sxFcFhrp7Yw9iOa
         8jPseGf2f+EI5VcX/CCXZg0I81ZK7fz+J5MYAgjYHF7CzYXrwM2DNMrJ0h4a0/jFen
         SRc/hBN0KCH4A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Pratyush Yadav <p.yadav@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Apurva Nandan <a-nandan@ti.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: cadence-quadspi: fix dma_unmap_single() call
Date:   Wed, 13 Oct 2021 16:45:55 +0200
Message-Id: <20211013144600.2378037-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are separate constants for the dma-mapping API and the dmaengine
API, mixing them up causes a warning in some builds:

In file included from drivers/spi/spi-cadence-quadspi.c:12:
drivers/spi/spi-cadence-quadspi.c: In function 'cqspi_versal_indirect_read_dma':
drivers/spi/spi-cadence-quadspi.c:950:55: error: implicit conversion from 'enum dma_transfer_direction' to 'enum dma_data_direction' [-Werror=enum-conversion]
  950 |         dma_unmap_single(dev, dma_addr, bytes_to_dma, DMA_DEV_TO_MEM);
      |                                                       ^~~~~~~~~~~~~~
include/linux/dma-mapping.h:407:70: note: in definition of macro 'dma_unmap_single'
  407 | #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
      |                                                                      ^

Fixes: 1a6f854f7daa ("spi: cadence-quadspi: Add Xilinx Versal external DMA support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5bdb1bae5c99..8b3d268ac63c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -947,7 +947,7 @@ static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
 	       reg_base + CQSPI_REG_INDIRECTRD);
 
-	dma_unmap_single(dev, dma_addr, bytes_to_dma, DMA_DEV_TO_MEM);
+	dma_unmap_single(dev, dma_addr, bytes_to_dma, DMA_FROM_DEVICE);
 
 	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
 	reg &= ~CQSPI_REG_CONFIG_DMA_MASK;
-- 
2.29.2

