Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F271947BDB9
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 10:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhLUJvH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 21 Dec 2021 04:51:07 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:52561 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLUJvH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 04:51:07 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 471A9240006;
        Tue, 21 Dec 2021 09:51:00 +0000 (UTC)
Date:   Tue, 21 Dec 2021 10:50:58 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v7 01/14] spi: spi-mem: Fix a DTR related check in
 spi_mem_dtr_supports_op()
Message-ID: <20211221105058.69822ac5@xps13>
In-Reply-To: <20211220183917.m3mywavgxsgq7yar@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
        <20211217161654.367782-2-miquel.raynal@bootlin.com>
        <20211220183917.m3mywavgxsgq7yar@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

p.yadav@ti.com wrote on Tue, 21 Dec 2021 00:09:19 +0530:

> On 17/12/21 05:16PM, Miquel Raynal wrote:
> > It seems that the number of command bytes must be "2" only when the
> > command itself is sent in DTR mode. The current logic checks if the
> > number of command bytes is "2" when any of the cycles is a DTR cycle. It
> > is likely that so far no device was actually mixing DTR/non-DTR cycles
> > in the same operation, explaining why this was left undetected until
> > now.  
> 
> This was intentional. spi_mem_dtr_supports_op() must only be called when 
> the operation is DTR in all phases so I did not add any sanity checks if 
> someone was using it for non-DTR ops.

Maybe that was the original intention but since then the Macronix
driver has been merged and supports (at lest does not reject) these
modes.

> In fact, I added on to this 
> function in [0] to check nbytes for other phases as well. The patch fell 
> off my radar unfortunately, and it didn't get merged.
> 
> I would like to keep this as it is since we have no user of mixed 
> DTR/non-DTR modes yet.

I don't know if the Macronix driver really supports it or if it is the
driver that is doing the wrong checks but in appearance such mixed mode
could be used.

> But if you really want to support it, please 
> apply my patch first to make sure we check for every phase, not just 
> command.
> 
> [0] https://lore.kernel.org/all/20210531181757.19458-5-p.yadav@ti.com/

Nice, I might take that as well indeed in order to make the checks a
little bit more robust.

Thanks,
Miquèl
