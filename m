Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258341DD279
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 17:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgEUP4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 11:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgEUP4x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 11:56:53 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C71C061A0E;
        Thu, 21 May 2020 08:56:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so3529024pfa.1;
        Thu, 21 May 2020 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLjdHqDrd9wWktm9zc7kw926gJ/JO0FqXQQJQmrShF4=;
        b=dngjX3TeyNGA7sZM07y2jXFvvj1nmwPK5g8vLMbECNPRlMxTkgVDBCfRCm4xl/ZlPj
         l/gcF3rw74gdyfv3+GS++6F7GPZw+ufPa7T0RDiDlmgCuZBohxaJOeqBBAM19QW/Xu7a
         SZcyBeTokj5OhtoJ4ZTWiW6unl0K0rsEhLyixrl3PCsNs8LCtaQ1/BG1tIwuCWAvmgCC
         WwKIx0A+Pznggn96M82Rly1BHnJn1lNA+k7uEtAUl2o4Na0QoUw9+tDRjCyuPofuBx5H
         pKMdpjVcSG259KqzVsGPR5a9Cvuj8+bpfkP3zYPA+gQgZ70yB1Ma0eNTBWAb34NZjov6
         PtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLjdHqDrd9wWktm9zc7kw926gJ/JO0FqXQQJQmrShF4=;
        b=OzA00lIoS6txj72EcIRLkz859VpSlV9r++5ySqf9/bJuwSkGvMjBUJ2nM6JYdmVSmN
         wFFdq7Xh2VF42EmfUUCPoU2qb9M1q4PR8UyIbQJvEySeb0e1gAFM+OxsCJ/Kqn7ATzaN
         /aCRPcTmEgHNKO/duHtjE5xXcX8CuNeF8uIQ/uCJKA9w73GcQ/BRzYHnIQbW0/xI8pAn
         8qCqLBF7Bku8MVZloOp92/2j5I+fEpc40dAZB1T67/ie1HnkUGLitE/s75Am0lTQCXHf
         zIl2UA6E4+t4DmcfwUCF6GzVamOMlb3OwADvpzIvl0EcwVVoort4xh/Peg+TH/TMk+sA
         rKWw==
X-Gm-Message-State: AOAM532TNNKFlap9eFiBXCTSdxaGPLZDBrha3u7kzcs00Z/7pSHRjl2u
        pp966j3i82Om0Y42P1m57fEbL0EggYiG3i9h9hbS+OFkjAk=
X-Google-Smtp-Source: ABdhPJwY6fukj1moTBQBXDZlJMalh9K/lPhnjO7xxB26LRgOQffMoS4rcujl+Hw/ssJOO8QGT/pGOV5trEVGneTgPgs=
X-Received: by 2002:a62:2f43:: with SMTP id v64mr9786031pfv.170.1590076612340;
 Thu, 21 May 2020 08:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-4-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VcOX-hZSxHqro_W2X=KzSShg1V=jAsxdz8L5TZpW0kBYA@mail.gmail.com>
 <20200521121228.aqplh6eftylnys3p@mobilestation> <20200521155143.GE4770@sirena.org.uk>
In-Reply-To: <20200521155143.GE4770@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 May 2020 18:56:40 +0300
Message-ID: <CAHp75Vfw=4L+ogWzfD+6OLQf9NUJ5TNiGMBG-4fNrmFMe1y8Ow@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] spi: dw: Discard static DW DMA slave structures
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 6:51 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, May 21, 2020 at 03:12:28PM +0300, Serge Semin wrote:
>
> > Well, for me both solutions are equal except mine consumes less stack memory.
> > The only reason why your solution might be better is that if DW DMA driver or
> > the DMA engine subsystem changed the dw_dma_slave structure instance passed to
> > the dma_request_channel() method, which non of them do. So I'll leave this for
> > Mark to decide. Mark, could you give us your final word about this?
>
> Honestly I'm struggling to care either way.  I guess saving a bit of
> stack is potentially useful.

Yes, but OTOH dropping maintainability by this is worse in my opinion.

-- 
With Best Regards,
Andy Shevchenko
