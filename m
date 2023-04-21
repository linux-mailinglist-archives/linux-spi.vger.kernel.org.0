Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2A56EB04F
	for <lists+linux-spi@lfdr.de>; Fri, 21 Apr 2023 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjDURLQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Apr 2023 13:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjDURLP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Apr 2023 13:11:15 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A327E167F8
        for <linux-spi@vger.kernel.org>; Fri, 21 Apr 2023 10:10:57 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b97ec4bbc5aso1011892276.3
        for <linux-spi@vger.kernel.org>; Fri, 21 Apr 2023 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682097056; x=1684689056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sshayw4Xz5HwmxPgOrsGArckGApAws6Ivrag6BUTgjE=;
        b=njJK7avwkadDD1fO/nydVQsJ4ikCfYB6Va4SuEvgEJ1S8H4i6YEOB2VWGPXR2HXacH
         GTJufN29U3ZugcyeoPdkZO2pFXQSfD3VLktIBzYYO1lhhxvVciRZAgoaKYAmW6Kf9YlJ
         m3BBH6xcsnDQxmxcWBBS8gtOD/JdejbAfLI55TKKJQX2qP2cvx36985Kfv+FDEDeZ5+0
         rWcTvEm8LhJkYIsa0jl49LNZQJkPfTWVIDamPmaak8S5x7YY/8tYi1/83ljge43gFpiS
         SYXXmeCO7bdKxlZY2v8M6OqgyqqCdfPfTuKWvfpozIhwX79FU1ciZpr977cblvieAznG
         1O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682097056; x=1684689056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sshayw4Xz5HwmxPgOrsGArckGApAws6Ivrag6BUTgjE=;
        b=gGzeBGHwJKCtP4W5g7LwFxmrVaVJ2iZj74JHztlgr4i+WUq1CZ6AKE/S4iiKDUnGrF
         RaSJGw7i/1Q5UhMhoAlMgzi+n6HRYFcTwnP12VBxbP1jmv455P7+CSUwVWbQAB9ugx/P
         X+5pi5k7ylcgoLIMjQgxxlSk1MWRXvEH7DBOb/THKlVFuSloTmgK0HbVAbNAIM1z0aA8
         iJRcRA0q0XVnnZOhdYdFghoC8fAMIZ/iqW57g14PCVby9JRkz4ETgoeBBOPgw0cb1zd8
         8WYwoiBjYV9O733/CHY9jRv7yciMRuWJcVSChy5VAHJtjO/ZBaHhKHdF++9Bu17jnqJ2
         NWzA==
X-Gm-Message-State: AAQBX9d/gGTF1OIpT6sqj5iF2A5AJEamNnVm4SpEo8FO//r6HKvzTjnS
        yXHNuJk9Wwu4DLuZK9/qZR0xMFZGIKeCNKYNcdBv2Q==
X-Google-Smtp-Source: AKy350ZJfC07gVkKyUPQkz8gTiB7EjTgI9J5qlrNOAksIGBX7HMXhs/Foz2IvWulIOMvz17u6R70pPDknMuVoPCYDMk=
X-Received: by 2002:a0d:e888:0:b0:54f:91d:71e9 with SMTP id
 r130-20020a0de888000000b0054f091d71e9mr2889765ywe.14.1682097056525; Fri, 21
 Apr 2023 10:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230420055131.2048959-1-joychakr@google.com> <20230420055131.2048959-6-joychakr@google.com>
 <20230421085354.34dwrgr3enlxqhtc@mobilestation> <CAOSNQF1aK2EdgeUbNN4Bpp8hjPHTzBwt-q6+-Wb24VSsUOtSqA@mail.gmail.com>
 <969a083998224016947f5e77218f4587@AcuMS.aculab.com> <20230421164838.52euobr5ohfyxxti@mobilestation>
In-Reply-To: <20230421164838.52euobr5ohfyxxti@mobilestation>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Fri, 21 Apr 2023 22:40:44 +0530
Message-ID: <CAOSNQF14TcJCU3BBvkL7PuokNXAczTyU=0mOisujBCYNNc2rZA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] spi: dw: Round of n_bytes to power of 2
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manugautam@google.com" <manugautam@google.com>,
        "rohitner@google.com" <rohitner@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Apr 21, 2023 at 10:18=E2=80=AFPM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> On Fri, Apr 21, 2023 at 04:39:30PM +0000, David Laight wrote:
> > From: Joy Chakraborty
> > > Sent: 21 April 2023 10:22
> > ...
> > > Sure, I can make the following change in the formatting and send the
> > > patch series:
> > >          dws->n_bytes =3D
> > >                  roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_w=
ord,
> > >                                                  BITS_PER_BYTE));
> >
>
> > Won't checkpatch bleat about that?
>
> Why would it?

I ran checkpatch on this and it seems to be fine with minor spacing changes=
.

>
> >
> > Is it ever actually valid for the caller to provide a
> > value that isn't 8, 16 or 32 ?
>
> Judging by this
> https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/spi/spi.c#L3630
> it is. SPI-controller also supports word lengths within the
> pre-synthesized range. So it's up to the SPI-peripherals and their
> protocols what word length to select.
>
> -Serge(y)
>
> >
> > I'm sure it looked as though some other lengths/counts
> > where likely to go badly wrong.
> >
> > I know there are times when it is useful to bit-bang 'odd'
> > numbers of bits - like command+address+delay for fast reads
> > but that is a sub-32bit transfer so (at least somewhere)
> > is 1 word but not all the bits.
> >
> >       David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)
