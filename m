Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006E34DA067
	for <lists+linux-spi@lfdr.de>; Tue, 15 Mar 2022 17:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbiCOQt4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Mar 2022 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349556AbiCOQty (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Mar 2022 12:49:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60304553B
        for <linux-spi@vger.kernel.org>; Tue, 15 Mar 2022 09:48:41 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bn33so27317973ljb.6
        for <linux-spi@vger.kernel.org>; Tue, 15 Mar 2022 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zt/r5r2zHXpo2duxNnaYNgAPA5dxpfI76juAqVaexSw=;
        b=Y8ZdU+nyxKNyEdgJPvaWFUnJeWVz2wDo7JAxJf0kQlI3siurpvUSwzZXG6ifa5fbmg
         MltEjmXOo5W/lLyp5KhMrgLIzMlNAy0/jeohNDmB9yR04no6Qu+KmI3XIpDHN31hjRkQ
         amVOlehEnYI4vI6vTRY9fPOaSRRx8KBdzOaJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zt/r5r2zHXpo2duxNnaYNgAPA5dxpfI76juAqVaexSw=;
        b=arbQhTGGIRb4p93K8AvfUYzFEB6wI3tSExoj+6zc1l9Qs95SrnvtiWZTQj+NRqdkyf
         xe2WJxVsRKHJjuf4vSV6T7XEJcfrEP9IqyfmbJ40/hXhmVRNkRal3HPGL1+nM5i0IThV
         e2TsFURHeROyqe628H6vpdZoofwOWGaK3nGsgzeoIYW/hv4A+vo/FHq6tzUMJ7sdBFyR
         X+gP3+50IY05Zp1qRFJXodyLURhm/kw225LLRy5PT07dl54Rsa0ZBE6DX3KmwAJq7pUH
         FmxX1dI6Asb4pxlCAShelY7EcevVkGPiNJ67NX/dCisEeSD/Ncu1mXpckuQZrsrl/9Fr
         BFDw==
X-Gm-Message-State: AOAM530KHKHw7LpprRPhMhENMBb6sCi1nttD5V/iMg6uYdVwGQ3NgGFf
        PQUmw+ECL4B9Xd8Pin907D8FgVtpprZ5skCx
X-Google-Smtp-Source: ABdhPJy6+bssWai+T58/l/XQFvCW2BDG2nQvMGCOlvAiJTqlUSPkBwtWxFrtd2uU+zipM0HB23nkUg==
X-Received: by 2002:a2e:b5a1:0:b0:244:d3b4:dc24 with SMTP id f1-20020a2eb5a1000000b00244d3b4dc24mr18108382ljn.83.1647362918287;
        Tue, 15 Mar 2022 09:48:38 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id c7-20020a2e9d87000000b00247ebe11990sm4410596ljj.10.2022.03.15.09.48.36
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 09:48:37 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id c15so10737888ljr.9
        for <linux-spi@vger.kernel.org>; Tue, 15 Mar 2022 09:48:36 -0700 (PDT)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr18220509ljg.176.1647362916222; Tue, 15
 Mar 2022 09:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220310121327.63C6FC340E8@smtp.kernel.org> <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
 <YinzW413m6p0H/i1@sirena.org.uk> <CAMuHMdU9t2wLonWBjkXBdxxyK_oJiOUTSqrYVrZWjsY2JKEJ2g@mail.gmail.com>
In-Reply-To: <CAMuHMdU9t2wLonWBjkXBdxxyK_oJiOUTSqrYVrZWjsY2JKEJ2g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Mar 2022 09:48:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZnS6n1ROQg3FHd=bcVTHi-sKutKT+toiViQEH47ZACg@mail.gmail.com>
Message-ID: <CAHk-=wiZnS6n1ROQg3FHd=bcVTHi-sKutKT+toiViQEH47ZACg@mail.gmail.com>
Subject: Re: [GIT PULL] SPI fixes for v5.17-rc7
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 15, 2022 at 2:08 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> I had noticed while reviewing the patch, but changing to size_t wouldn't
> help much, as other related code paths treat the value as unsigned int
> anyway.

.. but it really would.

Note that the paths *after* this code don't matter. Because the result
is guaranteed to fit in 'unsigned int' anyway.

Put another way:

    min_t(unsigned int,x,y)

is buggy if one of x/y is 'size_t'. Why? Because if that one gets
truncated, you're doing 'min()' with a value that may be artificially
much too small (that was exactly the problem commit 1a4e53d2fc4f:
"spi: Fix invalid sgs value")fixed).

But the situation is _not_ true in the reverse. Look:

    min(size_t,x,y)

is guaranteed to fit in 'unsigned int' as long as _one_ of x,y fits in
'unsigned int' - even if the other doesn't. Because then 'min()' will
just pick the one that already had the right size.

To make it really concrete, compare

    min_t(unsigned int, 5, 0x100000001);
    min_t(size_t, 5, 0x100000001);

on a 64-bit machine (ie size_t is 64-bits, and unsigned int is 32-bit).

One returns 1. The other returns 5. Both fit the result in 'unsigned
int', but one of them is wrong.

                Linus
