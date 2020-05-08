Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C234D1CA768
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 11:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgEHJoh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 05:44:37 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41262 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgEHJoh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 05:44:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8C9AD80307C2;
        Fri,  8 May 2020 09:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZVwyYHvRLEER; Fri,  8 May 2020 12:36:51 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Date:   Fri, 8 May 2020 12:36:19 +0300
Message-ID: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Baikal-T1 SoC System Controller is equipped with a Boot Controller. It's
responsible for the system starting up from different sources. In
particular it's possible to boot the chip either from an internal firmware
or from an externally attached 16MB SPI flash or from the SoC SRAM
pre-initialized with first 64KB of the external SPI flash. Though the later
option is formally unavailable thus undocumented. Anyway in order to
perform the booting up from the SPI flash there is a DW APB SSI-based SPI
controller embedded into the System Boot Controller. Due to being utilized
for a specific usecase it's got very limited resources: no IRQ, no DMA,
a single native chip-select and just 8 bytes Tx/Rx FIFO available. In
addition to that the transparent (from SoC CPU point of view) initial code
execution is implemented by means of the SPI flash direct mapping method.
It's done by a vendor-specific block built on top the SPI controller so the
SPI flash slave device data is available just by dword-readings from a
dedicated memory region of 16MB. Taking into account the peculiarities of
the controller registers and physically mapped SPI flash access, very
limited resources, seeing the normal usecase of the controller is to
access an external SPI-nor flash, and due to multiple Baikal-T1 specifics,
which had to be workarounded in the driver code we decided to create a
dedicated SPI driver for it instead of using the DW APB SSI driver
available in the kernel.

The driver provides callbacks for the native messages-based SPI API
(though only if GPIO-based chip-select is declared), SPI-memory and direct
mapping read operations. Due to not having any asynchronous signaling
interface provided by the core we have no choice but to implement a
polling-based data transmission/reception algorithm. In addition to that
in order to bypass the automatic native chip-select toggle the driver
disables the local interrupts during the memory-based transfers if no
complementary GPIO-based chip-select detected in the platform.

This patchset is rebased and tested on the mainline Linux kernel 5.7-rc4:
base-commit: 0e698dfa2822 ("Linux 5.7-rc4")
tag: v5.7-rc4

New vendor prefix will be added in the framework of the next patchset:
https://lkml.org/lkml/2020/5/6/1047

Note as a result of next discussion with @Lee and @Miquel
https://lkml.org/lkml/2020/3/6/421
I've added dirmap_create() and dirmap_read() callbacks to this driver,
so the Baikal-T1 Boot MFD driver won't be resubmitted and can be dropped.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
Cc: Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Chuanhong Guo <gch981213@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (2):
  dt-bindings: spi: Add Baikal-T1 System Boot SPI Controller binding
  spi: Add Baikal-T1 System Boot SPI Controller driver

 .../bindings/spi/baikal,bt1-sys-ssi.yaml      | 100 ++
 drivers/spi/Kconfig                           |  13 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-bt1-sys.c                     | 873 ++++++++++++++++++
 drivers/spi/spi-bt1-sys.h                     | 169 ++++
 5 files changed, 1156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/baikal,bt1-sys-ssi.yaml
 create mode 100644 drivers/spi/spi-bt1-sys.c
 create mode 100644 drivers/spi/spi-bt1-sys.h

-- 
2.25.1

