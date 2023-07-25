Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A88A762152
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jul 2023 20:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjGYSat (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jul 2023 14:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGYSas (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jul 2023 14:30:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E992129
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 11:30:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99b78fda9a8so657020766b.1
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690309844; x=1690914644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CGUzsI7Hg5HNN48tuYY6ykJTqafYlRSVvbn1sDRD8w=;
        b=PwKzLi5110oUilmTqVOwIm4NJbZfFzpemuGfflbbrudAgVS+3M6K6RFVRr+UsAnu8w
         keq3ZPFFzB0ETMaQkZwjWBviBqt9IENw2cj+ZrqjwGT1sboHiOsBG7rbA6y/HQtK/16D
         ioaDGWmYbRN+enHC0MgKGON+avKifU0GzXhSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690309844; x=1690914644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CGUzsI7Hg5HNN48tuYY6ykJTqafYlRSVvbn1sDRD8w=;
        b=jUFrZ0P7klndvI4hperKH9jzAc/piUPU3i2clto8O6mmfiJuDy7hZrqr17gBZDCP4i
         k9QgWiAKLhia1s1XGGkSigaYzDP+aExkWpO/1+dk1kwWtxB3+NPAhwhiB3yp0RhHVDu0
         WOy/JMhTOhH7xHIhV8vp4Jq2o19r8H78t96Kx+rWW1vWKy3QhzmZiNAEoCObqSVpP8AA
         +fILpKJkdsqrtRci4pXfIJjYhkgMY7xuVQNXnKCW7M5G15qB8rrSWJgH4KG84cq5zdx2
         09ob0S7iJdJesFKNTmA6iWa5zKVSY4OQlGbGJBfFsOnORy0NHwn5PggbYtUGUQx0Z6/v
         n7pg==
X-Gm-Message-State: ABy/qLbiE0YEnhCwIRICw42KlrSMuT2FLPVUCrk0JaBM+ILlJo2rx/wY
        wx/dxLf5yNhBvMlxzDSw4aDVZh4yJF2z6EkZRVpwOq0S
X-Google-Smtp-Source: APBJJlG+nRWtoxyGxpTXQtyhqY5nS9q2SV1eWmhUC/rTIblJ4eyKI7WSrFp/A5f4QvXkLwv+CKuIxQ==
X-Received: by 2002:a17:906:1091:b0:991:c9da:70da with SMTP id u17-20020a170906109100b00991c9da70damr15000021eju.61.1690309843878;
        Tue, 25 Jul 2023 11:30:43 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm8499988ejd.218.2023.07.25.11.30.43
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 11:30:43 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so2236a12.0
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 11:30:43 -0700 (PDT)
X-Received: by 2002:a50:c311:0:b0:521:f642:7183 with SMTP id
 a17-20020a50c311000000b00521f6427183mr134357edb.1.1690309842907; Tue, 25 Jul
 2023 11:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
 <20230725110226.2.Id4a39804e01e4a06dae9b73fd2a5194c4c7ea453@changeid> <1e7225c2-3ac6-43d0-a1cc-e9a207d263d4@sirena.org.uk>
In-Reply-To: <1e7225c2-3ac6-43d0-a1cc-e9a207d263d4@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jul 2023 11:30:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uw99A6w5J_x7QoMH6Vv_zsFaSHNFGQPcJYMT2dbdi_+Q@mail.gmail.com>
Message-ID: <CAD=FV=Uw99A6w5J_x7QoMH6Vv_zsFaSHNFGQPcJYMT2dbdi_+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Add mem_ops to avoid PIO for
 badly sized reads
To:     Mark Brown <broonie@kernel.org>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
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

On Tue, Jul 25, 2023 at 11:24=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Tue, Jul 25, 2023 at 11:02:27AM -0700, Douglas Anderson wrote:
> > In the patch ("spi: spi-qcom-qspi: Fallback to PIO for xfers that
> > aren't multiples of 4 bytes") we detect reads that we can't handle
> > properly and fallback to PIO mode. While that's correct behavior, we
> > can do better by adding "spi_controller_mem_ops" for our
> > controller. Once we do this then the caller will give us a transfer
> > that's a multiple of 4-bytes so we can DMA.
>
> This is more of an optimisation for the case where we're using flash -
> if someone has hung some other hardware off the controller (which seems
> reasonable enough if they don't need it for flash) then we'll not use
> the mem_ops.

Right. That's why I also have the first patch in the series too. The
first patch ensures correctness and the second patch makes things more
optimal for when we're using flash. Do you want me to re-submit the
patch with wording that makes this more obvious?

Note that it's pretty likely someone wouldn't use this SPI controller
for anything other than SPI flash. While it's theoretically possible,
the controller is intended for SPI flash (supports dual and quad SPI
modes) and is only half duplex.

-Doug
