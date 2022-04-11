Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78764FBAC4
	for <lists+linux-spi@lfdr.de>; Mon, 11 Apr 2022 13:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiDKLXc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Apr 2022 07:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiDKLXb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Apr 2022 07:23:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B20542A02
        for <linux-spi@vger.kernel.org>; Mon, 11 Apr 2022 04:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649676078; x=1681212078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lXWE8/D3F7ICFpIEi+G5SWmrHUk92l6DxqATEA/aqZ8=;
  b=U1A1kc3LxQMNyzrpytBo0qDdkmvgnHgQasBtVzv+3gXSCXP0gVLW9WDh
   uZAdVwsMXhD89ZPYERbOcaHtg80ftTUfZD0uktdA0HmYbcgsv49NcAS94
   nKxNUTRKqY+1wYu9EaWDX3b0qeWTStiz9U9dY9tZaNk3RFJg5GC4749/s
   rBg9MXAK/6mSOJIfcTGoW1JGeSB03J0g1PxG3xmN0uKal2ABULtv7ZC3e
   X1mAvgUi6kzlnfK5BAwhFOjhAPsvIWOnQjU/aWs/b8q9DxlsOnkc1shIN
   6KHasG+S4dHfmv+gx8zC6+Ajbf+kr9ZTJ4OlmFaHFkn7COX2qPJViIsLt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="260938045"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="260938045"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="654583265"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 11 Apr 2022 04:21:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 60C1A18E; Mon, 11 Apr 2022 14:21:16 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: intel: Add support for Raptor Lake-S SPI serial flash
Date:   Mon, 11 Apr 2022 14:21:16 +0300
Message-Id: <20220411112116.53281-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Intel Raptor Lake-S has the same SPI serial flash controller as Alder
Lake-P. Add Raptor Lake-S PCI ID to the driver list of supported
devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index a5ef7a526a7f..f6eec7a869b6 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -72,6 +72,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x4da4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x51a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x54a4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa0a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0xa1a4), (unsigned long)&bxt_info },
-- 
2.35.1

