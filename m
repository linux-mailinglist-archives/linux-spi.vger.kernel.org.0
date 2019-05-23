Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE1927536
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2019 06:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfEWEff (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 May 2019 00:35:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43419 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfEWEfe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 May 2019 00:35:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id u27so3330455lfg.10
        for <linux-spi@vger.kernel.org>; Wed, 22 May 2019 21:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I855tJLOmH+qENWERPddony+uMrLikCWrVK/n6EsJqc=;
        b=rCgMh7qpt13wmLAW/uPcMoimflmUIWRE5l1dzHpFB6L1XFMi7NIAAyl2nAGdY3QYAm
         2Vp3JxFwWfhj1hCSKK6QapYcHiBkpDuxPlMJfGm4vVVr6PsO50LgdIKPTtKqdxzKB3gu
         fJVnZVhCcxwYEREjEQlh+Fko+9kSupaCOq1Jifj7JZ3CjB5MSYl/Cbffoe0nAD46Ak+k
         E5tl6G/OuHtr9KqCw4RBWVXyq+b5rhYTcSpFuS0ahwK/9lkO+9MnW5+tP6yKvmYX5/G3
         WHgkwMjHmnwaAc1RPsfxb6LHZft2CHPx+adeSd3Ufs/lG0rJodh1t2icOQJHg9JaHuIH
         f9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I855tJLOmH+qENWERPddony+uMrLikCWrVK/n6EsJqc=;
        b=B+yxubWS2Y9o2fhBrmFbQMyPeQIxU9UrbiR2C4PS0MDPZZ+r/hmJKVwTg18rX/u9b5
         i92v9uwXagfRunQNxv6uB2nnrccCWWDv7FIWFgTItw00XwmGb8e+H15qO7ulPAw9y2oW
         95XRQdNbuQDAXLWJ/rb2WwKVrMBg4VcGgCSKbSwHiLRpo0XBgMGc8zrSYqYKyOjxtaoT
         I8ZouMggGPpmN+JQlXYgd+yT//nuoqRDGyo7j5gpIR4CDuJuyx2fPSjwkbe/Hc069S+B
         Yo6FoxqTFNZCumpiyJu4opa5sVGEpwqCOYfhcrMIXu5dRlmiaD3c6hNE2JRMUyyxrK4i
         zTyA==
X-Gm-Message-State: APjAAAUsEc1NCSA9FOzXH4q0oe4lTsoRjWRkdDXpIkikDrC+uMUoW358
        /mmEQu4u4b1RwdjGZVE/P6DrQwONfmMFIknHWY3iHQ==
X-Google-Smtp-Source: APXvYqyaErcZ/ZN3iXve6bWnH5MYhT4dOYSh5zC4VziNvEwTFzT6US9SEnDJGPzkHwm5nImpUQk6ket1qgSZ82jyGJg=
X-Received: by 2002:a19:1dc3:: with SMTP id d186mr44962791lfd.101.1558586133038;
 Wed, 22 May 2019 21:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190521115958.22504-1-masahisa.kojima@linaro.org>
 <20190521115958.22504-4-masahisa.kojima@linaro.org> <20190521181609.GB16633@sirena.org.uk>
 <CADQ0-X9yKQ2akerpxKfjxOxmRhPiaaxe7ALDO7VQiH+-+SHo3w@mail.gmail.com> <20190522110906.GD8582@sirena.org.uk>
In-Reply-To: <20190522110906.GD8582@sirena.org.uk>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Thu, 23 May 2019 13:35:21 +0900
Message-ID: <CADQ0-X8xd+edmPWfMSDgHrRCHEHewxsLH3zNs6jnPtfaQBhaLQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] spi: Add spi driver for Socionext Synquacer platform
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        geert@linux-m68k.org, tpiepho@impinj.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Satoru Okamoto <okamoto.satoru@socionext.com>,
        Yoshitoyo Osaki <osaki.yoshitoyo@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 22 May 2019 at 20:09, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 22, 2019 at 05:27:23PM +0900, Masahisa Kojima wrote:
> > On Wed, 22 May 2019 at 03:16, Mark Brown <broonie@kernel.org> wrote:
> > > On Tue, May 21, 2019 at 08:59:58PM +0900, Masahisa Kojima wrote:
>
> > > > +     ret = devm_request_irq(&pdev->dev, rx_irq, sq_spi_rx_handler,
> > > > +                             0, "synquacer-spi-rx", sspi);
> > > > +     ret = devm_request_irq(&pdev->dev, tx_irq, sq_spi_tx_handler,
> > > > +                             0, "synquacer-spi-tx", sspi);
>
> > > The code looked awfully like we depend on having interrupts?
>
> > I"m not sure I correctly understand what this comment means,
> > should driver assume the case interrupt is not available?
> > Do I need to support both interrupt and polling handling?
>
> If the driver requires interrupts it should not just ignore errors when
> it requests interrupts.

I'm sorry, I misunderstood.
Yes, interrupt is required. I will handle errors properly.
