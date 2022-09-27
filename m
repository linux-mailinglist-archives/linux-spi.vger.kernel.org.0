Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6865ECED5
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 22:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiI0UnY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiI0UnX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 16:43:23 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB3B10194B
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 13:43:21 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id s9so6797531qkg.4
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 13:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bvj+/fKclZERPZ1ExossQHs6Penbj8NKdbet3CgkCuU=;
        b=bL6cy5fY93zs/yyptSp4J1zuwBKgErY0QoqXGk02THZP+bYvQHWJ3BARPe17Fet092
         26HJSDGsgwU4QmnoxSHss7fwJyrXgdO15vbm1Pid/C20fGnExfCwfrtuPqpqnz9zcnL5
         YZi6xURRH07d8ehT1HbeYGfb6w4QY6ZHG+rw1YTkln/C3o/V+ZcWxDJO14pzK3d7f5aE
         Y9DNmTEQTsuDBy/IOF5pOfV+W8JUhP84CsQCFGqAy3o/oadBr0RoVmlU8r0RnMB7HNWL
         7TL4VGgRoEYEPPufqxBIJ+g710jMHzq1872hxgmJ7iPbLwtqXexXEAt1UP9AnS27Gd6z
         17aA==
X-Gm-Message-State: ACrzQf2u5yOjvmmIRW/nJecmTUrA77jii/vuvlsS7SkMjQ/jx9k0HEKB
        3z51q63YZhXQskT6ubXReuQIAt6ycFLLYA==
X-Google-Smtp-Source: AMsMyM6UOIWk10cUa3DZktVvhV7MQE0k+luzfeZ0TByysw5rHHqcAz0sx2kYAbDZ+sf3lt04Kioo/Q==
X-Received: by 2002:a05:620a:462c:b0:6ce:3aa5:417e with SMTP id br44-20020a05620a462c00b006ce3aa5417emr19810970qkb.736.1664311400868;
        Tue, 27 Sep 2022 13:43:20 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id x17-20020a05620a449100b006ce5f4720cdsm1927779qkp.47.2022.09.27.13.43.20
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 13:43:20 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 135so13616288ybl.9
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 13:43:20 -0700 (PDT)
X-Received: by 2002:a25:3a02:0:b0:6bb:fce3:7b06 with SMTP id
 h2-20020a253a02000000b006bbfce37b06mr7546182yba.89.1664311399802; Tue, 27 Sep
 2022 13:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de> <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com> <20220927133129.GA29821@wunner.de>
 <YzMsc1IM/73CMEeg@sirena.org.uk> <20220927201901.GB24652@wunner.de> <YzNbhPjn27cWHwyi@sirena.org.uk>
In-Reply-To: <YzNbhPjn27cWHwyi@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Sep 2022 22:43:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWb8qeUGbr-zku4-zAM4Zj5MgCLJKR=Xg=Txe39kno8Og@mail.gmail.com>
Message-ID: <CAMuHMdWb8qeUGbr-zku4-zAM4Zj5MgCLJKR=Xg=Txe39kno8Og@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
To:     Mark Brown <broonie@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
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

Hi Mark,

On Tue, Sep 27, 2022 at 10:24 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 27, 2022 at 10:19:01PM +0200, Lukas Wunner wrote:
> > On Tue, Sep 27, 2022 at 06:01:39PM +0100, Mark Brown wrote:
> > > On Tue, Sep 27, 2022 at 03:31:29PM +0200, Lukas Wunner wrote:
> > > > On Tue, Sep 27, 2022 at 07:57:05PM +0800, Yang Yingliang wrote:
>
> > > > > Do you mean to introduce two more proper wrappers to instead of
> > > > > devm_spi_alloc_master/slave() ?
>
> > > > Honestly I don't think there's room for (or a need for) improvement here.
>
> > > The issue here is that we're trying to get rid of the master/slave
> > > terminology.
>
> > Converting drivers to use spi_controller everywhere in lieu of
> > spi_master is fine, but drivers need to specify whether the
> > spi_controller is a master or a slave and Geert's design is
> > to specify that on allocation.  Which makes sense because
> > that's the moment the spi_controller comes to life, there's
> > no earlier moment where one could specify the type.
>
> Sure, but since the current wrappers use the legacy names this means
> that we need new wrappers with more modern names hence there is
> something to improve here.

So what are the more modern names?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
