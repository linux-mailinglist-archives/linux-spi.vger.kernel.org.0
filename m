Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45221DD7DF
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 22:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgEUUDq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 16:03:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43760 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgEUUDp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 16:03:45 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LK3Hd2084735;
        Thu, 21 May 2020 15:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590091397;
        bh=KgACAFLoJRVyGtBb1FVqvHXti7scEZKPVWNBAC0Joe4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZqioNx7VbIEs/+pVdVa2H3QrOLpXgUwJwWiCrNv643SA99qm4R7rLR6RdTF0mdvQN
         +w5oFB/il5gzOZtFWMTjXfTMbWELYxBsuaKZ8cZeKdnKEEVCd2MQEoP8Xg2FSrRBdA
         vBba3Iq2+YZvQw9i6MWLr9P5FfXzsBYN0ISsDe3s=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04LK3HIC051566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 15:03:17 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 15:03:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 15:03:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LK3Gia014075;
        Thu, 21 May 2020 15:03:17 -0500
Date:   Fri, 22 May 2020 01:33:15 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
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
Message-ID: <20200521200313.bnil6a4u3dhiizr4@ti.com>
References: <20200520163053.24357-1-p.yadav@ti.com>
 <20200520163053.24357-5-p.yadav@ti.com>
 <20200521202256.5816eb32@collabora.com>
 <20200521194129.3lqdormmcs4zadh2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200521194129.3lqdormmcs4zadh2@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22/05/20 01:11AM, Pratyush Yadav wrote:
> On 21/05/20 08:22PM, Boris Brezillon wrote:
> > On Wed, 20 May 2020 22:00:38 +0530
> > Pratyush Yadav <p.yadav@ti.com> wrote:
> > 
> > > In xSPI mode, flashes expect 2-byte opcodes. The second byte is called
> > > the "command extension". There can be 3 types of extensions in xSPI:
> > > repeat, invert, and hex. When the extension type is "repeat", the same
> > > opcode is sent twice. When it is "invert", the second byte is the
> > > inverse of the opcode. When it is "hex" an additional opcode byte based
> > > is sent with the command whose value can be anything.
> > > 
> > > So, make opcode a 16-bit value and add a 'nbytes', similar to how
> > > multiple address widths are handled.
> > > 
> > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > ---
> > >  include/linux/spi/spi-mem.h | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> > > index e3dcb956bf61..731bb64c6ba6 100644
> > > --- a/include/linux/spi/spi-mem.h
> > > +++ b/include/linux/spi/spi-mem.h
> > > @@ -69,6 +69,8 @@ enum spi_mem_data_dir {
> > >  
> > >  /**
> > >   * struct spi_mem_op - describes a SPI memory operation
> > > + * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
> > > + *		sent MSB-first.
> > >   * @cmd.buswidth: number of IO lines used to transmit the command
> > >   * @cmd.opcode: operation opcode
> > >   * @cmd.dtr: whether the command opcode should be sent in DTR mode or not
> > > @@ -94,9 +96,10 @@ enum spi_mem_data_dir {
> > >   */
> > >  struct spi_mem_op {
> > >  	struct {
> > > +		u8 nbytes;
> > >  		u8 buswidth;
> > >  		u8 dtr : 1;
> > > -		u8 opcode;
> > > +		u16 opcode;
> > >  	} cmd;
> > >  
> > >  	struct {
> > 
> > As mentioned in one of my previous review, you should patch the mxic
> > driver before extending the opcode field:
> 
> IIUC, this patchset doesn't break original functionality of the driver. 
> It will work like before with 1-byte opcodes. So I don't think it is the 
> responsibility of this patchset to enhance the driver. It didn't work 
> before with 2-byte opcodes, it won't work now. IMO this should be a 
> separate, independent change.

Scratch that. Big/little endian issue. If you'd drop your Signed-off-by, 
I'll write the commit message and patch it in.
  
> > --->8---
> > diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
> > index 69491f3a515d..c3f4136a7c1d 100644
> > --- a/drivers/spi/spi-mxic.c
> > +++ b/drivers/spi/spi-mxic.c
> > @@ -356,6 +356,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
> >         int nio = 1, i, ret;
> >         u32 ss_ctrl;
> >         u8 addr[8];
> > +       u8 cmd[2];
> >  
> >         ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
> >         if (ret)
> > @@ -393,7 +394,10 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
> >         writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
> >                mxic->regs + HC_CFG);
> >  
> > -       ret = mxic_spi_data_xfer(mxic, &op->cmd.opcode, NULL, 1);
> > +       for (i = 0; i < op->cmd.nbytes; i++)
> > +               cmd[i] = op->cmd.opcode >> (8 * (op->cmd.nbytes - i - 1));
> > +
> > +       ret = mxic_spi_data_xfer(mxic, cmd, NULL, op->cmd.nbytes);
> >         if (ret)
> >                 goto out;
> >  

-- 
Regards,
Pratyush Yadav
Texas Instruments India
