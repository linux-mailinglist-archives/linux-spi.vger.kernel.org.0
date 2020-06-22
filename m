Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF549203D6C
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jun 2020 19:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgFVREi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jun 2020 13:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbgFVREb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Jun 2020 13:04:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5029C06179B
        for <linux-spi@vger.kernel.org>; Mon, 22 Jun 2020 10:04:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so104281pje.4
        for <linux-spi@vger.kernel.org>; Mon, 22 Jun 2020 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+m5221Ut6o3WuT6BjiL72c05hVwdkXllFG7aX4yJx4M=;
        b=qKm/WhlsQKDgGm0JFnkCdb0IzzhquY358SdW3YjXotmWgdudNMJZnXNXgvLG0UCoo9
         7Cw6pnkmDWaW0NfZwL15NqU9yndpUvZfap4/r4/N0EchCfKEkHwdBZzA06x2GNQH+3Mt
         J/3WYO6M5B8qpkeQr8fpVlBadLhCAZf2C9poaWq+QLaHYcQ0rGyiUjvhR65Bxkj+hA2b
         s9+jLdjx7crDjAvCyWnbR0bBghdrf6Nltn1qYGOn5boJGAxwdb3AWa19DW56iVy38cNF
         K25EWlpr0J4GIzjxfrzpPzlHwPqk4eyUHRflEds57fzvbDL6gzcelUVq6RZ2ZRqHOBVq
         4aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+m5221Ut6o3WuT6BjiL72c05hVwdkXllFG7aX4yJx4M=;
        b=GjnL9kdE0LVVSIirKt2KJMNXoPGPt2ef7Pt+yDaiAHZERKmQKm6s07YzviyCm8wOjj
         3HZz8h8nprtVmy6Kzg/Esulehx9j/XtgPYCzxUh1OaEd0G0Y7UNKyxqe6iNC8cY857oX
         WmaRkazGi5FoT/eBy1N+aUFr6DdJ2jicpLHAI9cpGKJaL+tDjEt7Hb1808JgRSDFUVy0
         n/QU9x2qqdnXQjiMz+m++OW4ESUbMV6Bkt5ChY7Rj9Nhiiva3b/GFw4axpVKWQg69kRL
         /5hiz5Q8CYiTwMQ1VGeI0N4UAkf3UDN1lB2bD701/FB7ikz33PPS9plxmJvDvyFF5QS8
         o7Yg==
X-Gm-Message-State: AOAM533WDAIpsn5T/bJBdjFtxkt8YRrROK4kERHWIOwpC4V9GKUVTDdv
        R04L/Nc6MipqF77otlXjJNSAd0PH2lFwwdo7bJZqTg==
X-Google-Smtp-Source: ABdhPJwq3U6/P+kOQWrtaPsfC7pEtXaKjHv6HeLE+nRTnxPEDc+MHw061OC9xpPpZ7i7YIPBLzcZEdJFmiD+WA1tEsk=
X-Received: by 2002:a17:90a:e2c4:: with SMTP id fr4mr19317188pjb.32.1592845469798;
 Mon, 22 Jun 2020 10:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200620033007.1444705-1-keescook@chromium.org> <20200620033007.1444705-5-keescook@chromium.org>
In-Reply-To: <20200620033007.1444705-5-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jun 2020 10:04:18 -0700
Message-ID: <CAKwvOdmsXuqx-3Rt_KNFq4psAeFjG2-7qQaqkJ7dDqqmscUFNw@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] b43: Remove uninitialized_var() usage
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org,
        Network Development <netdev@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 19, 2020 at 8:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings (e.g.
> "unused variable"). If the compiler thinks it is uninitialized, either
> simply initialize the variable or make compiler changes. As a precursor
> to removing[2] this[3] macro[4], just initialize this variable to NULL.
> No later NULL deref is possible due to the early returns outside of the
> (phy->rev >= 7 && phy->rev < 19) case, which explicitly tests for NULL.
>
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>
> Fixes: 58619b14d106 ("b43: move under broadcom vendor directory")
> Signed-off-by: Kees Cook <keescook@chromium.org>

I see three total uses of uninitialized_var() in this file, do we want
to eliminate all of them?

> ---
>  drivers/net/wireless/broadcom/b43/phy_n.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
> index c33b4235839d..46db91846007 100644
> --- a/drivers/net/wireless/broadcom/b43/phy_n.c
> +++ b/drivers/net/wireless/broadcom/b43/phy_n.c
> @@ -4222,7 +4222,7 @@ static void b43_nphy_tx_gain_table_upload(struct b43_wldev *dev)
>         u32 rfpwr_offset;
>         u8 pga_gain, pad_gain;
>         int i;
> -       const s16 *uninitialized_var(rf_pwr_offset_table);
> +       const s16 *rf_pwr_offset_table = NULL;
>
>         table = b43_nphy_get_tx_gain_table(dev);
>         if (!table)
> --

-- 
Thanks,
~Nick Desaulniers
