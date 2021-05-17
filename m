Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DD9382E3A
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbhEQOFD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 10:05:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:31775 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237584AbhEQOEz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 10:04:55 -0400
IronPort-SDR: vygO6f4Ax9EO9fDx8P4jBhhORLVydXd1wB1yzHkh5dT+rWeIRwvvNEeGyUIlsIveUPitoyflGq
 wI7031gmtRkw==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="264386594"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="264386594"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 07:03:39 -0700
IronPort-SDR: F56TXeGzOu8GfgprpVTxRcST7KceuRRfrTbvY3ixRQWx2OZCBnXSMV1EHIcqzKbWCqKPEyl1sU
 R86aVSGY1rIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="438934344"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 17 May 2021 07:03:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 65F788F2; Mon, 17 May 2021 17:03:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 8/9] spi: pxa2xx: Update documentation to point out that it's outdated
Date:   Mon, 17 May 2021 17:03:50 +0300
Message-Id: <20210517140351.901-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
References: <20210517140351.901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Update documentation by pointing out that it's applicable mostly
for a legacy platform. While at it, add couple of points with regard
to ACPI, Device Tree, and automatic DMA enablement.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/spi/pxa2xx.rst | 58 ++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
index 882d3cc72cc2..6312968acfe9 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -2,43 +2,47 @@
 PXA2xx SPI on SSP driver HOWTO
 ==============================
 
-This a mini howto on the pxa2xx_spi driver.  The driver turns a PXA2xx
-synchronous serial port into a SPI master controller
+This a mini HOWTO on the pxa2xx_spi driver. The driver turns a PXA2xx
+synchronous serial port into an SPI master controller
 (see Documentation/spi/spi-summary.rst). The driver has the following features
 
-- Support for any PXA2xx SSP
+- Support for any PXA2xx and compatible SSP.
 - SSP PIO and SSP DMA data transfers.
 - External and Internal (SSPFRM) chip selects.
 - Per slave device (chip) configuration.
 - Full suspend, freeze, resume support.
 
-The driver is built around a "spi_message" fifo serviced by workqueue and a
-tasklet. The workqueue, "pump_messages", drives message fifo and the tasklet
-(pump_transfer) is responsible for queuing SPI transactions and setting up and
-launching the dma/interrupt driven transfers.
+The driver is built around a &struct spi_message FIFO serviced by kernel
+thread. The kernel thread, spi_pump_messages(), drives message FIFO and
+is responsible for queuing SPI transactions and setting up and launching
+the DMA or interrupt driven transfers.
 
 Declaring PXA2xx Master Controllers
 -----------------------------------
-Typically a SPI master is defined in the arch/.../mach-*/board-*.c as a
-"platform device".  The master configuration is passed to the driver via a table
-found in include/linux/spi/pxa2xx_spi.h::
+Typically, for a legacy platform, an SPI master is defined in the
+arch/.../mach-*/board-*.c as a "platform device". The master configuration
+is passed to the driver via a table found in include/linux/spi/pxa2xx_spi.h::
 
   struct pxa2xx_spi_controller {
 	u16 num_chipselect;
 	u8 enable_dma;
+	...
   };
 
 The "pxa2xx_spi_controller.num_chipselect" field is used to determine the number of
 slave device (chips) attached to this SPI master.
 
 The "pxa2xx_spi_controller.enable_dma" field informs the driver that SSP DMA should
-be used.  This caused the driver to acquire two DMA channels: rx_channel and
-tx_channel.  The rx_channel has a higher DMA service priority the tx_channel.
+be used. This caused the driver to acquire two DMA channels: Rx channel and
+Tx channel. The Rx channel has a higher DMA service priority than the Tx channel.
 See the "PXA2xx Developer Manual" section "DMA Controller".
 
+For the new platforms the description of the controller and peripheral devices
+comes from Device Tree or ACPI.
+
 NSSP MASTER SAMPLE
 ------------------
