Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB85E97AD
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2019 09:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfJ3IMA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Oct 2019 04:12:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:19158 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3IMA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Oct 2019 04:12:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 01:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="212025078"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2019 01:11:57 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, vigneshr@ti.com, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 0/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller 
Date:   Wed, 30 Oct 2019 16:11:53 +0800
Message-Id: <20191030081155.29947-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for the Cadence QSPI controller. This controller is
present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
This driver has been tested on the Intel LGM SoCs.

This driver does not support generic SPI and also the implementation
only supports spi-mem interface to replace the existing driver in
mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
flash memory.

v2 changes from v1:
  Thank you Mark and Vignesh for the review comments and also shared link to develop 
cadence-quadspi driver based on spi-mem framework against removal of legacy SPI.

Mark Brown Review comments:
	If it's different versions of the same IP then everything should be in
	one driver with the optional features enabled depending on what's in a
	given system.

Vignesh review comments:
	Nope, you cannot have two drivers for the same IP (i.e Cadence QSPI)
	just to support to different types of SPI memories. This is the reason
	why spi_mem_ops was introduced.

	Please rewrite this driver over to use spi_mem_ops (instead of using
	generic SPI xfers) so that same driver supports both SPI-NOR and
	SPI-NAND flashes. Once that's done drivers/mtd/spi-nor/cadence-quadspi.c
	can be deleted.

	There are few existing examples of spi_mem_ops users in drivers/spi/
	(git grep spi_mem_ops) and materials here on how to write such a driver:
	
	[1] https://bootlin.com/blog/spi-mem-bringing-some-consistency-to-the-spi-memory-ecosystem/
	[2] https://www.youtube.com/watch?v=PkWbuLM_gmU

 

Ramuthevar Vadivel Murugan (2):
  dt-bindings: spi: Add schema for Cadence QSPI Controller driver
  spi: cadence-quadpsi: Add support for the Cadence QSPI controller

 .../devicetree/bindings/spi/cadence,qspi.yaml      |   65 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-cadence-quadspi.c                  | 1290 ++++++++++++++++++++
 drivers/spi/spi-cadence-quadspi.h                  |  272 +++++
 5 files changed, 1638 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi.yaml
 create mode 100644 drivers/spi/spi-cadence-quadspi.c
 create mode 100644 drivers/spi/spi-cadence-quadspi.h

-- 
2.11.0

