Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A961C5262
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 12:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEEKB3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 06:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727931AbgEEKB2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 May 2020 06:01:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FEEC061A0F;
        Tue,  5 May 2020 03:01:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:d3ea:1c7:41fd:3038])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B203B2A0982;
        Tue,  5 May 2020 11:01:26 +0100 (BST)
Date:   Tue, 5 May 2020 12:01:23 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     masonccyang@mxic.com.tw
Cc:     "Pratyush Yadav" <me@yadavpratyush.com>, broonie@kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        "Pratyush Yadav" <p.yadav@ti.com>, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D
 mode
Message-ID: <20200505120123.24962338@collabora.com>
In-Reply-To: <20200505114443.6ebd5d3c@collabora.com>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
        <20200421092328.129308f6@collabora.com>
        <20200427175536.2mmei2fy6f7bg6jm@yadavpratyush.com>
        <OF18214CA5.6A9B2B30-ON48258558.001D894C-48258558.002249E0@mxic.com.tw>
        <20200428085401.574wmo6qddmumd7q@yadavpratyush.com>
        <OF04289CE2.B346916F-ON48258559.002280BD-48258559.00295800@mxic.com.tw>
        <20200429181856.kkavelcczylg4yxf@yadavpratyush.com>
        <OF28AE0642.4F34D6BB-ON4825855F.002D6E58-4825855F.003458C9@mxic.com.tw>
        <20200505114443.6ebd5d3c@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 5 May 2020 11:44:43 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Tue, 5 May 2020 17:31:45 +0800
> masonccyang@mxic.com.tw wrote:
> 
> 
> > > > > > I quickly went through your patches but can't reply them in each     
> > your   
> > > > > > patches.
> > > > > > 
> > > > > > i.e,.
> > > > > > 1) [v4,03/16] spi: spi-mem: allow specifying a command's extension
> > > > > > 
> > > > > > -                                u8 opcode;
> > > > > > +                                u16 opcode;
> > > > > > 
> > > > > > big/little Endian issue, right? 
> > > > > > why not just u8 ext_opcode;
> > > > > > No any impact for exist code and actually only xSPI device use     
> > > > extension     
> > > > > > command.    
> > > > > 
> > > > > Boris already explained the reasoning behind it.    
> > > > 
> > > > yup, I got his point and please make sure CPU data access.
> > > > 
> > > > i.e,.
> > > > Fix endianness of the BFPT DWORDs and xSPI in sfdp.c
> > > > 
> > > > and your patch,
> > > > +                                ext = spi_nor_get_cmd_ext(nor, op);
> > > > +                                op->cmd.opcode = (op->cmd.opcode <<     
> > 8) |   
> > > > ext;
> > > > +                                op->cmd.nbytes = 2;
> > > > 
> > > > I think maybe using u8 opcode[2] could avoid endianness.    
> > > 
> > > Again, thanks Boris for answering this. FWIW, I don't see anything wrong     
> >   
> > > with his suggestion.
> > > 
> > > To clarify a bit more, the idea is that we transmit the opcode MSB 
> > > first, just we do for the address. Assume we want to issue the command 
> > > 0x05. In 1S mode, we set cmd.opcode to 0x05. Here cmd.nbytes == 1. Treat     
> >   
> > > is as a 1-byte value, so the MSB is the same as the LSB. We directly 
> > > send 0x5 on the bus.    
> > 
> > There are many SPI controllers driver use "op->cmd.opcode" directly,
> > so is spi-mxic.c.
> > 
> > i.e,.
> > ret = mxic_spi_data_xfer(mxic, &op->cmd.opcode, NULL, op->cmd.nbytes);  
> 
> Just because you do it doesn't mean it's right. And most controllers use
> the opcode value, they don't dereference the pointer as you do here.
> 
> >   
> > > 
> > > If cmd.nbytes == 2, then the opcode would be 0x05FA (assuming extension 
> > > is invert of command). So we send the MSB (0x05) first, and LSB (0xFA) 
> > > next.    
> > 
> > My platform is Xilinx Zynq platform which CPU is ARMv7 processor.
> > 
> > In 1-1-1 mode, it's OK to send 1 byte command by u16 opcode but
> > in 8D-8D-8D mode, I need to patch
> > 
> > i.e.,
> > op->cmd.opcode = op->cmd.opcode | (ext << 8);
> > 
> > rather than your patch.  
> 
> Seriously, how hard is it to extract each byte from the u16 if your
> controller needs to pass things in a different order? I mean, that's
> already how it's done for the address cycle, so why is it a problem
> here? This sounds like bikeshedding to me. If the order is properly
> documented in the kernel doc, I see no problem having it grouped in one
> u16, with the first cmd cycle placed in the MSB and the second one in
> the LSB.

So, I gave it a try, and we're talking about something as simple as the
below diff. And yes, the mxic controller needs to be patched before
extending the cmd.opcode field, but we're talking about one driver here
(all other drivers should be fine). Oh, and if you look a few lines below
the changed lines, you'll notice that we do exactly the same for the
address.

--->8---
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 69491f3a515d..c3f4136a7c1d 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -356,6 +356,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
        int nio = 1, i, ret;
        u32 ss_ctrl;
        u8 addr[8];
+       u8 cmd[2];
 
        ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
        if (ret)
@@ -393,7 +394,10 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
        writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
               mxic->regs + HC_CFG);
 
-       ret = mxic_spi_data_xfer(mxic, &op->cmd.opcode, NULL, 1);
+       for (i = 0; i < op->cmd.nbytes; i++)
+               cmd[i] = op->cmd.opcode >> (8 * (op->cmd.nbytes - i - 1));
+
+       ret = mxic_spi_data_xfer(mxic, cmd, NULL, op->cmd.nbytes);
        if (ret)
                goto out;
 
