Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F527620C0
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jul 2023 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjGYR6q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jul 2023 13:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjGYR6m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jul 2023 13:58:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFEE2122
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 10:58:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5221b90f763so5274391a12.0
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690307914; x=1690912714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMKz+TTfcKiqAZL/r0ZMj0g0KndoteFH21pGmnEW37o=;
        b=C4hfvdcz2Kd0kg0THkwyqsUnm7jg6s7XMrWcyfK+ASRMvcXgDr3GMWvjfreAq47KJX
         VNjtIVJN/FESh6Sc9yzffvhWPnqbESaZRDWJCAxNDEOBnkVm0xUVZ8sMCYppgNU3ExKo
         TX4XmxaGRShLsqlpUN6fc99Vc0jnxBLUEBGGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307914; x=1690912714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMKz+TTfcKiqAZL/r0ZMj0g0KndoteFH21pGmnEW37o=;
        b=hevnS4Veg1aPSG6QrXmcgfezJYpQvnI7sURhPk0lQMq39AZ8NLPwj9ICd/fc4x2Mhb
         3xu8u3Fw0/WSrthbA6zMUU7O9KyEKVCzQZtnD78rAErfBDqFDNCC/AxmgM9eELtLXJwx
         GLFvTUx/VP61Zyeh/ppW4F71SVnTRqzw2kvf5RY+Vq4QB86E4807BZ8N6ompXqa+geG0
         Krv8SVwUQFqVuPAvW3ieTSxMCqbVUHryvktN0+3TVHPzSKx7mjUZEKLNOx+zznk7xpgC
         TV4mReUsia8B89BaIyFYDoyginZ+28VUiH5IUSI7PA3LrCr82LRP99pqkMpb+gtcgw9Z
         4Usw==
X-Gm-Message-State: ABy/qLYGqHXplQAhaSQ90LulKGK20WplfP4hCpCHSFeb3NB/LqFI53Vm
        B85FXJZQ2tHmWaQSGHbJBDwuuY/vaQGsJFaCbJmt3AIp
X-Google-Smtp-Source: APBJJlGbTXtsEPAmfexWynzaLkTRtjYkhFLIK2ajQMNmIfrs6JUfs92P0+2TXHY1xITKBOej21aJCA==
X-Received: by 2002:a17:906:7a53:b0:98e:933:2909 with SMTP id i19-20020a1709067a5300b0098e09332909mr13529856ejo.22.1690307914490;
        Tue, 25 Jul 2023 10:58:34 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906814600b00993cc1242d4sm8465179ejw.151.2023.07.25.10.58.33
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 10:58:33 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1497a12.0
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 10:58:33 -0700 (PDT)
X-Received: by 2002:a50:d6de:0:b0:51e:5773:891d with SMTP id
 l30-20020a50d6de000000b0051e5773891dmr136155edj.4.1690307913684; Tue, 25 Jul
 2023 10:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com> <1690285689-30233-5-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1690285689-30233-5-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jul 2023 10:58:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+LULPZW7fccz2aMqfrR=fuOvBAb7LN-mGYeppuxAQZw@mail.gmail.com>
Message-ID: <CAD=FV=X+LULPZW7fccz2aMqfrR=fuOvBAb7LN-mGYeppuxAQZw@mail.gmail.com>
Subject: Re: [PATCH 4/4] spi: spi-qcom-qspi: Add DMA_CHAIN_DONE to ALL_IRQS
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Jul 25, 2023 at 4:48=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Add latest added DMA_CHAIN_DONE irq to QSPI_ALL_IRQS that encompasses all
> of the qspi IRQs.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't think this really does anything since the interrupts shouldn't
really be "hanging around" when a PIO transfer starts and that's the
only place it's used. I suspect we could actually fully remove that
bit of "Ack any previous interrupts that might be hanging around" code
and everything would be fine.

In any case, I don't have any huge objections, thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
