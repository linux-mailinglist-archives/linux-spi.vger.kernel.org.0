Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD777706AEB
	for <lists+linux-spi@lfdr.de>; Wed, 17 May 2023 16:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjEQOSl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 May 2023 10:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjEQOSk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 May 2023 10:18:40 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A264849C7
        for <linux-spi@vger.kernel.org>; Wed, 17 May 2023 07:18:36 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-61b58b6e864so6510846d6.3
        for <linux-spi@vger.kernel.org>; Wed, 17 May 2023 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684333114; x=1686925114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeihledOH06fF9rXlghvkbkJKeeeuSIzbFVA64CPmJo=;
        b=Y3QZveStY9N27WRapKiuPW8I1WUrIQEvBlpgZq/JyAN+wyvZ54r7yhEang6CoApTmd
         aO1Sk+eC0FkloBa7C+o+L8nS3olCx/VTU1U9RN5NE8Zc8LTVT098W9gA+kG3sXKEkYZb
         S8lGoaiD4vjz2+vqlRYaIN8cwq84As0ujCfIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333114; x=1686925114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeihledOH06fF9rXlghvkbkJKeeeuSIzbFVA64CPmJo=;
        b=UI7EOdn443/FeFB81D2L9bBZuhnMcELEuh5XzzVriWk5m2Trg6OuS1C6ZhlQNBy/db
         Q990U39OSMHsCmmm9jvtOz7R8KGN0RFf3U1aVwm3czBnnMiLE/F8Q/n6lq3z9d0HTr0W
         mn6Fb2PgyaFNoJkaLd2X2Pz3q+KCnQsqp61XKSyCm+tkYb+lS/jwvkmpi5unTgi6VMZw
         xIPvxCqL3Zol2nyMPKRRHtBoUGA3Gktwj1/+bClyxW7qB203hqR/6Bch6Da63fO2m9Xc
         ONnUThtstq19A2L2kiHDJxYb1zHcJ9UTnsANUQVzgpah42k50QO4rQ1BQQgEgEh1+eDr
         snpw==
X-Gm-Message-State: AC+VfDx4IUwqGLLOtPXM/hNQYQWmP0b6xuEfMXrZCQ/i9xf8j/6HrcJD
        4IFsaoZNK7RYeUDrQw73bStFJ5m7+rzj5qzKs7g=
X-Google-Smtp-Source: ACHHUZ6SUnIM4GxV0dHfxyP7vTp5m95A/HTkJTN+j8r2tZ/+ckdUgMqB84YAo+0ccu84hAswdi4qeA==
X-Received: by 2002:ad4:5b8f:0:b0:623:66d3:e538 with SMTP id 15-20020ad45b8f000000b0062366d3e538mr15890108qvp.29.1684333114034;
        Wed, 17 May 2023 07:18:34 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id c23-20020a05620a11b700b007594229600csm635959qkk.81.2023.05.17.07.18.30
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:18:31 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-3f396606ab0so187091cf.0
        for <linux-spi@vger.kernel.org>; Wed, 17 May 2023 07:18:30 -0700 (PDT)
X-Received: by 2002:a05:622a:1892:b0:3ef:a55:7f39 with SMTP id
 v18-20020a05622a189200b003ef0a557f39mr358230qtc.12.1684333109945; Wed, 17 May
 2023 07:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com> <1684325894-30252-2-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1684325894-30252-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 May 2023 07:18:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xbx9h3B1u5NcK7XeEKWC30pn=AWYToqYbAs+oNrV+7Ww@mail.gmail.com>
Message-ID: <CAD=FV=Xbx9h3B1u5NcK7XeEKWC30pn=AWYToqYbAs+oNrV+7Ww@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: qcom: geni-se: Add interfaces
 geni_se_tx_init_dma() and geni_se_rx_init_dma()
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

On Wed, May 17, 2023 at 5:18=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> The geni_se_xx_dma_prep() interfaces necessarily do DMA mapping before
> initiating DMA transfers. This is not suitable for spi where framework
> is expected to handle map/unmap.
>
> Expose new interfaces geni_se_xx_init_dma() which do only DMA transfer.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v1 -> v2:
> - interfaces to take dma address as argument instead of its pointer
> ---
>  drivers/soc/qcom/qcom-geni-se.c  | 67 +++++++++++++++++++++++++++++-----=
------
>  include/linux/soc/qcom/geni-se.h |  4 +++
>  2 files changed, 53 insertions(+), 18 deletions(-)

Mark and Bjorn will have to coordinate how they want to land this,
since normally patch #1 would go through the Qualcomm tree and patch
#2 through the SPI tree. In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
