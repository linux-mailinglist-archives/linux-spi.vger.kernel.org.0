Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB415BABD
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 09:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgBMI0b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Feb 2020 03:26:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43044 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMI0a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Feb 2020 03:26:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so4741849oth.10;
        Thu, 13 Feb 2020 00:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFkQl6NOscQuei7LQaq+MljWAEd7BswkSjJA8CjWHao=;
        b=PkyfVK2rszYo2MQgvsm/NKRAHgph4VaKIZBvSkggz2FOagg5GewlEA35x2zDpJcvXO
         YhN70584fV1K1WTt4lV2XRFLFuDL6/K148P+cB5+Xj6Qm7vDkcYL19E/a9PFm7bNkmNx
         kbYVlL8C7lGCm/YzC1qZ4GtP0tgTy+Z8ebDZy+cwMChLRoMn4IGQXJYiFFkIPzCnn7P/
         Vn73pa+Fo0+FcDveaWIYlV9ZSauZRtzIGo30LQeUnTLaMcb/FCO46X37FsqNRAB5IvfK
         Npyerb5em7T1hRRrJkVtQmc+T3c23vSqXW5zai+dPnzzNTb6OOXjw+nzN7WENiz/NZ4E
         CvNg==
X-Gm-Message-State: APjAAAUKp5C/9aIJDG1OAKXNYXeldAH88xsJXyjzIcoSLiGx28rJxs/k
        5KXq7TSwvMpGNrraTRADFfOS/fAEOcI2m6jnHiMI+/4W
X-Google-Smtp-Source: APXvYqyiMHu10QaIdyNLPnx1fzKkFpgHJA8E8PC1EeL8qUGj2ImyP3UpKCF1uUxEz8CnnAzWAH/VazxDRwbP/sPvJG0=
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr12410749oth.145.1581582390035;
 Thu, 13 Feb 2020 00:26:30 -0800 (PST)
MIME-Version: 1.0
References: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn> <1581567368-8055-2-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1581567368-8055-2-git-send-email-yangtiezhu@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Feb 2020 09:26:19 +0100
Message-ID: <CAMuHMdXi4ieMvZY1J8RjuOeR+vKrTmASq-40MK27xutZPv4deQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] spi: spidev_test: Check input_tx and input_file first
 after parse options
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Tiezhu,

On Thu, Feb 13, 2020 at 5:17 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> It is better to check input_tx and input_file first after parse options.
> Otherwise, it will do some useless operations when both -p and --input
> are selected.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/tools/spi/spidev_test.c
> +++ b/tools/spi/spidev_test.c
> @@ -404,6 +404,9 @@ int main(int argc, char *argv[])
>
>         parse_opts(argc, argv);
>
> +       if (input_tx && input_file)
> +               pabort("only one of -p and --input may be selected");
> +

Alternatively, this check could be moved to the end of parse_opts().

>         fd = open(device, O_RDWR);
>         if (fd < 0)
>                 pabort("can't open device");

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
