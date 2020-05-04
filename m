Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C941C3AC9
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 15:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgEDNEf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 09:04:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:6156 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgEDNEf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 09:04:35 -0400
IronPort-SDR: P3Ag4SCcv/w9wWphseukUI90fYpM9AlcJaMigI75FwbHReO0R9oajzcTNwdXDKJFYsZg3IIbJe
 Bk/hVZlLnLNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 06:03:53 -0700
IronPort-SDR: SqD2jz1g8H7tjohWBdR0QpBITFwTOHGpD/CEL0sBgoMTJEB90XKm3m+kCEEdUa+vRyK2apcgge
 gp5Ol4ersm+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="249169049"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2020 06:03:51 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v4 0/7] spi: dw: Add support for Intel Keem Bay SPI
Date:   Mon,  4 May 2020 21:02:39 +0800
Message-Id: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset adds support for DesignWare DWC_ssi. This soft IP
is an AMBA version 2.0-compliant AHB slave device. Existing driver
already supports the older APB version.

Intel Keem Bay SPI controller is using this IP. This patchset is
tested on Keem Bay evaluation module board.

Changes since v3:
- DT changes for feature addition is done on snps,dw-apb-ssi.txt.
- And then convert the updated snps,dw-apb-ssi.txt to DT schema format.

Changes since v2:
- Rebased to v5.7-rc4.
- Change the order of the patches i.e. dt-bindings patches go last.

Changes since v1:
- Rework the third patch based on Rob's feedback.

Wan Ahmad Zainie (7):
  spi: dw: Fix typo in few registers name
  spi: dw: Add update_cr0() callback to update CTRLR0
  spi: dw: Add support for DesignWare DWC_ssi
  dt-bindings: spi: dw-apb-ssi: Add compatible string for DesignWare
    DWC_ssi
  spi: dw: Add support for Intel Keem Bay SPI
  dt-bindings: spi: dw-apb-ssi: Add Intel Keem Bay support
  dt-bindings: spi: dw-apb-ssi: Convert bindings to json-schema

 .../bindings/spi/snps,dw-apb-ssi.txt          |  41 ------
 .../bindings/spi/snps,dw-apb-ssi.yaml         |  72 ++++++++++
 drivers/spi/spi-dw-mid.c                      |   4 +
 drivers/spi/spi-dw-mmio.c                     |  57 +++++++-
 drivers/spi/spi-dw.c                          | 125 +++++++++++++-----
 drivers/spi/spi-dw.h                          |  25 +++-
 6 files changed, 243 insertions(+), 81 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

-- 
2.17.1

