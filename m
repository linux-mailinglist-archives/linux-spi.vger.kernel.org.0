Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE8044D216
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 07:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhKKG5M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 01:57:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:34073 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhKKG5M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 01:57:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="230324724"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="230324724"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 22:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="642864889"
Received: from ubuntu18.png.intel.com ([10.88.229.69])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2021 22:54:19 -0800
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v3 0/5] Add support for Intel Thunder Bay SPI controller
Date:   Thu, 11 Nov 2021 14:51:56 +0800
Message-Id: <20211111065201.10249-1-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Hi,

This patch set adds support for Designware SPI version v1.02a (patch 1,2,3).
This patch also enables support for DW SPI on Intel Thunder Bay (patch 4,5).

Patch 1: DW SPI DT bindings for Slave Select Toggle Enable (SSTE).
Patch 2: Adds SSTE support for Designware SPI controller.
Patch 3: Adds master mode support for Designware SPI controller v1.02a.
Patch 4: DW SPI DT bindings for Intel Thunder Bay SoC.
Patch 5: Adds support for Designware SPI on Intel Thunderbay SoC.

The driver is tested on Keem Bay and Thunder Bay evaluation board

Summary:
Changes from v2:
1) SSTE support made using dt and created seperate patches.
2) SPI controller master mode selection made common to all DW SPI controllers.
3) Using a common init function for both keem bay and thunder bay.

Changes from v1:
1) Designware CR0 specific macros are named in a generic way.
2) SPI CAP macros are named in generic way rather than naming project specific.
3) SPI KEEM BAY specific macros are replaced by generic macros.
4) Resued the existing SPI deassert API instead of adding another reset


Changes in patches:

Patch 1 and Patch 2
Changes from v2/v1:
1) Patch is newly introduced in v3 to support SSTE via DTS

Patch 3:
Changes from v2/v1:
1)Newly introduced in v3 to make master mode selection (v1.02a) as seperate patch

Patch 4:
Changes from v2/v1:
1) No change in this patch. 

Patch 5:
Changes from v2/v1:
1) Removed SSTE support from this patch and moved to Patch 2.
2) Removed master mode selection and moved to Patch 3.
3) Init function made common for Keem Bay and Thunder Bay.



Thanks & Regards,
Nandhini



Nandhini Srikandan (5):
  dt-bindings: spi: Add SSTE support for DWC SSI controller
  spi: dw: Add SSTE support for DWC SSI controller
  spi: dw: Add support for master mode selection for DWC SSI controller
  dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
  spi: dw: Add support for Intel Thunder Bay SPI controller

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml  |  8 ++++++++
 drivers/spi/spi-dw-core.c                         | 15 +++++++++++++--
 drivers/spi/spi-dw-mmio.c                         |  9 +++++----
 drivers/spi/spi-dw.h                              |  6 ++++--
 4 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.17.1

