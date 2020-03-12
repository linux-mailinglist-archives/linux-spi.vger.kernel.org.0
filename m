Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C50182F35
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 12:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCLLbr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 07:31:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:28073 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLLbr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Mar 2020 07:31:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 04:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="389575834"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2020 04:31:44 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 0/7] spi:dw: Add support for Intel Keem Bay SPI
Date:   Thu, 12 Mar 2020 19:31:22 +0800
Message-Id: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 106 +++++++++++++++
 drivers/spi/spi-dw-mid.c                      |   4 +
 drivers/spi/spi-dw-mmio.c                     |  57 +++++++-
 drivers/spi/spi-dw.c                          | 125 +++++++++++++-----
 drivers/spi/spi-dw.h                          |  25 +++-
 6 files changed, 277 insertions(+), 81 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

-- 
2.17.1

