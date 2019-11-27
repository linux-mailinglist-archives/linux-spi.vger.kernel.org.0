Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF53C10AE5D
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 12:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfK0LAH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 06:00:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40124 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfK0LAH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 06:00:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id y5so4077412lfy.7
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 03:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LVXYk2GTgYebVYrLbsZZQ8ix/ZNBLKp9RuSfiv7skGE=;
        b=d6P4vobnbfEqOhvMwxzaqOYAphFhJXFcQk8I6qNDGfyFQpvvfkld8uZzUgWb0ep+kH
         B9adAnTEM1EzBDRpvZIB+5RHj+n//eSXKQB7W1xKWEo/Bd48wk22IBb/F3Lo+npqJj7E
         gz3uetxKJm5Nyd7tQpKunSbjJd+i1w5AHAEpNOUCFOX8/4bglXzREFtupGfrXqEutZg8
         aU0ORy9hay/E3SGzf3dAR3MlvMnbVmkBSw/LijILzLwblaIee+uhKVQkyGVl3dCNC/8a
         b9k3d6oKm0f1Ihmz4QlEuPbj7dgkpBdqRxoxDyr1GIn9dJKhxk/CKxZMIL2xrLtxulfw
         Ec4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LVXYk2GTgYebVYrLbsZZQ8ix/ZNBLKp9RuSfiv7skGE=;
        b=Gg+HNkujaLqxEtFsUkY024mFP0VkEpcKt3DNv2B+Flwfwl/IjymmF/cpnHB5s5nG7H
         AGkxWyHRPmo3uKv1vNWFXX32cwHZ3moQykr9OqwylnHO6OUQ4ZYtghlKyRSYZBG4pAnH
         Pyp4/fnIIGJumIg4nfoU9e/GCrea6afnby4mYEfJehwV18AuOirPQshR+DzlTLNGhB/7
         3IZED6c8dLxbzIMuqFKPzt5aMR+BoA3J7VtyR66CgaEXf6991j6YuIV2QvQ6PMerSHP3
         Q9wAki44i5iRd24Shd3zlQlQq1R5RXxlrr1aYroPRyQV8E2X5C2YwdHqxCLW3I8KQJGP
         13qA==
X-Gm-Message-State: APjAAAWQLME7jtRtY3NOM2/UAQ3gHFwLel9g/BLPFZowU4gxbnJkb1C4
        t4/yKRoyrQqgOssGzWLqlwtigpnI/KihEcSUVq/U1g==
X-Google-Smtp-Source: APXvYqy29Zl9VoNK1r6+iSNNFQIeMLnFkI37owghNky+Gs1crkdPiQ8aGhke4N2t8gAqLBL4/PeqOpK10iZlZUNWoW4=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr27678900lfi.93.1574852405249;
 Wed, 27 Nov 2019 03:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20191127094031.140736-1-linus.walleij@linaro.org>
 <bcfa8e29-7adf-8a14-43e8-8e1d73df33bc@c-s.fr> <4eed765b-57af-87a0-f713-de1e6bee3d4b@c-s.fr>
 <9c202a84-16c9-1293-a6a8-674de674d31d@c-s.fr>
In-Reply-To: <9c202a84-16c9-1293-a6a8-674de674d31d@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 11:59:53 +0100
Message-ID: <CACRpkdYVwV8F0-pp2S4CcSQnDZ00KBvZx2zuTmsFMPUP4cT+yA@mail.gmail.com>
Subject: Re: [PATCH] gpio: Handle counting of Freescale chipselects
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 27, 2019 at 11:25 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Le 27/11/2019 =C3=A0 11:15, Christophe Leroy a =C3=A9crit :
> > Le 27/11/2019 =C3=A0 11:07, Christophe Leroy a =C3=A9crit :
> >> Le 27/11/2019 =C3=A0 10:40, Linus Walleij a =C3=A9crit :
> >>> We have a special quirk to handle the Freescale
> >>> nonstandard SPI chipselect GPIOs in the gpiolib-of.c
> >>> file, but it currently only handles the case where
> >>> the GPIOs are actually requested (gpiod_*get()).
> >>>
> >>> We also need to handle that the SPI core attempts
> >>> to count the GPIOs before use, and that needs a
> >>> similar quirk in the OF part of the library.
> >>>
> >>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> >>> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>> Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
> >>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> Still getting:
> >>
> >> [    3.374867] fsl_spi: probe of ff000a80.spi failed with error -22
> >
> > Indeed,  of_spi_get_gpio_numbers() uses of_gpio_named_count(np,
> > "cs-gpios") which still returns 0;
>
> Replacing by of_gpio_named_count(np, "gpios"); , I get further down to
> the same spi_fsl_setup() warning as when renaming the property in the DTS=
.

Ah, I got bitten by recursion, sorry.

OK I changed to to "gpios" in my patch too, it's the right way.

Now we need to find the final culprit that makes it not even work when
renaming to "cs-gpios"...

Yours,
Linus Walleij
