Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A133564AF
	for <lists+linux-spi@lfdr.de>; Wed,  7 Apr 2021 09:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243875AbhDGHAy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 7 Apr 2021 03:00:54 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:33665 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhDGHAy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Apr 2021 03:00:54 -0400
Received: by mail-vs1-f45.google.com with SMTP id q4so3802067vsm.0;
        Wed, 07 Apr 2021 00:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ch3mktnaaoSwaqAPTJ1Z21NOePYOqwtf3Uxq3fGcLqU=;
        b=SbXEJS9qJIa2XsUhKAsTOGj5FDvhetAyTz1KFMFH2FzrNMeD0YJgP91Ydz80RZ9/hB
         ZKmYEWVvRHJO8fBfcpD6npNKiqlyyOIN6jZKgRCaGtIAZNPnIekPRydPwWQicP7fJXwR
         qrg++4rWOPd+fZr/Wxr2T+bAxZHgSov22kuWRHg2jnal0filYuP9KdiK1C/M+1ktVqB6
         MdH1NfA/Z/y/cGs+HroMvXbd8NXNLE/sLo95Cgfjfgx/RDbIk1bHMRb9yljUdWIion8q
         RNrZuK8ERY5WUDZ+4OccZxtFV6fjos9iisBNQEzKyzjMP06kFwLlcMQhp8PjFFF2CAp/
         crRA==
X-Gm-Message-State: AOAM530P8pLuId/6LBEZBmCli7P4CgpDBEff52HcVFyey99OonGOBdsO
        L0PWxSmSUZ4Jzh3uoEkaPDNKkluSShWulpunlVuf65WT0PE=
X-Google-Smtp-Source: ABdhPJzi1MUzRRoF+PCOYuZGoNmbYewNjr6akQpTTEBI0/nG0U5EYi7E9txeWJ8EHRgxaV24NEvF63E5QSh5n4tQQCs=
X-Received: by 2002:a67:7d02:: with SMTP id y2mr994951vsc.18.1617778844953;
 Wed, 07 Apr 2021 00:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210330181755.204339-1-u.kleine-koenig@pengutronix.de>
 <20210330181755.204339-7-u.kleine-koenig@pengutronix.de> <20210331120212.GB4758@sirena.org.uk>
 <20210406065727.i7wbve2ihdblq24p@pengutronix.de>
In-Reply-To: <20210406065727.i7wbve2ihdblq24p@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Apr 2021 09:00:33 +0200
Message-ID: <CAMuHMdXD3UgbLWD2pEc-Y=OstdYn0riuBaXFZvwZMQ0Xem6soA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] spi: davinci: Simplify using devm_clk_get_enabled()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Uwe,

I'm not Mark, but I'd like to share my 2€c.

On Tue, Apr 6, 2021 at 3:43 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Wed, Mar 31, 2021 at 01:02:12PM +0100, Mark Brown wrote:
> > On Tue, Mar 30, 2021 at 08:17:55PM +0200, Uwe Kleine-König wrote:
> > > devm_clk_get_enabled() returns the clk already (prepared and) enabled
> > > and the automatically called cleanup cares for disabling (and
> > > unpreparing). So simplify .probe() and .remove() accordingly.
> >
> > Acked-by: Mark Brown <broonie@kernel.org>
>
> Thanks. I wonder what you think about this series. Is it more "Well, ok,
> if you must, the change you did to this spi driver looks correct." or
> "This is a good simplification and a similar change for nearly all other
> spi drivers that make use of a clk is possible, too. Dear clk
> maintainers, please go forward and apply this useful series."?

While this simplifies drivers, this makes it harder to add power
management by controlling the clocks through Runtime PM later, as that
will require reverting the s/devm_clk_get/devm_clk_get_enabled/ again.

At least the Keystone series already uses PM Domains, but I don't
know if that includes clock control.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
