Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D082DC065
	for <lists+linux-spi@lfdr.de>; Wed, 16 Dec 2020 13:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgLPMhO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Dec 2020 07:37:14 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:38386 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPMhO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Dec 2020 07:37:14 -0500
Received: by mail-oo1-f53.google.com with SMTP id i18so5666903ooh.5;
        Wed, 16 Dec 2020 04:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNmIFhL3IA2YySUy5Ex3F/eKMw1MQCTRrjCKuFE3zsI=;
        b=PFZqi83Csq72eEcxOurRet2ZmXbAPfxO5NgxRI6RgQmzBiZ3rtPtz8lXTpYnKtt4kM
         6/E5U8PdAV3SrPoqnk4D2pIcepCrE14flisO/J87fw5yNpeTHGIFZvG38y2u7f1bsZom
         Ev8mg8x9Apl2NlIxZAvat28Au3Ia0CXSWk7hPPzxiDvUwWRVN3jnNEUVnWSpn7IGU224
         aWAA8OLfwGxDJgaNCSco/3PlmOPxtnrPCUPYWQY/Uq6a4W3FclpAKwg3qf3ActyOJo0q
         eo4Z/OQ3krnD6JQhPMG/ccKMeZhiH3wJ+Lzs7w1GpLrVD6KtrsoFe4FLFTfImnoB2bKI
         jMAQ==
X-Gm-Message-State: AOAM53002y3xnUlr8qVm8BD1qL1KhC0oqxHF0cdE4WHboN8uLDWcdECj
        h27LQ25cDdSD82F4CWhzsqlHXV4MUcQT9bBK1Zr7bWG/
X-Google-Smtp-Source: ABdhPJz5gSJ0pvws1OiEx7u0oWXkdp7ivnWsEjRXTBTRiDHy9EzbZvcQ2YmSi80r4Rn2zzeThNggmQ2EQZVWvScT16w=
X-Received: by 2002:a4a:ca14:: with SMTP id w20mr25302230ooq.11.1608122193481;
 Wed, 16 Dec 2020 04:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20201216092321.413262-1-tudor.ambarus@microchip.com>
In-Reply-To: <20201216092321.413262-1-tudor.ambarus@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Dec 2020 13:36:22 +0100
Message-ID: <CAMuHMdW5pV0P9B8AKSw82DXBL7jBa4mHHJJcwtbSCP26o5dMJw@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix the clamping of spi->max_speed_hz
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 16, 2020 at 10:23 AM Tudor Ambarus
<tudor.ambarus@microchip.com> wrote:
> If spi->controller->max_speed_hz is zero, a non-zero spi->max_speed_hz
> will be overwritten by zero. Make sure spi->controller->max_speed_hz
> is not zero when clamping spi->max_speed_hz.
>
> Put the spi->controller->max_speed_hz non-zero check higher in the if,
> so that we avoid a superfluous init to zero when both spi->max_speed_hz
> and spi->controller->max_speed_hz are zero.
>
> Fixes: 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
