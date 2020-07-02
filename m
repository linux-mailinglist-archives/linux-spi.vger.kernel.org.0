Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA58D2120B6
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 12:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgGBKNw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 06:13:52 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:55304 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGBKNv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 06:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593684831; x=1625220831;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8+cmfMl8STke39loCF9+Y2W12FqffVX09lpGcUyOefo=;
  b=WtVk/mGDYE6fqJiYTkedsN/LzQta6/s99qRLOqnU/SUeIu/JoFTg4HOH
   8mEv0CTLzAwCgMAyFCvkfCsad1mMqPauC0F0BFMUiYInqbaWq6wCVqWPt
   Vh7VY6PMgn2tZRk4ZYswK+1+iCFVKmSrPrMhzSHBNiWXQgI3CFga3kuqV
   k087ChaUAOcv5JcGJ8ln3Xlob88qyGgHKqn6zitULpaH9sr8uUOyjmk/a
   Z/sPVSYsHwT30FkWlbyd/fsAOmA9Ka1K2SscQUBOpQxjFqVoaA/Ht3+zL
   kLBKW4mE7jM8knpHZqT6R6V2Fn5vV0tXhq8S1aMtDuPk8bSdk3PE2Weq8
   A==;
IronPort-SDR: +wdcuJ+VBDclE695fkpRHK6OplxcpMoJbk5thf8eMgoPu2i6Aw6nS7XMMrOtms3eNHvzw2KC3B
 BSUuZ7yDc1YlnFKQ4V47xSxgUcYmjRe32aH6Ao3aU6KT/nlI79Bp0EzYgc5sDWuWfXVPHci34o
 3n5U43Bb/LjfWCTSWE3BhuEyx8XFkMjIBo4gtRQEd509hpNKQPtcG7WiAgfSOgALVyFQE7/sP1
 cmPCJi4wHofADOsHKb/eXMvPyok7iuOVeIVeAUoP8VqcqSrDkNXKZaiU351EaEIUsSenYYJVNB
 SaU=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="85979627"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 03:13:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 03:13:50 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 2 Jul 2020 03:13:27 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v3 0/8] spi: Adding support for Microchip Sparx5 SoC
Date:   Thu, 2 Jul 2020 12:13:23 +0200
Message-ID: <20200702101331.26375-1-lars.povlsen@microchip.com>
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

Lars Povlsen (8):
  spi: dw: Add support for RX sample delay register
  arm64: dts: sparx5: Add SPI controller and SPI mux
  spi: dw: Add Microchip Sparx5 support
  mux: sparx5: Add Sparx5 SPI mux driver
  dt-bindings: snps,dw-apb-ssi: Add sparx5 support, plus
    snps,rx-sample-delay-ns property
  dt-bindings: microchip,sparx5-spi-mux: Add Sparx5 SPI mux driver
    bindings
  arm64: dts: sparx5: Add spi-nor support
  arm64: dts: sparx5: Add spi-nand devices

 .../mux/microchip,sparx5-spi-mux.yaml         |  71 +++++++++
 .../bindings/spi/snps,dw-apb-ssi.yaml         |  28 ++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  43 ++++++
 .../arm64/boot/dts/microchip/sparx5_nand.dtsi |  32 ++++
 .../boot/dts/microchip/sparx5_pcb125.dts      |  16 ++
 .../boot/dts/microchip/sparx5_pcb134.dts      |   1 +
 .../dts/microchip/sparx5_pcb134_board.dtsi    |   9 ++
 .../boot/dts/microchip/sparx5_pcb135.dts      |   1 +
 .../dts/microchip/sparx5_pcb135_board.dtsi    |   9 ++
 drivers/mux/Makefile                          |   2 +
 drivers/mux/sparx5-spi.c                      | 138 ++++++++++++++++++
 drivers/spi/Kconfig                           |   1 +
 drivers/spi/spi-dw-core.c                     |  20 +++
 drivers/spi/spi-dw-mmio.c                     |  79 +++++++++-
 drivers/spi/spi-dw.h                          |   2 +
 15 files changed, 451 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_nand.dtsi
 create mode 100644 drivers/mux/sparx5-spi.c

--
2.27.0
