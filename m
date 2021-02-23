Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75DD323042
	for <lists+linux-spi@lfdr.de>; Tue, 23 Feb 2021 19:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhBWSI3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Feb 2021 13:08:29 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:32849 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhBWSI3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Feb 2021 13:08:29 -0500
Received: by mail-ot1-f54.google.com with SMTP id c16so16559360otp.0
        for <linux-spi@vger.kernel.org>; Tue, 23 Feb 2021 10:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJC41uj2PpVZYS8ZrypliNOrjVrALIbDACe38HQbpe0=;
        b=CXa5vp4FYXF1MBt4gQJt0ZIZYMVBwCuNuLA938eOaZVlvh4VHuYwJHprNjIl+ca2Ky
         2cHux3Sehrt9dFLyT90HW6odTJvE6lx7/khgtPcV0xjdiAxMM72/hrbZZpj+aRCzc0hO
         mgF24tDC3AZLL0X6msOxFRunQ5IDF6wx9OZ00fkTttlOzVEdYeU8vU0dmHMzQBAy/4aF
         ZAEFFJGz2LWRhE0+VzH0JJ4OUuUn4hb1fF9LpjijoBNgdnm92NyIKUkIjFvB0MYyS6mS
         KQvJUKf0ZHWQaYPnyMQT4ulvc68RcVz8GQz8tsAoc6OK9YFLFPxqUos8gy7sdMEX6krd
         zLEA==
X-Gm-Message-State: AOAM5323IMWIjzNQga2YIyxoeoPznesycfodntDeOH6ILMsXGYoFNlwg
        R+G9Nhqmh5kH6nPZag5l4gFlPsbhuNwUi05X+ZWKrlSfkkg=
X-Google-Smtp-Source: ABdhPJy39Q4RNfyXx9Fl6r4sFKRG/1VC3igCpLK13X1CD9+hSAxjZ5QPPeB+USoxzPBCi8FwPi3lUkr6goSzhiRZnNY=
X-Received: by 2002:a9d:77d6:: with SMTP id w22mr21544277otl.145.1614103668840;
 Tue, 23 Feb 2021 10:07:48 -0800 (PST)
MIME-Version: 1.0
References: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
 <1612517808-10010-2-git-send-email-zhengxunli@mxic.com.tw>
 <20210205104736.2771074c@xps13> <20210205133404.esqqeokhlp4askpq@ti.com>
 <20210223141344.7ad25831@xps13> <20210223133649.GD5116@sirena.org.uk> <20210223152504.jtq4uxfepz7bdxhl@ti.com>
In-Reply-To: <20210223152504.jtq4uxfepz7bdxhl@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Feb 2021 19:07:37 +0100
Message-ID: <CAMuHMdVQUCaiBwdU=KdFOu=D71kYbGqoqp9V3pLsXXE0AAdCog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: macronix: add support for Macronix octaflash
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, "R, Vignesh" <vigneshr@ti.com>,
        juliensu@mxic.com.tw, ycllin@mxic.com.tw,
        linux-spi <linux-spi@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        zhengxunli <zhengxunli@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

On Tue, Feb 23, 2021 at 4:25 PM Pratyush Yadav <p.yadav@ti.com> wrote:
> On 23/02/21 01:36PM, Mark Brown wrote:
> > On Tue, Feb 23, 2021 at 02:13:44PM +0100, Miquel Raynal wrote:
> > > Pratyush Yadav <p.yadav@ti.com> wrote on Fri, 5 Feb 2021 19:04:04 +0530:
> >
> > > > [0] Since SPI NOR has no way of knowing what speed the controller is
> > > > running at, assume the fastest speed the flash can run at.
> >
> > > Ok, I am not entirely clear about what is available/not available from
> > > the SPI core.
> >
> > > If this is true then I guess we can't do better with the current code
> > > base and this can be improved in the future if needed. So I'm fine with
> > > the current implementation.
> >
> > For normal SPI operations you can set the speed (really, top speed) on a
> > per transfer basis.
>
> To select the optimal number of dummy cycles we need to know what speed
> the controller is running at, not the other way around. The flash would
> always set the top speed to its maximum (say 200 MHz). But if the
> controller is only capable of running at 50 MHz, you will end up wasting
> dummy cycles. I don't see any API to communicate speed from controller
> to flash.

spi_transfer.effective_speed_hz?

If the driver has filled this in (after the first transfer), you can optimize
dummy cycles before doing the next transfer.  Note that effective_speed_hz
might not always be the same, if e.g. the SPI controller shares its parent
clock with another component.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
