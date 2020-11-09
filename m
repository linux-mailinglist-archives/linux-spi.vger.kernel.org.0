Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440772ABF7B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 16:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgKIPOj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 10:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbgKIPNe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 10:13:34 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047BAC0613CF;
        Mon,  9 Nov 2020 07:13:32 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e21so7381202pgr.11;
        Mon, 09 Nov 2020 07:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHWsdF+9c9Znyw/+xmlrHFHZZNlg9caiciX5yI+PJqg=;
        b=h/xYBWjJerd+Nng65RxzaEks1xJhwINQyY9Kk84UP0ulcLuRhnmTobsVYl3EaoGFCr
         pmRS8cTieTCtPXnqRHSV81aivSlGEFes5pjpp+y+DAjSEjaETUwjo3t7vma6iGQpHtaA
         qr3Rn9lg5N9jeL+Hlgd6tevc5NbF3r5DuW9qEcUbSMWmIO/fU4BZwQndEgYRP4zocklU
         ZmgImOQ17grJhUCyvTmxMCR4ocfKILJSZMBwVVzqk1G/oTvwKehmO/xQB6rTtzYJHxxA
         46TfEl4s0YenH/OSsT0v8VTAoIXqo7BPVjX530QwGZRCIPobomB982/lQwc7wXvK3h1h
         zKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHWsdF+9c9Znyw/+xmlrHFHZZNlg9caiciX5yI+PJqg=;
        b=gHmMwMJNnLOKHqbXk9EgyOL8kJJxdDWjdjUZtpZQn5qQiGsvR4SLa+u/Fa1rocsX/t
         tjb5pnYzXuMz8RR9x8ZQzj5YXBwzWOMssGaerUQS2YxcL0n4DfZJsZFMoVNgZYlrwUaJ
         ijvLdafohk1SAVu3494Go6SctnTE4XyjqiLSXRBtmV8i5bgbmCApsyBYVBaHGnQo5lU4
         o7VKdvhfYfw9R35EeCrGCeEsArEcdIKQNMMs4tPWo2fN3P+0Bp7bzDAMIVI5DyAP7DdS
         0NS8P9WPufG8vpdEBBc6LoE0gCeEpV7fLVdXq+iu08hJgoZ1ZKUVOAc/j54+CFkZUPPE
         ufWA==
X-Gm-Message-State: AOAM532StM3jfcToTj8WG8IZCFhHis0kIA4pCkV3E9Rs6h8qgo1Tpr0H
        kdX7VIxM+sp6780wsTU94ogF5NSGVCcMe6ax96I=
X-Google-Smtp-Source: ABdhPJzbzt1UYLvSnFqF0Z8uM3EiVS1ndggK5B8kpcpbTxvC1ovHRrCqnbQrmSaPrTMJIc851fa8tqkAO+ZtDX3BrV8=
X-Received: by 2002:a63:4511:: with SMTP id s17mr13179323pga.4.1604934812562;
 Mon, 09 Nov 2020 07:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-2-damien.lemoal@wdc.com>
In-Reply-To: <20201107081420.60325-2-damien.lemoal@wdc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Nov 2020 17:14:21 +0200
Message-ID: <CAHp75VfvUZ6h+JGCUQ65i7qFsugvbd3n=aCprgvp=geRSpQEhQ@mail.gmail.com>
Subject: Re: [PATCH 01/32] of: Fix property supplier parsing
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 7, 2020 at 10:14 AM Damien Le Moal <damien.lemoal@wdc.com> wrote:

> @@ -1308,7 +1308,6 @@ DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
>  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> -DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")

Sorry, but the above doesn't sound right to me.
It's a generic code and you may imagine how many systems you broke by
this change.

-- 
With Best Regards,
Andy Shevchenko
