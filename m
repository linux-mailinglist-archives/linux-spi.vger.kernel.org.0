Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C01B46E3
	for <lists+linux-spi@lfdr.de>; Wed, 22 Apr 2020 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDVOMk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Apr 2020 10:12:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:55662 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVOMk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Apr 2020 10:12:40 -0400
IronPort-SDR: TmK8d7A6G//8FycmGt9yEeYSKowQaejR2YeQxSQg/zGTXhpwwAl23txF3JBs7vk6PY4alus7wY
 c/HzoxfJvcLw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 07:12:39 -0700
IronPort-SDR: a87ikjocUkAw37EpT821rljrZjEfnFB+B0YI6diU0qr4wwkzdnEO4xp9qRjakoBvYP8Qn8+Erk
 nMlD2Rbp6EqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="402560679"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2020 07:12:37 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v2 0/7] spi: dw: Add support for Intel Keem Bay SPI
Date:   Wed, 22 Apr 2020 22:11:35 +0800
Message-Id: <20200422141142.25591-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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

Changes since v1:
- Rework the third patch based on Rob's feedback.


Wan Ahmad Zainie (7):
  spi: dw: Fix typo in few registers name
  spi: dw: Add update_cr0() callback to update CTRLR0
  dt-bindings: spi: dw-apb-ssi: Convert bindings to json-schema
  dt-bindings: spi: dw-apb-ssi: Add compatible string for DesignWare
    DWC_ssi
  spi: dw: Add support for DesignWare DWC_ssi
  dt-bindings: spi: dw-apb-ssi: Add Intel Keem Bay support
  spi: dw: Add support for Intel Keem Bay SPI

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

