Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2832A7DD0
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 13:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgKEMEc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 07:04:32 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:48528 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgKEMEb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 07:04:31 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0A5Bxvq9068678;
        Thu, 5 Nov 2020 19:59:57 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 5 Nov
 2020 20:03:35 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <clg@kaod.org>, <bbrezillon@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-spi@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v3 0/4] Porting ASPEED FMC/SPI memory controller driver
Date:   Thu, 5 Nov 2020 20:03:27 +0800
Message-ID: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0A5Bxvq9068678
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series aims to porting ASPEED FMC/SPI memory controller
driver with spi-mem interface. Adjust device tree setting of SPI NOR
flash in order to fit real AST2600 EVB and new SPI memory controller
driver. Also, this patch has been verified on AST2600-A1 EVB.

v2: Fix sparse warnings reported by kernel test robot <lkp@intel.com>.
v3: Fix build warnings with x86 allmodconfig.

Chin-Ting Kuo (4):
  dt-bindings: spi: Add binding file for ASPEED FMC/SPI memory
    controller
  ARM: dts: aspeed: ast2600: Update FMC/SPI controller setting for
    spi-aspeed.c
  ARM: dts: aspeed: ast2600-evb: Adjust SPI flash configuration
  spi: aspeed: Add ASPEED FMC/SPI memory controller driver

 .../bindings/spi/aspeed,spi-aspeed.yaml       |  66 ++
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      |  26 +-
 arch/arm/boot/dts/aspeed-g6.dtsi              |  18 +-
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-aspeed.c                      | 969 ++++++++++++++++++
 6 files changed, 1080 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
 create mode 100644 drivers/spi/spi-aspeed.c

-- 
2.17.1

