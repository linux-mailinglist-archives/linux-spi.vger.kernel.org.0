Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B581F8199
	for <lists+linux-spi@lfdr.de>; Sat, 13 Jun 2020 09:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFMHdn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 Jun 2020 03:33:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44380 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgFMHdn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 13 Jun 2020 03:33:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so9159360ote.11
        for <linux-spi@vger.kernel.org>; Sat, 13 Jun 2020 00:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+quWnbfUaYV+MLwJZ1Tn3VvejUBEHpZGReawVyBEpI=;
        b=SHYXExEjPmhRfosl4FfJNgDSUPx0kfrboej6Ej5CSRgkPtx1vkw3zww69jc9HnuHkb
         4t2+4TlTjkTlPoVg4EZCTufuKc+bB3dEeOCdB0HkoBItESarpTrCOl2DeKrb/4TwsFJj
         qCuFp/6i7dXu+KIF9tLajFLzWMAf/c+FHSjxYfogtkKi361g0dmGPyp5CNb8EpgZ3EmW
         myP/Xmr06483/ANGQfAS6V3wnM7HoRTdY6179B/DmdJwYJmPPV1e1DYy2QTvFtEis4Wj
         wXDNAYGf+6doFSh1ki14sGwz4YJrjcYfot3eTNcu+Dr+hYNd2pXAMB5Jv/o0V6vhuY9Q
         i5fA==
X-Gm-Message-State: AOAM5338tnLj4S+TF4sL+kC0jCLJPeSs0245EjNNf2Oasdrxs42yb9Yp
        jeCQhjH+FY1KRYu76ipqFF5LUqN9JEaEOZ6pyH86HFbr
X-Google-Smtp-Source: ABdhPJzuSKaE0iuCYeI5eH2dyLQuPDo+7ZcNC6RTJ1oMBhRbMdaYQf1o2jynq6pbxwl7jdQ0V09o40+rPftHFRvYYlQ=
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr13894031otp.250.1592033622755;
 Sat, 13 Jun 2020 00:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <7cddc1a3-f3a8-37dd-487a-cd2274b7941c@fastree3d.com>
In-Reply-To: <7cddc1a3-f3a8-37dd-487a-cd2274b7941c@fastree3d.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 13 Jun 2020 09:33:31 +0200
Message-ID: <CAMuHMdXzErU5z69=2gks5ySutkGw98O6+f7weiuPUp8uqTx63w@mail.gmail.com>
Subject: Re: [cadence-spi] daisy chain
To:     Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Adrian,

CC Lukas for #daisy-chained-devices

On Fri, Jun 12, 2020 at 6:26 PM Adrian Fiergolski
<adrian.fiergolski@fastree3d.com> wrote:
> I have a daisy chain of three ltc2634 slaves (iio/dac/ltc2632.c)
> connected to a single chip select of the cadence-spi master. I have the
> impression such a configuration is supported by none of those two
> drivers. I could try to extend both, however, I haven't found any other
> SPI driver, where I could find implementation inspiration. Is it
> supported by kernel?

drivers/gpio/gpio-max3191x.c supports "#daisy-chained-devices".
drivers/gpio/gpio-74x164.c supports multiple shift registers through the
"registers-number" DT property.

So both drivers handle this in their SPI slave drivers.

Of course this does not handle the mixed case, i.e. daisy-chaining
different types of devices.

> The documentation mentions only about the common 'daisy-chained-devices'
> property (devicetree/bindings/common-properties.txt). However, in order
> to try to implement it in the master driver, IMHO, the spi subsystem
> would need to have a call 'no-operation' to other nodes on the
> daisy-chain, which are not addressed by the given SPI access. Is there
> any recommended approach to address this case?

Supporting this in a generic way would indeed be nice, as it would mean
individual SPI slave drivers no longer have to care about it.
However, that may be difficult, as the master needs to known which
dummy (no-op) data is safe to shift through the non-addresses SPI slaves.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
