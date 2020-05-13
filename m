Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4F31D16AE
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbgEMOAm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:00:42 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62324 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387927AbgEMOAm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 10:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589378441; x=1620914441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tXc6/mHc2+SLyIE4RWS7EYDLa9x7v+roOjcgud5k/FM=;
  b=oOxq79/SeNFYdZtELVOfCDXkVugkIlyJyRsdZsVE5tPbac+aK4QsmyTR
   qcwTl/2dE26hXLd7KjcjhlKZUAwJo1fW37nbvHiPGjFRBpKBPaYSvvceN
   I5WxrqSxaNtWjNF5UhbtwjfIaWRVSyMkr+4imdWPqYhe9xbq6euK/FBxa
   D35oFIKXhH9QgxBB2plxI70G7PiGnB3uSlkmPaaFT/502k+ShO4nlPg4S
   YZdFN8TqghLY8cCFT07Z4URwJ/mXWkhlGv6npnpqZ/yxMiVEXQwzy83VS
   MJcmd2qo0GosgfNRSXalCNpF2gfEZGcO//d7Fv+l3k9MbrGElFJjaYk+A
   A==;
IronPort-SDR: ZplCVhn7dt1CCXrvIyaxi9B793BQdV1bKqjSMlGMUb4HA8bM99qF+Wp9bNj3XO9slj7PoV908D
 cSgPoBCVWra8hvvma+1I7zjC4031JbUOISOcJlRV5rTR6P1RqaK/axH7cdYHpYMqMydiItVldv
 WjTS+58FzWB/Bn8awju8rUKASA1iVxvQ3TNkgajJhegAVvJ1IcPucq7TgObvHrx9O5lNYOUL/7
 5y15H2OMurJBB4nVJKLBtrhaqRC7X8TUDT9bGGGi0kk0GW3kXoMxKgzipt+HyCqRiPuUsa4L5F
 utg=
X-IronPort-AV: E=Sophos;i="5.73,388,1583218800"; 
   d="scan'208";a="75774839"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 07:00:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 07:00:43 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 07:00:39 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 00/10] spi: Adding support for Microchip Sparx5 SoC
Date:   Wed, 13 May 2020 16:00:21 +0200
Message-ID: <20200513140031.25633-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is an add-on series to the main SoC Sparx5 series
(Message-ID: <20200513125532.24585-1-lars.povlsen@microchip.com>).

The series add support for Sparx5 on top of the existing
ocelot/jaguar2 spi driver.

It spins off the existing support for the MSCC platforms into a
separate driver, as adding new platforms from the MSCC/Microchip
product lines will further complicate (clutter) the original driver.

New YAML dt-bindings are provided for the resulting driver.

It is expected that the DT patches are to be taken directly by the arm-soc
maintainers.

Lars Povlsen (10):
  spi: dw: Add support for polled operation via no IRQ specified in DT
  spi: dw: Add support for RX sample delay register
  spi: dw: Add support for client driver memory operations
  dt-bindings: spi: Add bindings for spi-dw-mchp
  spi: spi-dw-mmio: Spin off MSCC platforms into spi-dw-mchp
  dt-bindings: spi: spi-dw-mchp: Add Sparx5 support
  spi: spi-dw-mchp: Add Sparx5 support
  arm64: dts: sparx5: Add SPI controller
  arm64: dts: sparx5: Add spi-nor support
  arm64: dts: sparx5: Add spi-nand devices

 .../bindings/spi/mscc,ocelot-spi.yaml         |  89 ++++
 .../bindings/spi/snps,dw-apb-ssi.txt          |   7 +-
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  37 ++
 .../boot/dts/microchip/sparx5_pcb125.dts      |  16 +
 .../boot/dts/microchip/sparx5_pcb134.dts      |  22 +
 .../dts/microchip/sparx5_pcb134_board.dtsi    |   9 +
 .../boot/dts/microchip/sparx5_pcb135.dts      |  23 +
 .../dts/microchip/sparx5_pcb135_board.dtsi    |   9 +
 arch/mips/configs/generic/board-ocelot.config |   2 +-
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-dw-mchp.c                     | 399 ++++++++++++++++++
 drivers/spi/spi-dw-mmio.c                     |  93 ----
 drivers/spi/spi-dw.c                          |  31 +-
 drivers/spi/spi-dw.h                          |   4 +
 16 files changed, 644 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
 create mode 100644 drivers/spi/spi-dw-mchp.c

--
2.26.2
