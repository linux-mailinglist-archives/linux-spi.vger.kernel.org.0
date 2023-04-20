Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9D66E9AAD
	for <lists+linux-spi@lfdr.de>; Thu, 20 Apr 2023 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjDTR0O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Apr 2023 13:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjDTR0N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Apr 2023 13:26:13 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4EF3AA6
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 10:26:12 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5422bb4603bso375701eaf.1
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682011571; x=1684603571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npIvl3QgC8NcszelNQAZW8/zRVotzvOXnUNhHUMiAZ8=;
        b=IhDnBqZQY8cR4abRY8OAlrGsC1yzIdWd5846V5sc1ZwbEdcA8jgpocudwoihI1qbNG
         k9jbA3glNctnLWTcNWHvVJCxiwkh79I+tqpCYME/SzJy55bjEiQbJN9ODFMY54v2Qci9
         jLplJlAVaBlMSIGaz2NetPKe6HCkQvCE+ynOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011571; x=1684603571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npIvl3QgC8NcszelNQAZW8/zRVotzvOXnUNhHUMiAZ8=;
        b=bW0IESndPiXtm52cFm2nZSmz1tcNebgUL1ZH3RTWyIB7+Jk2BKMlY6WY3n/PNpsVpf
         DPzFidoBYpoN3/xmTI0gMXCt73HOXn03pXLmvsJu2YnQ6GObfa7+6yXUxo3d1aaAhb2R
         fhER1fNnqPnuSra/t9v+ti1ueNLj540ZdT6IezdEet1fbuy0PW6AJrH4Ns7tRa3XxPUr
         cu0lQ+N0Gkl526nJwGUAsYrzM1r+Y3qwC9b3MGnmqBfDzjKb/WqE9Dkv27IbX54hSLOY
         mdVtnajbTNzalWVLhq6X145sgP9jjNjNILJVjZ8el8IZreeoKW/I+eO4Uz62So9Kf77f
         ePig==
X-Gm-Message-State: AAQBX9c+gE7X7lnJ414JqYzT69ihvSYLSR3RHemAZP8INnuvw4dz67Xw
        9V1ziH0/9uY1CR3M7rLqUfJzfUZi1fcPOHu5qDA=
X-Google-Smtp-Source: AKy350ZZuL+mXe5ZB45a6yroXR7c6qd/y+V4aAlc4Dg3LFfa4cPdiAWhi14tv0DNvyDRv4p+Xtmcew==
X-Received: by 2002:aca:1901:0:b0:38d:f794:258 with SMTP id l1-20020aca1901000000b0038df7940258mr1078631oii.33.1682011571115;
        Thu, 20 Apr 2023 10:26:11 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id z184-20020a4a49c1000000b00545b549c2f1sm832228ooa.22.2023.04.20.10.26.10
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:26:10 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-38e12d973bfso699899b6e.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 10:26:10 -0700 (PDT)
X-Received: by 2002:a25:cacc:0:b0:b98:6352:be17 with SMTP id
 a195-20020a25cacc000000b00b986352be17mr882764ybg.0.1682011227804; Thu, 20 Apr
 2023 10:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com> <1681996394-13099-3-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1681996394-13099-3-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Apr 2023 10:20:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WyVRxRc7WuW1vhFXWDG81cAu7g5WiC9sggGoEuQOA4Cw@mail.gmail.com>
Message-ID: <CAD=FV=WyVRxRc7WuW1vhFXWDG81cAu7g5WiC9sggGoEuQOA4Cw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64: dts: qcom: sc7180: Add stream-id of qspi to iommus
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
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
