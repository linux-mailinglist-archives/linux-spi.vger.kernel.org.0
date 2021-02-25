Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4AD325881
	for <lists+linux-spi@lfdr.de>; Thu, 25 Feb 2021 22:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhBYVRg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Feb 2021 16:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhBYVRb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Feb 2021 16:17:31 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263A8C06174A
        for <linux-spi@vger.kernel.org>; Thu, 25 Feb 2021 13:16:51 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id c8so8124902ljd.12
        for <linux-spi@vger.kernel.org>; Thu, 25 Feb 2021 13:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Q5jeV0/eI5MVanjQDC59pyS/bWWpJw2xxtG8W1c7H4=;
        b=lSDsTa8+1W/LrXlNbDCet5BRX7EP5F6fAfIS4wDDgeQxu1IDh/qbnAteagqoVU/4kt
         0hUW0AMRMdI5mL1PWlNAlkFWnXHFNW+JMVbA1ApVnBUrA1lkPZSqxHpIG3CDDRHc4exv
         WpzZ5/9965fNkK5SJ2SjZR9aCd3KqnbYIaFF8CBANIB0L+enAl72WgK7bJi1wVsdpQna
         irU4+WZ2ROO7Z80oUaV8Vv84aUTnMF6bQ0CX/x/IZ/OGnB8AGcJO7o5D04R1RdtokRx+
         exfZd2Jn12m7Z7EpFkp59f2TNUutRHx4aaA4GiBTXT6sJ9mabLs6TgFUzdH5PmkM81k3
         2XBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Q5jeV0/eI5MVanjQDC59pyS/bWWpJw2xxtG8W1c7H4=;
        b=bkpCiinz36jmygFSpoilmFP1yEPJdgMgSM98Wt4p0RY0vwH3PfRtqwMUe5fvnGHSUm
         Klt34FdzQ4CpX7xvnfeXQaZJOiPYZ6yQNMDAVgPXRRD45Y+rbGUxZ7RU9cNcFRMCPLJq
         D8XKgp2VhmCZeclxLSzOugINQLII5WCbBwtuSWp+KPOFVcwgXK4vFY7s/nmvw6kSC3Qf
         ZSi8H70eayeqzCvTK8yjTTCFPQfspdHtkHy/HbxMmE5QtRCK4U0lHnQyY3GQ/Q11je9g
         vL8yt4x1h9zR28zVXipdvss8cUVZf1ar2DLCIhMHFJgbLq6PjU6EZ85t0BDiIYz1VrFw
         F/mw==
X-Gm-Message-State: AOAM530T0r1nLx0nrTj3COW7NoZ+jZ97CY/uQOrR5XxtPvT396IbgZtj
        iUzQiKjbDdwFzvuxSG6rzQ0hhEpQgIHUW+aGwHIrsQ==
X-Google-Smtp-Source: ABdhPJyoukkJIzbnUCTDgEc8ErCmiFKnaC//5UEi7GGwOSyywu4N1VzA/uVndHYzTf2iwxBHw4DsoQHM4/1tXrcLxow=
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr2535739ljp.495.1614287809489;
 Thu, 25 Feb 2021 13:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20210225125541.1808719-1-arnd@kernel.org>
In-Reply-To: <20210225125541.1808719-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Feb 2021 13:16:38 -0800
Message-ID: <CAKwvOdkcR=8Ay+VaOym6y4ySC-x+=dfTjN_HDLs-281KdUhojA@mail.gmail.com>
Subject: Re: [PATCH] spi: rockchip: avoid objtool warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Jon Lin <jon.lin@rock-chips.com>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Alexander Kochetkov <al.kochet@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        linux-spi@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 25, 2021 at 4:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building this file with clang leads to a an unreachable code path
> causing a warning from objtool:
>
> drivers/spi/spi-rockchip.o: warning: objtool: rockchip_spi_transfer_one()+0x2e0: sibling call from callable instruction with modified stack frame
>
> Use BUG() instead of unreachable() to avoid the undefined behavior
> if it does happen.

Thanks for the patch!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 65498c6ae241 ("spi: rockchip: support 4bit words")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/spi/spi-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 936ef54e0903..972beac1169a 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -521,7 +521,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
>                  * ctlr->bits_per_word_mask, so this shouldn't
>                  * happen
>                  */
> -               unreachable();
> +               BUG();
>         }
>
>         if (use_dma) {
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
