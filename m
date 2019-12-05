Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE2113C4B
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2019 08:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfLEH1g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Dec 2019 02:27:36 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36186 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfLEH1g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Dec 2019 02:27:36 -0500
Received: by mail-ot1-f42.google.com with SMTP id i4so1772471otr.3
        for <linux-spi@vger.kernel.org>; Wed, 04 Dec 2019 23:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pw4WZcfphzCIzhgoRD2Vp3ZAYrP3HBw25b8UxRdaKd8=;
        b=ksz8sxnwTt6EqNy17D9I6rQBRR77F2DIox2uC0l+a9AODnOc099RXnfUrOQaF4S0Wi
         ck9afS4ijO9uW9C9whCXq0f+lpe9v/9dpreuO5N6kcEUVDTbw8JFFC4/PNiTyEVwRDgS
         7nVEaa/7Qlv9A09dvw449AANgzSILKIefnVD7DH3OdvNpgIaBrRUJQDnhscVex5SVkfv
         091nahI6oQXmdmmR5E1RBgd4t1R+ko47gBr432k8ATg2blqXv8zcGZiOUhP/FwsqDVh1
         VQDqulp7ywaaE6WIr8v7MimxsIBe5YSY+nd/7Sm1EveF8Hv+iE6baehgw5gyh51oNfsm
         Me9A==
X-Gm-Message-State: APjAAAW/44Q1dCJp9jqWe6Lso7hk8zoxonWULDKLNQPvXMWPkirCc5yk
        PglTT+mCD/tvGKTDBwU5iQp9T0f0N21bz+N+BMs=
X-Google-Smtp-Source: APXvYqzPrmk9ff91NtbYQS9Y/ocMlPBzmXUcgeDKzX2+flvXR9Ts+wSM51OIwXz87ej0u1MDmd6ODMTIm/xCzR+HtOY=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr5566725ota.145.1575530854987;
 Wed, 04 Dec 2019 23:27:34 -0800 (PST)
MIME-Version: 1.0
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
 <20191202134344.GE1998@sirena.org.uk> <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
 <20191203163521.GM1998@sirena.org.uk> <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA@mail.gmail.com>
 <CACRpkdaxXKMqL4Y8yFu+U7WhpXgq6Yr+hx4rYd3aDzc+-dLDFw@mail.gmail.com>
In-Reply-To: <CACRpkdaxXKMqL4Y8yFu+U7WhpXgq6Yr+hx4rYd3aDzc+-dLDFw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 Dec 2019 08:27:23 +0100
Message-ID: <CAMuHMdW=eoOiuucv8-p7gs=u9QK_W_Onpu37fq57xU6f+0r0qg@mail.gmail.com>
Subject: Re: Side effect of SPI GPIO descriptor usage
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Phil Elwell <phil@raspberrypi.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Linus,

On Thu, Dec 5, 2019 at 12:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> drivers/rtc/rtc-rx6110.c
> Prints a warning if not flagged SPI_CS_HIGH, wil print
> that warning if used with a GPIO chip select from device
> tree. No regression, also no in-tree users.

So this warning will trigger if the board designer added an inverter, e.g.
to make it work with an SPI controller that doesn't support CS_HIGH...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
