Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173C022C41D
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jul 2020 13:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgGXLOT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jul 2020 07:14:19 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:23441 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgGXLOS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Jul 2020 07:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595589258; x=1627125258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MSrS4SgPtucxam/i2osqyW0WomORtGwBLnc6F0rn0ms=;
  b=U4Z/mlhQnTwkLIR7unBeUTu/Na1uOVcJJ7Ev+1NnRuUsMF2rxDl503KQ
   cClUrel+FKyMJfxZATNqmiJAhZZ8djmYa+xhlyAe/m5yeNLaw3g34xOuR
   Rz6wG5PvOPIR0GbZNprkU53+X2zRd75iLxFh686agsgszTGUXj8qJIsz7
   pIrIsBwfwAhcleu08jwGuGg5ayoBKm9hHfay2NIc7unmz9m5tWkik73Ie
   HfWe21p4Q7zI8x5urxqMH3vFldhMpRQ5Vrc7/uYc2jpot2xH5SrMRho0H
   qYSum5TNDyroV6kwjB4y+oPGWXydBl0OJaMvJGLuvLkxWnZCc2ifbdMOF
   w==;
IronPort-SDR: jG1OkJTaODSRQIiJ7KNJRpIPabU+a8Vl54DQuV86wndtUUn3nOJjrMJRxbDf3qn2wpMV9TkyNM
 fnBjVjEK8p8w97YVQYnaUvntqNis2x9I5f0YgtYDVkV85kyoT0i4giwWt5AiIg5RPNotiB7E64
 OV02y/7XPEW1tmd6ccZzldOkCXo2SOx7kRtHc8iIaj7QY2Scsc69Dsx8lKoyxKqFZlNkpHEXOZ
 3OIhW12jqMoe89e2z9NaS95IXCHL9fbs7/qn0XN8TpoaIaWTg9cFq+Rmlb/CrKwD33P7ay0wHS
 FJw=
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="85239319"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2020 04:14:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 04:14:18 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 24 Jul 2020 04:13:35 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v4 0/6] spi: Adding support for Microchip Sparx5 SoC
Date:   Fri, 24 Jul 2020 13:13:58 +0200
Message-ID: <20200724111404.13293-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is an add-on series to the main SoC Sparx5 series
(Message-ID: <20200615133242.24911-1-lars.povlsen@microchip.com>

The series add support for the Sparx5 SoC SPI controller in the
spi-dw-mmio.c spi driver.

v4 changes:
- Changed snps,rx-sample-delay-ns to snps,rx-sample-delay-ns
  suggested by Rob Herring (rockchip also has this property).
- Added support for controller-level rx-sample-delay-ns value as
  well as per SPI slave value (rockchip has controller-level property).
- Dropped internal mux in favor of suggested spi-mux to
  control bus inteface selection.

v3 changes:
- Added mux support for controlling SPI bus interface. This is new mux
  driver, bindings and added to sparx5 base DT.
- Removed "microchip,spi-interface2" property in favour of
  "mux-controls" property in SPI controller (sparx5 only).
- Changed dw_spi_sparx5_set_cs() to use the mux control instead of
  directly acessing "mux" register. Associated code/defines moved to mux
  driver.
- Changed dw_spi_sparx5_set_cs() to match other similar functions in
  signature and avoid explicit CS toggling.
- Spun off duplicated NAND device DT chunks into separate DT file.

v2 changes:
- Moved all RX sample delay into spi-dw-core.c, using
  the "snps,rx-sample-delay-ns" device property.
- Integrated Sparx5 support directly in spi-dw-mmio.c
- Changed SPI2 configuration to per-slave "microchip,spi-interface2"
  property.
- Added bindings to existing snps,dw-apb-ssi.yaml file
- Dropped patches for polled mode and SPI memory operations.

Lars Povlsen (6):
  spi: dw: Add support for RX sample delay register
  spi: dw: Add Microchip Sparx5 support
  arm64: dts: sparx5: Add SPI controller and associated mmio-mux
  dt-bindings: snps,dw-apb-ssi: Add sparx5 support, plus
    rx-sample-delay-ns property
  arm64: dts: sparx5: Add spi-nor support
  arm64: dts: sparx5: Add spi-nand devices

 .../bindings/spi/snps,dw-apb-ssi.yaml         | 21 ++++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     | 47 ++++++++++++-
 .../arm64/boot/dts/microchip/sparx5_nand.dtsi | 31 ++++++++
 .../boot/dts/microchip/sparx5_pcb125.dts      | 30 ++++++++
 .../boot/dts/microchip/sparx5_pcb134.dts      |  1 +
 .../dts/microchip/sparx5_pcb134_board.dtsi    | 16 +++++
 .../boot/dts/microchip/sparx5_pcb135.dts      |  1 +
 .../dts/microchip/sparx5_pcb135_board.dtsi    | 16 +++++
 drivers/spi/spi-dw-core.c                     | 26 +++++++
 drivers/spi/spi-dw-mmio.c                     | 70 ++++++++++++++++++-
 drivers/spi/spi-dw.h                          |  3 +
 11 files changed, 260 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_nand.dtsi

-- 
2.27.0

