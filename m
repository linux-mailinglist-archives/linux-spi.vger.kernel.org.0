Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0C5EBB2C
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 09:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiI0HLT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 03:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiI0HLS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 03:11:18 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31FA6C56
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 00:11:16 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id cj27so5508640qtb.7
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 00:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JK82yNRvtqLc00Ws2oZcJq4aTs1A2QbEXwaYmwu2tAQ=;
        b=QfZnT64AjviynZoQYLHXxi+1FM58sCgDon6wHnjn/f1MaXtg/1G4vJ2eYROtNBZzDO
         Ht2AjFwYzx5xInrmpXbPek6Lpbke4g1dsmcDJJMZMq4sZEHsIsO25rEUMpBYOypEitqM
         +Y1wPjbtro/g49LYVHcVkcsQlDZQHEH1OPoc7d8GhtsrdrDbPvKmf4Z4RG0+26RLer6g
         8POxZcLr/Kl+cK8Ergy39cKhRvTLBN5OngrDfLmw6sp50slNs57nYclqCQwQf9FVbO3e
         Sm8kJiej041a6HtWIYmAmQxvj4FBvTxRyuuL1YyIdCV28OIvOa6yNq8GQD3ty79TVLF2
         QtgA==
X-Gm-Message-State: ACrzQf3eiPJBonTGEm+oWSwnbf5oUcZX8pEPoH/DdM8fWyClehlDCkHA
        BaWKlWZMCvsw6g1e9IFalDuYw5C1yAErLA==
X-Google-Smtp-Source: AMsMyM6o+PvGx+xyfH0Qxs1pqh/ve6pTScb6iRv/+1kj+caUfMOT5VvgDyPhLo2kzrpD9jxRJ56SQA==
X-Received: by 2002:ac8:5b0e:0:b0:35c:bae7:d9eb with SMTP id m14-20020ac85b0e000000b0035cbae7d9ebmr21245388qtw.681.1664262675322;
        Tue, 27 Sep 2022 00:11:15 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id a2-20020ac81082000000b0035d1f846b91sm374792qtj.64.2022.09.27.00.11.14
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 00:11:15 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id p69so11265795yba.0
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 00:11:14 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr23151951ybl.604.1664262674564; Tue, 27
 Sep 2022 00:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220926142933.2299460-1-yangyingliang@huawei.com> <20220927034525.GA32253@wunner.de>
In-Reply-To: <20220927034525.GA32253@wunner.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Sep 2022 09:11:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXFnAOP_NorpOt9gas6WtvSiMebxna_FZXzgJSXwEWX9A@mail.gmail.com>
Message-ID: <CAMuHMdXFnAOP_NorpOt9gas6WtvSiMebxna_FZXzgJSXwEWX9A@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lukas,

On Tue, Sep 27, 2022 at 5:45 AM Lukas Wunner <lukas@wunner.de> wrote:
> [+cc Geert, who originally came up with "spi_controller"]
>
> On Mon, Sep 26, 2022 at 10:29:32PM +0800, Yang Yingliang wrote:
> > Introduce devm_spi_alloc_controller() to wrap __devm_spi_alloc_controller(),
> > with this wrapper, the drivers can use it to update to the modern naming.
> [...]
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -778,6 +778,12 @@ static inline struct spi_controller *devm_spi_alloc_slave(struct device *dev,
> >       return __devm_spi_alloc_controller(dev, size, true);
> >  }
> >
> > +static inline struct spi_controller *devm_spi_alloc_controller(struct device *dev,
> > +                                                            unsigned int size)
> > +{
> > +     return __devm_spi_alloc_controller(dev, size, false);
> > +}
> > +
> >  extern int spi_register_controller(struct spi_controller *ctlr);
> >  extern int devm_spi_register_controller(struct device *dev,
> >                                       struct spi_controller *ctlr);
>
> This doesn't really make sense I'm afraid.  The umbrella term
> "spi_controller" can refer to either a master or a slave.
> One has to specify on allocation which of the two is desired.
>
> An API which purports to allow allocation of the umbrella term
> but defaults to a master behind the scenes seems misleading to me.

Moreover, you already added devm_spi_alloc_master() and
devm_spi_alloc_slave() in commit 5e844cc37a5cbaa4 ("spi: Introduce
device-managed SPI controller allocation") in v5.10 ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
