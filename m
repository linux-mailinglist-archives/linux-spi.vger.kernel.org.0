Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE022C2049
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 09:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbgKXInn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 03:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730608AbgKXInm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 03:43:42 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422A0C0613D6
        for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2020 00:43:42 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d20so11829790lfe.11
        for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2020 00:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaOgVY3DT0axuPXm6Wf+nM+h8FcaH7ypPyzww8UGHiA=;
        b=lN5cc08a6CagxJpTMEus4nk8yN3LrNsf+6Fb1xG5jouQm5lQ9g0JNVT3AHjCbW1gGc
         QZkNd5wSRX8H/RmI0c/v09Ybd/WNDgtW0kdaD+AgYuFVr8nmG3xf0OnUfQYzhIUoBqcJ
         58A6Es0AU2RwJdzQ6Orj1gQLa5+/TmY8nOPDyKFDS6qPBMf+VEf8q37y8s87PeJ3/zaX
         iw6Pk8tGJZ7z6d1jfUBwNgdYEpQALn309O3FCy8sp9marTgkYzjLRqK8dVeMeCFJLX35
         PROf7S91HkoVlyMjJfFPWGroDxuBaltHv6OTVKyUJDYOEXywsQ1ze9tfB76Oh+0Q260U
         c9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaOgVY3DT0axuPXm6Wf+nM+h8FcaH7ypPyzww8UGHiA=;
        b=ZchfyM/5/GrW5swEU8lTP0qejnIj1jqiGBMxjay6d++N9hfnvt6hgP9ODa1rzGbyf7
         31nlx25L18XOEGS5R2iUxXNWUsuQatk6qgzWnJN8w7xMSYVN2z4HLhF3KSDiNI6CB1jY
         qx5BjF/RKDrXSpkghtsFC8xHjOL7l3WVpwDZqvou3bJeUOwpJmHUSg5PAS7bHH7PQq+l
         +0KarXtqEOQJY3zbAwMR6X02rwEZMlXUN+8u0CEaciH/GsJDdxcIMQpLxV8IwYOUQDmp
         W77rLkjVf+D8Jd9iuE3SrqNlu5m0fLOyXBQvJYUmLzH+vc4Ewo/g6VrLJJR/YcHB03Lc
         Jk3g==
X-Gm-Message-State: AOAM533Yg9lX9lOBgfRAieGJVXbnFB5Pe6qlu8D5ed3eAoTj7tMC+LUa
        qAxKY19dZvUyt3gQEJm0ZZrtJMjemD8yHblw2pLK/Q==
X-Google-Smtp-Source: ABdhPJwfslqVfk1bAlpxvLALOaiPyZkEzCXcFjklOgHwERbpK3OuBSxE/8+9JiCpkPggMPoqlydmwwG1XchrhzX2p5A=
X-Received: by 2002:a19:8686:: with SMTP id i128mr1245870lfd.333.1606207420757;
 Tue, 24 Nov 2020 00:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-21-damien.lemoal@wdc.com>
In-Reply-To: <20201107081420.60325-21-damien.lemoal@wdc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Nov 2020 09:43:30 +0100
Message-ID: <CACRpkdZhOxz5NhrkFxZ5G4aOrmBoAcQodOvqzNROQtXpHVQGDQ@mail.gmail.com>
Subject: Re: [PATCH 20/32] riscv: Add Kendryte K210 FPIOA pinctrl driver
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 7, 2020 at 9:15 AM Damien Le Moal <damien.lemoal@wdc.com> wrote:

> Add the pinctrl-k210.c pinctrl driver for the Kendryte K210 FPIOA
> (fully programmable IO array) to allow configuring the SoC pin
> functions. The K210 has 48 programmable pins which can take any of 256
> possible functions.
>
> This patch is inspired from the k210 pinctrl driver for the u-boot
> project and contains many direct contributions from Sean Anderson.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

The kernel build robot is complaining about this patch so I'm waiting for
a new version.

Would also be nice if the maintainer could add some comments?

Yours,
Linus Walleij
