Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7CF06C5
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2019 21:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKEUUX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Nov 2019 15:20:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:64357 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfKEUUX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 Nov 2019 15:20:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 12:20:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="376815162"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2019 12:20:18 -0800
From:   thor.thayer@linux.intel.com
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH] spi: dw: Fix Designware SPI loopback
Date:   Tue,  5 Nov 2019 14:22:10 -0600
Message-Id: <1572985330-5525-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The SPI_LOOP is set in spi->mode but not propagated to the register.
A previous patch removed the bit during a cleanup.

Fixes: e1bc204894ea ("spi: dw: fix potential variable assignment error")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 9a49e073e8b7..076652d3d051 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -308,7 +308,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
 		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
-			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET))
+			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET) |
+			(((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET))
 		| (chip->tmode << SPI_TMOD_OFFSET);
 
 	/*
-- 
2.7.4

