Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747B432514C
	for <lists+linux-spi@lfdr.de>; Thu, 25 Feb 2021 15:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhBYOKK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Feb 2021 09:10:10 -0500
Received: from mail-yb1-f179.google.com ([209.85.219.179]:37202 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhBYOKH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Feb 2021 09:10:07 -0500
Received: by mail-yb1-f179.google.com with SMTP id p193so5527570yba.4;
        Thu, 25 Feb 2021 06:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Es5XNJa+9iwk/MVy1/C4neul9HbJdUAtiHxYan40OFg=;
        b=pG0Mp5OccvcKNpGwF304+8ygk39X6KIZl1ItOToZ4vbrynUDJNrERN60RxGdVw8Bqo
         nBh9DNcQgGhtQHdIxfQa/oXD8NdYK1E4Q6z3VBk//lTrBlk4yjQN+5kQR9gGQM619Hpk
         XNLkTNER5TRnPbcv5KPXn9sLF7VKNtbAMJuZm19bxiFNimJIQJdsuYfcjRQtLNu/AX8O
         mbiD9lrUWp7Gc17i3Y1dWFgvXTRuCA5ExOmglsnSz/tmdpSzviIcF+6wjPI7tVIMaYbj
         6VtP1NaeE7h5Gwi8U1E6UxIpxJw+qc2uOa5lOT05AiGyXEjanUjWBACuvj+qI4wE9MXF
         8ZRA==
X-Gm-Message-State: AOAM530vRFxPk82yjllwNbqvtZwGqNUf8W/g6CTmk5s81q1HJQ8qG7nv
        MQE0VV2WSsuk7hBSNmX3r0yTBPQz1feChXeYMe/Nk0eTQV1ezg==
X-Google-Smtp-Source: ABdhPJznLeyC6BnYFkpCmYVfHyYd+Yr+VQKBcKGQWFjTCaAbcUCo7BKZQJ/6U71x6ZA5evp6BfOvPTSN5cwrv9asZ4I=
X-Received: by 2002:a25:bbd0:: with SMTP id c16mr4092373ybk.23.1614262165784;
 Thu, 25 Feb 2021 06:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20210225125541.1808719-1-arnd@kernel.org>
In-Reply-To: <20210225125541.1808719-1-arnd@kernel.org>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Thu, 25 Feb 2021 15:09:13 +0100
Message-ID: <CANBLGczcWOYyEavx6H1Uk-KvQzTJoq2qC72f22K8ZP-TS5hSnw@mail.gmail.com>
Subject: Re: [PATCH] spi: rockchip: avoid objtool warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jon Lin <jon.lin@rock-chips.com>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Alexander Kochetkov <al.kochet@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        linux-spi@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 25 Feb 2021 at 13:55, Arnd Bergmann <arnd@kernel.org> wrote:
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
>
> Fixes: 65498c6ae241 ("spi: rockchip: support 4bit words")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Emil Renner Berthing <kernel@esmil.dk>

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
