Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8F41D00F7
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 23:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbgELViD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 17:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728313AbgELViC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 17:38:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4CCC061A0C;
        Tue, 12 May 2020 14:38:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 145so6999077pfw.13;
        Tue, 12 May 2020 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tyo1TFdkWDgBr+SNz2GzBpADOWT+48QaLk9kJPjvFys=;
        b=R2zWiomTXIUU7FTP8rTUAlIlUUiXALX0r+yu2oh0AAJujBYyPGTOB0WKDkbsAqRc4y
         pQTlhw2M4+iKIb42xzK/sKyC8CYi1VMMtmefj1dLYm815MteG+1Vo8VPSpD++OFe0bto
         JO3/nK9aTskjrwScKbtSjRlMsVfmGGy+I7J5U4VZItIYCaL7wGypqCV5kg/ErW2Z1alv
         NEmf17truudxi2EKGIm1K71sLiaaC+oN8ea7GgLO5oUZohTrTWguMkv/qaMoZ8FN6YNs
         US51cj/KaMptYwhR3WuCP8/fQ4CECht6btIdXmVzR9UNVb0vmqPL3qoo25vIhFIHpqMJ
         v61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tyo1TFdkWDgBr+SNz2GzBpADOWT+48QaLk9kJPjvFys=;
        b=JvFnZodhHmraDs1Av+3L8yc9UmisK06ruBXma+YKVj8DY/g1tRwumALC+AyBM6707t
         SC9sVTVDY+D8J/y8j8c62Zv22MoGDEaXyiT9YrNRynJPbe/iDYESAd+BFbiPvYnLvVkF
         uhSdXaCH9ZWE/SX8qKHYEg/0sRqCReWRf6CibVV7zqqFll4Yj3LwDgO9kWWArz67LAH5
         ZNN5IyPhUxmQ5mRV5RcSdZ+bFey2wZq2eai71QLoAKEDVILNWRRpeGHCt6HoqqjSINQa
         4XcBAK2MPfGR6FjJ/kEQgjVw6jpBxKymVvrdoM4B3MpHV+gUZ0y53rhhmUgRXEm2W7FO
         TtUw==
X-Gm-Message-State: AGi0PuY7Rb+aA/fM22MlvDre2b9Yl1xwb391kYjQL7YWCCjF+qyd4B0U
        Cn9rD7nxokUQir+yTbHDOKnxZJw6I5aem1y1TbM=
X-Google-Smtp-Source: APiQypJYKYmgz5pdLPekQqni1lIF4lwB+NqlpSWbo35f3rCpzIHjuVZHrDnrnBcq8uzXhibYVAHCN2qKpPUxbpNRtCc=
X-Received: by 2002:a62:7f11:: with SMTP id a17mr21981022pfd.36.1589319482095;
 Tue, 12 May 2020 14:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-5-Sergey.Semin@baikalelectronics.ru> <20200508194324.GA185537@smile.fi.intel.com>
 <20200512212650.bmq5i3mrl5mydcvz@mobilestation>
In-Reply-To: <20200512212650.bmq5i3mrl5mydcvz@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 May 2020 00:37:50 +0300
Message-ID: <CAHp75VcRN=kDRteK9KHPRCLqTSNEcCFH8q3OKGvt5YL5D44iyQ@mail.gmail.com>
Subject: Re: [PATCH 04/17] spi: dw: Cleanup generic DW DMA code namings
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 13, 2020 at 12:28 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> On Fri, May 08, 2020 at 10:43:24PM +0300, Andy Shevchenko wrote:
> > On Fri, May 08, 2020 at 04:29:29PM +0300, Serge Semin wrote:
> > > Since from now the former Intel MID platform layer will be used
> > > as a generic DW SPI DMA module, lets alter the internal methods
> > > naming to be DMA-related instead of having the "mid_" prefix. In
> > > addition the DW PCI-DMA specific methods and structures should
> > > be named with pci-suffexes, since we'll implement the DW MMIO DMA
> > > specific functions and objects soon.
> >
> > I think we rather leave Intel Medfield things alone.  And I think I did this already in spi/for-next in less invasive way.
>
> The naming is horrible in that module.

I agree!

> Since it's going to be a generic DMA
> driver the prefixes should be correspondingly fixed. Currently they are a bit
> random.

Unfortunately, proposed '_pci' not anyhow better. There is Medfield
stuff and non-Medfield.
Luckily Elkhart Lake uses generic approach. That's why better to have
suffix based on platform, rather than on bus.

I think what should be done here are (in a patch per item):
1) moving to new named module (w/o mid)
2) removing mid_ prefix
3) something else I forgot?

-- 
With Best Regards,
Andy Shevchenko
