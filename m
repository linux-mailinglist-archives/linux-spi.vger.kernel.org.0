Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8565365B39
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhDTOeB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhDTOeA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Apr 2021 10:34:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCA2C06174A;
        Tue, 20 Apr 2021 07:33:29 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 31so11247499pgn.13;
        Tue, 20 Apr 2021 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5s+uTm3uKcDwspuvE5tIia1o+W93TUOVR1mdiRVaUw=;
        b=sNnmeeOCGsi0FfA4068XakKtInCDFiAS/mOiDtmzrPccc/3LQaaZlVxuWjE6jdPLcZ
         dDg0/faPvAbMlcYbSsOUCUQUuqXQeyOD7hRCBP3FrrZHHOE+dtnru33SBwQgfI8tbU3T
         6bK/xio8YdzIMZ0dNROEjJPvAqbKPLrUMFum0F+KEcfo6H1Y0svcpaDGmKavtLTkW6fD
         RA1wMZAqrrzreJoRZbDE9TyCAVUL5oTViyJmUAs4FjC4YP/x0zghiGAAge624rqstgI0
         fxAswV21TE7ayBItOHmvxveF8cXWrHvRpXtgORoqjlR+aiE+HehhtSBJ1hhDjs7JKleN
         3+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5s+uTm3uKcDwspuvE5tIia1o+W93TUOVR1mdiRVaUw=;
        b=BHo1FyIEmISBVLfjx/XxBa0phBMpJt5a1Wva6AqCU5cZgv49gwep9gUAV6yHp3a6U4
         cDMVA1XPCRTkujy3VzeaqCPkzjJKCtWscdsxDlZZ3b4V0/3ofIuN4YiaX28VXjsM85bk
         47W3aasYXTXJQ3ox0g/qHasP5EEA9dfHksSjN8MWW8Q5N6p4Oy2PWR3uGOBKzgBhzxBc
         GWhTvNLOmxPXY135K2Tw1wQcihCDH5Ki7vDdjQQ5WLEcoBrEqlw9c2EDV46h/8HMzFD7
         j52dj5yUA1ceRAW/5R+K6Wo1hWR24hNDC3h+bBSot6BwSFng5AUz6mka/3BqeCXA5jTu
         8mgA==
X-Gm-Message-State: AOAM531dU5yR8AkCIYtM9zLd5KEZwBA6Zd98wvWTwiVqv578yJhLQHOL
        OXGBOGHIb0XstNhr20f903Rm5Z7gRlCRs+Dts+fBr72Ti30=
X-Google-Smtp-Source: ABdhPJy7uC4w76V7ZS6QtyqMxAawuOBbViNKZAvZ5DlmcUjJJ71YMg+3pavIA9hduVxcdfMNpwhLGa3v2Zpkvz5116E=
X-Received: by 2002:a63:cd11:: with SMTP id i17mr13152405pgg.74.1618929208653;
 Tue, 20 Apr 2021 07:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210420131901.80233-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210420131901.80233-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Apr 2021 17:33:12 +0300
Message-ID: <CAHp75VdsRgV8vrTiZmJwL-fhms7NRT27cBbr9WCBFORqvthVjw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Don't overwrite num_chipselect with error code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 20, 2021 at 4:19 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The code currently organized in a way that num_chipselect is overwritten
> each time we call spi_get_gpio_descs(). It might be potentially dangerous
> in case when the gpiod_count() returns an error code.
>
> Note, that gpiod_count() never returns 0, take this into account as well.
>
> Fixes: f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")

It doesn't fix anything. I missed the max_t(int).
In any case it makes error handling cleaner, so I'll reformulate the
commit message in v2 and drop Fixes tag.

-- 
With Best Regards,
Andy Shevchenko
