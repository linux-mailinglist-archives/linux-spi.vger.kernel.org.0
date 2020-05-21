Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59781DD817
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 22:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgEUURE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 16:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUURD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 16:17:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BCBC061A0E;
        Thu, 21 May 2020 13:17:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D0AD82A0667;
        Thu, 21 May 2020 21:17:01 +0100 (BST)
Date:   Thu, 21 May 2020 22:16:58 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: Re: [PATCH v6 04/19] spi: spi-mem: allow specifying a command's
 extension
Message-ID: <20200521221658.037b802b@collabora.com>
In-Reply-To: <20200521200313.bnil6a4u3dhiizr4@ti.com>
References: <20200520163053.24357-1-p.yadav@ti.com>
        <20200520163053.24357-5-p.yadav@ti.com>
        <20200521202256.5816eb32@collabora.com>
        <20200521194129.3lqdormmcs4zadh2@ti.com>
        <20200521200313.bnil6a4u3dhiizr4@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 22 May 2020 01:33:15 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> On 22/05/20 01:11AM, Pratyush Yadav wrote:
> > On 21/05/20 08:22PM, Boris Brezillon wrote:  
> > > On Wed, 20 May 2020 22:00:38 +0530
> > > Pratyush Yadav <p.yadav@ti.com> wrote:
> > >   
> > > > In xSPI mode, flashes expect 2-byte opcodes. The second byte is called
> > > > the "command extension". There can be 3 types of extensions in xSPI:
> > > > repeat, invert, and hex. When the extension type is "repeat", the same
> > > > opcode is sent twice. When it is "invert", the second byte is the
> > > > inverse of the opcode. When it is "hex" an additional opcode byte based
> > > > is sent with the command whose value can be anything.
> > > > 
> > > > So, make opcode a 16-bit value and add a 'nbytes', similar to how
> > > > multiple address widths are handled.
> > > > 
> > > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > > ---
> > > >  include/linux/spi/spi-mem.h | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > > > index e3dcb956bf61..731bb64c6ba6 100644
> > > > --- a/include/linux/spi/spi-mem.h
> > > > +++ b/include/linux/spi/spi-mem.h
> > > > @@ -69,6 +69,8 @@ enum spi_mem_data_dir {
> > > >  
> > > >  /**
> > > >   * struct spi_mem_op - describes a SPI memory operation
> > > > + * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
> > > > + *		sent MSB-first.
> > > >   * @cmd.buswidth: number of IO lines used to transmit the command
> > > >   * @cmd.opcode: operation opcode
> > > >   * @cmd.dtr: whether the command opcode should be sent in DTR mode or not
> > > > @@ -94,9 +96,10 @@ enum spi_mem_data_dir {
> > > >   */
> > > >  struct spi_mem_op {
> > > >  	struct {
> > > > +		u8 nbytes;
> > > >  		u8 buswidth;
> > > >  		u8 dtr : 1;
> > > > -		u8 opcode;
> > > > +		u16 opcode;
> > > >  	} cmd;
> > > >  
> > > >  	struct {  
> > > 
> > > As mentioned in one of my previous review, you should patch the mxic
> > > driver before extending the opcode field:  
> > 
> > IIUC, this patchset doesn't break original functionality of the driver. 
> > It will work like before with 1-byte opcodes. So I don't think it is the 
> > responsibility of this patchset to enhance the driver. It didn't work 
> > before with 2-byte opcodes, it won't work now. IMO this should be a 
> > separate, independent change.  
> 
> Scratch that. Big/little endian issue. If you'd drop your Signed-off-by, 
> I'll write the commit message and patch it in.

Just add a Suggested-by, that should be fine.

>   
> > > --->8---  
> > > diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
> > > index 69491f3a515d..c3f4136a7c1d 100644
> > > --- a/drivers/spi/spi-mxic.c
> > > +++ b/drivers/spi/spi-mxic.c
> > > @@ -356,6 +356,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
> > >         int nio = 1, i, ret;
> > >         u32 ss_ctrl;
> > >         u8 addr[8];
> > > +       u8 cmd[2];
> > >  
> > >         ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
> > >         if (ret)
> > > @@ -393,7 +394,10 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
> > >         writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
> > >                mxic->regs + HC_CFG);
> > >  
> > > -       ret = mxic_spi_data_xfer(mxic, &op->cmd.opcode, NULL, 1);
> > > +       for (i = 0; i < op->cmd.nbytes; i++)
> > > +               cmd[i] = op->cmd.opcode >> (8 * (op->cmd.nbytes - i - 1));
> > > +
> > > +       ret = mxic_spi_data_xfer(mxic, cmd, NULL, op->cmd.nbytes);
> > >         if (ret)
> > >                 goto out;
> > >    
> 

