Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C656E9A98
	for <lists+linux-spi@lfdr.de>; Thu, 20 Apr 2023 19:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjDTRVU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Apr 2023 13:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjDTRVQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Apr 2023 13:21:16 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B085266
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 10:21:13 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fc337a650so51959377b3.4
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682011271; x=1684603271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78/qGEvYe/lkrFdeVXssBK2xk+jn/Iin4nBiAlABPII=;
        b=W2KQMjbB2G3yMUkW1rPKlIip/zQTBozc2YLiGxo3HuRE3be0I5a2HuuaVWMADDYDjg
         c9vJwnivbXDs0xz7u38Hx9c4QXIymnpwL6DBieWn0CshyAFBgNELXiFzON8/FOcI3xRA
         PxSxbLKIQVefkaqDE6O8E2Nrmy3vAysBOwWD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011271; x=1684603271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78/qGEvYe/lkrFdeVXssBK2xk+jn/Iin4nBiAlABPII=;
        b=VnLvZuFlWPP4FDzENY3zIffUpMDGs3j0SjnvlpGCnzqkaFccBLaJ0pmouGo1oWy3Cj
         3wj2NkExdMTGMhsSiUVPOsSvlPGg7wUprGoQkUw+D9hQSKymGuLq+Dl/NbO+3msvCy8e
         2Qi2lseuyMmPKHmAeRjas38kXP48yJZPhxlkWiVJEN5hMKaOh6TLT3GLX91+RvN0TLBH
         AIEg7NCz4yIk4AH6KBiWuHx/atBA/7d6DqfF82qxs7LooE4PU1cxKqb1Fg6HO69+g6uM
         1Gbdh8iTK3ZwOkrbKcd0Q8u00c99V0NGmLTugTCczDAMFnl/xGOFr6iaG3+/8kBsIelQ
         lZvw==
X-Gm-Message-State: AAQBX9fa4HQz1LbTsrkFj9v7FrpneUv+gT35t9GN8Iw603+b1DZOiDFo
        4rBXY0w+Oog54+CJfT93Ss8C8m3xUWvZKKVXcwU=
X-Google-Smtp-Source: AKy350YB39S5kPXTihjRhaQfnBfAFAtFJG9wqM4CHXvsSApH6ELeNJHv0ov/BAVOXFpnY9y7Qag3MQ==
X-Received: by 2002:a0d:ea82:0:b0:541:85ce:5a23 with SMTP id t124-20020a0dea82000000b0054185ce5a23mr1264638ywe.38.1682011271686;
        Thu, 20 Apr 2023 10:21:11 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id o193-20020a0dccca000000b00545cb6adc16sm452493ywd.6.2023.04.20.10.21.08
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:21:09 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id g11so1254842ybp.11
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 10:21:08 -0700 (PDT)
X-Received: by 2002:a25:d895:0:b0:b98:6352:be20 with SMTP id
 p143-20020a25d895000000b00b986352be20mr684421ybg.0.1682011268498; Thu, 20 Apr
 2023 10:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com> <1681996394-13099-5-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1681996394-13099-5-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Apr 2023 10:20:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ULfbQh7JgGTNh67JjQCwcBZD3nZqWGw7-fP1W2WX0pfg@mail.gmail.com>
Message-ID: <CAD=FV=ULfbQh7JgGTNh67JjQCwcBZD3nZqWGw7-fP1W2WX0pfg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] arm64: dts: qcom: sdm845: Add stream-id of qspi to iommus
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
> As part of DMA mode support to qspi driver.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
