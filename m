Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 044B3E6A88
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2019 02:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfJ1BiN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Oct 2019 21:38:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36802 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfJ1BiN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Oct 2019 21:38:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id bm15so6625842edb.3;
        Sun, 27 Oct 2019 18:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zncCQd975Gz2HvK2SjXCCS9OAbsNjkyZCeZT6yaW7zQ=;
        b=MJFVIuDrAyz9pDLgpUUl9PU1eZbzKuPQNiEAzcQW1qYjBZjuoWDjrqGy9uWwBC66Cd
         dI3yEdlYrJi9nlHlHzafl7i8WvKj/XLHxPbDWEtsBpUBMumEUFvInIYQnVTLK+ti+7tO
         BA7mgqjIeTWS1O1WIN27xKabnFwlPMrDCiIPvQUPLPAq7HMw8gsza012bODYpDuy2/vD
         taxlG8IqDmUdHTSnMyFv5PMGM92EtSdVF5rDTJo3CJh1YqlOtU4Zj+9HaR42o5jK8e3s
         jenl27VKb6t9BWfqRxFCO0FEO8G9hJFf5yNF0aRrMh28ErjfYLPp42bc4NbualuBRcp/
         eA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zncCQd975Gz2HvK2SjXCCS9OAbsNjkyZCeZT6yaW7zQ=;
        b=DFGzwfx7yteJn42AglkjGVDhQhojYv2DjzleECKTqc+pztvOGPfEXA2d/5tk0/DXf3
         HefSkC8lA/107Ewu5E22Y0uIfSTrESpKRjVSwlgoXCvMW+cgMZ0qdSLfOE+5kLm9Alhm
         /4MM0aSIw9E3u2qXLBQQoKrrOPbeA3HNcsW5+atPv1nzMQ2/8pZgebnfjEnKzOY5fjOX
         9UINNcm0IVC647VWr5Vzm+iavjy+EBhq7MsYZS6DS975daPXxiM+C4Fd/LkwpuosR5eR
         UA9zAcynxlZDh1L75MPCDbVhvCXK7W7pKxHG4x74cC+PXN++eZDivoxyPJlbCIYylIto
         fSIQ==
X-Gm-Message-State: APjAAAW29Is33njqt1Ai7j8xIc+++cMRXFCaEr5PkdeZyamW+iAz96H+
        op0WMfVM4sbGdlkNso32CAYkfylr1hBmYe8yGmaskbsfjpE=
X-Google-Smtp-Source: APXvYqzgnaDiUcH3IYDfQVBOpeExgcPu32wDgAZkOKAPutypEopBXKs6avGlVlBxf+yhnsEi3FfGHSOF7QMkbQk2/Ug=
X-Received: by 2002:a17:906:1d4d:: with SMTP id o13mr10006173ejh.196.1572226690648;
 Sun, 27 Oct 2019 18:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191017025058.31528-1-hslester96@gmail.com> <CAHp75Vd2SMERjtvNumxAF1HSp8GSThmcyx96zkFzUXKwnD5d2Q@mail.gmail.com>
 <CANhBUQ2yxGbjk_DgXbip=TPT=evzA5naoJSY9t1_Ep47e9oupw@mail.gmail.com>
 <CAHp75VeLyTi=gqfNr-=Tg36yQs_fYG__iQAxAEKdks0mqsTbug@mail.gmail.com>
 <CANhBUQ1CnCHiY8tkCMcXZ3DAPcfnQZgfA_Fj4qf3yYBKGg10Wg@mail.gmail.com> <CAHp75Vdb19w02zKHo1tqAtF8TmT=z6Ye2YFfxVw_TGtO3VxfLA@mail.gmail.com>
In-Reply-To: <CAHp75Vdb19w02zKHo1tqAtF8TmT=z6Ye2YFfxVw_TGtO3VxfLA@mail.gmail.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Mon, 28 Oct 2019 09:38:00 +0800
Message-ID: <CANhBUQ2WJaFrk5JBDbTjaTM5mv0ebwdcHBoR8ODm28X_mOukLA@mail.gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add missed security checks
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 18, 2019 at 10:04 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Oct 18, 2019 at 2:37 PM Chuhong Yuan <hslester96@gmail.com> wrote:
> > On Fri, Oct 18, 2019 at 7:14 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Oct 18, 2019 at 1:39 PM Chuhong Yuan <hslester96@gmail.com> wrote:
> > > > On Fri, Oct 18, 2019 at 5:35 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Fri, Oct 18, 2019 at 8:59 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> > > > > I'm not sure they are mandatory for all platforms.
> > > > > To be on the safe side, you simple need to add _optional() to the both
> > > > > call along with above change.
> > > > >
> > > >
> > > > As I know, this is the only one in spi which does not have a check for
> > > > devm_clk_get.
> > >
> > > For some it still may be optional. That's why better to check it and
> > > mention in the commit message.
> > >
> > > > Even if add _optional(), they still may return errors and need security checks.
> > >
> > > Of course, see "along with" in my previous comment.
> > >
> >
> > Got it. I will send version 2 in which both _optional() and security
> > checks will be added.
>
> Let me be clear. I didn't check if _optional() needed or not. You need
> to investigate this before sending new verison.
> And in either case this should be explained in commit message.
>

I have checked this file again and found ssp->clk is used by clk_get_rate in
pxa2xx_spi_probe.
Therefore, it should not be NULL and _optional cannot be used here.
Besides, ssp->irq is also used in pxa2xx_spi_probe.
Hence, I think this patch is fine.

Regards,
Chuhong

> --
> With Best Regards,
> Andy Shevchenko
