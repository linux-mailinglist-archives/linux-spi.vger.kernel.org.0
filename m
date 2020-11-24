Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1698D2C1C9E
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 05:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKXESv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 23:18:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:8580 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgKXESu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 23:18:50 -0500
IronPort-SDR: bZIpqjR0X3A1w8KeVtfJ2dWeWAN+pJaBxSUBLZcxo+c4rtRKitui8BcEr55Sby6tho8tbEhXRN
 hXfaikrwGlww==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="168378648"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="168378648"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 20:18:49 -0800
IronPort-SDR: fmeGY2cnWG1z8RzqGKX08iy6zPdPpEkv/HnJTzeTE8KcdaWA22IeAEiJpi67Bf5fPjog1NkGjw
 P5kN+gd9gT4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="343029822"
Received: from sgsxdev004.isng.phoenix.local (HELO localhost) ([10.226.81.179])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2020 20:18:46 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, vigneshr@ti.com, p.yadav@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v9 0/5] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC
Date:   Tue, 24 Nov 2020 12:18:35 +0800
Message-Id: <20201124041840.31066-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add QSPI controller support for Intel LGM SoC. 

Patches to move move bindings over to
"Documentation/devicetree/bindings/spi/" directory and also added compatible
Support for Intel platform.

dt-bindings: spi: cadence-qspi: Add support for Intel lgm-qspi
(earlier patch mail thread and Ack-by)
link: "https://lore.kernel.org/lkml/5d6d1b85.1c69fb81.96938.0315@mx.google.com/"

Reference:
        https://lkml.org/lkml/2020/6/1/50
---
v9:
  - Vignesh review comments address and update
  - Retain the patchv4 move the binding documentation from mtd to spi
    directory.
  - Add intel's compatible string over the legacy documentation
  - Remove unused variable, CQSPI_SUPPORTS_MULTI_CHIPSELECT macro and check  
  - YAML convertion patch alone dropped
v8:
  - As Mark suggested to add the dt-bindings documentation patches
    end of the series , so dropped.
v7:
  - Rob's review comments address and fixed dt-schema warning
  - Pratyush review comments address and update
  - DAC bit reset to 0 and 1 (enable/disable)
  - tested QSI-NOR flash mx25l12805d on LGM soc, it's working after disable DAC
  - Linus suggested to use 'num-cs' prperty instead of 'num-chipselect'
v6:
  - Rob's review comments update
  - add compatible string in properly aligned
  - remove cadence-qspi extra comaptible string in example
v5:
  - Rob's review comments update
  - const with single compatible string kept
v4:
  - Rob's review comments update
  - remove '|' no formatting to preserve
  - child node attributes follows under 'properties' under '@[0-9a-f]+$'.
v3:
  - Pratyush review comments update
  - CQSPI_SUPPORTS_MULTI_CHIPSELECT macro used instead of cqspi->use_direct_mode
  - disable DAC support placed in end of controller_init
v2:
  - Rob's review comments update for dt-bindings
  - add 'oneOf' for compatible selection
  - drop un-neccessary descriptions
  - add the cdns,is-decoded-cs and cdns,rclk-en properties as schema
  - remove 'allOf' in not required place
  - add AdditionalProperties false
  - add minItems/maxItems for qspi reset attributes

resend-v1:
  - As per Mark's suggestion , reorder the patch series 1-3 driver
    support patches, series 4-6 dt-bindings patches.
v1:
  - initial version

Ramuthevar Vadivel Murugan (5):
  spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
  spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
  spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
  spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
  dt-bindings: spi: cadence-qspi: Add support for Intel lgm-qspi

 .../bindings/{mtd => spi}/cadence-quadspi.txt      |  1 +
 drivers/spi/Kconfig                                |  2 +-
 drivers/spi/spi-cadence-quadspi.c                  | 24 ++++++++++++++++++----
 3 files changed, 22 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/{mtd => spi}/cadence-quadspi.txt (97%)

-- 
2.11.0

