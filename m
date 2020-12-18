Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2E52DDD1A
	for <lists+linux-spi@lfdr.de>; Fri, 18 Dec 2020 03:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgLRCyc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 21:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732610AbgLRCyb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 21:54:31 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A08C06138C
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 18:53:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id f9so628866pfc.11
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 18:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=+5h6MHsc9e2fsuGf4fTF1s0Y9/mJkESC8G8Prf9wXDs=;
        b=OrX26ZdejlRF4tVGFkT5qbuvhtqIVAIw8cA9VoIVIi7EMzU9ZrDyWD7p10yjx595/L
         y4zpwCH67mcIhicrQKNv8A1kXfntT/K3ci41EV9Q85UuVedXCTApy5x3Uxv9SmLvEUwc
         Lo9pIAYLIj1Ppv/Js7Zzb0GO/gH6cafRzGKkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=+5h6MHsc9e2fsuGf4fTF1s0Y9/mJkESC8G8Prf9wXDs=;
        b=mwRrHyn0jUIqxUqk6ipB13AZ5qS94FcxvG0moJDtuBbaq0dZdi4YOtJz5WhXeZvoCv
         yqC76rdCSODRpZ1Lzw1MilmegbzXi+i5IFAQeW+fWw7M/XCIv7R0OE5GtO8EP3uwfQHm
         lQQn17uu563UoZppYW4PKui5j2pgCCfpY603A4b5yP14UoAuLR+W4MTLp5UDw5GFL92Z
         hxcivEYDnk8Gg0iBIskBjtaW63LzF12Z/KG9kN+l2jK3NG2zZ9Duy4GQF90Riwvgtnob
         7q+swBYod0dHzQJMNDHezf2KLsSAAE/LZ4CXWerbdnCOOUW52dS+F9UkzzcOSEB2vAen
         XSUQ==
X-Gm-Message-State: AOAM530dxZ2XlOubaATy9GW8MLycweWAmR5KSVQZhjPutCPoZDEr6Kws
        lfb3BKo34JXRR6arizatqC8Uig==
X-Google-Smtp-Source: ABdhPJzPhsRehN9IClQCYY5PbOBt7t4XsQWnFk8FAHyPFkxJpXhG7kJUeDM9HLI2DN1EkCU+1rnknQ==
X-Received: by 2002:a63:f842:: with SMTP id v2mr2178758pgj.374.1608260029727;
        Thu, 17 Dec 2020 18:53:49 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id mj5sm6030771pjb.20.2020.12.17.18.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 18:53:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=UgGNy2MkYsf5jjL-fcSsqz0vNYsdrpd4hcfG=7tuJcGQ@mail.gmail.com>
References: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid> <20201216144114.v2.2.Ibade998ed587e070388b4bf58801f1107a40eb53@changeid> <160817888737.1580929.1745000818550256213@swboyd.mtv.corp.google.com> <CAD=FV=UgGNy2MkYsf5jjL-fcSsqz0vNYsdrpd4hcfG=7tuJcGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] spi: spi-geni-qcom: Fail new xfers if xfer/cancel/abort pending
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, msavaliy@qti.qualcomm.com,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Dec 2020 18:53:47 -0800
Message-ID: <160826002765.1580929.5295166406857894256@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Doug Anderson (2020-12-17 13:45:18)
>=20
> On Wed, Dec 16, 2020 at 8:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> >         if (M_CMD_CANCEL_EN || M_CMD_ABORT_EN) /* but not the other irq=
s like CMD_DONE or refill fifos */
> >                 writel(M_CMD_CANCEL_EN | M_CMD_ABORT_EN, se->base + SE_=
GENI_M_IRQ_CLEAR);
> >
> > This would let us limp along and try to send another transfer in the
> > case that we timed out but the transfer went through by servicing our
> > own interrupt.
>=20
> A few problems:
>=20
> 1. The cancel and abort are commands and they generate a "done"
> interrupt along with their "cancel" and/or "abort".  Clearing the
> cancel/abort without the done will leave things in a much more
> confused state.

Ah I didn't know that the DONE bit was set even for cancel/abort, but
that makes sense given that it's a sequencer and everything that goes
into the sequencer eventually gets "DONE". I agree if the DONE bit
hanging around that really confuses stuff, so best to ignore it and
figure out why interrupt latencies are leading to this problem.
