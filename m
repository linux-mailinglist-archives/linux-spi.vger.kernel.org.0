Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EFC2AF402
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 15:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKKOpp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 09:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgKKOpj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 09:45:39 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9308C0613D1;
        Wed, 11 Nov 2020 06:45:38 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i7so1576268pgh.6;
        Wed, 11 Nov 2020 06:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QuhezNq2xmeafvchQlzIbY9JsjQJ+3pWNXa3pdsQlqM=;
        b=n9A+JbAZEp3NuDeNnot2mOxvTR+YMefqh/LkPfVIG96h2znG40AYdzJoppK12VwM9C
         dEZKlBFP9+OfNTsfH492yUBO3CtBdvH3Dq+FxW9wW4ta5A04judTu+phr4LKJA5pwmQm
         MwU9K/STQoo3SNT6aScow4A26pZ75n8VsHARak/u6xfM5K+Wlapaa2pmE8JGTmCIwCUq
         kZjU/bcTaFTT1R+aIOURcGSK1pbZOpBj6euvV6MgbMKRlw38aF8xwYNUPR0msnooajYo
         GarSJ07O9eUQ0mWSCj1n+ZcOeoZw0ueTCrsxkGFhpO4LG265hmcJ3U7lq0Hp/Cit5lSH
         RBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuhezNq2xmeafvchQlzIbY9JsjQJ+3pWNXa3pdsQlqM=;
        b=l7waHv/L+RN/duo7oe9Fr5sORu8ovvKNwoXwOqFNLfE++w6M41BtkwTeLpSK8g9KVz
         Wtkm5JsUY/HTlpBhXfc1lYcoso+vycYWGPvwnziKzCqaG1mOC1ZERuXEJfoDyTzdI0Yv
         C1/awZyfXtSfXjaCvqetPonn+NBFXnKLS+M0FNAjb6wFWWuSImdjkAFK0Bpa/0EUGQBw
         OQt4kL0Gq1r7FyHwAeWLO4BkudGUIdh96gsrnuhtFRfH+4xa+lCYiQENHSGVsxtLkgqy
         XAAhmvGGqMtVSESqBfoiX6mcYKwozPckIWauethJjYcFL82idkN4To2ewY/9NuqwyMVv
         Q23A==
X-Gm-Message-State: AOAM530EarNNWF6wjxD0+kEUhnhhi7HGZAXyaEjvnyR+DnAlNMezAPVs
        p7L7+ykOIpZQ8awLcASwJ83Hj4AGICFZbGEGuwOcL/iqYco=
X-Google-Smtp-Source: ABdhPJwfFs9Ko3GXgbbFnEJ2HrhiolTOdqkgYSc2ZxfRKOwzjknjGIHQuaLwEkORM4NOTv2HSLWbxTQ9u12afLeSTyg=
X-Received: by 2002:a63:3e05:: with SMTP id l5mr21572969pga.74.1605105938509;
 Wed, 11 Nov 2020 06:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20201111141529.98147-1-alexandru.ardelean@analog.com>
In-Reply-To: <20201111141529.98147-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Nov 2020 16:46:27 +0200
Message-ID: <CAHp75VcKmiBM1WQTtmJ7L3kpB1xdXX=xOtM2zCAtaszXBcHokg@mail.gmail.com>
Subject: Re: [PATCH] spi: Add SPI_NO_TX/RX support
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 11, 2020 at 4:13 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Dragos Bogdan <dragos.bogdan@analog.com>
>
> Transmit/receive only is a valid SPI mode. For example, the MOSI/TX line
> might be missing from an ADC while for a DAC the MISO/RX line may be
> optional. This patch adds these two new modes: SPI_NO_TX and
> SPI_NO_RX. This way, the drivers will be able to identify if any of
> these two lines is missing and to adjust the transfers accordingly.

Shouldn't this update a binding documentation?

...

> -       /* check mode to prevent that DUAL and QUAD set at the same time
> +       /* check mode to prevent that any two of DUAL, QUAD and NO_MOSI/MISO
> +        * are set at the same time
>          */

/*
 * Perhaps switch to proper multi-line comment style
 * at the same time?
 */

...

>  #define        SPI_TX_OCTAL    0x2000                  /* transmit with 8 wires */
>  #define        SPI_RX_OCTAL    0x4000                  /* receive with 8 wires */
>  #define        SPI_3WIRE_HIZ   0x8000                  /* high impedance turnaround */
> +#define        SPI_NO_TX       0x10000                 /* no transmit wire */
> +#define        SPI_NO_RX       0x20000                 /* no receive wire */

Perhaps switch to use BIT() instead at some point (as a prerequisite
patch, for example)

-- 
With Best Regards,
Andy Shevchenko
