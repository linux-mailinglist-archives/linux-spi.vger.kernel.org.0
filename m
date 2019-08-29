Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58CCEA1A70
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2019 14:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfH2Muc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Aug 2019 08:50:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:18391 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfH2Muc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Aug 2019 08:50:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 05:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="332499872"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.61])
  by orsmga004.jf.intel.com with ESMTP; 29 Aug 2019 05:50:30 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: dw-pci: Add MODULE_DEVICE_TABLE
Date:   Thu, 29 Aug 2019 15:50:00 +0300
Message-Id: <20190829125000.26303-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

MODULE_DEVICE_TABLE is missing from the PCI part of the driver. Add it
so userspace can autoload the the driver when it is built as module.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-dw-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 4e3a4c317636..140644913e6c 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -138,6 +138,7 @@ static const struct pci_device_id pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x4b87), (kernel_ulong_t)&spi_pci_ehl_desc},
 	{},
 };
+MODULE_DEVICE_TABLE(pci, pci_ids);
 
 static struct pci_driver dw_spi_driver = {
 	.name =		DRIVER_NAME,
-- 
2.23.0.rc1

