Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2953C6E9B4B
	for <lists+linux-spi@lfdr.de>; Thu, 20 Apr 2023 20:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjDTSJl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Apr 2023 14:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDTSJk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Apr 2023 14:09:40 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAD31FC0
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 11:09:39 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54c12009c30so52666357b3.9
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682014178; x=1684606178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FVvbbOx6CVUuVacoumj0fiPSi4Hh5DrvtofkdN8frA=;
        b=DtGS09qzxizdtF+C2BdfWX99HwYvM4YeEwMGHtOgmNgkLqzFnpF/lhWDEt3DKusTH8
         3RsVrzGa0+vZhTH0TS3j+OSqSWyczoqQyPqslCp3HoGYBkpxNG6zbFC+zcaxqTROe92n
         YSLP0qnKUu7+T6of3H3quVpcS7hiibOzZbx54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014178; x=1684606178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FVvbbOx6CVUuVacoumj0fiPSi4Hh5DrvtofkdN8frA=;
        b=j6rptUfH3lTVqX3+4oIGdBoBAfSqfHTuVYlYWC74QxZmp1oPoAiWut9Gbh8nekd8Qt
         8/NCeftKH/XwHY5ccnSh251yeBYKUZqXwn/PIAhjMbPhb69U7athIDXvmGhQ9KUEdJHd
         uDpQnQSEoAkETIiOXCvskwVh1AbtoKqRFJgdfEyio8JGnqJeTWyEaDOuxQW+gGoMPlKf
         BzgNKPxxfH1YK5ZwJfCjr8bAcSg9V0lsknlJS+1BywYL565YV2LFObXBMNsqd+UDyZ2m
         esEenAQe1dyWxp0wnai/qHVl7vOm0cgT3c5PiZRhY33j38bKlrNrHKx8pi448/9Ru5O5
         4yYw==
X-Gm-Message-State: AAQBX9dDZ2mk7B1BVy8c8RjCbVxT2RE7x0b5VaR4xV4dddvTcvharAfT
        iRcu62SqgmSwaIAs73OtYwLgqwjlJ0wCZqomNfE=
X-Google-Smtp-Source: AKy350bWMSX4bNTcoe5ATohzMZHOsBMhT+XfGgp9NaGZMkiKgJzFVSGVg3tnPJsN8AGxvz1m3mPasw==
X-Received: by 2002:a0d:db4d:0:b0:54f:b9b2:402f with SMTP id d74-20020a0ddb4d000000b0054fb9b2402fmr1602610ywe.32.1682014177952;
        Thu, 20 Apr 2023 11:09:37 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id x67-20020a0dd546000000b0054c0be459dbsm475145ywd.39.2023.04.20.11.09.34
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 11:09:35 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id n17so2924620ybq.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 11:09:34 -0700 (PDT)
X-Received: by 2002:a25:d895:0:b0:b98:6352:be20 with SMTP id
 p143-20020a25d895000000b00b986352be20mr750560ybg.0.1682014173924; Thu, 20 Apr
 2023 11:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com> <1681996394-13099-6-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1681996394-13099-6-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Apr 2023 11:09:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UkSQUSkY0UsU=s=PhXYRCrh-0TWM4K7FRfymTtL+MbcQ@mail.gmail.com>
Message-ID: <CAD=FV=UkSQUSkY0UsU=s=PhXYRCrh-0TWM4K7FRfymTtL+MbcQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Apr 20, 2023 at 6:13=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> @@ -528,6 +760,7 @@ static int qcom_qspi_probe(struct platform_device *pd=
ev)
>         master->prepare_message =3D qcom_qspi_prepare_message;
>         master->transfer_one =3D qcom_qspi_transfer_one;
>         master->handle_err =3D qcom_qspi_handle_err;
> +       master->can_dma =3D qcom_qspi_can_dma;

One extra comment: it might be worth adding something like this (untested):

if (of_property_read_bool(np, "iommus"))
  master->can_dma =3D qcom_qspi_can_dma;

That will have the dual benefit of making old device trees work (which
we're supposed to to if possible) and also making it easier to land
these changes. Without something like that then I think transfers will
fail for anyone who pulls in the SPI tree but not the Qualcomm DT
tree.
