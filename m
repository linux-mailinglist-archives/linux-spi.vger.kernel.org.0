Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863FB486775
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jan 2022 17:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbiAFQNR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Jan 2022 11:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbiAFQNR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Jan 2022 11:13:17 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DCEC061201
        for <linux-spi@vger.kernel.org>; Thu,  6 Jan 2022 08:13:17 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e8so2414454ilm.13
        for <linux-spi@vger.kernel.org>; Thu, 06 Jan 2022 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5QlOKATkg+9Prd2ezRheoLg8bFfRjYXz/Me8Di8F7c=;
        b=k3wV17DuYBAKkilG5F4sMKLPdAc/udCpFB4Zg7vUaNdHN9hLlS8Y1+LLFS/kzWWNo7
         duV9yRWDKNuuxZ1SkusEk0Bhv/5JHdNKZ3HxDCsIxAvd9u3pgSsGI/9gsKfK3GJP8Zt1
         27kQpJbUxRuz+hcivXUoaFvU8CcUr15OTJpEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5QlOKATkg+9Prd2ezRheoLg8bFfRjYXz/Me8Di8F7c=;
        b=o0FYptCaJxyVEyhwfHSVgo4vlg75uoRuIDt6qTzOcNg+W32ksKq64uUKIFllWma59F
         zXCr1L22ELU56WkeGxRFxvkIHK6vs4l+wqHRYmzLmx1iGpFNmN7lu9r79a4sImmGRNVv
         lwFBru6I1EZu5QUaiTin5I8q5xf5xBsq0oE515YPlE+2G6cwwYMiLVq5JsVefsCMYRKs
         wf7a6LH7/uiMuLK4yCnbEAHQRuYg240F7fqRU0xhmeqQ+oSaEjU/e0+W++VO81X2g5x+
         tSSLBu3bKTcaOywXl3o6B2zhTB/f3g9hLUegcTrT86Qp0lieyhYSUXv6vIY+LIiHeGv3
         N0VA==
X-Gm-Message-State: AOAM530ZWHPIBAMb/nigVpMifKDhSsO1+SqF3owf53YlU1K1o1/zCWWp
        SQ50gSJu9LpsneB+vX07V0+ZCXl6+egMJg==
X-Google-Smtp-Source: ABdhPJxNRMLp1SY8eXoHisf3moIJbwdxKq/S+BXlA2nU8QRX+cBtnXz24UmaJ3SYxxEDnm2yH76hjw==
X-Received: by 2002:a05:6e02:174b:: with SMTP id y11mr28097629ill.293.1641485596237;
        Thu, 06 Jan 2022 08:13:16 -0800 (PST)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id r12sm1334701ill.58.2022.01.06.08.13.15
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 08:13:15 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id m4so2498145ilf.0
        for <linux-spi@vger.kernel.org>; Thu, 06 Jan 2022 08:13:15 -0800 (PST)
X-Received: by 2002:a05:6e02:2187:: with SMTP id j7mr27894010ila.120.1641485595294;
 Thu, 06 Jan 2022 08:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20220103071118.27220-1-vkoul@kernel.org>
In-Reply-To: <20220103071118.27220-1-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jan 2022 08:13:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ue9Z+NmqviCXEN2pHxWZaAcTbFzzn=xxfg8d8QzPwp4A@mail.gmail.com>
Message-ID: <CAD=FV=Ue9Z+NmqviCXEN2pHxWZaAcTbFzzn=xxfg8d8QzPwp4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: qcom: geni: set the error code for gpi transfer
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Sun, Jan 2, 2022 at 11:11 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> Before we invoke spi_finalize_current_transfer() in
> spi_gsi_callback_result() we should set the spi->cur_msg->status as
> appropriate (0 for success, error otherwise).
>
> The helps to return error on transfer and not wait till it timesout on
> error
>
> Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>
> Changes in v2:
>  - add missing spi_finalize_current_transfer() for dma error case
>
>  drivers/spi/spi-geni-qcom.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 413fa1a7a936..b82f3ddff0f4 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -346,17 +346,21 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
>  {
>         struct spi_master *spi = cb;
>
> +       spi->cur_msg->status = -EIO;
>         if (result->result != DMA_TRANS_NOERROR) {
>                 dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
> +               spi_finalize_current_transfer(spi);
>                 return;
>         }
>
>         if (!result->residue) {
> +               spi->cur_msg->status = 0;
>                 dev_dbg(&spi->dev, "DMA txn completed\n");
> -               spi_finalize_current_transfer(spi);
>         } else {
>                 dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
>         }
> +
> +       spi_finalize_current_transfer(spi);
>  }

What you have here should work and seems fine, though it's a bit
awkward. Every exit path now calls spi_finalize_current_transfer().
IMO this would be slightly cleaner like this (also moving the error
cases to both be first)

if (result->result != DMA_TRANS_NOERROR) {
  dev_err(...);
} else if (result->residue)
  dev_err(...);
} else {
  spi->cur_msg->status = 0;
  dev_dbg(...);
}

spi_finalize_current_transfer(spi);

I'll let Mark decide if he wants it to be respun with the above, wants
a follow-on patch, or doesn't care either way. In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
