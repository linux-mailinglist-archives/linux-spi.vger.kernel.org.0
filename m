Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51C05EE2D7
	for <lists+linux-spi@lfdr.de>; Wed, 28 Sep 2022 19:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiI1RPw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Sep 2022 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiI1RPR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Sep 2022 13:15:17 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD91031F
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 10:14:34 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id d17so8248688qko.13
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 10:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=B+fhgi1Xeto3l3kIO9+Bw6gY/52pJByebtQ+QZYcpQg=;
        b=TNYDR3VYihfPQjPman3giOBLxPmFeaQ4g7CcWEnrtBI0Xygd/vjtECks2WNBQ3h/aH
         +1mfnXWhzyuYUc40tvZZwgxnwi1TiVNzr2bbhT7Ik0EEkERiJhNuXyzHKb1K7Q1knvea
         JcUBrMu5hX/D187snlLL93ez0+ojbKUZ6f48y4O8V+8Lfztv+5cP4NnYOXoJ6UnXJQA4
         UxWXF2bBSknze/Ie2YrpZ/pLhiodpwlMPCUMjFjKnkTtVPvDlwUlLJcRUyL40Xz1IXcD
         b3U+7HNGEkaEwd+yXwbhFmxM/fYK8eUppXaYXiaCIf1OcpMiHO5IcS0ynvcSupZ8spRp
         pbcg==
X-Gm-Message-State: ACrzQf3DCx6ZJtio3m0UdoNDbUqIxAS2AK5bQPgkBuuS45s7CIEAhBzM
        QUyT77O1aEq+b4kAihv28kPdFrBZDZAIPg==
X-Google-Smtp-Source: AMsMyM70+3U3hym6Z3Ic6uedjVRTOCc1+3HJwOq1v1OAE3p9/nyInSwhP3xNWdOY5HyZSq2QRkbbqg==
X-Received: by 2002:a05:620a:662:b0:6cd:edf6:70bf with SMTP id a2-20020a05620a066200b006cdedf670bfmr21554903qkh.209.1664385272796;
        Wed, 28 Sep 2022 10:14:32 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id p186-20020a37bfc3000000b006ce5fe31c2dsm3470751qkf.65.2022.09.28.10.14.32
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:14:32 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-345528ceb87so136969327b3.11
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 10:14:32 -0700 (PDT)
X-Received: by 2002:a81:78f:0:b0:34d:74c0:1110 with SMTP id
 137-20020a81078f000000b0034d74c01110mr31697724ywh.383.1664385272149; Wed, 28
 Sep 2022 10:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de> <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com> <20220927133129.GA29821@wunner.de>
 <YzMsc1IM/73CMEeg@sirena.org.uk> <20220927201901.GB24652@wunner.de>
 <YzNbhPjn27cWHwyi@sirena.org.uk> <CAMuHMdWb8qeUGbr-zku4-zAM4Zj5MgCLJKR=Xg=Txe39kno8Og@mail.gmail.com>
 <YzQsw8hiMTxdqZuu@sirena.org.uk> <20220928151116.GA13418@wunner.de>
In-Reply-To: <20220928151116.GA13418@wunner.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Sep 2022 19:14:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVCg0RiVxCNbwZgvEvUmA7pKQn2DpxZxgPx6FYwSjfnJw@mail.gmail.com>
Message-ID: <CAMuHMdVCg0RiVxCNbwZgvEvUmA7pKQn2DpxZxgPx6FYwSjfnJw@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
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

On Wed, Sep 28, 2022 at 5:11 PM Lukas Wunner <lukas@wunner.de> wrote:
> On Wed, Sep 28, 2022 at 12:15:15PM +0100, Mark Brown wrote:
> > On Tue, Sep 27, 2022 at 10:43:08PM +0200, Geert Uytterhoeven wrote:
> > > On Tue, Sep 27, 2022 at 10:24 PM Mark Brown <broonie@kernel.org> wrote:
> > > > Sure, but since the current wrappers use the legacy names this means
> > > > that we need new wrappers with more modern names hence there is
> > > > something to improve here.
> >
> > > So what are the more modern names?
> >
> > It's unfortunately not 100% clear, and our use of controller for the
> > generic thing gets in the way a bit.  There was some stuff from one of
> > the open source hardware groups recently that tried to propose new names
> > but I'm not immediately finding it.  "host" and "target" would probably
> > do the trick?
>
> Perhaps you mean that one?
>
> https://www.oshwa.org/a-resolution-to-redefine-spi-signal-names/
>
> Looks like they're replacing master with controller and
> slave with peripheral.

In an inconsistent way: there is no peripheral select, but a chip select.

> Pity, we're using controller as
> an umbrella term for either one of them.

So we have a controller controller, and a peripheral controller ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
