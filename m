Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C43AA6C82
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2019 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfICPI4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Sep 2019 11:08:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36254 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfICPI4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Sep 2019 11:08:56 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8305628B338;
        Tue,  3 Sep 2019 16:08:53 +0100 (BST)
Date:   Tue, 3 Sep 2019 17:08:50 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] eeprom: at25: Convert the driver to the spi-mem
 interface
Message-ID: <20190903170850.6aee808b@collabora.com>
In-Reply-To: <CAMuHMdViBLGurV+w=EN4TMOsDey9vC=YS6qoX6wA4gwvirOoAA@mail.gmail.com>
References: <20190330141637.22632-1-boris.brezillon@collabora.com>
        <20190425194451.GA14552@kroah.com>
        <CAMuHMdViBLGurV+w=EN4TMOsDey9vC=YS6qoX6wA4gwvirOoAA@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

On Tue, 3 Sep 2019 17:06:52 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Thu, Apr 25, 2019 at 9:44 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sat, Mar 30, 2019 at 03:16:37PM +0100, Boris Brezillon wrote:  
> > > The AT25 protocol fits pretty well in the spi-mem model. Convert the
> > > at25 spi driver to a spi-mem driver and use the dirmap API instead of
> > > forging SPI messages manually.
> > > This makes the driver compatible with spi-mem-only controllers
> > > (controllers implementing only the spi_mem ops).
> > >
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > ---
> > >  drivers/misc/eeprom/at25.c | 282 +++++++++++++++++++++++--------------
> > >  1 file changed, 176 insertions(+), 106 deletions(-)  
> >
> > Will there be a new version of this to fix up the problems that 0-day
> > found in it?  
> 
> gmail-whitespace-damaged fix:
> 
> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index f2abe27010eff133..98145d7d43d0c728 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -36,6 +36,7 @@ config EEPROM_AT25
>         depends on SPI && SYSFS
>         select NVMEM
>         select NVMEM_SYSFS
> +       select SPI_MEM
>         help
>           Enable this driver to get read/write support to most SPI EEPROMs,
>           after you configure the board init code to know about each eeprom
> 
> Boris: what's the plan?

Sorry, I don't have time to respin this patch. Feel free to send a new
version if you need it.

Regards,

Boris
