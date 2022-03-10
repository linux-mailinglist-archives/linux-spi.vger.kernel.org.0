Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4134D46CD
	for <lists+linux-spi@lfdr.de>; Thu, 10 Mar 2022 13:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbiCJM0z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Mar 2022 07:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiCJM0y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Mar 2022 07:26:54 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BFE1480F3
        for <linux-spi@vger.kernel.org>; Thu, 10 Mar 2022 04:25:53 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u7so7412892ljk.13
        for <linux-spi@vger.kernel.org>; Thu, 10 Mar 2022 04:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqsFIaRY/TgoRkF083+IfsddSk28neU+fOzEwgSelz8=;
        b=SkF9GRN6Amd9gve917g3uYjQcjFuk1GmGmpMu33Vk7qfVtRVpuGBIXhZrO074ODRFP
         QUrGwVAIZzQRa294vznZ3IBUNlXKCFrNZcweyvGeNXzXKLJHlRq4CcYW6/ynB2A88hpG
         6Q5XWVJLar6jkaGxJlFZoyHL+gq60iAaVM+aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqsFIaRY/TgoRkF083+IfsddSk28neU+fOzEwgSelz8=;
        b=ATS3S7OHTHyChrnaJJxE1irSHxzo3C0VPPKPcL1eG+/liAOFZlLbhaRJF2Fw5+zD08
         ByU2REvLM1ctTQiouLgOPTcVHeIaK2YUPQEuAAIF0M4EwsKxkVff1Hkjs3Kjr1Qxlr0R
         Zue1xxSMCU0VUxRbIVjti7jCqR1sV8C2hwo8ovDqqbxbhVlACVt1jqaJ9ls0gj1dOirN
         Yql1Q1vUHTKeVqTpi529T1jvwDzWzsBKbMVAtfdX9g/6BTLu4B6lwjr235xr3e4b8z64
         2n9PD0+JqTsDx4oEKZbanEIaZBt4UCwBWc4XWeFtbqEAiC8l4GsBjEhDp0dTrIYY1cX9
         bdug==
X-Gm-Message-State: AOAM531gsWl8y3Vkz4lcP5hVHZl5iHQ0gFEZG6aTzhsiZ0ZIAKTsw/hL
        UlXNBnroLSKMDqfVI5EvA8DM5/cT+hdYNTcQ7o4=
X-Google-Smtp-Source: ABdhPJzBUKBWVlHzKX5UBiPVth3TVr2gsmNsC8/f/V72E7KTdnpTmnnuRdmYJ61lPumQQ0uWXQ4/Ww==
X-Received: by 2002:a2e:9cd:0:b0:244:d41d:69ef with SMTP id 196-20020a2e09cd000000b00244d41d69efmr2743440ljj.386.1646915151728;
        Thu, 10 Mar 2022 04:25:51 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id t6-20020a2e9c46000000b0022d81f4be1esm1040649ljj.45.2022.03.10.04.25.50
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:25:50 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id z11so9047813lfh.13
        for <linux-spi@vger.kernel.org>; Thu, 10 Mar 2022 04:25:50 -0800 (PST)
X-Received: by 2002:ac2:41cf:0:b0:448:1eaa:296c with SMTP id
 d15-20020ac241cf000000b004481eaa296cmr2838919lfi.52.1646915150173; Thu, 10
 Mar 2022 04:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20220310121327.63C6FC340E8@smtp.kernel.org>
In-Reply-To: <20220310121327.63C6FC340E8@smtp.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 04:25:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
Message-ID: <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
Subject: Re: [GIT PULL] SPI fixes for v5.17-rc7
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
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

On Thu, Mar 10, 2022 at 4:13 AM Mark Brown <broonie@kernel.org> wrote:
>
> One fix for type conversion issues when working out maximum
> scatter/gather segment sizes which caused problems for some systems
> which where the limits overflow due to the type conversion.

Side note: 'ctrl->max_dma_len' is a 'size_t', so even 'unsigned int'
isn't necessarily a sufficient type.

Not that I see anything setting it to values that would cause
problems, but it looks conceptually like a similar problem as that
'max_seg_size' thing was.

                    Linus
