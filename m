Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD36FC8EB
	for <lists+linux-spi@lfdr.de>; Tue,  9 May 2023 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjEIO0d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 May 2023 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbjEIO02 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 May 2023 10:26:28 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012543C1D
        for <linux-spi@vger.kernel.org>; Tue,  9 May 2023 07:26:14 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f392680773so10757011cf.0
        for <linux-spi@vger.kernel.org>; Tue, 09 May 2023 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683642373; x=1686234373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap1sxPFyCXYHlrPI9PqKEsUisI28MkyI1OG4pKfon1Y=;
        b=ZhrNogG7vc5h+0aTkiemp5tq4yOwBvHRRxAxFillFlD1qWK8b+B+2jXwwfGlzF14p4
         IBzjcbBeObUJAL2iRpm0I110rtYtMRsuqmcNQIqGwAbmhU24uBapB79EctlPFIkPGki2
         1xKxQTNSIKjUtFoJc+QpeqfHCEET57MxxZv4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683642373; x=1686234373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ap1sxPFyCXYHlrPI9PqKEsUisI28MkyI1OG4pKfon1Y=;
        b=eX+XdswrawUeLwGNmd+pPwfL6x6RslVTR8RPaccizuQq8lTgSLvzGYygn9gIUBut1E
         +kTPYSQKvudR/3vdaV+hwlb2l3tZY/EcXwheB5RbZATKIS0VmMrvET2Hu8aeaO3X+r9D
         UO0GDHX52d0+2FuyDTRyHBbdY/YAb6khd4YIm3anVI3nJetqvnNQstzKHP8aYGnlFiZC
         wCHq37HQEcJuwq4tyn+B8qksyObr3GdVmYj2tYlGHyvpilLT/g56OsQnMga6wgLm9c3S
         hRyWgetl9NBUejFOKCT9+N12l3UFq42VYBqNYactSkf+o9SdgPJDsvQEqO8CAhGoPhRV
         +d/A==
X-Gm-Message-State: AC+VfDw30XBXFFSVG3qfGFpep7uqFel1s7GJpP4+YgmsRsi+XsPyH2Hq
        8XPY1+ZKnk/BPIRqJfYRbvkfXwDqtS7WmQSdVak=
X-Google-Smtp-Source: ACHHUZ4asGIWUsAOy9fSODE0g35wBFmXaCuShYDegYE7PKUQZ6vCmyyXj0vOJKx3V0yQU0nez4ugXA==
X-Received: by 2002:ac8:7dcc:0:b0:3f3:9680:c520 with SMTP id c12-20020ac87dcc000000b003f39680c520mr4208578qte.4.1683642373252;
        Tue, 09 May 2023 07:26:13 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id f18-20020ac80152000000b003e3914c6839sm539768qtg.43.2023.05.09.07.26.12
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 07:26:12 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-3f38824a025so199181cf.0
        for <linux-spi@vger.kernel.org>; Tue, 09 May 2023 07:26:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1890:b0:3ef:330c:8f9e with SMTP id
 v16-20020a05622a189000b003ef330c8f9emr396501qtc.10.1683642371893; Tue, 09 May
 2023 07:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <1683626496-9685-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1683626496-9685-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 May 2023 07:25:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UNvsSP=ELt557e5MQ_vfeFgSYahNcR8Pykw+Kxxnd97g@mail.gmail.com>
Message-ID: <CAD=FV=UNvsSP=ELt557e5MQ_vfeFgSYahNcR8Pykw+Kxxnd97g@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Select FIFO mode for chip select
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
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

On Tue, May 9, 2023 at 3:01=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Spi geni driver switches between FIFO and DMA modes based on xfer length.
> FIFO mode relies on M_CMD_DONE_EN interrupt for completion while DMA mode
> relies on XX_DMA_DONE.
> During dynamic switching, if FIFO mode is chosen, FIFO related interrupts
> are enabled and DMA related interrupts are disabled. And viceversa.
> Chip select shares M_CMD_DONE_EN interrupt with FIFO to check completion.
> Now, if a chip select operation is preceded by a DMA xfer, M_CMD_DONE_EN
> interrupt would have been disabled and hence it will never receive one
> resulting in timeout.
>
> For chip select, in addition to setting the xfer mode to FIFO,
> select_mode() to FIFO so that required interrupts are enabled.
>
> Fixes: e5f0dfa78ac7 ("spi: spi-geni-qcom: Add support for SE DMA mode")
> Suggested-by: Praveen Talari <quic_ptalari@quicinc.com>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
