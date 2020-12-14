Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A72D9C37
	for <lists+linux-spi@lfdr.de>; Mon, 14 Dec 2020 17:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440069AbgLNQKF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 11:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439525AbgLNQJy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Dec 2020 11:09:54 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D96DC061793
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 08:09:10 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id t19so5635038uaq.1
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 08:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2aQQjeTAClD8BnlUklr8QIojrz0VDK1/YhYYkZp+14=;
        b=kIZlPMONz6lBq/gIOydcXGUjcQ0cvnJfuO8mypCn3kXK71AWGykGUryj8sLmqsAdFI
         ZUJzP+cGLH/fV3IW7Je5UBQzqFi7Be020MjYizulu8XR/il87US8F0Cbs4ZPNqvxhzl1
         oMJBu2XlH9E252F3Bb3qbUdtEo+LtrF9WOVHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2aQQjeTAClD8BnlUklr8QIojrz0VDK1/YhYYkZp+14=;
        b=cM6+n1ZOxr0F/zNN6YvzOKyulIIEUHni5GicK2fp5NJuexZ8jqvKfnN1OxGD2q7ZIR
         L28qKq9eHcBQutaqFmAZjq0H4nA+1GFE2zSiYDumKKCFbmaNID9N2w+lpLBlEcXaHcFR
         6yLahP16ZAqU/pXmdhALbCuwewoQ5AuhuIZb8rV0gCKsQbQoYmpzsIzlq4l8L32DpaGE
         vVT7j8jB2OHRZj5kOIcvvbmG2wB7ywrundZWRujU1w8MyAeTACDOH3jLdKWWTHGT9HpJ
         OKX3d1KVR0ufa01G5uK+oLiqC28IEAOFd9rnJT8vuTKvYyFGlgyrYzXElO72H79pN5dZ
         p+bw==
X-Gm-Message-State: AOAM530BMsn3zBGa7Ody9d1Rg3FAtmfRB2jvRQzAZG2rmiOTvjB3qR1S
        CCvv9pJchCLfhsjjSigJJoVUDCHH6Gf9dg==
X-Google-Smtp-Source: ABdhPJz2Fa2hteiJWLxIwGnDpvh3dqK8QjkYkQrM34IE/lvShbBnxnFl+3wYXD8Cy4IMBdOoLX9Rvg==
X-Received: by 2002:ab0:3106:: with SMTP id e6mr8311725ual.46.1607962149259;
        Mon, 14 Dec 2020 08:09:09 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 187sm2144113vsv.6.2020.12.14.08.09.07
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 08:09:07 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id p2so5624142uac.3
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 08:09:07 -0800 (PST)
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr23719280uaa.104.1607962147154;
 Mon, 14 Dec 2020 08:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20201213052948.308263-1-swboyd@chromium.org>
In-Reply-To: <20201213052948.308263-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Dec 2020 08:08:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WWe-0v1=kzw4XGQ9TFUkFcf2nAx0so6TFBg74JH6bVmw@mail.gmail.com>
Message-ID: <CAD=FV=WWe-0v1=kzw4XGQ9TFUkFcf2nAx0so6TFBg74JH6bVmw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-qcom-qspi: Use irq trigger flags from firmware
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Sat, Dec 12, 2020 at 9:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to force this to be trigger high here, as the firmware
> properly configures the irq flags already. Drop it to save a line.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/spi/spi-qcom-qspi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 5eed88af6899..8e70f5e63e0b 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -516,8 +516,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>         ret = platform_get_irq(pdev, 0);
>         if (ret < 0)
>                 goto exit_probe_master_put;
> -       ret = devm_request_irq(dev, ret, qcom_qspi_irq,
> -                       IRQF_TRIGGER_HIGH, dev_name(dev), ctrl);
> +       ret = devm_request_irq(dev, ret, qcom_qspi_irq, 0, dev_name(dev), ctrl);

I don't feel that the old code is really wrong, but I guess it is
weird that it's double-specified (both in the code and in the dts).
...so this is OK w/ me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
