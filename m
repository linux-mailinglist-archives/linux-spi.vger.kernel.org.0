Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91022509F6
	for <lists+linux-spi@lfdr.de>; Mon, 24 Aug 2020 22:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHXUad (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 16:30:33 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:1130 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUaa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 16:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598301029; x=1629837029;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7oFAii9lyA4lIaQ8JCE+tvw5Jg9aKR2Pa8NNZaZzymw=;
  b=CBpYfJ5TuSwXo36upy+QPhqQAQ596doiIehHCXOGRnBv5XHcn/INsVdb
   c9pa0g/JWLij5ZWHNe4EQEL04d3mJwJMZpJJIm6Gpf1347SyR4rr9KOGN
   7fOIGNYzYyt+ITs335CS6QgzLOzYV6LEhyeI8UJGJqVvRU8gUtYgamXM4
   6OpUy5RELPlXHMG9zMXMcZ815xYdhzP4dDLG5xHLjWeFxnnDauMmn3v6R
   GWy4aM4m5igZ/xIDwBf9/ffGeSct0nSHSijiztGTDe7i4Ts6XVSPxZG+n
   +o0Jv4/AHWkqg+SB4OL+41vwVM9hSvvsdkQltqg2PgbePs+D0avzmwI5w
   Q==;
IronPort-SDR: Jr42Kf2odZaGMYdGcDDQFr0x4tsxGSQT5OXB4NBYP7JaL0IKHeXgPbnhQMz74q4AaW32COvVcr
 srbNsYcrPi53SjK4Y+bKuIqxuZqELq2ObB7azUgdTu6W1rN6vR42fRqzja0VOxRh51lPE3BlWG
 Cqe47QYC4OBQmytUoNmq5yd5SJ/J1YhVcB57i1piBdWlSCSSyYxF0ulCNB+SUw+U0BlIc4hdNe
 9zc58zwTcQGlNIRy339rl3rkRpYcT+ciHRuooiig72N1xCWj11EIN6nFHJ0kopJ/QNjEgSparc
 F4g=
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="92961876"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2020 13:30:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 13:30:23 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 24 Aug 2020 13:29:48 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v5 0/6] spi: Adding support for Microchip Sparx5 SoC
Date:   Mon, 24 Aug 2020 22:30:04 +0200
Message-ID: <20200824203010.2033-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The series add support for the Sparx5 SoC SPI controller in the
spi-dw-mmio.c spi driver.

v5 changes:
- rx-sample-delay-ns documentation changes from Rob Herring:
 - Drop superfluous type $ref
 - Add default value = 0

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

