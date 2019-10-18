Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE9DC5E5
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 15:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393278AbfJRNVm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 09:21:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:64737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbfJRNVm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 18 Oct 2019 09:21:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 06:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,311,1566889200"; 
   d="scan'208";a="186825711"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.66])
  by orsmga007.jf.intel.com with ESMTP; 18 Oct 2019 06:21:40 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 3/3] spi: dw-pci: Fix Chip Select amount on Intel Elkhart Lake PSE SPI
Date:   Fri, 18 Oct 2019 16:21:31 +0300
Message-Id: <20191018132131.31608-3-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018132131.31608-1-jarkko.nikula@linux.intel.com>
References: <20191018132131.31608-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Intel(R) Programmable Services Engine (Intel(R) PSE) SPI controllers in
Intel Elkhart Lake have two Chip Select signals instead of one.

Reported-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-dw-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 1cddecea2715..12c131b5fb4e 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -36,7 +36,7 @@ static struct spi_pci_desc spi_pci_mid_desc_2 = {
 };
 
 static struct spi_pci_desc spi_pci_ehl_desc = {
-	.num_cs = 1,
+	.num_cs = 2,
 	.bus_num = -1,
 	.max_freq = 100000000,
 };
-- 
2.23.0

