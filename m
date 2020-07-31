Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C17C2340B9
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbgGaIAE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 04:00:04 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59648 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731384AbgGaIAD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jul 2020 04:00:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 348BA8030866;
        Fri, 31 Jul 2020 07:59:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T9BwIsQNMf_F; Fri, 31 Jul 2020 10:59:57 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8] spi: dw-dma: Add max SG entries burst capability support
Date:   Fri, 31 Jul 2020 10:59:45 +0300
Message-ID: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mainly this series is about fixing a very nasty problem discovered in the
DW APB SSI driver working in a couple with DW DMAC, which doesn't have
multi-block capability support (a.k.a. accelerated SG list entries
traversal/burst, or automatic LLP entries reload, etc.).

DW DMA IP-core and its DMA channel on the synthesize stage can be tuned by
setting a vast number of the model parameters, some of which are provided
to create a more optimized/performant controller. In particular two of
those parameters are DMAH_CHx_MULTI_BLK_EN and DMAH_CHx_HC_LLP. If at
least one of them is set to zero (false) then the target DMA controller
will be smaller and faster but will lack of the DMA blocks chaining
support. In the kernel notation it means that the controller won't be able
to automatically reload a next SG-list entry, when a current one is
finished. Since Linux kernel DMA subsystem interface requires to have the
SG-lists execution supported, the DW DMA engine driver is developed in a
way so to resubmit each SG-list entry one-by-one by software means: each
SG-list entry execution finish is tracked by the DW DMA controller
interrupt, which handler executes a tasklet, which then re-charges a DW
DMA channel with a next SG-list entry if one is available.  Such
implementation is a normal design and works well for the most of the DW
DMAC client devices. But it may cause problems for devices, which send and
receive data by means of internal FIFOs. That requires having several DMA
channels working synchronously in order to prevent the FIFOs overflow.

A bright example of such device is the DW APB SSI controller. It has Tx
and Rx FIFOs, which first need to be filled in with data before data
sending out or receiving in. But those FIFOs are inter-dependent because
of the SPI nature and its shift-register design. So each sent over Tx FIFO
byte immediately causes getting a byte from the SPI bus into the Rx FIFO.
It makes a strategy of working with the SPI controller a bit tricky. The
more data we push into the Tx FIFO and the faster the SPI bus is, the more
careful we have to be in pulling data from Rx FIFO since if software or
DMA engine misses a moment when Rx FIFO is full, for instance, due to
being busy with some other activity or due to being blocked if system bus
is busy with doing something else or just due to being too slow to keep up
with incoming data, then Rx FIFO will be overflown, which consequently
causes data loss. Needless to say that such situation is fatal and mustn't
be tolerated for a bus like SPI.

In application to the DW APB SSI driver the problem above may happen when
DW DMAC is synthesized with no multi-block capability support and it's
enabled to be working with DW APB SSI for full-duplex transfers. DW APB
SSI driver allocates two DW DMAC channels to perform Tx and Rx SPI
transfers, initializes them, submits Tx and Rx SG-lists for execution and
then waits until the DMA transfers are finished. The issue happens when Rx
SG-list consists of more than one entry. Since the multi-block capability
is unsupported the DW DMAC driver will use the software-based SG-list
entries traverse implementation, which by design may cause
non-deterministic latency during the Rx SG-list entries re-charge. During
the entries re-charge procedure the DMA Tx channel will keep pushing data
into the SPI Tx FIFO. DW APB SSI controller in its turn will keep pushing
data out from the Tx FIFO to the SPI bus, and will immediately fill in the
Rx FIFO. So if the latency is big enough, then we'll eventually end up
with Rx FIFO overflow.

One of the possible solution of the problem denoted above is to feed the
DMA engine with the Tx and Rx SG-list entries one-by-one. This series
provides an implementation of that approach. First it moves the requested
DMA channels configuration into the dma_setup() callback, which should
have been there in the first place. Then it's better to move the DMA
transfers submission into the DMA-preparation methods to collect all the
setups in a single method. After that the current implementation of a
straightforward SG-lists DMA transfer should be unpinned into a dedicated
method dw_spi_dma_transfer_all() since we are about to introduce an
alternative DMA-based SPI transfer approach. Since DMA-transfers finish is
now locally detected we can simplify the driver code a bit and move the
DMAC register cleanup to a single place in the dw_spi_dma_transfer_all()
method. In order to re-use the DMA-{wait, submit Tx, submit Rx} methods we
have to alter their prototypes, so they would accept SG-lists instead of
the SPI-transfer structure. Finally we introduce a new DMA-based
SPI-transfer method, which traverses the SG-list entries in a loop and
synchronously submits each of then to the Tx and Rx DMA channels in a way
so the DMA engine wouldn't need to activate the prone to errors in our
case SG-list entries re-charge implementation. That new method is utilized
only for the DMA controllers, which can't handle all Tx and Rx SPI
transfer SG-lists in a single DMA transaction without software
intervention, and for the full-duplex SPI-transfers.

Note since the DMA-engine subsystem in kernel 5.8-rcX doesn't have the
max_sg_burst capability supported, this series is intended to be applied
only after the "next"-branch of the DMA-engine repository is merged into
the mainline repo. Alternatively the series could be merged in through the
DMA-engine repo.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (8):
  spi: dw-dma: Set DMA Level registers on init
  spi: dw-dma: Fail DMA-based transfer if no Tx-buffer specified
  spi: dw-dma: Configure the DMA channels in dma_setup
  spi: dw-dma: Move DMA transfers submission to the channels prep
    methods
  spi: dw-dma: Detach DMA transfer into a dedicated method
  spi: dw-dma: Move DMAC register cleanup to DMA transfer method
  spi: dw-dma: Pass exact data to the DMA submit and wait methods
  spi: dw-dma: Add one-by-one SG list entries transfer

 drivers/spi/spi-dw-dma.c | 309 ++++++++++++++++++++++++++++++---------
 drivers/spi/spi-dw.h     |   1 +
 2 files changed, 238 insertions(+), 72 deletions(-)

-- 
2.27.0

