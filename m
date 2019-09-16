Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11FBB357F
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2019 09:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfIPHXa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Sep 2019 03:23:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:35843 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfIPHXa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Sep 2019 03:23:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 00:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="270109760"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 16 Sep 2019 00:23:27 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v3 0/2] spi: cadence-qspi: Add cadence-qspi support for Intel LGM SoC 
Date:   Mon, 16 Sep 2019 15:23:23 +0800
Message-Id: <20190916072325.32104-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

patch 1: Add YAML for cadence-qspi devicetree cdocumentation.
patch 2: cadence-qspi controller driver to support QSPI-NAND flash
using existing spi-nand framework with legacy spi protocol.

Ramuthevar Vadivel Murugan (2):
  dt-bindings: spi: Add support for cadence-qspi IP Intel LGM SoC
  spi: cadence-qspi: Add QSPI support for Intel LGM SoC

 .../devicetree/bindings/spi/cadence,qspi-nand.yaml |  84 +++
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-cadence-qspi-apb.c                 | 644 +++++++++++++++++++++
 drivers/spi/spi-cadence-qspi-apb.h                 | 174 ++++++
 drivers/spi/spi-cadence-qspi.c                     | 461 +++++++++++++++
 drivers/spi/spi-cadence-qspi.h                     |  73 +++
 7 files changed, 1446 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
 create mode 100644 drivers/spi/spi-cadence-qspi-apb.c
 create mode 100644 drivers/spi/spi-cadence-qspi-apb.h
 create mode 100644 drivers/spi/spi-cadence-qspi.c
 create mode 100644 drivers/spi/spi-cadence-qspi.h

-- 
2.11.0

