Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AA2492D04
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 19:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbiARSMy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 13:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbiARSMy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 13:12:54 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02941C06161C
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 10:12:53 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id f24so4507628uab.11
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 10:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1RQy1GPxyJOygdU8LSftSpYUEzrYqolvY3YbNsj+tk8=;
        b=wkgKDyNNhufcfMfSVn1M8P+RYjxU4dw9Fpc6jaHKwhGyg+uqdeI0NuuDC8tjfNXvAZ
         2lWO9Q9gB9nFOIbFez6V6AtTdsR/bEBos4Iybu/HMEBTDlCtHPt+Sp/i8xV5u9oLhK0g
         rwIuODdpe/FFk90XeZ/AnOnUAib+0tZz8xNPoRQq34Pve+jX5B6M2Ga8jlLASOuwUzGX
         OwFhmRc/m0LT/LO9qnAlwPj81uvSksN2ieADElhESn3nDSP/Awme6Xg8NJc5LfjCdoFj
         MtNuEGA94kDywpALPqOyKXpuDa5aZ8gDe5k7s/CyBWlp3TBg+HQdC0797ZkGD1weB/e2
         8pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1RQy1GPxyJOygdU8LSftSpYUEzrYqolvY3YbNsj+tk8=;
        b=138/BdXM3IcnTmKEFelYiPAU7IlvkONfAFT3hG1cxOWzWX2gl2yKsn201vGWT3Qtv4
         1dqPiU7O3H0lGi1c5bCjrlkmwZGYQ/Hk8BMgUUg35IQEtI60VeVtPf7BgnUseAFc4+4b
         u4nmEOmyzxowXl4AGM4woLgJmTw7Gf2sEj7d3yTYaUS0bx63bR5aj4zeaWECKztElONZ
         rFgBjuWX9oVH1YAtftgJa3aI/pvBWHJ1ShgGRgndDXjYLSZ3agAAH8whxeM/7MJaMx1r
         me6028cSvjpqGuZcPyT2HKeYk3fGCt60DLNfB05crxkEdv5g5pPe5sg/ySiTezWEmMjS
         vkpw==
X-Gm-Message-State: AOAM5325onVWdnC+YcrEHKjjyZ7qG9G+yS7h1MsJi6mU06s0QY148fMu
        pNLajDH0wpZoHNguAd/eLMEtHouPspNr1+e9jYUdwjc66aoXgQ==
X-Google-Smtp-Source: ABdhPJxAmR9Afk9RB57wvNNnGDS3cjPfHig05+jDSqhX28ABw+Zb8v1etaQvVKTtq+8YoVUNG5DjCOZ0Fg7IkMisxME=
X-Received: by 2002:ab0:5381:: with SMTP id k1mr10968965uaa.17.1642529573008;
 Tue, 18 Jan 2022 10:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20220118110928.120640-1-linus.walleij@linaro.org>
 <20220118110928.120640-3-linus.walleij@linaro.org> <CAPLW+4kNbC2BNcC54evJL_9tYoY_S3hcski81KHUPughs3f0ag@mail.gmail.com>
 <Yebx+BwFfKaXchtU@sirena.org.uk>
In-Reply-To: <Yebx+BwFfKaXchtU@sirena.org.uk>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 18 Jan 2022 20:12:41 +0200
Message-ID: <CAPLW+4kvurCoQ5kbvJ=CtrK=XzF5972bEcc=1UEhuiDh9zoMCw@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] spi: s3c64xx: Convert to use GPIO descriptors
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Jan 2022 at 18:59, Mark Brown <broonie@kernel.org> wrote:

[snip]

>
> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.

Sure. Thanks for pointing that out. Just forgot to do so this time :)
