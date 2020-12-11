Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC32D6DAA
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 02:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390359AbgLKBkn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 20:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390332AbgLKBkV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Dec 2020 20:40:21 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B4C0613D3
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 17:39:41 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t37so6050754pga.7
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 17:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=H3bNyqjYE3P3FE+pJdfbGUHM/wRVgfwC3WmKBMLEr7M=;
        b=dEgyJPXv0kmdJSrcSv+bLlHu62vF3ra95gSKtR8K44I6/dpazQExwhUkTuKh1Hmru3
         dfprGYiB08/idrTanAYAC5/AZjQgID2vscE07va0W1FWTcSRxybjyvdZhWob7e2BVT3p
         IhtpwI3muN6WlQz1pNmKtGJQdIYD1Z/zYB36Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=H3bNyqjYE3P3FE+pJdfbGUHM/wRVgfwC3WmKBMLEr7M=;
        b=HtxcZR69kwOgdzzobggBJ3dieRSG0CgFnHvHn3F10Y1JIXHrjowsqJRqVjAUVPizfU
         qnzt42wUcn0PGgvvUJu/2KQEa8EBLBIckmIEiXjJLytktT4E+DTLrhh9TwnhFMa83GgX
         mwPZw9HoaqfvTzY22xtpSoi2SafJWit+z1Emz6IjAAHLUZTL4Qs7Q+lYHTbBUF2jtt++
         L0Cdj1Zlzkf9qLrC4bQdqbaJwzh0A/hkMnT8hN6zdk/yx1wYh+YZetPR/5x3P0d8vmZz
         /PuRxZFRlo1EQh2gEe2QzOLLqP2cuoDfwwqrozixn70bSuOIOT4TpCksV92DSUYNYfJb
         GVJg==
X-Gm-Message-State: AOAM53094k1XiVFjNZAFev4FGrtnfhVY4pes9eBVqQMWHchhJlnhaTpP
        It6z/LHvp3Z69RQKqSAuqUyucmHLhPRpGA==
X-Google-Smtp-Source: ABdhPJwS2eEsNkdSg9gzpVa3oDaAxMF5jsW+xoVUW5TxVlsMAiakjkBodXM2xbhz+QHjt9vWSMi7Hw==
X-Received: by 2002:a17:90a:fa0c:: with SMTP id cm12mr10705104pjb.87.1607650780522;
        Thu, 10 Dec 2020 17:39:40 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id s189sm7542837pfb.60.2020.12.10.17.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 17:39:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=Xgw+33pCycHyaMPsk64Qs+oh8e-RtJaM1yn0F27qZRVQ@mail.gmail.com>
References: <20201203074459.13078-1-rojay@codeaurora.org> <CAD=FV=WtU3cnRe6pDKFMA9_0cnQFtSOyohY_bJwZObK+KrbhVQ@mail.gmail.com> <160764107797.1580929.14768824290834396298@swboyd.mtv.corp.google.com> <CAD=FV=WuQjKC6GHy8d2nuqS-fgsUfxYrJosg3eyC9JU1FPCcjw@mail.gmail.com> <160764316821.1580929.18177257779550490986@swboyd.mtv.corp.google.com> <CAD=FV=WvG085orLqnvg9WUobL7iyxwgoxh-8RvOaRdi9rLeDUg@mail.gmail.com> <160764785500.1580929.4255309510717807485@swboyd.mtv.corp.google.com> <CAD=FV=VD78fmSRciFf38AbZG=EFPzDiT_e7QkEC08zA9iL1vTw@mail.gmail.com> <160764967649.1580929.3992720095789306793@swboyd.mtv.corp.google.com> <CAD=FV=Xgw+33pCycHyaMPsk64Qs+oh8e-RtJaM1yn0F27qZRVQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Fix NULL pointer access in geni_spi_isr
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        msavaliy@qti.qualcomm.com
To:     Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Dec 2020 17:39:38 -0800
Message-ID: <160765077856.1580929.643282739071441296@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Doug Anderson (2020-12-10 17:30:17)
> On Thu, Dec 10, 2020 at 5:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Yeah and so if it comes way later because it timed out then what's the
> > point of calling synchronize_irq() again? To make the completion
> > variable set when it won't be tested again until it is reinitialized?
>=20
> Presumably the idea is to try to recover to a somewhat usable state
> again?  We're not rebooting the machine so, even though this transfer
> failed, we will undoubtedly do another transfer later.  If that
> "abort" interrupt comes way later while we're setting up the next
> transfer we'll really confuse ourselves.

The interrupt handler just sets a completion variable. What does that
confuse?

>=20
> I guess you could go the route of adding a synchronize_irq() at the
> start of the next transfer, but I'd rather add the overhead in the
> exceptional case (the timeout) than the normal case.  In the normal
> case we don't need to worry about random IRQs from the past transfer
> suddenly showing up.
>=20

How does adding synchronize_irq() at the end guarantee that the abort is
cleared out of the hardware though? It seems to assume that the abort is
pending at the GIC when it could still be running through the hardware
and not executed yet. It seems like a synchronize_irq() for that is
wishful thinking that the irq is merely pending even though it timed
out and possibly never ran. Maybe it's stuck in a write buffer in the
CPU?
