Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B19E0473
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 15:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfJVNDb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 09:03:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44694 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbfJVNDb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 09:03:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id 21so14041095otj.11
        for <linux-spi@vger.kernel.org>; Tue, 22 Oct 2019 06:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/DLC2DNu3Rt6IJVip2qVqpyLqNGx6oK52nNG4NVR2s=;
        b=ZabSGeSENakGvf8UxMNAAMINqPgNg2ZYiYFsfEXheQz0EzJ907tuWgYy+FzHSzQkLH
         6q63kA9NrzBkMEuHhcyLKKWqkWQU/bHJpqXy1hcU9XjjNg3Jm6o7R4spszVwr+qK5Wlx
         YMYhjHkvRuqWALfAZ+BVA8zf2K9gX/bXW1byLpTxWiqYKeEnzbFhkbQlqnWuRMzJWW8r
         Oh4t9Lht7F305dYdBfneYjlyuAZjnx9f+CpnNwwAEt7WKBIxHdMSmK+kym4+WOXZc7so
         YeSuoRZhjXmX1eJgM4jaPWyLnut5vIVIUuPGQYCHalCtdNyhaq0Qd5fELimv8PKcMPhT
         /vUA==
X-Gm-Message-State: APjAAAWZgVynynQ7LIa6MWfVc1L6zSeIYveVvaafnrPVWImw6s1BEpxs
        OP/51PpIeUk6HkedTijdOOEHxkR3MNdO1VYQFFMytYOD
X-Google-Smtp-Source: APXvYqx6d39A7IVHJ85uPE7lCiYz55jlgLNniUkBQC6ow9Pa5qOVirIQR6ucv0By7VDgj7S35SInq3sfffTh+Mj2AcY=
X-Received: by 2002:a05:6830:1544:: with SMTP id l4mr2610445otp.297.1571749409991;
 Tue, 22 Oct 2019 06:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191022090007.15147-1-alvaro.gamez@hazent.com>
 <20191022102007.GA5554@sirena.co.uk> <20191022102859.GA1928@salem.gmr.ssr.upm.es>
In-Reply-To: <20191022102859.GA1928@salem.gmr.ssr.upm.es>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Oct 2019 15:03:18 +0200
Message-ID: <CAMuHMdWavg_50DrKnSa5K9j4oxN5gn0RWGhS2yr42x6okHvLoQ@mail.gmail.com>
Subject: Re: [PATCH] spi: xilinx: Add DT support for selecting transfer word width
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Alvaro,

On Tue, Oct 22, 2019 at 12:38 PM Alvaro Gamez Machado
<alvaro.gamez@hazent.com> wrote:
> On Tue, Oct 22, 2019 at 11:20:07AM +0100, Mark Brown wrote:
> > On Tue, Oct 22, 2019 at 11:00:07AM +0200, Alvaro Gamez Machado wrote:
> >
> > >             of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
> > >                                       &num_cs);
> > > +           ret = of_property_read_u32(pdev->dev.of_node,
> > > +                                      "xlnx,num-transfer-bits",
> > > +                                      &bits_per_word);
> > > +           if (ret)
> > > +                   bits_per_word = 8;
> >
> > Any new DT property needs documentation adding but in any case this
>
> Oh, ok. If this patch is of any interest, then I should provide changes to
> the appropriate file under Documentation/, is that right?
>
> I was preparing and testing a second patch to add "spi-bits-per-word"
> property to children of the SPI driver, similar to the spi-max-frequency
> property and others alike, to fully support AXI Quad SPI core with different
> word widths. This also modifies the DT, so I guess it'd be better to send a
> single patch that comprises all these changes alongside the DT
> documentation. Would that be correct procedure?

Is this "spi-bits-per-word" a property of the SPI slave device?
If yes, it may be better to hardcode it in the SPI slave device driver,
as it is fixed for that type of SPI slave.

If not, perhaps I'm misunderstanding the purpose.

> > shouldn't be set in DT, it should be set by the client driver - it's
> > going to be a fixed property of the device, not something that varies
> > per system.
>
> But this is in fact something that changes per system. When instantiating an
> AXI Quad SPI core in a HDL design that's exactly one of the options you can
> provide. In fact, in the board I'm working with right now, I'm instantiating
> two SPI cores, one of them with 8 bits per word but the other one requires
> 32 bits per word, as the devices it's going to talk to have this
> requirement.

So you're instantiating two variants of the same "xlnx,axi-quad-spi-1.00.a"
controller, with different options?
While you could add an "xlnx,foo" DT property for that, an alternative could
be to introduce a new compatible value.
It all depends on how many options there are when instantiating such a
controller.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
