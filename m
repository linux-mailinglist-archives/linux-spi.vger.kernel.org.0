Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C249C15BAC3
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 09:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgBMI2E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Feb 2020 03:28:04 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37369 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgBMI2E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Feb 2020 03:28:04 -0500
Received: by mail-oi1-f195.google.com with SMTP id q84so4971053oic.4;
        Thu, 13 Feb 2020 00:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUdfEmpu25mRYOfIJZi8kyE6tBIrXeyCx0UzQu32/XA=;
        b=AQySvvjEjlb1uUFdUtPLjHAUs6j1M3BPfSGpjUFjTWq1vbN2A5/m4qasmx8wZkojdS
         KVgXsmC1RolIE9v3Q3PuHzCw83krVvrZ42KoORr/bh0IaeC1D58sXT1CjVABOnyEY80T
         5FuXi/SAVVxQnshE5THi9tqVYACV84vZSFZE+Vw5YQ9qlAByJAxymsttlOw/4BK3bFfb
         F4SeISd7w0EmZRPK34oGsdiFFTLqZ5Qa0QnfS09Me3CqSSPbRu1WDs5RRJ9Ca6eZ0+cE
         CEv+VnMolWazD7ugDRvq5S0FVvatmmua68dldm8VW5JvDVwMV6j8ig2qKoBSeu9R5+J9
         ixQA==
X-Gm-Message-State: APjAAAUGppuYg/4FSeI0RBCSK874NtzoGm1kPhS68UjITjlROa0g3FSi
        dVUvfe0vZQp+3gen8y9rOJ6VS+O7XbUh6m1U19E=
X-Google-Smtp-Source: APXvYqzeMYQ5gY/uBVauBiLyeVV9ChtdJB+OknQWQXs1t4BPSV9IamFUEpgUgmXJJJ4OBpq1W8fJl+UT1b2y2UWEx1I=
X-Received: by 2002:a54:4707:: with SMTP id k7mr1994108oik.153.1581582483924;
 Thu, 13 Feb 2020 00:28:03 -0800 (PST)
MIME-Version: 1.0
References: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn> <1581567368-8055-3-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1581567368-8055-3-git-send-email-yangtiezhu@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Feb 2020 09:27:52 +0100
Message-ID: <CAMuHMdWb2ZxtFQC0ukCVbPhX2M50k0aQ0nvmRfD02FAksEJOfQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] spi: spidev_test: Use perror() only if errno is not 0
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 13, 2020 at 5:17 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> It is better to use perror() only if errno is not 0, it should use printf()
> when errno is 0, otherwise there exists redudant ": Success".
>
> E.g. without this patch:
>
> $ ./spidev_test -p 1234 --input test.bin
> only one of -p and --input may be selected: Success
> Aborted (core dumped)
>
> With this patch:
>
> $ ./spidev_test -p 1234 --input test.bin
> only one of -p and --input may be selected
> Aborted (core dumped)
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
