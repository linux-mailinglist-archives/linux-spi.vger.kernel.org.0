Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF3A1C88FD
	for <lists+linux-spi@lfdr.de>; Thu,  7 May 2020 13:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEGLyz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 May 2020 07:54:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:16074 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgEGLyz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 May 2020 07:54:55 -0400
IronPort-SDR: NvJEts7Nwow8FllK3zVnRyoSF9f2QwVDosy45+aFteJ/C291zG4Cj5LEnBFdw3npTyOklzRGod
 lFvYQw9n4Fkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 04:54:54 -0700
IronPort-SDR: I22wjVu6ESLu2ZriRuLau1+PzO74TYb5DV8GinzVwMQPiftQJmnExq+RmnY8HVvxetPh50io2n
 mDcoup40NGBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="284970016"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2020 04:54:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B6EF3119; Thu,  7 May 2020 14:54:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: dw: Avoid useless assignments in generic DMA setup
Date:   Thu,  7 May 2020 14:54:48 +0300
Message-Id: <20200507115449.8093-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Generic DMA setup doesn't rely on certain type of DMA controller and thus
shouldn't use Intel Medfield settings, although it's harmless in this case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mid.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index f3c85f92ef12c..8b7b94c5a9ccf 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -321,8 +321,6 @@ static const struct dw_spi_dma_ops generic_dma_ops = {
 
 static void dw_spi_mid_setup_dma_generic(struct dw_spi *dws)
 {
-	dws->dma_tx = &mid_dma_tx;
-	dws->dma_rx = &mid_dma_rx;
 	dws->dma_ops = &generic_dma_ops;
 }
 #else	/* CONFIG_SPI_DW_MID_DMA */
-- 
2.26.2