-Below is a sample configuration using the PXA255 NSSP::
+Below is a sample configuration using the PXA255 NSSP for a legacy platform::
 
   static struct resource pxa_spi_nssp_resources[] = {
 	[0] = {
@@ -79,9 +83,10 @@ Below is a sample configuration using the PXA255 NSSP::
 
 Declaring Slave Devices
 -----------------------
-Typically each SPI slave (chip) is defined in the arch/.../mach-*/board-*.c
-using the "spi_board_info" structure found in "linux/spi/spi.h". See
-"Documentation/spi/spi-summary.rst" for additional information.
+Typically, for a legacy platform, each SPI slave (chip) is defined in the
+arch/.../mach-*/board-*.c using the "spi_board_info" structure found in
+"linux/spi/spi.h". See "Documentation/spi/spi-summary.rst" for additional
+information.
 
 Each slave device attached to the PXA must provide slave specific configuration
 information via the structure "pxa2xx_spi_chip" found in
@@ -101,9 +106,9 @@ device. All fields are optional.
   };
 
 The "pxa2xx_spi_chip.tx_threshold" and "pxa2xx_spi_chip.rx_threshold" fields are
-used to configure the SSP hardware fifo.  These fields are critical to the
+used to configure the SSP hardware FIFO. These fields are critical to the
 performance of pxa2xx_spi driver and misconfiguration will result in rx
-fifo overruns (especially in PIO mode transfers). Good default values are::
+FIFO overruns (especially in PIO mode transfers). Good default values are::
 
 	.tx_threshold = 8,
 	.rx_threshold = 8,
@@ -118,7 +123,7 @@ use a value of 8. The driver will determine a reasonable default if
 dma_burst_size == 0.
 
 The "pxa2xx_spi_chip.timeout" fields is used to efficiently handle
-trailing bytes in the SSP receiver fifo.  The correct value for this field is
+trailing bytes in the SSP receiver FIFO. The correct value for this field is
 dependent on the SPI bus speed ("spi_board_info.max_speed_hz") and the specific
 slave device.  Please note that the PXA2xx SSP 1 does not support trailing byte
 timeouts and must busy-wait any trailing bytes.
@@ -131,19 +136,19 @@ testing.
 The "pxa2xx_spi_chip.cs_control" field is used to point to a board specific
 function for asserting/deasserting a slave device chip select.  If the field is
 NULL, the pxa2xx_spi master controller driver assumes that the SSP port is
-configured to use SSPFRM instead.
+configured to use GPIO or SSPFRM instead.
 
 NOTE: the SPI driver cannot control the chip select if SSPFRM is used, so the
 chipselect is dropped after each spi_transfer.  Most devices need chip select
-asserted around the complete message.  Use SSPFRM as a GPIO (through cs_control)
+asserted around the complete message. Use SSPFRM as a GPIO (through a descriptor)
 to accommodate these chips.
 
 
 NSSP SLAVE SAMPLE
 -----------------
-The pxa2xx_spi_chip structure is passed to the pxa2xx_spi driver in the
-"spi_board_info.controller_data" field. Below is a sample configuration using
-the PXA255 NSSP.
+For a legacy platform or in some other cases, the pxa2xx_spi_chip structure
+is passed to the pxa2xx_spi driver in the "spi_board_info.controller_data"
+field. Below is a sample configuration using the PXA255 NSSP.
 
 ::
 
@@ -212,7 +217,9 @@ DMA and PIO I/O Support
 -----------------------
 The pxa2xx_spi driver supports both DMA and interrupt driven PIO message
 transfers.  The driver defaults to PIO mode and DMA transfers must be enabled
-by setting the "enable_dma" flag in the "pxa2xx_spi_controller" structure.  The DMA
+by setting the "enable_dma" flag in the "pxa2xx_spi_controller" structure.
+For the newer platforms, that are known to support DMA, the driver will enable
+it automatically and try it first with a possible fallback to PIO. The DMA
 mode supports both coherent and stream based DMA mappings.
 
 The following logic is used to determine the type of I/O to be used on
@@ -236,5 +243,4 @@ a per "spi_transfer" basis::
 
 THANKS TO
 ---------
-
 David Brownell and others for mentoring the development of this driver.
-- 
2.30.2

