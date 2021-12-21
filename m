Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D3547BE04
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 11:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhLUKPR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Dec 2021 05:15:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42290 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhLUKPR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 05:15:17 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BLAF35t114581;
        Tue, 21 Dec 2021 04:15:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640081703;
        bh=40NnMAfNyavw+mHDYO4/rAXDzD3CBKIyI2aZ0CGwH18=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IIGSXhFFp5l2kbRtnHKNSt3EGbk8mok1niqf7kkZL4ej7ELLzKkCirGSNJa2JqJ5t
         25nWZaC1ghIwWnv6XeFfSziOHKvRCaxAWQWkcnSnMFn6TuZ1MEFjr4Gj/YCo63A3fU
         AfGg1ajeHMxEYlVD4y3yPa/k2i71wcG2xe2Dhlt8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BLAF2f5120700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Dec 2021 04:15:03 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Dec 2021 04:15:02 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Dec 2021 04:15:02 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BLAF1K3102331;
        Tue, 21 Dec 2021 04:15:02 -0600
Date:   Tue, 21 Dec 2021 15:45:01 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
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
Message-ID: <20211221101459.sahoe2actpu5644b@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
 <20211217161654.367782-2-miquel.raynal@bootlin.com>
 <20211220183917.m3mywavgxsgq7yar@ti.com>
 <20211221105058.69822ac5@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211221105058.69822ac5@xps13>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 21/12/21 10:50AM, Miquel Raynal wrote:
> Hi Pratyush,
> 
> p.yadav@ti.com wrote on Tue, 21 Dec 2021 00:09:19 +0530:
> 
> > On 17/12/21 05:16PM, Miquel Raynal wrote:
> > > It seems that the number of command bytes must be "2" only when the
> > > command itself is sent in DTR mode. The current logic checks if the
> > > number of command bytes is "2" when any of the cycles is a DTR cycle. It
> > > is likely that so far no device was actually mixing DTR/non-DTR cycles
> > > in the same operation, explaining why this was left undetected until
> > > now.  
> > 
> > This was intentional. spi_mem_dtr_supports_op() must only be called when 
> > the operation is DTR in all phases so I did not add any sanity checks if 
> > someone was using it for non-DTR ops.
> 
> Maybe that was the original intention but since then the Macronix
> driver has been merged and supports (at lest does not reject) these
> modes.

But I don't see any code that actually creates mixed DTR ops. SPI NOR 
does not do it for sure, and SPI NAND does not have DTR support yet. 
Those are the only two users of SPI MEM I can see. So we are solving at 
a problem that doesn't exist yet. Which is fine of course, I just want 
to point it out.

> 
> > In fact, I added on to this 
> > function in [0] to check nbytes for other phases as well. The patch fell 
> > off my radar unfortunately, and it didn't get merged.
> > 
> > I would like to keep this as it is since we have no user of mixed 
> > DTR/non-DTR modes yet.
> 
> I don't know if the Macronix driver really supports it or if it is the
> driver that is doing the wrong checks but in appearance such mixed mode
> could be used.
> 
> > But if you really want to support it, please 
> > apply my patch first to make sure we check for every phase, not just 
> > command.
> > 
> > [0] https://lore.kernel.org/all/20210531181757.19458-5-p.yadav@ti.com/
> 
> Nice, I might take that as well indeed in order to make the checks a
> little bit more robust.

Thanks.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
