Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5704F7BBF9E
	for <lists+linux-spi@lfdr.de>; Fri,  6 Oct 2023 21:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjJFTOZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Oct 2023 15:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjJFTOZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Oct 2023 15:14:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096FA95
        for <linux-spi@vger.kernel.org>; Fri,  6 Oct 2023 12:14:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso4455277a12.1
        for <linux-spi@vger.kernel.org>; Fri, 06 Oct 2023 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696619661; x=1697224461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmhUWZX30hXfIU80TyRy7axZSi3Eoh4Vptrv5M6pTXM=;
        b=D7QekHNh4EI33zCc9hFJdYppUuG3eywEXkkeQFVHYBDgwyj1yRYN/7V7F5ImVT15F3
         B/HGIGsx5qdcwMLkCOv+xkQZepWuQPK1YEYmvCOFC4RUFbRiGFPP+0/BPA3SlgDo6VYW
         vTpbURe4f4ZB6cYzkur5MlvqBH3aYcItMI0ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619661; x=1697224461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmhUWZX30hXfIU80TyRy7axZSi3Eoh4Vptrv5M6pTXM=;
        b=STLka+pwVqPx2ZuJJHd61PgAKfTmRkv21q6DkXLN1KFgkM7i2PW5QiSO6Db954scDF
         fOd4fTZLYVzbVZyRQ/0qCvDf/UZHMAemVWR9p2unP1vOPD9+Yl5oK486czK8Jl/d+APz
         XMhP7LOFFNv3y+id2yh5qZ32IO657n/2e+ODhgAPF7VRHkfOfm6oUaSU1oUjxfWtAgl6
         ju2mjP+zEXMgrd/raowjJOrxuxRmW+sBtF5ygeTXDlK2GD9OHB8sfCwEqeZ5oMUDJkTL
         Zr7/D2Ew9LqvrBQ2PyTSIhKVHJ7My5xjjw0uFpXYbirqM73RAyPrdohskp4c0DprQ6oE
         Cx2w==
X-Gm-Message-State: AOJu0YwSL5hVRYrnML48QgJKca1zjTr1nNUHSqubObJqgFxxOgHbM3x0
        mOYN+/DWdTdEW8hAE9Qb5eqCE+tEDTS0heOWtoOmBLv6
X-Google-Smtp-Source: AGHT+IGe0u10tGTkrm4uwzQjfL4B4GgN+6+975sxfAZIaDhnHGaMNvwgveK6/13aHAVWA+isIUXp0w==
X-Received: by 2002:a17:906:311b:b0:9b0:169b:eedf with SMTP id 27-20020a170906311b00b009b0169beedfmr8811902ejx.7.1696619661010;
        Fri, 06 Oct 2023 12:14:21 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id kb4-20020a1709070f8400b009adc81bb544sm3295302ejc.106.2023.10.06.12.14.20
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 12:14:20 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso2459a12.0
        for <linux-spi@vger.kernel.org>; Fri, 06 Oct 2023 12:14:20 -0700 (PDT)
X-Received: by 2002:a50:9b1d:0:b0:525:573c:643b with SMTP id
 o29-20020a509b1d000000b00525573c643bmr232878edi.7.1696619660110; Fri, 06 Oct
 2023 12:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <1696614170-18969-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1696614170-18969-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 6 Oct 2023 12:14:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ua-bDMvSj-FRWKxCm3oS4U-rqzd--g4UX_TBDF65rb5A@mail.gmail.com>
Message-ID: <CAD=FV=Ua-bDMvSj-FRWKxCm3oS4U-rqzd--g4UX_TBDF65rb5A@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Rename the label unmap_if_dma
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Fri, Oct 6, 2023 at 10:43=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> The code at unmap_if_dma label doesn't contain unmapping dma anymore but
> has only fsm reset.
>
> Rename it to reset_if_dma accordingly.
>
> No functional change.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I guess perhaps technically this could have:

Fixes: 3a76c7ca9e77 ("spi: spi-geni-qcom: Do not do DMA map/unmap
inside driver, use framework instead")

...since before that commit it _did_ do the unmap, right? ;-)

In any case, this seems good to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
