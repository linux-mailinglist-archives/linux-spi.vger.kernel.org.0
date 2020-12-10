Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08362D6BFA
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 00:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394380AbgLJXdo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 18:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394378AbgLJXdb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Dec 2020 18:33:31 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A6FC0613D6
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 15:32:50 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id s21so5667772pfu.13
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 15:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=9eWTFNUzUm01PgnNoVde/S0D0c6WiXawj32iLWQB4Xk=;
        b=fsr0oEwn1dC4dB7RsuUNqzLTvkghUmkbYGGNVSZHb6mrpS00TPDeQps86aqbK416CI
         0Za26B+jcc31slw5Ccmgwrcqo/KTESOQcwT6mpdaThtops+FvzjcyuScuUZezj5Nopcr
         Y27cdKQPNHn+y9jA6T9YFrcD4tpM5VeEb5EhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=9eWTFNUzUm01PgnNoVde/S0D0c6WiXawj32iLWQB4Xk=;
        b=nIpSZxs3ifsNLCVR/zP1T7OU1qdVesUxQ/MRawAtVUBNzkVnxiKgVGV2jJ+IwsEz/1
         X/kw0kbWtBNhtmdRHmoghIGsmWOLBO+chjF4gKuf/Ioa+538DMdlMLGmYNQHCQGLBGs7
         qmfAvpFqlK7Tux4oceL7Z720npOUGEf7MsYHcEvhB0mv8NbGM1gMlxJ6lVKRE5IsPmg+
         L148kI99Qn2JXbv9wi0m3Tr3zyIlo10kjw0rTMlpcblBv8Gxh5t3HfSpZq64vEZFsNpD
         z8XU0ryzTdYtOA7nyNJL7UGqwMOe4HV8gOvTRoGLBn1pm+6td2olt7vnL7Q18KLxl8V5
         WW1Q==
X-Gm-Message-State: AOAM532FobQevjJyYWoX8HTq6PoR6w8IZXh1tR31c0B2J1/bt3fFRp6s
        iWcQzZq+bsjEdXYD3YB8L16CfA==
X-Google-Smtp-Source: ABdhPJxFmEKsWlyG2x1rCJPU/ohPLBWHLySIE8O46jomFJur9ZcfwOtmH/+xlg7dGlO7I/jEBT4RQg==
X-Received: by 2002:a62:184e:0:b029:19e:c636:17f9 with SMTP id 75-20020a62184e0000b029019ec63617f9mr3783130pfy.23.1607643170366;
        Thu, 10 Dec 2020 15:32:50 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id a20sm7497319pgg.89.2020.12.10.15.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 15:32:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=WuQjKC6GHy8d2nuqS-fgsUfxYrJosg3eyC9JU1FPCcjw@mail.gmail.com>
References: <20201203074459.13078-1-rojay@codeaurora.org> <CAD=FV=XKyXnjsM4iS-ydRWBnmYMojPOaYAdYhOkxkPTCQf0RLQ@mail.gmail.com> <160757022002.1580929.8656750350166301192@swboyd.mtv.corp.google.com> <CAD=FV=WtU3cnRe6pDKFMA9_0cnQFtSOyohY_bJwZObK+KrbhVQ@mail.gmail.com> <160764107797.1580929.14768824290834396298@swboyd.mtv.corp.google.com> <CAD=FV=WuQjKC6GHy8d2nuqS-fgsUfxYrJosg3eyC9JU1FPCcjw@mail.gmail.com>
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
Date:   Thu, 10 Dec 2020 15:32:48 -0800
Message-ID: <160764316821.1580929.18177257779550490986@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Doug Anderson (2020-12-10 15:07:39)
> Hi,
>=20
> On Thu, Dec 10, 2020 at 2:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > right? It will only ensure that other irq handlers have completed, which
> > may be a problem, but not the only one.
> >
> > TL;DR: Peek at the irq status register in the timeout logic and skip it
> > if the irq is pending?
>=20
> I don't have tons of experience with synchronize_irq(), but the
> function comment seems to indicate that as long as the interrupt is
> pending synchronize_irq() will do what we want even if the CPU that
> should handle the interrupt is in an irqsoff section.  Digging a
> little bit I guess it relies upon the interrupt controller being able
> to read this state, but (hopefully) the GIC can?

I didn't read synchronize_irq() more than the single line summary. I
thought it would only make sure other irq handlers have finished, which
is beside the point of some long section of code that has disabled irqs
on CPU0 with local_irq_disable(). And further more, presumably the irq
handler could be threaded, and then we could put a sufficiently large
msleep() at the start of geni_spi_isr() and see the same problem?

>=20
> If it doesn't work like I think it does, I'd be OK with peeking in the
> IRQ status register, but we shouldn't _skip_ the logic IMO.  As long
> as we believe that an interrupt could happen in the future we
> shouldn't return from handle_fifo_timeout().  It's impossible to
> reason about how future transfers would work if the pending interrupt
> from the previous transfer could fire at any point.

Right. I just meant skip the timeout handling logic. We'd have to go
back to the timeout and keep waiting until the irq handler can run and
complete the completion variable.

I forgot that this is half handled in the spi core though. Peeking at
m_irq doesn't look very easy to implement. It certainly seems like this
means the timeout handler is busted and the diagram earlier could
indicate that spi core is driving this logic from
spi_transfer_one_message().

So why don't we check for cur_xfer being NULL in the rx/tx handling
paths too and bail out there? Does the FIFO need to be cleared out in
such a situation that spi core thinks a timeout happened but there's RX
data according to m_irq? Do we need to read it all and throw it away? Or
does the abort/cancel clear out the RX fifo?

----8<-----
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 25810a7eef10..651b1720401a 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -522,10 +522,12 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	spin_lock(&mas->lock);
=20
 	if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
-		geni_spi_handle_rx(mas);
+		if (mas->cur_xfer)
+			geni_spi_handle_rx(mas);
=20
 	if (m_irq & M_TX_FIFO_WATERMARK_EN)
-		geni_spi_handle_tx(mas);
+		if (mas->cur_xfer)
+			geni_spi_handle_tx(mas);
=20
 	if (m_irq & M_CMD_DONE_EN) {
 		if (mas->cur_xfer) {
