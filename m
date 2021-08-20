Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172133F2BAE
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbhHTMCw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 20 Aug 2021 08:02:52 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42269 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbhHTMCw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 08:02:52 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C18EB60005;
        Fri, 20 Aug 2021 12:02:11 +0000 (UTC)
Date:   Fri, 20 Aug 2021 14:02:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 13/13] mtd: spinand: Add support for Winbond W35N01JW
 SPI NAND flash
Message-ID: <20210820140210.47d348dc@xps13>
In-Reply-To: <64f130dc-1d87-5657-ae93-09bfdb7e93a1@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-14-a-nandan@ti.com>
        <20210806211423.5c9d3e96@xps13>
        <64f130dc-1d87-5657-ae93-09bfdb7e93a1@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Fri, 20 Aug 2021 17:21:33
+0530:

> Hi Miquèl,
> 
> On 07/08/21 12:44 am, Miquel Raynal wrote:
> > Hi Apurva,
> > 
> > Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:38
> > +0000:
> >   
> >> Winbond W35N01JW is SPI NAND flash supporting Octal DTR SPI protocol.  
> > 
> >                       a
> >   
> >> Add op_vairants for W35N01JW, which include the Octal DTR read/write  
> > 
> > variants
> >   
> >> page ops as well. Add W35N01JW's oob layout functions for the  
> > 
> >                                     OOB
> >   
> 
> Okay, will correct these.
> 
> >> mtd_ooblayout_ops. Add all op adjustments required for Octal DTR SPI
> >> mode using the adjust_op(). Finally, add an entry for W35N01JW in
> >> spinand_info table.
> >>
> >> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
> >>  
> > 
> > Maybe we can split this into two parts:
> > 1/ support the chip
> > 2/ add 8-D support
> >   
> 
> I can split the patch into:
> 1/ Add implementation of manufacturer_ops: adjust_op() to handle variations of ops in 8D-8D-8D mode
> 2/ Add support/entry for Winbond W35N01JW SPI NAND flash chip
> 
> As 8-D support has already been added in a previous patch.

I also don't want the renaming to happen in the patch adding more
logic.

Thanks,
Miquèl
