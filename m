Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357601DD2A6
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 18:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEUQCo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgEUQCo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 12:02:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1224BC061A0E;
        Thu, 21 May 2020 09:02:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s69so3289810pjb.4;
        Thu, 21 May 2020 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BLwnYkqoaG4VSk3NtlQU7fBYhqtOMjc6lr5gP631Rc=;
        b=dWqsN7OmQL0R0obRqAungpLixVGrXzEeLC0is7oEl5MRLcfRQlmWFNlaS4ppUECPny
         Gqr9X9njPV6p9RTEBXlLoFxCToW39ej2ntTRhpzaygCIKMSz37au8z9wA/fFuWkna7a+
         zUG/5+GIUE/1ydmEQGjiNZlwS1+qJvJV2wtb4yG7uvRzPbDFBQbMIWmgkpVmCJsCzTfY
         JxjMFHvjXUiJZ8D6vbqWOECMx94pEznfElX8HLj5hoRNMKeqTfGZ2qjYjB6ekl/hDu0N
         AipVm8Kk7vgP9d5ClaREUxqt+n+cIygUW/h5rIqjufYW+yJmhmCPJgqw+ArO1nsTQDlF
         snCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BLwnYkqoaG4VSk3NtlQU7fBYhqtOMjc6lr5gP631Rc=;
        b=j/qzdGpKrRybQAyHeh3kVDOIqCVuJ9LVXBCAmrdEYxLv4hv0uc2kG6n1Il427SmZgh
         T9GaXfsKnK/w7m71XeKqRCSFjywF0IsrzSba1rrVG+hjNQuqj3evc5w+Eq2jbdpG8Alb
         w6di9/Q13rjMu8LNbwclyasJzIZiUNEZl2R/TvUCSyZNTxdUB1UJOstTNCkDlFeP4k6D
         n4JBO/inhI/XuGnJLlz35XfJgFdbW8ICTZZ2oBW/cttdctERtyTNjD4WANChBJGN/ULW
         6pEKtVxM3WsTyuPgEAH5Syw/invR1ssXu+sKABqObAGz2zpotacyL5nO3k5ErPj/lyoW
         913w==
X-Gm-Message-State: AOAM531NHW91hS8qaeCKJ+76VZtdrq+sfVys1fIVWi7p5TEHpCfphUap
        2+LNQ2L4JR/8du9D2x18pu54SuoMOnk2mGvRz4s=
X-Google-Smtp-Source: ABdhPJwucelyYO7GsggYWr7ec9Pafxw6XccHHHJtfTTflZIfh2CR8isb1SxBpC43l5TtiraVelVG3AyWY6t8Sawq8Vg=
X-Received: by 2002:a17:90b:113:: with SMTP id p19mr12591489pjz.129.1590076963484;
 Thu, 21 May 2020 09:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-4-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VcOX-hZSxHqro_W2X=KzSShg1V=jAsxdz8L5TZpW0kBYA@mail.gmail.com>
 <20200521121228.aqplh6eftylnys3p@mobilestation> <20200521155143.GE4770@sirena.org.uk>
 <20200521155804.qgaaqc23h2nll7r3@mobilestation>
In-Reply-To: <20200521155804.qgaaqc23h2nll7r3@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 May 2020 19:02:32 +0300
Message-ID: <CAHp75VcY9HG3=wft9VFWKJD9PG6TiSbmOyjgYZyue+z3PW_eCQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] spi: dw: Discard static DW DMA slave structures
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
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

On Thu, May 21, 2020 at 6:58 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Thu, May 21, 2020 at 04:51:43PM +0100, Mark Brown wrote:
> > On Thu, May 21, 2020 at 03:12:28PM +0300, Serge Semin wrote:
> >
> > > Well, for me both solutions are equal except mine consumes less stack memory.
> > > The only reason why your solution might be better is that if DW DMA driver or
> > > the DMA engine subsystem changed the dw_dma_slave structure instance passed to
> > > the dma_request_channel() method, which non of them do. So I'll leave this for
> > > Mark to decide. Mark, could you give us your final word about this?
> >
> > Honestly I'm struggling to care either way.  I guess saving a bit of
> > stack is potentially useful.
>
> Settled then.

With whom?

> Let's leave the patch as is.

Mark, should I send a partial revert afterwards in this case?
I'm not fully satisfied with it.

-- 
With Best Regards,
Andy Shevchenko
