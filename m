Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC7710E4A
	for <lists+linux-spi@lfdr.de>; Thu, 25 May 2023 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbjEYO0D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 May 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjEYO0C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 May 2023 10:26:02 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094FF187
        for <linux-spi@vger.kernel.org>; Thu, 25 May 2023 07:26:01 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-774924b7c4dso169549439f.1
        for <linux-spi@vger.kernel.org>; Thu, 25 May 2023 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685024759; x=1687616759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIaS1CiG05qxEN3YCh4DxBPvMLd9g2DK0yZG+wFH+TY=;
        b=QZmHsnu2sAnvLhCp2YBsBsnd+fNBrH1S4AQX4mWtZJqZr8alDh15ZgXDY2OUYyLBzn
         DX4V1qiWbK2K72UCdenknj5xZvi7HjNIrmrtagrA3cwcUcDXbp//azM7URajrH+nsTad
         Gab+SC4HzJZqmRFfjKBYpPgMcnbGyh+ymqaqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685024759; x=1687616759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIaS1CiG05qxEN3YCh4DxBPvMLd9g2DK0yZG+wFH+TY=;
        b=As6bWtoSq0uTXO/ULIycTV2Bd/scxtwVYWyn7lGBj1CE384DKCThnlbTmalp6rD/53
         fmyftdlFnLInmRukgni82PLMwZB0ISyfMX47suVkJ0HLcAris1JfZ+XW3fd/myj0J3nH
         PWwp6TMBO/4ionaLmDdgMb1iGS7I5TxCcsZuAs34QO4q3z0tLb7Ua2FRW/J3J1uTyCnN
         A680EBLgbGiIhA29JETMggGminIOFtZvYPATLSCXfvVBlOMPnUuZm7JpEQgiXRX6JN9m
         yyf8EODjmyQdfOQLiJUZ5cj9dtVLlbs6ybtrGfBTnAw9Eo8+kgDz1KDQqWj78j1bVMqo
         293A==
X-Gm-Message-State: AC+VfDyfP4gCja+e/SI4mSRMBCwDeqEdAXlWmmKSaZWZpZpZMsCeTU9V
        YA2QHTrBkFwleRX/mHxoyjq1dK0WSZN+zyz9LE0=
X-Google-Smtp-Source: ACHHUZ59QxAILWG/qTjaqBB4yvCbf70wLxAoBLe/VHVRDiUCdbzbMEg0abaV0gSYyhr8H643DocdfA==
X-Received: by 2002:a5d:91cb:0:b0:76c:71dc:55f3 with SMTP id k11-20020a5d91cb000000b0076c71dc55f3mr14307321ior.6.1685024759526;
        Thu, 25 May 2023 07:25:59 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id u28-20020a02cbdc000000b00418a50b958esm446979jaq.178.2023.05.25.07.25.57
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 07:25:57 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-33164ec77ccso175105ab.0
        for <linux-spi@vger.kernel.org>; Thu, 25 May 2023 07:25:57 -0700 (PDT)
X-Received: by 2002:a05:6e02:1d12:b0:331:aabc:c8b7 with SMTP id
 i18-20020a056e021d1200b00331aabcc8b7mr224459ila.10.1685024756622; Thu, 25 May
 2023 07:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <1682328761-17517-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1682328761-17517-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 May 2023 07:25:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WdTS6UA9oSahdn8k2hKRLZo974A4b8nrDYSiTggKAv+g@mail.gmail.com>
Message-ID: <CAD=FV=WdTS6UA9oSahdn8k2hKRLZo974A4b8nrDYSiTggKAv+g@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] spi: Add DMA mode support to spi-qcom-qspi
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        mka@chromium.org, swboyd@chromium.org, quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Bjorn,

On Mon, Apr 24, 2023 at 2:32=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> There are large number of QSPI irqs that fire during boot/init and later
> on every suspend/resume.
> This could be made faster by doing DMA instead of PIO.
> Below is comparison for number of interrupts raised in 2 scenarios...
> Boot up and stabilise
> Suspend/Resume
>
> Sequence   PIO    DMA
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Boot-up    69088  19284
> S/R        5066   3430
>
> Speed test results...
> spi-nor read times in sec after 2 min uptime
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> PIO - Iterations-1000, min=3D3.18, max=3D3.74, avg=3D3.53
> DMA - Iterations-1000, min=3D1.21, max=3D2.28, avg=3D1.79
>
> spi-nor write times in sec after 2 min uptime
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> PIO - Iterations-1000, min=3D3.20, max=3D8.24, avg=3D3.58
> DMA - Iterations-1000, min=3D1.25, max=3D5.13, avg=3D1.82
>
> Further testing performed...
> a) multiple entries in sgt (simulated by max_dma_len =3D 1024)
> b) fallback to pio (simulated by dma setup failure)
>
> Vijaya Krishna Nivarthi (5):
>   spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus
>   arm64: dts: qcom: sc7180: Add stream-id of qspi to iommus
>   arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
>   arm64: dts: qcom: sdm845: Add stream-id of qspi to iommus
>   spi: spi-qcom-qspi: Add DMA mode support

Mark has landed the bindings / code changes:

b5762d95607e spi: spi-qcom-qspi: Add DMA mode support
64c05eb3a0f4 spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus

...so I think the dts changes here are ready for you to land. There
are no hard dependencies here so you can land the dts without needing
the code changes.

Thanks!

-Doug
