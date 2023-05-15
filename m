Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE4703266
	for <lists+linux-spi@lfdr.de>; Mon, 15 May 2023 18:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbjEOQLb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 May 2023 12:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242566AbjEOQL0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 May 2023 12:11:26 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27223A82
        for <linux-spi@vger.kernel.org>; Mon, 15 May 2023 09:11:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7577ef2fa31so2729737085a.0
        for <linux-spi@vger.kernel.org>; Mon, 15 May 2023 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684167060; x=1686759060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHHGh5czrg9Hn8ruae6+tSUOYEqC66Bkk4Dqa3XiSlo=;
        b=m0PHCsR2wUvPmVHi/pqxU7Y5Tbzs6sLgY+9mJCOyGXKsSk9dzqC6vMU+VBffF6ql3o
         v/avUmXENBS5axoNLXgnJluwyafElfrJLkzWH4P3MLseF+9UD1vafGaTo5Of7HEABaBJ
         lc58PYrddvBcYY3VNa6LFl0raCBmx62l3/5lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684167060; x=1686759060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHHGh5czrg9Hn8ruae6+tSUOYEqC66Bkk4Dqa3XiSlo=;
        b=BYKBcpUc+YnIuVl5+9SoCGXDlF5md4iDN5Virye5rNFZ36SGShjBjxxeFi6+9uXSXt
         wgnENxMJ4IyfIjNSTx+j36LUH2wao2L7QCY3ZxF06iyRg6+YvMDof+CiDxGigS8FZ8k7
         W9Z8lV6mD1FLf17sSTKpGdRDOt3gIX5O0j/xxOa9Bo+MxINWRgqfEbkks2YI+ZF+f0UP
         bV6fv8sz1MyBMey8COS0KZYoftae7dK5hsq6MnzblmBVAbKFZRT/2w235w7IWLJT8nph
         olYuECSV+94SFPJoYQO0Zd38hv4BWMtqU/ghBOQQKB69uY6FMEO4scvkvMdtP9Ub3bxR
         RCFw==
X-Gm-Message-State: AC+VfDzzHl+iMEYrJMticf5FfIHXCthZvJvp+C2yhWp9n2Wk8B3EfPL6
        pu2NAPrakrzJreCUBlZXgo+F1/w7jqPE0pfJc0g=
X-Google-Smtp-Source: ACHHUZ7d1WOJDvhVNu5caNvFtjxRuizIjZfKSEbSH5pjXfbujGCA9DXtgUHAo3BCot5dA1+dVX6znQ==
X-Received: by 2002:a05:622a:c9:b0:3f3:87d8:c6f4 with SMTP id p9-20020a05622a00c900b003f387d8c6f4mr47131653qtw.7.1684167059860;
        Mon, 15 May 2023 09:10:59 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id d8-20020a37c408000000b0074abed56793sm50232qki.20.2023.05.15.09.10.57
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:10:57 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-3f51ea3a062so253481cf.1
        for <linux-spi@vger.kernel.org>; Mon, 15 May 2023 09:10:57 -0700 (PDT)
X-Received: by 2002:a05:622a:1a96:b0:3bf:e4e0:26a0 with SMTP id
 s22-20020a05622a1a9600b003bfe4e026a0mr1191894qtc.14.1684167056984; Mon, 15
 May 2023 09:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <1683911265-3395-1-git-send-email-quic_vnivarth@quicinc.com> <1683911265-3395-2-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1683911265-3395-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 May 2023 09:10:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VY31FCpj7HP+erKBA3SCGGgUxO=msTaVDjsGYB1eKmiA@mail.gmail.com>
Message-ID: <CAD=FV=VY31FCpj7HP+erKBA3SCGGgUxO=msTaVDjsGYB1eKmiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: geni-se: Add interfaces
 geni_se_tx_init_dma() and geni_se_rx_init_dma()
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Fri, May 12, 2023 at 10:07=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> The geni_se_xx_dma_prep() interfaces necessarily do DMA mapping before
> initiating DMA transfers. This is not suitable for spi where framework
> is expected to handle map/unmap.
>
> Expose new interfaces geni_se_xx_init_dma() which do only DMA transfer.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/soc/qcom/qcom-geni-se.c  | 67 +++++++++++++++++++++++++++++-----=
------
>  include/linux/soc/qcom/geni-se.h |  4 +++
>  2 files changed, 53 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni=
-se.c
> index 795a2e1..adfcd6e 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -682,6 +682,30 @@ EXPORT_SYMBOL(geni_se_clk_freq_match);
>  #define GENI_SE_DMA_EOT_EN BIT(1)
>  #define GENI_SE_DMA_AHB_ERR_EN BIT(2)
>  #define GENI_SE_DMA_EOT_BUF BIT(0)
> +
> +/**
> + * geni_se_tx_init_dma() - Initiate TX DMA transfer on the serial engine
> + * @se:                        Pointer to the concerned serial engine.
> + * @iova:              Pointer to store the mapped DMA address.

We're not returning the "iova" from this function, so it shouldn't say
"Pointer to store".


> + * @len:               Length of the TX buffer.
> + *
> + * This function is used to initiate DMA TX transfer.
> + */
> +void geni_se_tx_init_dma(struct geni_se *se, dma_addr_t *iova, size_t le=
n)

There is no reason to pass iova as a pointer, right? Change it to just
"dma_addr_t"


Same comments on the RX side of things.


-Doug
