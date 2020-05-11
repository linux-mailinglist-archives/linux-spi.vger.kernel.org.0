Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C441CD4DD
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 11:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgEKJ1S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgEKJ1S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 05:27:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF45C061A0C;
        Mon, 11 May 2020 02:27:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D85042A0F28;
        Mon, 11 May 2020 10:27:15 +0100 (BST)
Date:   Mon, 11 May 2020 11:27:12 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <p.yadav@ti.com>, alexandre.belloni@bootlin.com, vigneshr@ti.com,
        richard@nod.at, nsekhar@ti.com, Nicolas.Ferre@microchip.com,
        linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
Message-ID: <20200511112712.466f7246@collabora.com>
In-Reply-To: <3649933.zuh8VGJVCz@192.168.0.120>
References: <20200424184410.8578-1-p.yadav@ti.com>
        <3649933.zuh8VGJVCz@192.168.0.120>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 11 May 2020 09:00:35 +0000
<Tudor.Ambarus@microchip.com> wrote:

> Hi, Pratyush, Boris,
> 
> On Friday, April 24, 2020 9:43:54 PM EEST Pratyush Yadav wrote:
> > This series adds support for octal DTR flashes in the spi-nor framework,  
> 
> I'm still learning about this, but I can give you my 2 cents as of now, to 
> open the discussion. Enabling 2-2-2, 4-4-4, and 8-8-8 modes is dangerous 
> because the flash may not recover from unexpected resets. Entering one of 
> these modes can be:
> 1/ volatile selectable, the device return to the 1-1-1 protocol after the next 
> power-on. I guess this is conditioned by the optional RESET pin, but I'll have 
> to check. Also the flash can return to the 1-1-1 mode using the software reset 
> or through writing to its Configuration Register, without power-on or power-
> off.

My understanding is that there's no standard software reset procedure
that guarantees no conflict with existing 1S commands, so even the
software reset approach doesn't work here.

> 2/ non-volatile selectable in which RESET# and software reset are useless, the 
> flash defaults to the mode selected in the non volatile Configuration Register 
> bits. The only way to get back to 1-1-1 is to write to the Configuration 
> Register.

I'm less worried about this case though, since I'd expect the ROM
code and bootloaders to be able to deal with xD-xD-xD modes when the
flash is set in this mode by default. That implies letting Linux know
about this default mode of course, maybe through an extra DT
property/cmdline param.

> 
> Not recovering from unexpected resets is unacceptable. One should always 
> prefer option 1/ and condition the entering in 2-2-2, 4-4-4 and 8-8-8 with the 
> presence of the optional RESET pin.

Totally agree with you on that one, but we know what happens in
practice...

> 
> For the unfortunate flashes that support just option 2/, we should not enter 
> these modes on our own, just by discovering the capabilities from the SFDP 
> tables or by the flags in the flash_info struct. The best we can do for them 
> is to move the responsibility to the user. Maybe to add a Kconfig option that 
> is disabled by default with which we condition the entering in 2-2-2, 4-4-4 or 
> 8-8-8 modes.

Hm, a Kconfig option doesn't sound like the right solution to the
problem, since it should be a per-flash decision, not something you set
system-wise.

> Once entered in one of these modes, if an unexpected reset comes, 
> you most likely are doomed, because early stage bootloaders may not work in 
> these modes and you'll not be able to boot the board. Assuming that one uses 
> other environment to boot the board, we should at least make sure that the 
> flash works in linux after an unexpected reset. We should try to determine in 
> which mode we are at init, so maybe an extension of the default_init hook is 
> needed. But all this looks like a BIG compromise, I'm not yet sure if we 
> should adress 2/. Thoughts?

We should definitely not write non-volatile regs on our own, but
instead use the mode that's been chosen there. I doubt anyone
setting the non-volative conf to 8D-8D-8D will ever want to go back to
1S-1S-1S anyway, so 8D -> 1S transitions are not really an issue, right?

Of course, that still leaves us with the 'mode detection' issue, and I
have no solution other than flagging it through the DT/cmdline for that
one...
