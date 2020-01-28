Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E445114B1A9
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2020 10:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgA1JUg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jan 2020 04:20:36 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35635 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgA1JUg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jan 2020 04:20:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id b18so5707377oie.2
        for <linux-spi@vger.kernel.org>; Tue, 28 Jan 2020 01:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cX+pkfmPkeZOljrZ56E/E1jQrXYnhbNGFHUq88mRAwA=;
        b=h1PyE2ZDGjBcWh5ftsqmYcgQeu1JQszApb6RCcBuAHiSN9cumZHk/mbTL7fNrFFVM/
         +Y1oJuy6MECIebE07+TLSyKbBGGLZkIvd6BApChfq4naXSxj4ZPzGtRjfThWwabYyJsv
         G8s+dmwdhpHQYTrOJHcTZNnadueFjFrZmg32xgSMqxYMQRmaPW/HMCyURVLb3Y1TdNrD
         hFkIU51v+SAVJGWv37H0VFFz5HeP3GCjdrup8UMcVX+OBaab9XsAs2N5C6LRTD9o0Udm
         Vh5+PFce4/EilNokFyPuZkq+xzd7Z9aO4cuTphH1EQSuFCIh/IRHNQZy1e/sVkbu8IFk
         tUCw==
X-Gm-Message-State: APjAAAU/msSngVXp5TXT0YeBaXuOisU9ERSsoI+khr5ygr0iBWFlX8fT
        /Uacdqom6O4ki1GfL+zcS/sN0gtjfuYQZzgCF/7PxURE
X-Google-Smtp-Source: APXvYqyyPqgc3ribNaCdbJfdBJeYr4ycvwmN5G/8GMMjcg0FUpeTeN1qZvdzLnAh8T0ljMxgdaWOiE3EWq5PfJkanvM=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr2098209oif.131.1580203235504;
 Tue, 28 Jan 2020 01:20:35 -0800 (PST)
MIME-Version: 1.0
References: <067ed094-fa5d-f472-8abd-c22f4c0dba03@inbox.ru>
In-Reply-To: <067ed094-fa5d-f472-8abd-c22f4c0dba03@inbox.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jan 2020 10:20:24 +0100
Message-ID: <CAMuHMdWiWqquohF93jssKuu0GFhs0QHtyXsTse5WN9rUjPGd4A@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-espi: add GPIO chipselect support
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Maxim,

Thanks for your patch!

On Tue, Jan 28, 2020 at 8:26 AM Maxim Kochetkov <fido_max@inbox.ru> wrote:
> Subject: [PATCH] spi: spi-fsl-espi: add GPIO chipselect support
>
> eSPI controller can't send transactions without hardware chip selects.
> So, to use GPIO chip selects with eSPI controller we need to use one
> dedicated hardware chip select signal. To specify shared chip select for
> GPIO use "fsl,espi-shared-chipselect" DT property.

Do you need a property to specify this?
Can't the driver just pick an unused native chip select instead?
Recently I've added generic support for that to the SPI core, cfr. commit
7d93aecdb58d47e8 ("spi: Add generic support for unused native cs with
cs-gpios").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
