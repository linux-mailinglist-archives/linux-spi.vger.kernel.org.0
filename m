Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58E778F01
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2019 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfG2PUN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jul 2019 11:20:13 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:40105 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728023AbfG2PUN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jul 2019 11:20:13 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x6TEP5TO025571;
        Mon, 29 Jul 2019 17:25:06 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id D6FB761FD3; Mon, 29 Jul 2019 17:25:05 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org, yogeshnarayan.gaur@nxp.com,
        tudor.ambarus@microchip.com, gregkh@linuxfoundation.org,
        frieder.schrempf@exceet.de, tglx@linutronix.de
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [RFC v1 0/3] *spi-mem: adding setup and callback function 
Date:   Mon, 29 Jul 2019 17:25:01 +0300
Message-Id: <20190729142504.188336-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Lately we have working on Flash interface unit (FIU) SPI driver that 
using spi-mem interface, Our FIU HW module support direct Flash Rd//Wr.

In our SOC (32 bit dual core ARM) we have 3 FIU's that using memory mapping as follow:

FIU0 - have 2 chip select and each one have 128MB memory mapping (total 256MB memory mapping)
FIU1 - have 4 chip select and each one have 128MB memory mapping (total 512MB memory mapping)
FIU2 - have 4 chip select and each one have 16MB memory mapping (total 32MB memory mapping)

Totally 800MB memory mapping.

When the FIU driver probe it don't know the size of each Flash that 
connected to the FIU, so the entire memory mapping is allocated for each FIU 
according the FIU device tree memory map parameters.
It means, if we enable all three FIU's the drivers will try to allocate totally 800MB.

In 32bit system it is problematic because the kernel have only 1GB 
of memory allocation so the vmalloc cannot take 800MB.

When implementing the FIU driver in the mtd/spi-nor we allocating memory address only 
for detected Flash with exact size (usually we are not using 128MB Flash), and in that case usually we allocating much less memory.

To solve this issue we needed to overcome two things:

1.	Get argument from the upper layer (spi-mem layer) 
2.	Calling the get argument function after SPI_NOR_SCAN function. (the MTD Flash size filled in  SPI_NOR_SCAN function)

The attach patch set solving the describe issue by:

1.	Add spi-mem callback function and value to the SPI device 
	for passing an argument from the spi-mem layer to the spi layer
2.	Add spi-mem setup function to the spi-memory operation that running 
	after the spi-mem probe finished.
3.	Implement function callback in the m25p80 driver that execute 
	get Flash size.

The patch set tested on NPCM750 EVB with FIU driver (implemented with SPI-MEM interface).

Thanks for your attention.

Tomer

Tomer Maimon (3):
  spi: spi-mem: add spi-mem setup function
  spi: spi-mem: add callback function to spi-mem device
  mtd: m25p80: add get Flash size callback support

 drivers/mtd/devices/m25p80.c | 12 ++++++++++++
 drivers/spi/spi-mem.c        | 27 ++++++++++++++++++++++++++-
 include/linux/spi/spi-mem.h  | 11 +++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.18.0

