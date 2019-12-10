Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F576118BFB
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 16:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLJPGo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 10 Dec 2019 10:06:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37042 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfLJPGo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 10:06:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so15780127otn.4
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2019 07:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=km8u3bLAz/I8IcS9hVD/PlEgIB9h4B7/8az0ohMQf/g=;
        b=gnpmQIrTfogi0TLISNDDf7ZzJg+Oc1drQDAS8hgMvKJ/6ALDiY0Eo+720AmsS5sgNV
         mimBRyEn6QAdn9MMG8AKSMx4OuoSJSizZ8gx0JaPGR7afuFWPUZthARt9WuVW0MCa11D
         r5z3gkGDXyywNzPnJbhgAJOVETR/qiEvuejecxeJf+qrcjyT2Vj1IwZeSo5jNbkOhLxl
         Sp+Frw7ahgDJAD3LwScSkuaMg4TqVfdm2Zin1aQdRLglDhhyHjV8HIm4AuG78OOpqa3y
         7Zblceo+WMWN9U/pc9yYGhG9K5Byq/EnBjtd5b2RYtWOjtwYr5ix1YmW6usRA2g1Payq
         7JkA==
X-Gm-Message-State: APjAAAVF20xayLdTRHePdmdQF6DhOhoeessn8uqxcnIMz6rj/d//Xq/l
        ni1gqr8HGVABKzbV8R7dJg8lI0I/9rrXsSycvus=
X-Google-Smtp-Source: APXvYqytlYAI6W2spqeb1WpBo7ssJFoSWLbwNHcCytR9HM/oOddQzTiQfwmrCoFuNLRCy2CcgI0WJA7XG3lmKrN6Ib0=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr26110089ota.145.1575990403554;
 Tue, 10 Dec 2019 07:06:43 -0800 (PST)
MIME-Version: 1.0
References: <201912101605.WSMiIcKr%lkp@intel.com> <CAMuHMdVUS+=k0cK-Z9x8JAS=p3BauPXm6C2EmV-umsJDQc1qMg@mail.gmail.com>
 <af7a7385-4980-ab18-6c91-29ba463a3cde@c-s.fr>
In-Reply-To: <af7a7385-4980-ab18-6c91-29ba463a3cde@c-s.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 16:06:12 +0100
Message-ID: <CAMuHMdX86AYi-901H8V1NmuRmA9vLefS57AW0v8Uakuu+COqrQ@mail.gmail.com>
Subject: Re: [spi:for-next 1/2] drivers/spi/spi-fsl-spi.c:749: undefined
 reference to `of_irq_to_resource'
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     kbuild test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>,
        kbuild-all@lists.01.org, linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Christophe,

On Tue, Dec 10, 2019 at 3:57 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Le 10/12/2019 à 11:46, Geert Uytterhoeven a écrit :
> > On Tue, Dec 10, 2019 at 9:10 AM kbuild test robot <lkp@intel.com> wrote:
> >> It's probably a bug fix that unveils the link errors.
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> >> head:   d661a226ebf2961631a3961f2463f5db1b132430
> >> commit: 6f2e2fffd91fd9b4364fbefb78ebbe46d05b0bdd [1/2] Merge branch 'spi-5.5' into spi-linus
> >> config: sparc64-randconfig-a001-20191209 (attached as .config)
> >> compiler: sparc64-linux-gcc (GCC) 7.5.0
> >> reproduce:
> >>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>          chmod +x ~/bin/make.cross
> >>          git checkout 6f2e2fffd91fd9b4364fbefb78ebbe46d05b0bdd
> >>          # save the attached .config to linux build tree
> >>          GCC_VERSION=7.5.0 make.cross ARCH=sparc64
> >>
> >> If you fix the issue, kindly add following tag
> >> Reported-by: kbuild test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>     drivers/spi/spi-fsl-spi.o: In function `of_fsl_spi_probe':
> >>>> drivers/spi/spi-fsl-spi.c:749: undefined reference to `of_irq_to_resource'
> >
> > config OF_IRQ
> >          def_bool y
> >          depends on !SPARC && IRQ_DOMAIN
> >
> >> vim +749 drivers/spi/spi-fsl-spi.c
> >
> > The driver should depend on OF_IRQ.
>
> Right. That's independent of the present patch though, as the fonction
> irq_of_parse_and_map() that's being replaced by of_irq_to_resource() is
> also depending on CONFIG_OF_IRQ.

That one does exist on SPARC, and has a dummy for !OF_IRQ:

include/linux/of_irq.h:
#if defined(CONFIG_OF_IRQ) || defined(CONFIG_SPARC)
/*
 * irq_of_parse_and_map() is used by all OF enabled platforms; but SPARC
 * implements it differently.  However, the prototype is the same for all,
 * so declare it here regardless of the CONFIG_OF_IRQ setting.
 */
extern unsigned int irq_of_parse_and_map(struct device_node *node, int index);

#else /* !CONFIG_OF && !CONFIG_SPARC */
static inline unsigned int irq_of_parse_and_map(struct device_node *dev,
                                                int index)
{
        return 0;
}
#endif /* !CONFIG_OF */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
