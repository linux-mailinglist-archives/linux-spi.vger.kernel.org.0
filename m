Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BDF49DE37
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jan 2022 10:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiA0Jhz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 27 Jan 2022 04:37:55 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42509 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiA0Jhz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jan 2022 04:37:55 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 130892000B;
        Thu, 27 Jan 2022 09:37:50 +0000 (UTC)
Date:   Thu, 27 Jan 2022 10:37:49 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v9 01/13] spi: spi-mem: Introduce a capability structure
Message-ID: <20220127103749.5b195f03@xps13>
In-Reply-To: <YfGHy/MsQhaWCeYM@sirena.org.uk>
References: <20220104083631.40776-2-miquel.raynal@bootlin.com>
 <20220126105333.883267-1-miquel.raynal@bootlin.com>
 <YfF4UhhVFu749ZYK@sirena.org.uk>
 <20220126183601.42d38e88@xps13>
 <YfGHy/MsQhaWCeYM@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Wed, 26 Jan 2022 17:41:31 +0000:

> On Wed, Jan 26, 2022 at 06:36:01PM +0100, Miquel Raynal wrote:
> 
> > > I was hoping to review this stuff?  I think I was expecting it to be
> > > rebased after the merge window...  
> 
> > Sorry for the misunderstanding, I thought you were fine with these
> > spi bits so I didn't ping you before applying. Can you review the v9
> > then? There is nothing different in the series I applied.  
> 
> > Depending on the outcome I'll either fix inline if you ack the patches
> > or drop the patches from that branch and send a v10 otherwise.  
> 
> I don't recall seeing anything but I'd dropped them due to the merge
> window, like I say I was expecting a repost for -rc1.  I'll try to fish
> them out and have a look tomorrow.

No worries, I've re-sent exactly the patches currently applied on the
spi-mem-ecc branch (so the rebased ones). Take your time for reviewing
them and depending on how it goes I will introduce your Acks inline or
send a v11 if it is needed.

Thanks,
Miquèl
