Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7C31CE289
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgEKSZK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 14:25:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44838 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbgEKSZK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 14:25:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04BIOvqo080948;
        Mon, 11 May 2020 13:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589221497;
        bh=hJLYMptzNWCT2nBGzqtwtRbCzj89zOemjfUVGWWmvq8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kRBX/UYTIJPvURcW2quJqeY9dWna9Z8FokWumJAkr2O9TfPJKXW1C/WVCGnL8sF46
         fAGKfo4rrchhj/nm5pJiZpZ/f9uMxBBFO55qGa3sYNaa2nExrfhe9FfR8ppHTAtBgt
         w3DXFEbQpRVcW3TH80+XA37ROsdVgCekZS+Vfxd8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04BIOvSX024459
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 13:24:57 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 11
 May 2020 13:24:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 11 May 2020 13:24:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04BIOu9u096276;
        Mon, 11 May 2020 13:24:56 -0500
Date:   Mon, 11 May 2020 23:54:55 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     <Tudor.Ambarus@microchip.com>, <alexandre.belloni@bootlin.com>,
        <vigneshr@ti.com>, <richard@nod.at>, <nsekhar@ti.com>,
        <Nicolas.Ferre@microchip.com>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
Message-ID: <20200511182453.ivfwu4wlfn2ta5ag@ti.com>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <3649933.zuh8VGJVCz@192.168.0.120>
 <20200511112712.466f7246@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200511112712.466f7246@collabora.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/05/20 11:27AM, Boris Brezillon wrote:
> On Mon, 11 May 2020 09:00:35 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
> > Hi, Pratyush, Boris,
> > 
> > On Friday, April 24, 2020 9:43:54 PM EEST Pratyush Yadav wrote:
> > > This series adds support for octal DTR flashes in the spi-nor framework,  
> > 
> > I'm still learning about this, but I can give you my 2 cents as of now, to 
> > open the discussion. Enabling 2-2-2, 4-4-4, and 8-8-8 modes is dangerous 
> > because the flash may not recover from unexpected resets. Entering one of 
> > these modes can be:
> > 1/ volatile selectable, the device return to the 1-1-1 protocol after the next 
> > power-on. I guess this is conditioned by the optional RESET pin, but I'll have 
> > to check. Also the flash can return to the 1-1-1 mode using the software reset 
> > or through writing to its Configuration Register, without power-on or power-
> > off.
> 
> My understanding is that there's no standard software reset procedure
> that guarantees no conflict with existing 1S commands, so even the
> software reset approach doesn't work here.
> 
> > 2/ non-volatile selectable in which RESET# and software reset are useless, the 
> > flash defaults to the mode selected in the non volatile Configuration Register 
> > bits. The only way to get back to 1-1-1 is to write to the Configuration 
> > Register.
> 
> I'm less worried about this case though, since I'd expect the ROM
> code and bootloaders to be able to deal with xD-xD-xD modes when the
> flash is set in this mode by default. That implies letting Linux know
> about this default mode of course, maybe through an extra DT
> property/cmdline param.
> 
> > 
> > Not recovering from unexpected resets is unacceptable. One should always 
> > prefer option 1/ and condition the entering in 2-2-2, 4-4-4 and 8-8-8 with the 
> > presence of the optional RESET pin.
> 
> Totally agree with you on that one, but we know what happens in
> practice...
> 
> > 
> > For the unfortunate flashes that support just option 2/, we should not enter 
> > these modes on our own, just by discovering the capabilities from the SFDP 
> > tables or by the flags in the flash_info struct. The best we can do for them 
> > is to move the responsibility to the user. Maybe to add a Kconfig option that 
> > is disabled by default with which we condition the entering in 2-2-2, 4-4-4 or 
> > 8-8-8 modes.
> 
> Hm, a Kconfig option doesn't sound like the right solution to the
> problem, since it should be a per-flash decision, not something you set
> system-wise.

Agreed.

Is there any such flash in use today? The two flashes the series adds 
support for both have volatile configuration for 8D mode. Unless we have 
to support a flash like this in practice, I think such a change is out 
of the scope of this series.
 
> > Once entered in one of these modes, if an unexpected reset comes, 
> > you most likely are doomed, because early stage bootloaders may not work in 
> > these modes and you'll not be able to boot the board. Assuming that one uses 
> > other environment to boot the board, we should at least make sure that the 
> > flash works in linux after an unexpected reset. We should try to determine in 
> > which mode we are at init, so maybe an extension of the default_init hook is 
> > needed. But all this looks like a BIG compromise, I'm not yet sure if we 
> > should adress 2/. Thoughts?
> 
> We should definitely not write non-volatile regs on our own, but
> instead use the mode that's been chosen there. I doubt anyone
> setting the non-volative conf to 8D-8D-8D will ever want to go back to
> 1S-1S-1S anyway, so 8D -> 1S transitions are not really an issue, right?
> 
> Of course, that still leaves us with the 'mode detection' issue, and I
> have no solution other than flagging it through the DT/cmdline for that
> one...

Correct. I tried doing it, and the best way I could figure out was to 
try reading the SFDP signature in 1S and 8D mode, and see where we get 
the correct value. But unfortunately, because the Read ID command is 
different in 8D mode for different flashes, we can't then figure out 
which flash it actually is.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
