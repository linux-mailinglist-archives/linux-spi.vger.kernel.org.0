Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E72ABF70
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 16:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgKIPJb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 10:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbgKIPJW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 10:09:22 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A315CC0613CF;
        Mon,  9 Nov 2020 07:09:22 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so8448061pfn.0;
        Mon, 09 Nov 2020 07:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXgL7bSpCk7huS0ble+eQtkF8YqujPFaIjmAgT6P/OY=;
        b=Zv8bGc1NiJu8a6ryJT8jY18QHrQKXvat8QSsQZB68X0umR8p3tPO/KelI+PraSirmh
         mTqj+ufpkwBOX42ckRrDwLYFXVz4iS8tPLkrMchAP0mP44el5uTcfVawcwvXcHA6u8zt
         I6oTwdD7rr8U5DYoIHA3zVN7/Cf+33Fbgp8jA8DR3dzWWwm4Z2PrrewN6O6iSX7qoj/U
         5ZRlhCyvCE6tCacFAfs3iNTACEZqYyeAVWFQePsdr6pWIv37Hi48x51mdciktsaEn73e
         Jcg2VY3s5+z2jKfm/ZhsUYsr9za/PXzxevrxfY4p2wbfIeMJMlOHe3Wa0t+DMP6DpSQm
         N3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXgL7bSpCk7huS0ble+eQtkF8YqujPFaIjmAgT6P/OY=;
        b=nwEqAKbpMEUNm48KQ+/l1+BpcOLFD+6cEQ7xtAs08/Ueo1M92hJvwEhCJ/EJxuf/qV
         BwcTamknCxvbSotatqc2kxUTkifUEKG5CcNsjcqcnlcDNXYUhNgfPh6gDgEQkeiXYwOn
         ggJv+uRHdnNeUYXtnK9u+xPlm5w1zAaLJ6RiLmHRUbnSwPKXUjtE1h6kQ7YreM2PgBbE
         0gugXN0do1ZMCt83RF/64Uf8gFtQ60rAOH7JjjhmRQ8lyy0LNvsKZKC6+wtdzoeP43uL
         gaNTbXsZtEdWGtc2FFaI3eLQW/mtWamX+LjGhkUkawicjkO1A2+lT2GCN/qDVWv9nbDn
         ILqw==
X-Gm-Message-State: AOAM530WB5CzTMBNHdICl/V4QM/UqZ29IygriKG+rbKmBUhzMRFYnJfs
        iG7V2rWzpATs1F2diXGiEIXNTvi0BuslTGRUJtM=
X-Google-Smtp-Source: ABdhPJyMSquh48GLk2NIL2CXXYgRILy6QvYqhJ4/SJTpzUiyihT8kl81IiarqQ+V+G7O1I1FnWuQFCQ91u1hJRmsjWA=
X-Received: by 2002:a17:90a:430b:: with SMTP id q11mr13852276pjg.129.1604934562239;
 Mon, 09 Nov 2020 07:09:22 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-3-damien.lemoal@wdc.com>
 <20201109142529.tt5ojjyn36vd3ohe@mobilestation> <6dc6d52e-a39d-c351-5280-71b9e8eafe37@gmail.com>
 <CAHp75VejtoTRAM1JmGib3OaJwzuw9Bb-qb08+XhdZUOuzTGUKw@mail.gmail.com>
 <CAHp75Vc+h5PCqBUnyFshw8RE4zWusE+zdvKKSxBxfFw1_5k0vQ@mail.gmail.com> <7e8bba71-763e-2e09-88d2-d736a56a6920@gmail.com>
In-Reply-To: <7e8bba71-763e-2e09-88d2-d736a56a6920@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Nov 2020 17:10:11 +0200
Message-ID: <CAHp75VdFd11XRQ5xj02=5NDZkPNc1xvdjayXBJk28VzgZH7bFQ@mail.gmail.com>
Subject: Re: [PATCH 02/32] spi: dw: Add support for 32-bits ctrlr0 layout
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 9, 2020 at 4:49 PM Sean Anderson <seanga2@gmail.com> wrote:
> On 11/9/20 9:41 AM, Andy Shevchenko wrote:
> > On Mon, Nov 9, 2020 at 4:40 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
...

> > For DW_ssi v1.x DFS is always for transfers up to 32-bit.
>
> Do you mean DWC_ssi?

One is called DWC_ssi (yes, the newer IP)
The other is DW_apb_ssi (the older one)



--
With Best Regards,
Andy Shevchenko
