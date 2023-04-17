Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C66E4AEE
	for <lists+linux-spi@lfdr.de>; Mon, 17 Apr 2023 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjDQOIp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Apr 2023 10:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDQOIk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Apr 2023 10:08:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDBC59F4
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 07:07:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id c9so25609244ejz.1
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681740462; x=1684332462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moL+4Bl3gFWXEYHuDwZ5rfkHMK20tDKYmlXyWn8rpAc=;
        b=bqx/tJOP7Kr6yD9FcNem6W0dLeNkXGRtenje02B36BaPj3BfVfKLwGQm0Fc86kOIhT
         svggese/AP5ZJrniAow8iq+IfyYgPm6EGAKqBOts5/YkUz4qyWeAqy3sVtzw1fwy0NIK
         fTqydFRoTGQl1TgSxARGA/cVnRDhfHkSNzib8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681740462; x=1684332462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moL+4Bl3gFWXEYHuDwZ5rfkHMK20tDKYmlXyWn8rpAc=;
        b=S+9ZS/bvbWJVoJSDN88TTjt2bDxox4WbhK6oRr0/BTdJhVyQl0zwbZjkjEfeQVW3h/
         zQFvludXRQiRIbvuUyn8krA+l0hBxpZldbvsmzGI2kq1APTvPzX8YXf1UnH5GrGhdG0J
         fNQYoWIJaZ4oKxkK7Aoj9/M/drV4oucmDJUMwaVkROw9wQCnlxGXjwrg8+ZGGmpEpPgC
         +Wg+BQOMlcF6Nwk40iO+tQfi1CXDI3thePnr0gUcKq0PXVN6Escvv1a2W+xNolz4chU6
         FFP/twz8i/dBrKxhjBiIHCqnejA/SCsfJO6sAq4xiZYsAqT5L/6+vYp+n+cdgupqfKHJ
         VjYg==
X-Gm-Message-State: AAQBX9fLrQGUt3W2cBydTlLO0pFt85KlAe4Bk4qivtkyXefo1jmmEri0
        Qx+H+DDz4zP2ZWHLHXQFuKc0/2yN2vSOiC9eTAAC0A==
X-Google-Smtp-Source: AKy350ZLw+N+QnwiLdk1GIjkGGZ+pNXgIDOgmvF84y34oMEAtACWGpsbhMkkTGas2xgsNYvXtWPASQ==
X-Received: by 2002:a17:906:b242:b0:931:cd1b:3c0 with SMTP id ce2-20020a170906b24200b00931cd1b03c0mr6194270ejb.3.1681740462306;
        Mon, 17 Apr 2023 07:07:42 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id jg7-20020a170907970700b0094f5d1bbb21sm2239233ejc.102.2023.04.17.07.07.41
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 07:07:41 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so21099043wmb.3
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 07:07:41 -0700 (PDT)
X-Received: by 2002:a7b:c40f:0:b0:3f1:6757:6239 with SMTP id
 k15-20020a7bc40f000000b003f167576239mr1471017wmi.6.1681740460987; Mon, 17 Apr
 2023 07:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com>
 <1681481153-24036-4-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=VKY-0vX271G+EQQ5kC3gTqpPPyTGE0xHWPBncVUhZufQ@mail.gmail.com> <30a752c9-3ea0-43d3-959a-da2e8b526cb4@sirena.org.uk>
In-Reply-To: <30a752c9-3ea0-43d3-959a-da2e8b526cb4@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Apr 2023 07:07:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VCbcUnf42tK-HV8j=71BXXytxku_0rGjKyhyR3WG4SUw@mail.gmail.com>
Message-ID: <CAD=FV=VCbcUnf42tK-HV8j=71BXXytxku_0rGjKyhyR3WG4SUw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] spi: spi-qcom-qspi: Add DMA mode support
To:     Mark Brown <broonie@kernel.org>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
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

On Mon, Apr 17, 2023 at 5:12=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Apr 14, 2023 at 03:05:58PM -0700, Doug Anderson wrote:
>
> > Having alignment requirements like this doesn't seem like it should be
> > that unusual, though, and that's why it feels like the logic belongs
> > in the SPI core. In fact, it seems like this is _supposed_ to be
> > handled in the SPI core, but it isn't? In "spi.h" I see
> > "dma_alignment" that claims to be exactly what you need. As far as I
> > can tell, though, the core doesn't use this? ...so I'm kinda confused.
> > As far as I can tell this doesn't do anything and thus anyone setting
> > it today is broken?
>
> SPI consumers should only be providing dmaable buffers.

Ah, I think I see.

1. In "struct spi_transfer" the @tx_buf and @rx_buf are documented to
have "dma-safe memory".

2. On ARM64 anyway, I see "ARCH_DMA_MINALIGN" is 128.

So there is no reason to do any special rules to force alignment to
32-bytes because that's already guaranteed. Presumably that means you
can drop a whole pile of code and things will still work fine.

-Doug
