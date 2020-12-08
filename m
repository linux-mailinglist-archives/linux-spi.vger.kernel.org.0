Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7827A2D280E
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 10:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgLHJrJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 04:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgLHJq5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Dec 2020 04:46:57 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF70C0613D6
        for <linux-spi@vger.kernel.org>; Tue,  8 Dec 2020 01:46:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m19so2317129lfb.1
        for <linux-spi@vger.kernel.org>; Tue, 08 Dec 2020 01:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWA7mZEVmYKxiKiaOAGDDtz5rgnnkaJr+YD5j24/dg0=;
        b=zQx7+JhevD7T4oO95TZSap4NIdAVBNWKEROVc2xSSoeZBIjdQZ+O0dHs2vPUhoDAOn
         T3aVo6eLfS2xxIb/SwvzV5x7mj28on/AbAMJv2Jj+LvgAPmRfyHfRUN8SaW/kT1ejOut
         wBx2HQvB2D9Lm6ngLDuQKZESgRYxotp6cR62WYVYi76MAKH42jjb1w9SOa77wrtiYlLj
         COMaTZXy6ynP7q0Yaa7ShRqthLcfiJeRVsXREnxKgs424i4cCMo6IOAtIKzjBpxmEqm3
         pR/W2GPgnqAH9zk4Jtsp032K7V/R4sV24oDdXYd8uloAxeCwzSG8X6r2ycllX+q/eFqf
         D9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWA7mZEVmYKxiKiaOAGDDtz5rgnnkaJr+YD5j24/dg0=;
        b=k+02md61sQwIp6MQyDQ+ThPGzwbHoPj6WcovkzDxxYqCStxf72JJOib8N1VCBWCH6+
         d8H8pBnnkp8R4TnBeTxa2s/oBRaiYUc+XeFnMhionds+RTPAWVnjp4gIVQ3Qm1VFGE+s
         V9klLYyYdB7VjBM25QtQ3YBEhaqnaH5wKL81U4kiP02dxFg+Yv1OImSFUAsk2IwU+nAz
         6ryOr+lO/fiYjonGiTuiBpISkSCVlpF01MU9/PmBZR3MnFfwbh0BFcco5OVTxyddxOD+
         +cbpr4aHTBxcGCf/6qJY/vQsEJflliqu/cLH/OtZRJtiiHgbkyLzPgK3HtEcY1/MRC0F
         HwWg==
X-Gm-Message-State: AOAM532NdNUHHUbo4C8LIpgxa4OWnvK+CemGgATqm7s9g+nnww9WNm/c
        W1UKv5GuOOPf2o0gFEfi2Fcl3cJCoda2ES6iNrRJaA==
X-Google-Smtp-Source: ABdhPJy6WmZsWAlUbp6GT+E1b+E0f6msms+aRNFlbCB/8MzQqBAsg3J2Pw62QFPy4x+TTGE7rqBNAxJMZrXnx6Ynel8=
X-Received: by 2002:ac2:47fc:: with SMTP id b28mr9542861lfp.157.1607420770078;
 Tue, 08 Dec 2020 01:46:10 -0800 (PST)
MIME-Version: 1.0
References: <AM6PR04MB562311BBA0A439F2C1A0B80EF3F50@AM6PR04MB5623.eurprd04.prod.outlook.com>
 <CACRpkdbEFjJBpqdwTjXf4bMgVFUbv1Rhw3DXs7Q5dw5gFraFww@mail.gmail.com> <VI1PR04MB52942BDDB1D1CD63AE94BC6090CE0@VI1PR04MB5294.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB52942BDDB1D1CD63AE94BC6090CE0@VI1PR04MB5294.eurprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Dec 2020 10:45:59 +0100
Message-ID: <CACRpkdY=Ky_Mej6Q6SSDR_SLPys7pa6K4ySJA=B7vOMmWpXrPQ@mail.gmail.com>
Subject: Re: Question about SPI_CS_HIGH setting when use controller->use_gpio_descriptors
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Clark Wang <xiaoning.wang@nxp.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Dec 7, 2020 at 8:41 AM Bough Chen <haibo.chen@nxp.com> wrote:

> I try to change the cs-gpios to GPIO_ACTIVE_LOW, seems this io extender still can work fine. Seems a bit wired.

It's because as discussed in one of the threads, unfortunately the semantics
are ambiguous so we let the SPI-specific cs-active-high attribute control
it exclusively. GPIO_ACTIVE_LOW gets ignored. We haven't found
any other way.

Yours,
Linus Walleij
