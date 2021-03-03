Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2932B500
	for <lists+linux-spi@lfdr.de>; Wed,  3 Mar 2021 06:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbhCCFsf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 00:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245403AbhCCDHD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Mar 2021 22:07:03 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0830FC06178A
        for <linux-spi@vger.kernel.org>; Tue,  2 Mar 2021 19:06:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ci14so20356110ejc.7
        for <linux-spi@vger.kernel.org>; Tue, 02 Mar 2021 19:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RKwqvjc2wk7e2+JEpQKXBE74c6T76PfSJ5fS7l5tMvw=;
        b=bFfFxkZfnEuSe+zD3dOESM/J8Phx3ou9kd9mPXToUzSdfQAb53Qs3YeQEEyLDTBDzM
         SqXy56RHCu+89Z6rlaZ/G920014szsVlNvAyH3Js+p9W5gbReYP9j83NcTH5tGY8rHar
         1OQ3ZP6fXm2KK4F4y19TLAygolEdoc7d0+vHt6kmmMTyL5wDi3Oaw09zpmACmxMt0eNw
         tgbsGnzfLfgUA/ccDdv/wDDoOIiCS4AiK7jHapszlkpK19V7XFeoVOBWUb/5RDW1OzhT
         csD+LtfQ/zQCYu+SdJ3LE8Dzpgc9/pR9p9mLmlAs2SdCrwCO5KE//k0c4i9nH3P9dxix
         hFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RKwqvjc2wk7e2+JEpQKXBE74c6T76PfSJ5fS7l5tMvw=;
        b=h0x5RiCzW0I8VPGffNvIlehG4C3EQtRwMc9pPTgXbbZEhTDQKOAIFY9g0P7H+JxvOV
         QIIgrSZP8kw1XBRQ+UdRc8Y5QDA7ZJtlIrhV+HQwuxl2cIs2v5odR2fg+BGbLFXydCjV
         VwX1IIBEIq0Rz8/Apednzfg+S8WtpZ6dFKNJ3Ee1ZFiPfJi6wq2QIbG3uble2b67bgAc
         gEe5TnmxhoiL18kqXYSUAGlNlEr1jt6x9TI2zTQCXIBs/4OoHqmjnKxVtGD9dYDIhIcR
         GiGp/OeI/nfUTniJixbOpwGsHusXrFCj9tK3RA6WnJKCsAwKrqkcWSZJ8TeO5wEtSNwC
         wU3Q==
X-Gm-Message-State: AOAM5339+MGxMoQt60ngkOn5Oknvadeehl8oBOQetB/Ba0YoC15U1QqV
        hU3bLdMk2Cc7TqqXg9ciyBYUDscxQzoFfYTfjQEpWw==
X-Google-Smtp-Source: ABdhPJyYqGm/IkXBg72idjlWOcasJpO+3VO1/ceWLHr+GEA9ohQQX4RYUV2o/t1wOsx2Xn55vwqBtBe54xMV9cUzjVI=
X-Received: by 2002:a17:906:4c8b:: with SMTP id q11mr23806065eju.270.1614740775721;
 Tue, 02 Mar 2021 19:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20210303025636.795-1-leilk.liu@mediatek.com>
In-Reply-To: <20210303025636.795-1-leilk.liu@mediatek.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Wed, 3 Mar 2021 11:05:39 +0800
Message-ID: <CAFRkauDpNmPRpnM-iz8az2N_cUEhEtDKMq6qfP-f++2iyxqVTw@mail.gmail.com>
Subject: Re: [PATCH] spi: mediatek: Re-license MTK SPI driver as Dual MIT/GPL
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "luhua . xu" <luhua.xu@mediatek.com>,
        Wei Yongjun <weiyj.lk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Leilk Liu <leilk.liu@mediatek.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: "leilk.liu" <leilk.liu@mediatek.com>
>
> It is wanted to use MTK spi bus driver with GPL-2.0 or MIT license.
> But now it is only licensed as GPL-2.0, so re-license it as dual
> MIT/GPL.
>
> Signed-off-by: leilk.liu <leilk.liu@mediatek.com>
Acked-by: Axel Lin <axel.lin@ingics.com>
