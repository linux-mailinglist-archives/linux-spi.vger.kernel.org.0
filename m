Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1C97620B9
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jul 2023 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGYR60 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jul 2023 13:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjGYR6Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jul 2023 13:58:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADDD1FF5
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 10:58:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9939fbb7191so26398566b.0
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690307898; x=1690912698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b46yA1Vvz5EBZCOyU8aDfGflg6YOPM/a7952vWZXQbs=;
        b=X81Eg+KiyJkaBmeVc7EzuZxmo2VAgibDS6w9rEvwlAfI6tGsS0j7KOFV9ugSL2rwNU
         Z88MZ/QzLnnbm0huHZtZLjh2zPf+1Gqt6pgk79KKrxL9k7PkcaPEr9hREGK3AzlTnfNM
         hu4xfVfmIw/WiTeUz/2DAZVTDsmJrhk4SlXZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307898; x=1690912698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b46yA1Vvz5EBZCOyU8aDfGflg6YOPM/a7952vWZXQbs=;
        b=CwwRYa95Pa+xqj+MsF0YpBprqnA2NkEp9sZ+jqmdNNbJWn1RPzqHq49JvjwtZZQp3h
         rlNnwS3Asf73CkjHUFYZL4Rzuy81wBMOIIRWhNA0ZXz97sF00TPobwv9kTrOYE7a4m+8
         KcdA/3VR9cquExS3zfA5xkW2BvdZGgh21IzSxFP8RcBe0AHptEFAu+diwqx8fvKIIRxh
         vWpyo0LJYlygrej7OlZOvR7pEXlQwgu/0W2MpieUmsC2IsfN1JPRQkyQrZOWoo3eD5zW
         fFTZmlHZqS/JFSotdP7T6T1/WuF3dFfv1sGbVU52gpgYH8NZQcWBe6RlvoYwV8mZSc/V
         ksqw==
X-Gm-Message-State: ABy/qLZKGRRHa1MEWdBEAyTWcosT8W+j9EFp9W72CPb0n9e/BIQOQlyz
        T7YyqbGCkaJSVd0H/x9BQMxhbjUl4BLELkFZAs4bm78V
X-Google-Smtp-Source: APBJJlHnZWQTSSIv5vds4nQvCELO1aaL/m2tC7r00+rIA6WpvZiJtxVNUp4m4BheZJohB+hwHAUAyA==
X-Received: by 2002:a17:906:6488:b0:997:6729:5f4b with SMTP id e8-20020a170906648800b0099767295f4bmr3600844ejm.11.1690307898578;
        Tue, 25 Jul 2023 10:58:18 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906831600b0098951bb4dc3sm8384421ejx.184.2023.07.25.10.58.17
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 10:58:17 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1475a12.0
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 10:58:17 -0700 (PDT)
X-Received: by 2002:a50:d55c:0:b0:51e:16c5:2004 with SMTP id
 f28-20020a50d55c000000b0051e16c52004mr143860edj.6.1690307897245; Tue, 25 Jul
 2023 10:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com> <1690285689-30233-3-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1690285689-30233-3-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jul 2023 10:58:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wb4_q7xL_ec=_=bQodb0dy18HQzY=E855mZ1r+5G36uQ@mail.gmail.com>
Message-ID: <CAD=FV=Wb4_q7xL_ec=_=bQodb0dy18HQzY=E855mZ1r+5G36uQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] spi: spi-qcom-qspi: Use GFP_ATOMIC flag while
 allocating for descriptor
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, dan.carpenter@linaro.org
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

On Tue, Jul 25, 2023 at 4:48=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> While allocating for DMA descriptor, GFP_KERNEL flag is being used and
> this allocation happens within critical section with spinlock acquired.
> This generates a static checker warning.
>
> Use GFP_ATOMIC to prevent sleeping; and since this increases chances of
> allocation failure, add handling accordingly.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/abc223e8-44af-40bb-a0bd-9865b393f435@=
moroto.mountain/
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
