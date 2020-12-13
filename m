Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5A2D8CBE
	for <lists+linux-spi@lfdr.de>; Sun, 13 Dec 2020 12:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393160AbgLML3m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 13 Dec 2020 06:29:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55826 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgLML3m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 13 Dec 2020 06:29:42 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 480961F44CF6;
        Sun, 13 Dec 2020 11:28:59 +0000 (GMT)
Date:   Sun, 13 Dec 2020 12:28:49 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>,
        <bbrezillon@kernel.org>, <p.yadav@ti.com>,
        <tudor.ambarus@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 5/9] spi: spi-mem: Allow masters to transfer dummy
 cycles directly by hardware
Message-ID: <20201213122849.65ddd988@collabora.com>
In-Reply-To: <20201213105426.294827c8@collabora.com>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
        <1607721363-8879-6-git-send-email-skomatineni@nvidia.com>
        <20201212115715.31a8d755@collabora.com>
        <7efb281a-98d7-68c5-1515-0e980b6cfe12@nvidia.com>
        <20201213105426.294827c8@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 13 Dec 2020 10:54:26 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Sat, 12 Dec 2020 09:28:50 -0800
> Sowjanya Komatineni <skomatineni@nvidia.com> wrote:
> 
> > On 12/12/20 2:57 AM, Boris Brezillon wrote:  
> > > On Fri, 11 Dec 2020 13:15:59 -0800
> > > Sowjanya Komatineni <skomatineni@nvidia.com> wrote:
> > >    
> > >> This patch adds a flag SPI_MASTER_USES_HW_DUMMY_CYCLES for the controllers
> > >> that support transfer of dummy cycles by the hardware directly.    
> > > Hm, not sure this is a good idea. I mean, if we expect regular SPI
> > > devices to use this feature, then why not, but if it's just for
> > > spi-mem, I'd recommend implementing a driver-specific exec_op() instead
> > > of using the default one.    
> > 
> > dummy cycles programming is SPI device specific.
> > 
> > Transfer of dummy bytes by SW or HW controller can be depending on 
> > features supported by controller.
> > 
> > Adding controller driver specific exec_op() Just for skipping dummy 
> > bytes transfer will have so much of redundant code pretty much what all 
> > spi_mem_exec_op does.
> > 
> > So in v1, I handled this in controller driver by skipping SW transfer of 
> > dummy bytes during dummy phase and programming dummy cycles in 
> > controller register to allow HW to transfer.
> > 
> > Based on v1 feedback discussion, added this flag 
> > SPI_MASTER_USES_HW_DUMMY_CYCLES which can be used by controllers 
> > supporting HW dummy bytes transfer and updated spi_mem_exec_op to skip 
> > SW dummy bytes.
> > 
> > This helps other controllers supporting HW transfer of dummy bytes as 
> > well just to set the flag and use dummy cycles directly.  
> 
> Except saying a spi_message has X dummy cycle is not precise enough.
> Where are those dummy cycles in the transfer sequence? spi-mem has well
> defined sequencing (cmd[+addr][+dummy][+data]) so we know exacly where
> dummy cycles are, but trying to retro-fit the dummy-cycle concept in
> the generic spi_message is confusing IMHO. If want to avoid code
> duplication, I'm pretty sure the driver can be reworked so the
> spi_transfer/exec_op() path can share most of the logic (that probably
> implies declaring a tegra_qspi_op).

Something like that might also do the trick:

--->8---

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index ef53290b7d24..8b0476f37fbb 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -353,6 +353,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
                xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
                xfers[xferpos].len = op->dummy.nbytes;
                xfers[xferpos].tx_nbits = op->dummy.buswidth;
+               xfers[xferpos].dummy_data = 1;
                spi_message_add_tail(&xfers[xferpos], &msg);
                xferpos++;
                totalxferlen += op->dummy.nbytes;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 99380c0825db..ecf7989318c5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -807,6 +807,10 @@ extern void spi_res_release(struct spi_controller *ctlr,
  *      transfer. If 0 the default (from @spi_device) is used.
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
+ * @dummy_data: set to 1 for a dummy transfer (a transfer whose data is
+ *      ignored). Controllers that are able to issue dummy cycles can ignore
+ *      tx_buf, for those that can't tx_buf will contain dummy bytes. The
+ *      number of  dummy cycles to issue is (len * tx_bits) / 8.
  * @cs_change: affects chipselect after this transfer completes
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
@@ -919,6 +923,7 @@ struct spi_transfer {
        struct sg_table tx_sg;
        struct sg_table rx_sg;
 
+       unsigned        dummy_data:1;
        unsigned        cs_change:1;
        unsigned        tx_nbits:3;
        unsigned        rx_nbits:3;
