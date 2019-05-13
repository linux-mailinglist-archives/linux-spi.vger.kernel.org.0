Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1101F1B0C3
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfEMHFH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 03:05:07 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35950 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfEMHFH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 03:05:07 -0400
Received: by mail-vs1-f68.google.com with SMTP id c76so7349349vsd.3;
        Mon, 13 May 2019 00:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gXmxzF/Po14uQPLggz4c13bFBQQgBSLY5M86BA4rHg=;
        b=Jxq+qTXEvj2MfT8eJ8De8dK1yRKJhLB01iIFZJCztitgZ6LadyEqdEArvfQSnz7bwF
         1lfNNIIYa7mYK14O0sMWglOWOeEnqRDxDDxczV4CzeyTnrcgkskD2NlwGgbpkmbEIMsF
         bMsgcFRWlYQZGNCYRBRXzIQZekeLaPKb1s5F6xYJiMl6mTS9amdN3wfVGQf20wjg5Vwh
         l9UqbSAJxojH2EVoKnVuzAknm5bBy45aY4y5i1tzx/i5em90iEt9OykmSwOHp7ZXEbEq
         G0BB1XjapZE2auk9tfXuqJylLd3wZVCeJXLhcoyX9CakxPxN2hjSlpm+dUNrCgWySz22
         vhXw==
X-Gm-Message-State: APjAAAWC/nnA2eNWBgvkuUp8331Azvnkp3is3fLZaY2Mhy6R31o5cxtC
        RZ9qAiBGifrxCrBynXqR0S9eDGWGzY+pKhxyUyU=
X-Google-Smtp-Source: APXvYqxgfS2ynbKs1o+2aZa8e7ecnAhyI2eO9iqCen14keAf7VzmDKsxF/OAPpOIAq4KuP9J+HPN5ZGt1iA/54SjGCc=
X-Received: by 2002:a67:fdd4:: with SMTP id l20mr8909563vsq.63.1557731105926;
 Mon, 13 May 2019 00:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190505180646.1442-2-radu_nicolae.pirea@upb.ro>
 <20190508090857.B7CB344003F@finisterre.sirena.org.uk> <20190508105105.GN3995@dell>
 <20190512075223.GF21483@sirena.org.uk>
In-Reply-To: <20190512075223.GF21483@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 May 2019 09:04:54 +0200
Message-ID: <CAMuHMdUOwff68bSjvG3vo5+HUjtRCNXLbAiUc7et4m+yfSCoFA@mail.gmail.com>
Subject: Re: Applied "dt-bindings: mfd: atmel-usart: add DMA bindings for
 USART in SPI mode" to the spi tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Sun, May 12, 2019 at 7:05 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 08, 2019 at 11:51:05AM +0100, Lee Jones wrote:
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > ---
> > >  .../devicetree/bindings/mfd/atmel-usart.txt   | 20 ++++++++++++++-----
>
> > Interesting!
>
> For some reason the bindings for the SPI function got put in the MFD
> directory, dunno why.

Because this is a block that can do either SPI or USART, hence MFD?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
