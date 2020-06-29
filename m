Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85D120E98F
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jun 2020 01:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgF2Xpp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jun 2020 19:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgF2Xpo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jun 2020 19:45:44 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6762AC03E97A
        for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2020 16:45:44 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id m25so10196020vsp.8
        for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2020 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYI3mC1TPWWNCe5dapKUu8m35ZbqtEKTTLgsE9b3Fkw=;
        b=TUksazA+FGM3tucKqjgqZrt9NinjymNomhfIBEhZ4zMzZqHhHj+tz5ZLgmJ2Zd0pbP
         jOtLn2445dpX0VSLOa02xXSbZVWvTtP8p6O5h+oU67hNQPp3Kn8EbdweXGQly9MscT6r
         sNzdpzM4hLW9cT6jYanMVyeZC5rRI6yB6SolM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYI3mC1TPWWNCe5dapKUu8m35ZbqtEKTTLgsE9b3Fkw=;
        b=nTI1WfuyJ9/Yi7pFMO6faL70dJDJQnknTduGYXuE9TQQ0+PygwbtPqABMd5KPB+fyA
         p7cC0jsbwtZbex/eFWlXx2x8efDfWkSH9FkmQN/v1pOT5pZVFso1SeK9wD5VOemc4ttx
         JFcCWFM+fR6xieGnUHGjgk5xHvrr4/fjLP9S9A7URes/zSw2lFrP1iHRAXaEk5Pl911I
         2zUeA7MdoounAOj6OX2+zv3XRFn5xI54+vh33/vOcARlPGrqFV24OcoX9/SU29HksznY
         5V0e0b6UPEObCB4il/o0JTCmydXJATDxxGxgO6ENNYHVrlxo5iuShgAsOlYqGGjkX3Jw
         wb5w==
X-Gm-Message-State: AOAM532etEb34dHnxIe6ZABFGv56JDX7vIQv/3djs3M0PDqDx40wys47
        TZsNcyr7Yb2caO/xNUrwW/ESqtUeqdc=
X-Google-Smtp-Source: ABdhPJxbygtYzGNP6IsQBisNMXVzgrFin7gS1eNZ28vA0+Ojx85Scieq7yzJ672O0Y7xzGvmYNl+0w==
X-Received: by 2002:a67:2f41:: with SMTP id v62mr12160048vsv.125.1593474343203;
        Mon, 29 Jun 2020 16:45:43 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id v129sm199436vkb.17.2020.06.29.16.45.42
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 16:45:42 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id x13so5462014vsx.13
        for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2020 16:45:42 -0700 (PDT)
X-Received: by 2002:a67:ec58:: with SMTP id z24mr8146370vso.109.1593474341915;
 Mon, 29 Jun 2020 16:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200626151946.1.I06134fd669bf91fd387dc6ecfe21d44c202bd412@changeid>
 <20200629115316.GB5499@sirena.org.uk>
In-Reply-To: <20200629115316.GB5499@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Jun 2020 16:45:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ULboyqRb1-1o1dq9Z7FGQ2gwb3oJi2bWLwZsXu6cybpw@mail.gmail.com>
Message-ID: <CAD=FV=ULboyqRb1-1o1dq9Z7FGQ2gwb3oJi2bWLwZsXu6cybpw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Don't set the cs if it was already right
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Mon, Jun 29, 2020 at 4:53 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jun 26, 2020 at 03:19:50PM -0700, Douglas Anderson wrote:
> > Setting the chip select on the Qualcomm geni SPI controller isn't
> > exactly cheap.  Let's cache the current setting and avoid setting the
> > chip select if it's already right.
>
> Seems like it'd be worth pushing this up to the core - if we're
> constantly setting the same CS value then perhaps we ought to just stop
> doing that?

Posted:

spi: Avoid setting the chip select if we don't need to
https://lore.kernel.org/r/20200629164103.1.Ied8e8ad8bbb2df7f947e3bc5ea1c315e041785a2@changeid

I see that you applied my patch to "spi-geni-qcom".  If the patch to
the core looks OK to you and lands, I think the one for the driver can
be reverted (though it doesn't hurt).

-Doug
