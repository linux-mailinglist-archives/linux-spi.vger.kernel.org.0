Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C412CD896
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 15:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgLCOJz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 09:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgLCOJy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 09:09:54 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52990C061A4E;
        Thu,  3 Dec 2020 06:09:14 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b26so1363811pfi.3;
        Thu, 03 Dec 2020 06:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJ7u1l2czPx09HJWCSw/GmDg+rkIf9SaGFfB2vz8DE0=;
        b=MPP+YY48bbGpf4uMpzlQnJ0NsdZyHG5oMLo1ZX9mAuBJGih1zUDyIuwV/QENfZRoOm
         mLio+3icihdlceE50ysgNBBczvZEfzLI/zukKmRRAKgNKylbUXLAZYQ/A19VIFbbxs6v
         uhC7kcSOyzdEiAPYdc0NPr7fDE8OcB2+yqmnFM5tau+HzSNTvCI6dBzMjvVn0SMoVLy2
         L25teH6LUHPkijypP3xIASQqUw/HG+xXB0e35x4A9q5Gmsjxz3KDZH0gz1r8jk+sT5DU
         j6w4UbjjUxlk4kpQjVIC30uf5FcIyAbDkXpBXgJzRHDmUl20lJrokhNKhRzsgqCXrKJj
         AZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJ7u1l2czPx09HJWCSw/GmDg+rkIf9SaGFfB2vz8DE0=;
        b=Olqp2czTfCAajwLoz5l/6HpNyHYcmyjZFBi7tkHfFOwa4M4uAiPEVzRdW36hPBP0k6
         LRIK0V19pJBcNNfZJdxGaCdL0zgZ0Wuo/WITajKq38sCWpDyl/PtA21Sdth71bruJKBD
         BCt5/oAlvZA7hNjemX+hSx3i1xziFv6g1Vu2DMVMMfqNYbjTWT9KlCar9Hz199pdbjnz
         Ob26CyFcoz5BfEZGpXbFNQH9uj1J5FeCQJYkK5FKnRnZCmNqnwqzhGczsuaUx3ftx+lv
         W01vaBUBOmVYyi4I/iu+Obp+cK/FifqK9RRYkd+OpD4ysc8dgkhvsxIOCKtthmX7D/cc
         r7Eg==
X-Gm-Message-State: AOAM5325sbH0tgf53wDjwLG+/SqmFg67nxehu6TyIbwEa4JoD/JxJ2GX
        61vHz+CIWHSJFORBmKREuAlCo4UQT/gfrYebgDc=
X-Google-Smtp-Source: ABdhPJy8gwkOuaOTstt9oMs1cJBUajEsYkOqutZ5s21vSkL0HssiI9Fujv2aRtCbYo+mm3LSggCPb1WAXHXNmWVe/PY=
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id
 66-20020a6204450000b029019c162bbbefmr3227328pfe.40.1607004553823; Thu, 03 Dec
 2020 06:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20201203140531.74470-1-alexandru.ardelean@analog.com> <20201203140531.74470-2-alexandru.ardelean@analog.com>
In-Reply-To: <20201203140531.74470-2-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Dec 2020 16:10:02 +0200
Message-ID: <CAHp75Veh=b0JYOP_gETyqqGGEYhO9JcxFCGXSuzSX27-qioprA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] spi: Add SPI_NO_TX/RX support
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Dec 3, 2020 at 4:00 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
> From: Dragos Bogdan <dragos.bogdan@analog.com>
>
> Transmit/receive only is a valid SPI mode. For example, the MOSI/TX line
> might be missing from an ADC while for a DAC the MISO/RX line may be
> optional. This patch adds these two new modes: SPI_NO_TX and
> SPI_NO_RX. This way, the drivers will be able to identify if any of
> these two lines is missing and to adjust the transfers accordingly.

...

> +       BUILD_BUG_ON(SPI_MODE_USER_MASK & SPI_MODE_KERNEL_MASK);

Please, use static_assert() as I have been pointed out. It may be
located outside of a function scope. You may attach it directly to the
definition of the KERNEL_MASK (I haven't tried yet with header
though).

...

> +#define SPI_NO_TX      BIT(31)         /* no transmit wire */
> +#define SPI_NO_RX      BIT(30)         /* no receive wire */
> +#define SPI_MODE_KERNEL_MASK   (SPI_NO_TX | SPI_NO_RX)

This needs a comment to explain what's going on with the flags (split).

-- 
With Best Regards,
Andy Shevchenko
