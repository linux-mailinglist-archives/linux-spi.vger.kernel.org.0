Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626D22CCA88
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 00:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgLBX33 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 18:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgLBX32 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Dec 2020 18:29:28 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8CFC0617A7
        for <linux-spi@vger.kernel.org>; Wed,  2 Dec 2020 15:28:48 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id x24so36911pfn.6
        for <linux-spi@vger.kernel.org>; Wed, 02 Dec 2020 15:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=8pWp0SPCJ1XCZyPVveVZNUF1OKkzpTtMQOSE9/M77g4=;
        b=bQAAzkO9ynlaSTKshCmW97hrKIoo0JqVWDL4kT0k3xJcu45mPAG8jgzadm2D/vRXkY
         62rMlkELSeOseUuWiljXs2Q9bm7sKezVx9dULNvmzooAumZNPioKQG2sF5bPQgbQn6Cp
         aiGWb9S7HXPxYi3vsF1ZWki8QtKsVQbBX7pdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=8pWp0SPCJ1XCZyPVveVZNUF1OKkzpTtMQOSE9/M77g4=;
        b=Uoz6wgXp/O2sZANI7HC+gUp4aPY5To/iqqDEOr838zmgLUd3qzUa5v/uMIp71SHJXS
         0CHSJN9xLicg4/nHJwA/ZB+H7KUG87UX3OaWWLM6WMfII5Nyv5oCtBCo7MNohuuH7/dl
         tQmWKPghyt9FpIWec8U8Y++Iw8RJhnmXTJ9jQYG84JAbsItCMujFHXGvSvhrxgH6cBa3
         wodoDYw0Qc7GML47zuOSyvxZyD6rDWXq3Yerm7f3qdIXAfjxW7C6f3oCqH3KSYvLH6f6
         Vip2LESfM/vyXgJLsA0ZuUVOA0J+ywrqeG97scv5ns5fKRtOvFpXtGdYEqgRDpWdbGLa
         Okng==
X-Gm-Message-State: AOAM530fVLDasta6UBY5cvKfikvifzBfB0HchuvEgXqk/KpWA/naS5p1
        WTlDeGznjrX/7PKzJpByDiU5BA==
X-Google-Smtp-Source: ABdhPJy3xZ3+XY/j3Fsbn4p0el59YjSVkKj3fLWs5fKu5+SYCItehaFYbnCFpE+3GubMxiaqj9DSpQ==
X-Received: by 2002:a65:6891:: with SMTP id e17mr567267pgt.410.1606951728200;
        Wed, 02 Dec 2020 15:28:48 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id n127sm151383pfd.143.2020.12.02.15.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:28:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHNYxRwMD4XahHXWW9z7b=VCOEsdPe5Df4CohNwmBy_ijWJ62g@mail.gmail.com>
References: <20201202214935.1114381-1-swboyd@chromium.org> <CAHNYxRwMD4XahHXWW9z7b=VCOEsdPe5Df4CohNwmBy_ijWJ62g@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Use the new method of gpio CS control
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Akash Asthana <akashast@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
To:     Alexandru M Stan <amstan@chromium.org>
Date:   Wed, 02 Dec 2020 15:28:45 -0800
Message-ID: <160695172591.2717324.17788035024164242534@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Alexandru M Stan (2020-12-02 14:18:20)
> On Wed, Dec 2, 2020 at 1:49 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Let's set the 'use_gpio_descriptors' field so that we use the new way of
> > requesting the CS GPIOs in the core. This allows us to avoid having to
> > configure the CS pins in "output" mode with an 'output-enable' pinctrl
> > setting.
> >
> > Cc: Akash Asthana <akashast@codeaurora.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Acked-by: Alexandru M Stan <amstan@chromium.org>
> I meant this as a joke in chat. It doesn't really mean anything in any ca=
pacity.

Sorry! It can be removed when applying.

>=20
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/spi/spi-geni-qcom.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> > index 25810a7eef10..c4c88984abc9 100644
> > --- a/drivers/spi/spi-geni-qcom.c
> > +++ b/drivers/spi/spi-geni-qcom.c
> > @@ -636,6 +636,7 @@ static int spi_geni_probe(struct platform_device *p=
dev)
> >         spi->auto_runtime_pm =3D true;
> >         spi->handle_err =3D handle_fifo_timeout;
> >         spi->set_cs =3D spi_geni_set_cs;
> > +       spi->use_gpio_descriptors =3D true;
> >
> >         init_completion(&mas->cs_done);
> >         init_completion(&mas->cancel_done);
> >
> > base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
> > --
> > https://chromeos.dev
> >
>=20
> Unfortunately this patch makes my cros-ec (the main EC that used to
> work even before my debugging) also fail to probe:
> [    0.839533] cros-ec-spi spi6.0: EC failed to respond in time
> [    1.040453] cros-ec-spi spi6.0: EC failed to respond in time
> [    1.040852] cros-ec-spi spi6.0: Cannot identify the EC: error -110
> [    1.040855] cros-ec-spi spi6.0: cannot register EC, fallback to spidev
> [    1.040942] cros-ec-spi: probe of spi6.0 failed with error -110
>=20
> I wasn't closely looking at this part closely when I was using my
> other spi port with spidev, so this is why I haven't noticed it
> before.
> Doug suggests this might be a polarity issue. More scoping to be had.
>=20

Ah I see. It looks like the cs-gpios polarity is wrong for the DTS on
sc7180. That's a patch that Doug has sent in for the qcom tree, commit
37dd4b777942 ("arm64: dts: qcom: sc7180: Provide pinconf for SPI to use
GPIO for CS") and it is pending for the next release (v5.11). Doug says
he will send in a fix for the DTS side, but this patch is still "good"
as far as I can tell. It moves us to use gpio descriptors and also finds
bugs like this in the DTS file that we would have missed otherwise
because the legacy mode doesn't look at the polarity flags in DT.
