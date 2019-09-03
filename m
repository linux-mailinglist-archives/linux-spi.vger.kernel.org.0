Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFA6A6C34
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2019 17:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfICPHF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Sep 2019 11:07:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43724 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfICPHF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Sep 2019 11:07:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id 90so13190890otg.10;
        Tue, 03 Sep 2019 08:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESEycbkGEsTf561HdtK9W+JMPb2DaqG5d3IDc2e1GG4=;
        b=gT7CpYeMWEJCGw+VbQwfn5wErprIG3SSBokyScYjprdRza1k7XOUUhzbuMh/uN9Cn5
         83UbEg2mITWzjpfzSZ1YGwJH+J/E1izU2fzi3TDGJlgbnetGskBDLT4pxH20QIHbsfBQ
         HCkleKIxe2TKhPKBH3ZIOtbbOoH9b27sFkXUrAWRpXNjMHJfxjIezY8kLjtH3nS6HdUO
         1a9MO4qcywkxw+C0X3bfB65LRUo73PSr0jrVsinfokGUs4IVqTj259nivSEX57beq1y9
         iazM0ezgdloDG+YbSgXpBP/v5MkxMJKC9xQXvs/K8u4sM9noMH5tMJJV3jOILx8hM+ve
         LQsQ==
X-Gm-Message-State: APjAAAXGqwXNnr3oFkFNGOcOqXR3GAtWSUFo1EVcYWPX/H0Vb60y8qqH
        TPIKC7Z39HLHbUeaai0P+5hOdMLzZJxEMRiDR1g=
X-Google-Smtp-Source: APXvYqxA9MC/Nx8W7llobkbX6NluWUXF0YQ9719X7MRA85ibLXQx6GzR3vQgyLYDbPoIeefD+uw420FZJO2CBcdT6z4=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr12305575oto.250.1567523224339;
 Tue, 03 Sep 2019 08:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190330141637.22632-1-boris.brezillon@collabora.com> <20190425194451.GA14552@kroah.com>
In-Reply-To: <20190425194451.GA14552@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Sep 2019 17:06:52 +0200
Message-ID: <CAMuHMdViBLGurV+w=EN4TMOsDey9vC=YS6qoX6wA4gwvirOoAA@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at25: Convert the driver to the spi-mem interface
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Apr 25, 2019 at 9:44 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Mar 30, 2019 at 03:16:37PM +0100, Boris Brezillon wrote:
> > The AT25 protocol fits pretty well in the spi-mem model. Convert the
> > at25 spi driver to a spi-mem driver and use the dirmap API instead of
> > forging SPI messages manually.
> > This makes the driver compatible with spi-mem-only controllers
> > (controllers implementing only the spi_mem ops).
> >
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/misc/eeprom/at25.c | 282 +++++++++++++++++++++++--------------
> >  1 file changed, 176 insertions(+), 106 deletions(-)
>
> Will there be a new version of this to fix up the problems that 0-day
> found in it?

gmail-whitespace-damaged fix:

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index f2abe27010eff133..98145d7d43d0c728 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -36,6 +36,7 @@ config EEPROM_AT25
        depends on SPI && SYSFS
        select NVMEM
        select NVMEM_SYSFS
+       select SPI_MEM
        help
          Enable this driver to get read/write support to most SPI EEPROMs,
          after you configure the board init code to know about each eeprom

Boris: what's the plan?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
