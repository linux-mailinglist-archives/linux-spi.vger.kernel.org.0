Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE30E267FBC
	for <lists+linux-spi@lfdr.de>; Sun, 13 Sep 2020 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgIMOP6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 13 Sep 2020 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgIMOP5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 13 Sep 2020 10:15:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED6FC06174A;
        Sun, 13 Sep 2020 07:15:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u21so16357111ljl.6;
        Sun, 13 Sep 2020 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sXH1qyDcIcLtxMMXhvx1mrVm2YfWzsrHvfD5f0O11Xg=;
        b=SesijJc96H0LSyMpHDyE5omS+dD5Cq2JYQ140rAPMyuLDxNNy7cL2WB4tCC6jSQJ1T
         1wbDnRaJPSRIsgCjJAjNNl6taoWbQ5Qra7wuUJliqFWxSjc7NLIDQzkmLcR2IcX0kQfs
         cwbHu/e2D/Jrm/TpBAq3IOhBhRQ6ri/hmtQuVzvDURcT1oUtFiejLbb0YmtJVfvg18Hi
         PDJ8WbvNdTlBgotU7xFb3qwtyM8oYNrdLVvld2ZAuygC324oAF1sZYTuWhe56HGMN4Nb
         HBOLQzwlKNhvBS05C9+p3nl6AkdTaiDT2H3nRsSvSuGdHBzr8hCbosCcLILCZrFiAZ3R
         KqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXH1qyDcIcLtxMMXhvx1mrVm2YfWzsrHvfD5f0O11Xg=;
        b=aXsjazwu0aAD6uOIT5Kvs8PcwT9tckBWt67pR1mtglD2sXsug7panIZNYbMgIRQGrd
         dpM77/Lea+WFYN6AJ+RoSUQnrcSPZGzeY0SHD+PMst1z56+2aot4TF+kmRb+bBR8Kh8h
         kjcu0X3BmvOdqHURs/HIGJpOlNXA+ab7d4h17vVqwlWV8qS/RqxDB7R3XZsHACzLhDo7
         s49tRSG0Fl0epwzWGTpnb104Aq6yKNMjoDFEYTlvvClGHYOaOwFe2OktyaT4KUs4Y8TT
         m9zqlRsK3FGHB05yPJY/0emt6cNfBXRaoknuIpFzlDUr68rE7+jqXwKvh671ukZq0sXn
         dzug==
X-Gm-Message-State: AOAM533hRiZLcJgfgq+es5ssrpsLKsG10FLsEqHSWu6UqHBXzYdQK7QD
        OkH0dLrgnZGaJkzdfd2HSCjK0drTAB7MVEL7xIPz+qRQ
X-Google-Smtp-Source: ABdhPJz6JRPrIBCRCTSiBzWMdLoifzKCVVls1cEzQ33HZyNqk43RsE9MhkynY/jBubcSjHEyDX3u4Tbig+VrEK3O6qc=
X-Received: by 2002:a2e:9b99:: with SMTP id z25mr3922268lji.403.1600006552764;
 Sun, 13 Sep 2020 07:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200903144028.20416-1-matthias.schiffer@ew.tq-group.com>
 <CAOMZO5DGHoG_8X+fbrGCHR4g=sGdEaF7bYrHbC_2T=aUnfTs8g@mail.gmail.com>
 <e1431dd2653dbffdfec39a2e7167db07836e30ac.camel@ew.tq-group.com>
 <CAOMZO5C7yyA11EOQvU0Fq-uDd5RK-B7WmbtvAy8OtPzfThYXRg@mail.gmail.com>
 <f753882996235439b9ef53747d24382e896dc4e7.camel@ew.tq-group.com>
 <20200904150450.GG4625@sirena.org.uk> <CAOMZO5DNE9dEqXMN3SkB2Xr_BZ2iFM=LJit0hp1sBCb8Htvr1g@mail.gmail.com>
 <6c353fa3cc60e8854404eaedebcebee07b103d7c.camel@ew.tq-group.com>
In-Reply-To: <6c353fa3cc60e8854404eaedebcebee07b103d7c.camel@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 13 Sep 2020 11:15:41 -0300
Message-ID: <CAOMZO5CVh==PQhB=WEWGyc01+YtcKB6B4t9v_B9b-jcD1Yu7dg@mail.gmail.com>
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH] spi-imx: remove num-cs
 support, set num_chipselect to 4
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Matthias,

On Mon, Sep 7, 2020 at 4:40 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> My rationale here is the following: As broken as the native CS of these
> controllers is, it isn't an unreasonable assumption that it is working
> fine with *some* devices or for some usecases - after all the support
> was implemented at some point, and has existed for a long time now. If
> we really want to remove this feature, a deprecation period with a
> warning message seems like the proper way to deal with this.
>
> Hypothetically, existing out-of-tree DTS could have used the native CS
> with num-cs set to 4. Always setting num_chipselect to 4 ensures that
> we don't break such DTS with the num-cs removal.

I still think this is more of a theoretical issue rather than a real
use case one.

Anyway, I have a proposal that I think will make both of us happy :-)

I will submit a patch shortly.
