Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E088487301
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jan 2022 07:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiAGGTy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jan 2022 01:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiAGGTy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jan 2022 01:19:54 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB393C061212
        for <linux-spi@vger.kernel.org>; Thu,  6 Jan 2022 22:19:53 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id j11so12020962lfg.3
        for <linux-spi@vger.kernel.org>; Thu, 06 Jan 2022 22:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmvnTwzlfoB582WhUoZ52uGUh4CYeJAXG7/ftItPFHk=;
        b=dlxgFGDLLwVGl/qH0bSPf2M7NiAjMT/V+HDr+e0lPtrgQPPZeb3tLBDfebm7HnGDxf
         uNu7Ahwy/mSRernbm/DsVrk2v+HxLH40oy4qYOU4sHFXEosPTVh2oMg1I1nZoyepVn0l
         uJO5OO8V1gYyo0Oc/6vg3ANkg7xbR0WZXTpXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmvnTwzlfoB582WhUoZ52uGUh4CYeJAXG7/ftItPFHk=;
        b=C2XDN0ji9qs5PapmxT2wZjleFVl8bYiC5AjvITKIS7HzzJAXjkgzN5Fg2ykCVhWtw5
         TZmGWIe8ik2fi8SANlad75mY2Te/o5oMjfKugBGui77ZEJcEwAcp2Z4erqshXQgaAWxP
         824SAlYlenelUvB7PKFSMzQLSpFT0DJ5oVdJwgehg8Hh4SnmSqPDTgDhPyNj9dHEb68A
         0rioDMQ+X9Pi58Wfv3NnPilwrofvAJH2WkHq7gf6l6DN4r1QZRJ0zGiW5YlCOsRLVPLc
         dlEM9LHuI1ZFKUbueRIB/5FBh7YB8j7idOaeWcZntsHez6+Z9za2xYKrtznE2jDhe9f0
         nk2g==
X-Gm-Message-State: AOAM533aAMUmFbaduvFFsuSoJmX1OrnRBJtObi6qWfZuNUgYcombqY82
        yKrDZPka6Q4F7VRDe58ZUnTSi9eZrm8SOfQqikGk5g==
X-Google-Smtp-Source: ABdhPJzIKh2xp+2CLreJdGK34F+DnUkYpGcKwNfCwUwQutIsw+wpEf0J5q4pU2xOrcpZNnZddD+BrBZQyqtJFjgz570=
X-Received: by 2002:a05:6512:2027:: with SMTP id s7mr53435381lfs.678.1641536391822;
 Thu, 06 Jan 2022 22:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
 <20211220121825.6446-5-tinghan.shen@mediatek.com> <CAGXv+5GaFikojqYYv0TfQsz3NSqn7QPmTWyCJY8V2g8UYoV4OA@mail.gmail.com>
In-Reply-To: <CAGXv+5GaFikojqYYv0TfQsz3NSqn7QPmTWyCJY8V2g8UYoV4OA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 7 Jan 2022 14:19:40 +0800
Message-ID: <CAGXv+5FcDAu4yKS6MRjfnsJc0CgoREXAvS1d+UWcPQ24NmCY-Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: Add mediatek SoC mt8195 and evaluation board
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, broonie@kernel.org,
        bgolaszewski@baylibre.com, sean.wang@mediatek.com,
        bayi.cheng@mediatek.com, gch981213@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Seiya Wang <seiya.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Dec 23, 2021 at 5:59 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
> On Mon, Dec 20, 2021 at 8:20 PM Tinghan Shen <tinghan.shen@mediatek.com> wrote:

> > +                       infracfg_rst: reset-controller {
> > +                               compatible = "ti,syscon-reset";
> > +                               #reset-cells = <1>;
> > +                               ti,reset-bits = <
> > +                                       0x140 18 0x144 18 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
> > +                                       0x120 0 0x124 0 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
> > +                                       0x730 10 0x734 10 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
> > +                                       0x150 5 0x154 5 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
>
> This should be 7 cells per entry:
>
>     ti,reset-bits =
>         <0x140 18 0x144 18 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE>,
>         <0x120 0 0x124 0 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE)>,
>         <...>,
>         <...>;

Please ignore this comment. It looks like I misread the binding, and your
version is correct. However please format the columns so they align.

ChenYu
