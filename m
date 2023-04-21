Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8766EB09B
	for <lists+linux-spi@lfdr.de>; Fri, 21 Apr 2023 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjDURfW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Apr 2023 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjDURfV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Apr 2023 13:35:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1779659F9
        for <linux-spi@vger.kernel.org>; Fri, 21 Apr 2023 10:35:20 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-5ef4d902708so21520616d6.2
        for <linux-spi@vger.kernel.org>; Fri, 21 Apr 2023 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682098518; x=1684690518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXK86wEYiVwAAffwU2RrQU5w4OvwpRlSMCsUx9Wsyw8=;
        b=dh3k5zlWzfu6th6WS5+nnxJv12bmwzJ8kcsy5CNsvsEzR1JVM6O6CyHsFBb+sFGGEb
         ieFhheJ7NCcb/qMtYTaAwQiRMA09D6tDISITrIQFyAxwL9TolUtieAOu8Cqi7yAoVj9J
         y1+SSii6oCjsVWCYFIp5IViRdYds0IZ1r65F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098518; x=1684690518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXK86wEYiVwAAffwU2RrQU5w4OvwpRlSMCsUx9Wsyw8=;
        b=YjA0xKTR8WRaeyAgb0C3NUwaI0SGQby5rdzEyuKfaeRvn4o5xmx65uhvz2RDvkTRh2
         kJSjPoI86hB2duCD3GJlq5nzTt01MS4ZSkVaUwtv0o/0yLqZc31rEL9PUUMyKfvKOGZp
         CpPB7KA900Hi3IokajJQOWdpA+enNwP2pEracZHKw7WngKi/7FX3jeY1t+JqLeXjaMiR
         zh8gZNO7GQV838f8UrCjPRBe0fq/zfbhdmJ2h192hzLR/y5yCm4gCEUDaZKVior0nQ0q
         OOsLIQRjN+I9oLOlPyKV1NgRqTTdGlqmjZ9vwwGPc66/ZSo4AURdPj+FXkXrLCIaaQKw
         +6Lg==
X-Gm-Message-State: AAQBX9e5nSqst5SpGUjZFEUr4mXXcc1htb8xkjw88fJhK73wHWTs7MrH
        R4DRKMfiBsavYa3+SKgQfAFNByweD3OgwWCn9pk=
X-Google-Smtp-Source: AKy350b2+5fL5rWJbopjyBhbErLn8N8hRNai1y0zCNCVUG5wjkGln2qv+ip66a+YGeXvzqCUIJGvLg==
X-Received: by 2002:a05:6214:2a4e:b0:5ef:6f81:6e with SMTP id jf14-20020a0562142a4e00b005ef6f81006emr12199614qvb.18.1682098518609;
        Fri, 21 Apr 2023 10:35:18 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id k14-20020a0cf58e000000b005eac706d223sm1301259qvm.124.2023.04.21.10.35.17
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 10:35:17 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-3ef36d814a5so1199331cf.0
        for <linux-spi@vger.kernel.org>; Fri, 21 Apr 2023 10:35:17 -0700 (PDT)
X-Received: by 2002:ac8:588f:0:b0:3ef:26ec:f27a with SMTP id
 t15-20020ac8588f000000b003ef26ecf27amr395030qta.13.1682098516847; Fri, 21 Apr
 2023 10:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com>
 <1681996394-13099-6-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=VU9Zdk2wz=90cjmuBWxaVz9w+UxzrTtW_ny-jrwVLV3w@mail.gmail.com> <7a6fe89b-5898-08d3-6c44-2cfc9d8fae7a@quicinc.com>
In-Reply-To: <7a6fe89b-5898-08d3-6c44-2cfc9d8fae7a@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Apr 2023 10:35:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U_7t4H9nXy6Ku49qLqbhZ02K-_XQv_Ssgkp26s3LyDMw@mail.gmail.com>
Message-ID: <CAD=FV=U_7t4H9nXy6Ku49qLqbhZ02K-_XQv_Ssgkp26s3LyDMw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] spi: spi-qcom-qspi: Add DMA mode support
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
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

Hi,

On Fri, Apr 21, 2023 at 9:58=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Hi,
>
> Thanks a lot for the review and inputs...
>
>
> On 4/20/2023 10:49 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Apr 20, 2023 at 6:13=E2=80=AFAM Vijaya Krishna Nivarthi
> > <quic_vnivarth@quicinc.com> wrote:
> >> @@ -137,11 +155,29 @@ enum qspi_clocks {
> >>          QSPI_NUM_CLKS
> >>   };
> >>
> >> +enum qspi_xfer_mode {
> >> +       QSPI_FIFO,
> >> +       QSPI_DMA
> >> +};
> >> +
> >> +/*
> >> + * Number of entries in sgt returned from spi framework that-
> >> + * will be supported. Can be modified as required.
> >> + * In practice, given max_dma_len is 64KB, the number of
> >> + * entries is not expected to exceed 1.
> >> + */
> >> +#define QSPI_MAX_SG 5
> > I actually wonder if this would be more nicely done just using a
> > linked list, which naturally mirrors how SGs work anyway. You'd add
> > "struct list_head" to the end of "struct qspi_cmd_desc" and just store
> > a pointer to the head in "struct qcom_qspi".
> >
> > For freeing, you can always get back the "virtual" address because
> > it's just the address of each node. You can always get back the
> > physical address because it's stored in "data_address".
> >
> Please note that in "struct qspi_cmd_desc"
>
> data_address - dma_address of data buffer returned by spi framework
>
> next_descriptor - dma_address of the next descriptor in chain
>
>
> If we were to have a linked list of descriptors that we can parse and
> free, it would require 2 more fields
>
> this_descriptor_dma - dma address of the current descriptor

Isn't that exactly the same value as "data_address"? Sure,
"data_address" is a u32 and the DMA address is 64-bits, but elsewhere
in the code you already rely on the fact that the upper bits of the
DMA address are 0 when you do:

virt_cmd_desc->data_address =3D dma_ptr


> next_descriptor_virt - virtual address of the next descriptor in chain

Right, this would be the value of the next node in the linked list,
right? So basically by adding a list_node_t you can find it easily.


> >> +static int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, dma_addr_t dm=
a_ptr,
> >> +                       uint32_t n_bytes)
> >> +{
> >> +       struct qspi_cmd_desc *virt_cmd_desc, *prev;
> >> +       dma_addr_t dma_cmd_desc;
> >> +
> >> +       /* allocate for dma cmd descriptor */
> >> +       virt_cmd_desc =3D (struct qspi_cmd_desc *)dma_pool_alloc(ctrl-=
>dma_cmd_pool,
> >> +               GFP_KERNEL, &dma_cmd_desc);
> > Remove unnecessary cast; "void *" assigns fine w/out a cast.
> >
> > Add "| GFP_ZERO" and then get rid of the need to clear the "reserved"
> > and "next_descriptor" stuff below.
> >
> I needed __GFP_ZERO to prevent a compile error, used same.

Ah, sorry. Sounds good.

-Doug
