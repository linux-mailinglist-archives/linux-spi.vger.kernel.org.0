Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B52719A95
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2019 11:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfEJJ0r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 05:26:47 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34626 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfEJJ0r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 May 2019 05:26:47 -0400
Received: by mail-vk1-f194.google.com with SMTP id d7so1327806vkf.1
        for <linux-spi@vger.kernel.org>; Fri, 10 May 2019 02:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DT5wT8AJFVUKeUgrd/69X3hf26YvnynRb3rkliFJbeQ=;
        b=rcMTsE1Zunz3RWKGXWGvaEF7YcDYAq+aYLfpWOmVln8GDmg51K+3DM4oUeDPkSPang
         Xz9lWykCZFlbR4+dEDrBCdg0g87PFe1uDvm8WWvRt3Q8YnGAU9gQIvdzdlOijt7tONEQ
         pVF/+JTaoDhL/CdqyrXxvw8W2sywndyc0QsskvdGHAiWZJcTRLEpnA/xJKSMykaR+vaM
         kN2XaaVpFwLVBJB5+BTc7H1X+i07Ix5xs5j5NukOoBWJFMwGMUOo7D7yJtQYmnVO1aSW
         /dj5Td45AwPmpyuzBtz5SdBDDJuGlvOA2y0bPzPZOZ9R3oprFhF5xvKsQZe9PE1HgAYc
         cm8g==
X-Gm-Message-State: APjAAAUhRdSf4zWzgZ0Y+8PUGIEunWXIsHRObGCvKAZnV1/nmp1JrPV5
        5aF4T9vKZ1Rp8IOBoAS5K+bgnXJS8BDf1V2oCeE=
X-Google-Smtp-Source: APXvYqzj9/rCw1pufzI1/agjRwFhQV+30BDwd3fzoCGNzdcwix3rNmXJAjBYqBSsxKR7EK7EHL7MuNngBAZXWTOnlw8=
X-Received: by 2002:a1f:ff0b:: with SMTP id p11mr4594722vki.83.1557480406122;
 Fri, 10 May 2019 02:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <1557480060-15311-1-git-send-email-na-hoan@jinso.co.jp>
In-Reply-To: <1557480060-15311-1-git-send-email-na-hoan@jinso.co.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 May 2019 11:26:33 +0200
Message-ID: <CAMuHMdX4x8x=xbszMJ-BVd6xCvZV_m7ds41d2b3og5XJKyZNQg@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835aux: Remove spi_alloc_master() error printing
To:     Nguyen An Hoan <na-hoan@jinso.co.jp>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 10, 2019 at 11:25 AM Nguyen An Hoan <na-hoan@jinso.co.jp> wrote:
> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
>
> Printing an error on memory allocation failure is unnecessary,
> as the memory allocation core code already takes care of that.
>
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
