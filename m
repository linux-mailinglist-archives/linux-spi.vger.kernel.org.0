Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10DFAAE839
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2019 12:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390951AbfIJKdq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Sep 2019 06:33:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40413 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389193AbfIJKdq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Sep 2019 06:33:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so15855339ljw.7
        for <linux-spi@vger.kernel.org>; Tue, 10 Sep 2019 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGSrpCaXqgzMsNgewILLlh1XqzPAveIzeVgEw6Biryo=;
        b=ge60Pgil5AfX4PcdyWwdIJOtoU+rI7c68w2fhSX/GA21cW8Fh+Dxq4KzdU1eEWEawv
         KrGBFusza5pub5hw+4tsXQy1zZzpc7+z3jCeGmBXB6nTIr0xY0ox+CjEeUcB7G2eJXBk
         ZOH30LkwKVKfD++vh/8Ncy7CCx5JKTZWzn5OL5vP340flT0nlTFNVb9ydKaGsftsnzdE
         LsjziEoue0PS893oAQF94bHoZnqSZyUKFT9lsDi3rVqyMaCfDiw7TRj44FfeuDktDpbc
         Ya5WTKocZrXgyDGIrgBEYJMYOyC9HAaabULeuTQcyqlEx+35X9QbEQb/EZ2Ax+Uh4Ro0
         03BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGSrpCaXqgzMsNgewILLlh1XqzPAveIzeVgEw6Biryo=;
        b=Nn090Gy1pUxQtqGcQUcWZIw+ZBlEW2ms+aiv5hwY7GG5VfD5snVyiKQpRd0qqYR31O
         VOyKbc2wufUTTn6O8KlhCpEaQ+NGclNhlEc8I5KvLxRv6n72wVg49vAVM1B9mbTD73LS
         PGmyPoo8/nrjcZ6YR5h8CyhFpN0xCqICC9Dr2u/JbfBPHxqJe00taHw1gV563xCgjFEL
         tY3PQwYlpQQlTiOwztOZqjR/1KNsaNRS98vRMHrL4X8HLo562wBAoWnJhzpn/dDQ/yBa
         b4DVs1JKbGruWMK0tNqbrE6p2V/VYSy9meDERmI5n4AVznTjssYhYiz3sVdGMEblkq7/
         6YWw==
X-Gm-Message-State: APjAAAXxQJ298cJ6o/8gZO/Fxckjrb0mwfvPkbiJNonDl0cBPuHKJe+q
        /rvKxZwP1SxRh6mOnomDD3r6slnwSkzFeO/j/95vdA==
X-Google-Smtp-Source: APXvYqzrS203uVyxVpv+f0AE49RyYwVN2ICTnAspsO3UNfX1wnKJSzWjWHoN0RFD+Do6MezjnHUSSEG/UbPW0dCtt1Y=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr15475740ljj.108.1568111624439;
 Tue, 10 Sep 2019 03:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190903231856.GA165165@dtor-ws>
In-Reply-To: <20190903231856.GA165165@dtor-ws>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Sep 2019 11:33:32 +0100
Message-ID: <CACRpkdYrSt7R8tA+zfN21DZpkz=1KaV5QihzHw7-KPCrUZhA-Q@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: of: fix fallback quirks handling
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 4, 2019 at 12:18 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> We should only try to execute fallback quirks handling when previous
> call returned -ENOENT, and not when we did not get -EPROBE_DEFER.
> The other errors should be treated as hard errors: we did find the GPIO
> description, but for some reason we failed to handle it properly.
>
> The fallbacks should only be executed when previous handlers returned
> -ENOENT, which means the mapping/description was not found.
>
> Also let's remove the explicit deferral handling when iterating through
> GPIO suffixes: it is not needed anymore as we will not be calling
> fallbacks for anything but -ENOENT.
>
> Fixes: df451f83e1fc ("gpio: of: fix Freescale SPI CS quirk handling")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch applied with Andy's review tag.

Sorry for not catching this before, the reasoning with the patch
is correct and I should have noticed. Overload I guess.

Yours,
Linus Walleij
