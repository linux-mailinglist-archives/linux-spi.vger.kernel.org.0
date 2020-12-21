Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46692DFFEB
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLUSgi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 13:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgLUSgi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 13:36:38 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADDAC061793;
        Mon, 21 Dec 2020 10:35:58 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id g1so9777246ilk.7;
        Mon, 21 Dec 2020 10:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhmLpbImfktD9rtiJGAflrESaA7xFsBYHnmh6LfS2Ls=;
        b=FBWqccZU9KieCRmfheuIw/ighBbgCIsb4g/imu3WpdLuAcGb4XJYoX8UH3FL5Kc/1q
         iDqGvC2hHaXQKIL2Lo0IZa5Pc1n9XGc0dSdxrtaZd6AWJ+g73iUhvCEfrMWGOVs40b6Z
         +DBJTLKSs6hYUkkRqP31UMcCmeTYFRMbIKPHck0AzOOp0YjonovMUI1PwOAbYxz6ZL12
         8Yj9QWBFz5NDAXEZ8rmpR37JPlhnTwzHH3rvIDV5GYy4qKpArTTGzWyLlXA2j8aXz1zM
         PuVKKXVZlIBaZ+2rbC9HIje6eqalX25x/4S8O/QN+/oW55VIMpOVKjVKu8F2zSLIqaRX
         gTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhmLpbImfktD9rtiJGAflrESaA7xFsBYHnmh6LfS2Ls=;
        b=jut3ngtd8Apqn40y+pIupbxu9BcbX/LgOTYAQ05fdfLxj1qoAsDHYFNKRVzYsroMaI
         kZlXk+p0JN7ZPClApcgkjmPuD1Bvoga1pWGwWWXxAfpE3OoykqcA2S27euPgUcZdFfOo
         I+/Q4RWj+1CFdYsHJWG54ag+PABR9iPM41z0r2U7JS7t02x1XQJb3aHvIxtFSMyWS5Yl
         SiJ/ofXhvvDyDQWXWl02XY/WPfV30Atw3UK0orgLzeCZ6G7M2sPqEDYH69g+qixsANLk
         dK2GrHl6GJZ47/LIkVRC7InENdpWcJRVRxUrqQDOeZIMpT7xvvm2VX/APVwGnLnQ4Y3h
         fzZQ==
X-Gm-Message-State: AOAM530IYXZCbl4EBWmNIng3s7Jhy9pT5xJU8F2Qxb4c/jpEBsQ2KsGG
        YnX9ocWhGeiCQH1EKbrp+fZmC4qrDa/h49yCYQmqc4HSYD8=
X-Google-Smtp-Source: ABdhPJzCXqSBMwof0shNIMhkp6pAbOXGp6t70+NwzERiqV+5xsZC1S2EdvNprvn5L28TiJaPUZ9+JCPiIvKrOsgL0qU=
X-Received: by 2002:a63:c04b:: with SMTP id z11mr15546680pgi.74.1608561353881;
 Mon, 21 Dec 2020 06:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20201221141906.48922-1-alexandru.ardelean@analog.com>
 <20201221141906.48922-2-alexandru.ardelean@analog.com> <CAHp75VfR1eNMry8JwJoFuaU48KZ6rdBWau=yaR1AnsaRSLTC=g@mail.gmail.com>
In-Reply-To: <CAHp75VfR1eNMry8JwJoFuaU48KZ6rdBWau=yaR1AnsaRSLTC=g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Dec 2020 16:36:42 +0200
Message-ID: <CAHp75VftBQEK10Z7pkD18fpr8B7ipCXUXVx=1Hnuq-2w=z2hgQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] spi: Add SPI_NO_TX/RX support
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Dec 21, 2020 at 4:34 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Dec 21, 2020 at 4:15 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > From: Dragos Bogdan <dragos.bogdan@analog.com>
> >
> > Transmit/receive only is a valid SPI mode. For example, the MOSI/TX line
> > might be missing from an ADC while for a DAC the MISO/RX line may be
> > optional. This patch adds these two new modes: SPI_NO_TX and
> > SPI_NO_RX. This way, the drivers will be able to identify if any of
> > these two lines is missing and to adjust the transfers accordingly.
> >
> > Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
>
> Missed Co-developed-by: Alexandru ... ?
>
> Anyway, looks good to me,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

One nit, though...

> > -               "setup: can not select dual and quad at the same time\n");
> > +               "setup: can not select any two of dual, quad and no-rx/tx "
> > +               "at the same time\n");

Can we avoid splitting string literals which are assumed to be on one
line when printed?

-- 
With Best Regards,
Andy Shevchenko
