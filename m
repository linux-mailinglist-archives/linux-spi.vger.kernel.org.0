Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41555FEB8
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 13:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiF2LeB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 07:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiF2LeB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 07:34:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D484D271A
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 04:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656502440; x=1688038440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KoX3ELsb74RYlahxkEYdL0FoTHasgp8HP1UPomYmgCo=;
  b=PMavHJIRy6yJUxMJu9j4rPAG7mZU2bUFc8xr/HBX80YbqzMPehJf5huI
   5iLg8X4mAbNEk4DEV6ouEY3vU2PU436MVU5j1NxUhjsZd98PJq+BPJfxr
   pLlQ9BDMEF9ryM4zlk5hUevqKemcrIipITej1omduznKcCefjgVgzhKTY
   +9sEzwlHVNmRksWZElyEF7TuxcR98yzaVrZAZBAJmdhihnfEiIZCJthAH
   gGzKiwSZ4TyGGuHAz17I0+CuLn/3PmS3Rd/NOyJ3J9ZR0jcnPmFY50fAA
   uI/N+Mrreo9f7knGHQ8xP4dRmxBJyDtV5qTCl+K26diGUxO+v0xGQGjfK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282741643"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="282741643"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="540829930"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2022 04:33:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B4C2EF1; Wed, 29 Jun 2022 14:34:03 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: intel: Add support for Intel Meteor Lake-P SPI serial flash
Date:   Wed, 29 Jun 2022 14:34:03 +0300
Message-Id: <20220629113403.79942-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Intel Meteor Lake-P has the same SPI serial flash controller as Alder
Lake-P. Add Meteor Lake-P PCI ID to the driver list of supported
devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index f6eec7a869b6..f0d532ea40e8 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -74,6 +74,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x54a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x7e23), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa0a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0xa1a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
-- 
2.35.1

