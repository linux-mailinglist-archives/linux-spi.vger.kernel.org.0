Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B1D4B83C2
	for <lists+linux-spi@lfdr.de>; Wed, 16 Feb 2022 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiBPJNh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Feb 2022 04:13:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiBPJNg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Feb 2022 04:13:36 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B394566ADE
        for <linux-spi@vger.kernel.org>; Wed, 16 Feb 2022 01:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645002804; x=1676538804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pW0qQVt5TP9RngYyt0C+NfE+pegPRZwRnJsd+gpsPq4=;
  b=UPtmtgAeYzSu2sotUF/BbMIivZnz//1HA7T49063aTQ6njyNTwx/pKN1
   dWyrcqBAlZ/HNSPolCsUnDzwr88cw1njRt8xb8zD0oorJ16+EFS8UjbeG
   fjyA1Bx+/UmOpETouuFubxxPwsBHuWNltH3/osykVr71w2ALZsCzhHz07
   Mr6dSH2JMlit4K3qHuGG9mpXxRajQ67F0J+iYVTBqv8I3R6jNvXoWftHa
   fZTSLonlrChpeW+jUmmwFJVlUUx6tBarDRMss1iO9vhbr6kiEpTZVP3TX
   cOPHbNAR+0UWvsIetDa0knZRkuheL0+9YQQLkpmOIOZFfyKNh0i/XesWJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250296783"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="250296783"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 01:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="773944992"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.51])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2022 01:13:22 -0800
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Raptor Lake PCH-S
Date:   Wed, 16 Feb 2022 11:13:17 +0200
Message-Id: <20220216091317.1302254-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for LPSS SPI on Intel Raptor Lake PCH-S. It has four
controllers each having two chip selects.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index abb9f0ffd377..edb42d08857d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1394,6 +1394,11 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac6), LPSS_BXT_SSP },
+	/* RPL-S */
+	{ PCI_VDEVICE(INTEL, 0x7a2a), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x7a2b), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x7a79), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x7a7b), LPSS_CNL_SSP },
 	/* ADL-S */
 	{ PCI_VDEVICE(INTEL, 0x7aaa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x7aab), LPSS_CNL_SSP },
-- 
2.34.1

