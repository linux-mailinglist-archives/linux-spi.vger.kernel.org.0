Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE84D113B
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 08:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiCHHoa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 02:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiCHHo3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 02:44:29 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25033B280;
        Mon,  7 Mar 2022 23:43:33 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id gm1so14046412qvb.7;
        Mon, 07 Mar 2022 23:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9ss0I2TcPyQQi0B3vt/XL1MTmMhZAB3vViRiACqSrg=;
        b=FGBTigACHIPwya0Ad0u4XHSjuTIkXU+TGMaoassuayR01ur3GYGb631WwMS7kLQYVC
         G6GqtEfo8xtpQeKTIvAFNTf93pat4O1zJ3NWEifD2CDD5EsbfFRM+35CJtf7YXBgbbZ7
         jcQA8H+5x50EN3lZyZqCA6gX+tY6o2bknizja2XzX3NeA/SrI7YLJgpWtEYrU8wCnoPS
         ifNDR51sc3b3IAa+jYL0xkwu3nhtikxB6F39F6RKS4I6xKm8Ud5k0Tql11YTSd8XvKKO
         LiDR6E6nJLBAJVYR4gPZmLXq5+ffjD5oLlbG23QJMyle95ypr80VStp8VFufyic0rU6u
         1kMw==
X-Gm-Message-State: AOAM531vVxKgWiXx+POauzRPaMyyUbQxOSMYur6Eb3PMAupf85i1aoeP
        mJYFsFuU6Fo9oVrQv36MAyX6uy967ZXsDA==
X-Google-Smtp-Source: ABdhPJzW9IiqAgMjv53DRe2tz6mJCUXvUg1MIkVd3GavlRBkwVeuaXxkDPOOgWrmKwr6XgJkJUNWFw==
X-Received: by 2002:a0c:d644:0:b0:432:e4b3:42a0 with SMTP id e4-20020a0cd644000000b00432e4b342a0mr10825943qvj.96.1646725412605;
        Mon, 07 Mar 2022 23:43:32 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id g202-20020a379dd3000000b0064932a7b992sm7400078qke.98.2022.03.07.23.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 23:43:32 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id l2so16555010ybe.8;
        Mon, 07 Mar 2022 23:43:31 -0800 (PST)
X-Received: by 2002:a25:bc8f:0:b0:628:8649:5c4b with SMTP id
 e15-20020a25bc8f000000b0062886495c4bmr10787075ybk.207.1646725411719; Mon, 07
 Mar 2022 23:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20220307180116.8388-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXPpM7nU=MZV=xJxZiOGyRGbgzuKxBR9EJsGJLWfD+Cbw@mail.gmail.com> <OS0PR01MB5922FECB366B55C75631BEA286089@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922FECB366B55C75631BEA286089@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 08:43:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWmvPnxyeJsVRdZdvxiFbt455us4ded9B30b01TLN3sQQ@mail.gmail.com>
Message-ID: <CAMuHMdWmvPnxyeJsVRdZdvxiFbt455us4ded9B30b01TLN3sQQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix invalid sgs value
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Biju,

On Mon, Mar 7, 2022 at 7:17 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH] spi: Fix invalid sgs value
> > On Mon, Mar 7, 2022 at 7:01 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > max_seg_size is unsigned int and it can have a value up to 2^32 (for
> > > eg:-RZ_DMAC driver sets dma_set_max_seg_size as U32_MAX) When this
> > > value is used in min_t() as an integer type, it becomes
> > > -1 and the value of sgs becomes 0.
> > >
> > > Fix this issue by replacing the 'int' data type with 'unsigned int'
> > > in min_t().
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -1019,10 +1019,10 @@ int spi_map_buf(struct spi_controller *ctlr,
> > struct device *dev,
> > >         int i, ret;
> > >
> > >         if (vmalloced_buf || kmap_buf) {
> > > -               desc_len = min_t(int, max_seg_size, PAGE_SIZE);
> > > +               desc_len = min_t(unsigned int, max_seg_size,
> > > + PAGE_SIZE);
> > >                 sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
> > >         } else if (virt_addr_valid(buf)) {
> > > -               desc_len = min_t(int, max_seg_size, ctlr->max_dma_len);
> > > +               desc_len = min_t(unsigned int, max_seg_size, (unsigned
> > > + int)ctlr->max_dma_len);
> >
> > The cast of the last parameter is not needed.
>
> OK. I thought since last param is size_t, casting is required.

That's exactly what min_t() does, but using an easier-to-grep-for
notation:
"min_t(type, a, b)" is equivalent to "min((type)a, (type)b)".

> OK will drop this.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
