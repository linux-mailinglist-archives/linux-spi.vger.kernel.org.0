Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5B764BB55
	for <lists+linux-spi@lfdr.de>; Tue, 13 Dec 2022 18:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiLMRsI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Dec 2022 12:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbiLMRsH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Dec 2022 12:48:07 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439FF62DD
        for <linux-spi@vger.kernel.org>; Tue, 13 Dec 2022 09:48:05 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3b10392c064so203380537b3.0
        for <linux-spi@vger.kernel.org>; Tue, 13 Dec 2022 09:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IJk386cPKRY//Y7MO6HtNee/KHa+FUorRyHnWTGhV8A=;
        b=d08kAh2br1YOFfRW5pF0TrY/ZNTrz9x9nQwRu0RUw++RQFsMqu4i8sLoPRe7BawPGS
         ESqup7asnlEPOL1zt4LTi5uNfyreYK+f+Et70il6JT+jSudf7izzjiV4EK2fqw5d3W96
         OqSb/unEd+7X0hM6R5Pj2XcL+2RpV9p1oYy3ddcverkyTVdNVQ6K3BLlaZU330bhusZM
         ijGzNA1KUox9BPuGdDQGGWRIR12SaHnOI8Lyg9Zo6V9IC5elwdnT6bEYAAido5K4iXM2
         VsxzxbE7YgrIpiHyQzCFWai7WFpK8Gy8o6T+NFNf86CrsjIdLkqGTqgZtH0P3v/iTzb3
         d+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJk386cPKRY//Y7MO6HtNee/KHa+FUorRyHnWTGhV8A=;
        b=6DPOglpNMmmkZH+Od2BUbahapw2qSwBF9Xkz5ECKjBVB5b58qUFbYMiXWLjMGgvCAG
         IP1Y2usV42r6X/ZFnokbqWg7Gk8v+Y/ooA7njt4FJIiWKMHEdXoYRzzWvpKwtWj6K0VT
         W1HYlLQATrGpOeiFbc0vPtSwYvjoXWLHL1e3ni6bwHUkBv2o5zn5c94cfommuUXLxG7o
         BQfWX2YTcxvRJWqK9pZEv0pJvKj4otJQPmaPw463+yMMYlxO0Vt32lQ7rkfVcWB6W6yT
         AznP2BzvsY8wE8qpuTH6a5RA6Xb8TrInfflnLtmeUZyO4HhlGeCd1oWno9Q1TZPyguFg
         dVJA==
X-Gm-Message-State: ANoB5pkUKfjqGernPH9FJ7THo+3lrapnaOjgy616OD3XyWXmTy9r6voB
        IWdpfuAMA0Q+WoUPn3Pmfmrfb9h+MfX205/HWIiqdQ==
X-Google-Smtp-Source: AA0mqf7RoXg62KCh1fzwVblmwOYc9OTRss5iJCbzpnG/aMuvB1Q0/G+e/o2T1TAAdqqmRpocYOU83g3L0k9gaJmAQUw=
X-Received: by 2002:a81:8316:0:b0:3d6:1fa3:e402 with SMTP id
 t22-20020a818316000000b003d61fa3e402mr37201681ywf.167.1670953684414; Tue, 13
 Dec 2022 09:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-15-sudip.mukherjee@sifive.com> <20221213163209.GA1684072-robh@kernel.org>
 <Y5ivfCku1P4CTFn8@sirena.org.uk>
In-Reply-To: <Y5ivfCku1P4CTFn8@sirena.org.uk>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Tue, 13 Dec 2022 17:47:53 +0000
Message-ID: <CAHyZL-c--gtWUHjBwnKcy6fSUu7yCUaiEYqK7kKMtwnakwR6jw@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] spi: dt-bindings: snps,dw-ahb-ssi: Add generic
 dw-ahb-ssi version
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 13, 2022 at 4:59 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Dec 13, 2022 at 10:32:09AM -0600, Rob Herring wrote:
> > On Mon, Dec 12, 2022 at 06:07:31PM +0000, Sudip Mukherjee wrote:
>
> > > Add new snps,dw-ahb-ssi version to the bindings.
>
> > Really, this should probably only be a fallback with an SoC specific
> > compatible. Future quirk properties which are not board specific only
> > will be rejected. You've been warned.
>
> Given how widely used DesignWare stuff is and usage in FPGAs it does
> seem reasonable to have compatibles for just the IP rather than SoC
> specific ones - we do have quirked versions that have been modified but
> these are things that people manage to deploy without needing that and
> SoC specific compatibles for FPGA instantiations would get painful.

Also, this patchset adds the autodetect procedure as discussed in the review
of the previous series at
https://lore.kernel.org/lkml/20220826233116.uulisbo663cxiadt@mobilestation/

So, we should be able to replace "snps,dw-apb-ssi" and
"snps,dwc-ssi-1.01a" with "snps,dw-ahb-ssi" after this.
And, also this generic compatible has been tested with the new 1.03a
version we are working with, which was
mentioned in my v1 at
https://lore.kernel.org/lkml/20220826233305.5ugpukokzldum7y5@mobilestation/

-- 
Regards
Sudip
