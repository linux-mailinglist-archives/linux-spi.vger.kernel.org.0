Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9CE9ACD
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 12:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfJ3Lbn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 07:31:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:49596 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJ3Lbn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Oct 2019 07:31:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 04:31:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; 
   d="scan'208";a="190250642"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.55])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2019 04:31:41 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] spi: dw: Remove runtime PM enable/disable from common part of the driver
Date:   Wed, 30 Oct 2019 13:31:37 +0200
Message-Id: <20191030113137.15459-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Committed version of the commit b9fc2d207e54 ("spi: dw: Move runtime PM
enable/disable from common to platform driver part") does not include by
some reason changes to drivers/spi/spi-dw.c that were part of the original
patch sent to the mailing list.

Complete the code move by doing those changes now.

Fixes: b9fc2d207e54 ("spi: dw: Move runtime PM enable/disable from common to platform driver part")
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-dw.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 54ed6eb3e252..466f5c67843b 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
-#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 
@@ -499,8 +498,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	if (dws->set_cs)
 		master->set_cs = dws->set_cs;
 
-	pm_runtime_enable(dev);
-
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
 
@@ -529,7 +526,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	spi_enable_chip(dws, 0);
 	free_irq(dws->irq, master);
 err_free_master:
-	pm_runtime_disable(dev);
 	spi_controller_put(master);
 	return ret;
 }
@@ -544,9 +540,6 @@ void dw_spi_remove_host(struct dw_spi *dws)
 
 	spi_shutdown_chip(dws);
 
-	if (dws->master)
-		pm_runtime_disable(&dws->master->dev);
-
 	free_irq(dws->irq, dws->master);
 }
 EXPORT_SYMBOL_GPL(dw_spi_remove_host);
-- 
2.24.0.rc1

