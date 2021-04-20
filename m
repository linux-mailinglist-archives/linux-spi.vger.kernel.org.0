Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBCF365EA5
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 19:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhDTRcT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 13:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhDTRcN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Apr 2021 13:32:13 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4A0C06138B
        for <linux-spi@vger.kernel.org>; Tue, 20 Apr 2021 10:31:41 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b17so27121221pgh.7
        for <linux-spi@vger.kernel.org>; Tue, 20 Apr 2021 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPw9B8VpCS//v/hIJM9C2hudihpSZ7tX54umVBcQ6yA=;
        b=LRVEEfrSj83qsnAUIZ9fpegSNbUCrHVwcz7VV2ZrH/h7MMmLhYHkOEQiU+m590idTP
         w7BS7ASN/ffjkK/dgIL4ftntHGay9KKnwjUjvIKXKt+rLiK10ErRbCW2GfQu+NAE24fS
         yxdES6YGYfViIR13ufahhsxTlT8E02ru/YefejRgeGg21vMzQmMotg0QkT+0Jw8RmHSj
         txmqBL8Aqt0CsTz9htm0gNwpI0BTfjkLrYTdzFPt0OXHs7kJPSxORL/1tguv97KL4DfV
         AMjdy1OWc6UIALnW0j7y9HwUg/fLmg2qZkDB6N25XcjMbsPgCU28T8ZqrF48fWsA8OHB
         N9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPw9B8VpCS//v/hIJM9C2hudihpSZ7tX54umVBcQ6yA=;
        b=UwngR2EfOaPlQ87V8Ug6Gt30oqGRT746NzfU+1gGH77wdiTT2kr717YMYt9WURYzFN
         HHjChai+AKR2jc/9Dmqt+wqMQUdDb9xQljZdtOJcR+uSY1n8Gr9Fa9HzBJF0X+i9fbj8
         I24qjF/0hOaqZIy1MXUdM4IzYIu2OgcmsEWLMyCUyX5w86qoQPp4+IH75m23bhDZUXuK
         1AMYUgiJXAIRz+wpSHdBjCzYiJsvKpNOIf/I4yRIB//i49kt3iLFumGW50ZB0i6v/hIH
         U/tccoqRQB5hOZ6/B97nLHwPuJ3K0lrhrfjdAZPtxr2/FjI4I5GyAstlNo3DjsWaPun6
         xOfA==
X-Gm-Message-State: AOAM5309NwuTfjlvI3gwqR8GFv96vM00knXwqEJNXV+vbpu8k4jZ99Dq
        zaXBrFD8olLCS00x51ZqDMiDv+MbLMUhb0aL4awdY/4nXW0=
X-Google-Smtp-Source: ABdhPJzWaHFUwthpjowJO/VRpGwSiWJ2xFDI+S67hekwBFdBWPmQio8+NtCjRJcsnh+9J18BjbodzHUQbhs2tw3G1KQ=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr25429894pfb.7.1618939901105; Tue, 20
 Apr 2021 10:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210416195956.121811-1-mail@david-bauer.net>
In-Reply-To: <20210416195956.121811-1-mail@david-bauer.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Apr 2021 20:31:25 +0300
Message-ID: <CAHp75VfStm5OeQc-n_djG7vQcvQGbBYSejtTP=e+9VDpAnDE4g@mail.gmail.com>
Subject: Re: [PATCH] spi: sync up initial chipselect state
To:     David Bauer <mail@david-bauer.net>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Apr 16, 2021 at 11:11 PM David Bauer <mail@david-bauer.net> wrote:
>
> When initially probing the SPI slave device, the call for disabling an
> SPI device without the SPI_CS_HIGH flag is not applied, as the
> condition for checking whether or not the state to be applied equals the
> one currently set evaluates to true.
>
> This however might not necessarily be the case, as the chipselect might
> be active.
>
> Add a force flag to spi_set_cs which allows to override this
> early exit condition. Set it to false everywhere except when called
> from spi_setup to sync up the initial CS state.

> Fixes commit d40f0b6f2e21 ("spi: Avoid setting the chip select if we don't
> need to")

It should be on one line and no blank lines in the tag block.
Otherwise bots will not see it as a fix.

Mark, I guess you need to amend your scripts to check that.

> Signed-off-by: David Bauer <mail@david-bauer.net>

-- 
With Best Regards,
Andy Shevchenko
