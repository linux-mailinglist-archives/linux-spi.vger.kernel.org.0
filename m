Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5411F9B26
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgFOO6x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 10:58:53 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:36625 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbgFOO6x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 10:58:53 -0400
Received: by mail-oo1-f67.google.com with SMTP id 18so3417476ooy.3;
        Mon, 15 Jun 2020 07:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AN9KQGotbKGW++UwmQvDIEa7aWiWGa/azjs8CdJeMXk=;
        b=Za7lIpqo00q5KHlMIruVAEK1Ssaw81rNcHzq/bA7of7+6b4sV3VHdS5cIeHinfu8UC
         2YnUdgE5IULCQ41dykbfa9PziutfyIjfm0fuzd5oOzyDZNJMhhGJMHJgFQPvI8++yZwh
         Xy1wYmWg2o57ewouZe0kGPyXIUAQtaxD0DYImBYAoReToe/YYehTtERHugvA8PqqB3ul
         MNYO5GdADr0d0X6MryCEq1fXt4QjOhHXcuh4kEU4OkjrgTcWdXymUKuABkICdkT4FnNw
         DQJR/Z/vR04pzGOEFJanN2vyXG40xhwfxXLqlTj4n0o4LFx1pvn1WR8ye8W7GZUUAb0a
         snuw==
X-Gm-Message-State: AOAM532ZCIzPFfbW/jwrJlwKmHPsHT6WevmmIf6wXIVwTkH6jHx7y+e/
        snzKHmcjmKmjvQg0GxwDnS1bnG6w0zykjRBV6mQ=
X-Google-Smtp-Source: ABdhPJwuyc9zbIxpxawYDchohAuiWrIiIb+qu+KSLkc5c2oPql5wLN10T4OQOiIpCs4ew5Xt65PfrABNBVo7hMoPwBU=
X-Received: by 2002:a4a:db4b:: with SMTP id 11mr21824324oot.11.1592233132690;
 Mon, 15 Jun 2020 07:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200613073755.15906-1-geert+renesas@glider.be> <20200615144215.GA19492@sirena.org.uk>
In-Reply-To: <20200615144215.GA19492@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Jun 2020 16:58:41 +0200
Message-ID: <CAMuHMdWYE2ZsERvXuw4LL07A5k+Tt5Wj8hkYx8UMbFSkC6ADKQ@mail.gmail.com>
Subject: Re: [PATCH] spi: uapi: spidev: Use TABs for alignment
To:     Mark Brown <broonie@kernel.org>
Cc:     Qing Zhang <zhangqing@loongson.cn>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Mon, Jun 15, 2020 at 4:42 PM Mark Brown <broonie@kernel.org> wrote:
> On Sat, Jun 13, 2020 at 09:37:54AM +0200, Geert Uytterhoeven wrote:
> > The UAPI <linux/spi/spidev.h> uses TABs for alignment.
> > Convert the recently introduced spaces to TABs to restore consistency.
> >
> > Fixes: f30e8cbdf8ee1a43 ("spi: tools: Add macro definitions to fix build errors")
>
> That commit doesn't exist?  I think you mean 7bb64402a092136.

Indeed, I stand corrected.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
