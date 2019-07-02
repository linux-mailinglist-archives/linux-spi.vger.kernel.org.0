Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D325D02B
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 15:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfGBNIo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 09:08:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43268 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfGBNIo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 09:08:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so11307556lfk.10
        for <linux-spi@vger.kernel.org>; Tue, 02 Jul 2019 06:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCLnVihBJV40vR9+YI3kcHij2GxU/X9F63wehIOuwKY=;
        b=n9af6sKxEBB3KYcBhut9/K984S2o+0PR1hieLrDTlrNJrtd59idbzmQE+rSaYbixH4
         +e69jGiH1C5GanbGYO/hq1QNVzX6t5ZdodBH0GFiGhcVki5JZYUgBuppX7QKNvntxt2S
         o+kDUphMf0Jn9A29f4YUOYwByhknBgM4ZkhnyXgYlNqIVjKMSrXwyi4qeFrmZxKPrQ09
         38B0RVjkMCfdKYgiaRSC4z3ahl6Lt4/zzCwPWIHZ19jChjmK799qdAZoGp9o/X5Jzkb4
         OYUCNwBq+Yq0bIUUk7wgZI7469oS20UMnO9Ng6tqIvt6tUteZOFjR0UGnclsXd82Bv+A
         lwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCLnVihBJV40vR9+YI3kcHij2GxU/X9F63wehIOuwKY=;
        b=rrr/G6gJ69p8G44XlSwnWT9rgG/oswFC64ORSKy/2P1tm3dQMM+tltxF1f+Ecvf00T
         RX9toDK0b3zj2gaAjVvNBD9FVwPoz514C6/zChmJ8UTakRBnbgu/Pt7317jD0tLQXJf1
         2+eFn/l1g7gFzt6bgCpVu05ipvAtKwEzC2G10ZZP/BjFmFJNVZWNhmptUSl/Ae3JpqMp
         nx3lBxjfwTjz/BEgCRxnUcZsn0SiNK1Jmk6RJoO7jjUps7X1hZWK111EUFiaO3SI/unQ
         uRWZSDK7A5/ZjwK923G0GA/7RQhbo7NXywZ/CQpyjd0crlnHCW5z3yCSpRfHDo8guXRS
         2gsA==
X-Gm-Message-State: APjAAAXE1zu8QoEmE79nuodGW3mu7eMbwG+uXQYp6nXxhWC98yKJlAXU
        119L6gqyFTzYFV4fdebPFfx8fafLPOC3Gaft+Q4EwA==
X-Google-Smtp-Source: APXvYqy3wczudnK80BGFtquagkYAX7CLB3YxSdn98grN7ftaoaJvFGlG9qJZ1AOdeEi+1xHXdLAg0K6hv7MMuZcfJHA=
X-Received: by 2002:a19:dc0d:: with SMTP id t13mr396014lfg.152.1562072922030;
 Tue, 02 Jul 2019 06:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190701172517.31641-1-linus.walleij@linaro.org> <20190702113914.GH2793@sirena.org.uk>
In-Reply-To: <20190702113914.GH2793@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Jul 2019 15:08:30 +0200
Message-ID: <CACRpkdbng1M=5BnzFuiubRaqM1Bu4eLxqKvb3fCQuqyKsVcBjg@mail.gmail.com>
Subject: Re: [PATCH] Revert "spi: gpio: Don't request CS GPIO in DT use-case"
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 2, 2019 at 1:39 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 01, 2019 at 07:25:17PM +0200, Linus Walleij wrote:
> > This reverts commit 249e2632dcd0509b8f8f296f5aabf4d48dfd6da8.
> >
> > After this commit drivers/net/dsa/vitesse-vsc73xx.c stopped
> > working. Apparently CS is not working because the reads
> > from the device is just returning just 1:s or just 0:s at
> > all bisection points, so it is a complete regression and
> > I think spi-gpio CS is essentially broken.
>
> Also I'm a bit concerned that nobody else noticed this - do we
> have any understanding of what the actual problem is?

I am trying to rootcause it, I suspect I was just the first to try this
on real hardware actually.

The users in the device trees in the kernel
mostly point to consumers like LEDs, displays and switches
that wouldn't cause boot regressions
instead you must observe more elaborate aspects of the system
so that is why the automatic test farms cannot see it.

Yours,
Linus Walleij
