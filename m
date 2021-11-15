Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211EA45079B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 15:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhKOO6U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 09:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhKOO6J (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 09:58:09 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE66C061206
        for <linux-spi@vger.kernel.org>; Mon, 15 Nov 2021 06:55:11 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu18so44443629lfb.0
        for <linux-spi@vger.kernel.org>; Mon, 15 Nov 2021 06:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHoS2QIQL9jiqdDjkTDeK4x6Tmu2ipOUCUNpKzNE59E=;
        b=e9U5TdTPp4xKy1kJcXwDzSC8tbSpVywEYH9Z+sUjf4G9L8eFHtx5l3hWhed7rd1Ajz
         ebxts1R/3Vp3BD3fmiIs8ijW3vwxCRNKKrpAMPOT4NK7HnryzYPTd9dWWqyCBM/3mHnA
         vTVpkSClOFZnaQA1Ggw0m1qKX5z9BFeyCSc4VjSaCn4xvJCaKykOcCzMkrUu/7sEAMyj
         DCGbe70UQxZRmBIWafqA3pLWLk2Lx7W2zU1CZkBTpErb5uREerVsGeElEyyT8+u6f//7
         cKqncI+6LUB4ho/pCz33S0HvvdKcK7yNiEWVK9N5MT9zepjoT0gjtQYQ+6o7aVhzRCiv
         8/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHoS2QIQL9jiqdDjkTDeK4x6Tmu2ipOUCUNpKzNE59E=;
        b=03nOGbtNatmVqbJUtot2dhPl/T4S/5pJiYcZToqY2aqrelX98nOvDtesIeq2sbcJVn
         kvEgwajKeLFhJ1yOPE8E2MRWR+oDM8aVshNhJS4t/lZlLwayuzCOEQQjHN2VYqcOtwpU
         /R72LkF/NF5ozJ90AqP5Oesp1oHc+r9k9QUKrRLki1MwqTOJXVFiTBp5ga5V7i125SZG
         jznva6ijTi6o9AqWYc5pdgfBLR2wCGDqmRg1zE5kXNxWTFdpNrF0uFmVKdbldsAovXxa
         Sg3Zu86oyAUgKT59MJXdLdhxtZYiUzu8J2Pv8LcbhmD80NJFSAQMhirUOPl1foIIPMoF
         nShA==
X-Gm-Message-State: AOAM533blJhvAVg6gi4kwNfJgt4ImncCCXA/uAjMncigh2Ft/JSDzYWV
        4dDSU4MBpALLg4wUuJCQExUNNLDp+V3SwnWu7SRu1g==
X-Google-Smtp-Source: ABdhPJyFimQg7KkOTLtcJuBiGvEEcKgbemK/wWoYIOj4AkODv0WaiGPYUVNn88xx+gbks93TFVmDWvukiTbSyXAzBIA=
X-Received: by 2002:a19:8c4d:: with SMTP id i13mr37079711lfj.254.1636988109753;
 Mon, 15 Nov 2021 06:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20211112082930.3809351-1-peng.fan@oss.nxp.com> <20211112082930.3809351-3-peng.fan@oss.nxp.com>
In-Reply-To: <20211112082930.3809351-3-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Nov 2021 15:54:33 +0100
Message-ID: <CAPDyKFq=7aiRhKw5f3EqoTq3Npyjs+L1xJBxjjqtTwh03GuXow@mail.gmail.com>
Subject: Re: [PATCH V4 2/9] dt-bindings: mmc: imx-esdhc: Add imx8ulp
 compatible string
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, aisheng.dong@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, broonie@kernel.org, linux@roeck-us.net,
        wim@linux-watchdog.org, linux@rempel-privat.de,
        Kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Rob Herring <robh@kernel.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 12 Nov 2021 at 09:30, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Jacky Bai <ping.bai@nxp.com>
>
> The USDHC on i.MX8ULP is derived from i.MX8MM, it uses two
> compatible strings, so update the compatible string for i.MX8ULP.
>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  - v4 changes:
>    no
>
>  - v3 changes:
>    no
>
>  - v2 changes:
>    refine the commit message
>
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 19621a2f8beb..d5be9863009c 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -44,6 +44,10 @@ properties:
>                - fsl,imx8qm-usdhc
>                - fsl,imx8qxp-usdhc
>            - const: fsl,imx7d-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx8ulp-usdhc
> +          - const: fsl,imx8mm-usdhc
>
>    reg:
>      maxItems: 1
> --
> 2.25.1
>
