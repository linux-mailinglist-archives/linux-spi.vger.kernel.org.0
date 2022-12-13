Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84664BD6F
	for <lists+linux-spi@lfdr.de>; Tue, 13 Dec 2022 20:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiLMTlt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Dec 2022 14:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiLMTls (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Dec 2022 14:41:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE68222A6
        for <linux-spi@vger.kernel.org>; Tue, 13 Dec 2022 11:41:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s5so19330601edc.12
        for <linux-spi@vger.kernel.org>; Tue, 13 Dec 2022 11:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RetF3ngpYBh7s+6+XvCxexcjP9OVby+dlAZpg2RiTJc=;
        b=YTDOji7eAwfiy0T0P67y9PKtfkZszKaZT9WVox0oDPg6GO3lBviChe2pj5KWoJYDBn
         j1/x48DOx/Ba7wL0qUZXz/3B71iPKF9yiLpi3saTxMOrYbywo6lmnOe4nH+sEZZKh4qj
         GN8BUu8isRTNF7dHvrxcXgHDqANTX9F489dJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RetF3ngpYBh7s+6+XvCxexcjP9OVby+dlAZpg2RiTJc=;
        b=OHUIFW+d4Za6jaRdbr5WTXo9yo82kKJ7cfGeqPXo2j+O17vL3Um1YmBvlzz9SbE1hU
         qs0cfsNBVcEAcQRHHQTlAwY4LzdiD7PleL/1qixNcdZ4cFEe3e47JA5bO7TJZgK5qb0y
         /jDIyU0hWHsmauE6lU2b4uRS2KkHhr0ITtXJG5z7aPA25fXBNjCUY21fK+4I8IuyG4BE
         E6shFiZ1vnqTCSmVnYFtY6pM1Pw3ePJVBSs0P2v+Ya6+wFHRzI3YLq+AemlrL5g6U1T5
         4m9swwLchpCBKWCpfngdFOcXrXXL3864ex7LWQFgNwGm5fZ/+uSvrCozzwoGyQKmOFPS
         jdsA==
X-Gm-Message-State: ANoB5pm6VjNQrOowwHbOXMnQXZoJL8eDhFObnodCLoCzlm6T6W31BcMg
        Uj8gwLQSv2QMrsYFOSKHYVXfHdAWVcUMkWySK6E=
X-Google-Smtp-Source: AA0mqf4tR2+ElHBB20SBOGjl437ptkugqlAohqaWgZ9UicSvjWeKaBaBtSVEaSuj3iBU0Fx3t6Wj4A==
X-Received: by 2002:a05:6402:e97:b0:461:6219:4b16 with SMTP id h23-20020a0564020e9700b0046162194b16mr6416398eda.33.1670960504805;
        Tue, 13 Dec 2022 11:41:44 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id s21-20020aa7cb15000000b0047021294426sm1471398edt.90.2022.12.13.11.41.44
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 11:41:44 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id h11so16844514wrw.13
        for <linux-spi@vger.kernel.org>; Tue, 13 Dec 2022 11:41:44 -0800 (PST)
X-Received: by 2002:a5d:4943:0:b0:242:3ca3:b7bd with SMTP id
 r3-20020a5d4943000000b002423ca3b7bdmr18561534wrs.583.1670960503788; Tue, 13
 Dec 2022 11:41:43 -0800 (PST)
MIME-Version: 1.0
References: <1670509544-15977-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1670509544-15977-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 13 Dec 2022 11:41:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VTkpZ84RzaKYmb15AG+hiVUM0mk0ieGmDHWYVLQgsrnA@mail.gmail.com>
Message-ID: <CAD=FV=VTkpZ84RzaKYmb15AG+hiVUM0mk0ieGmDHWYVLQgsrnA@mail.gmail.com>
Subject: Re: [V4] spi: spi-geni-qcom: Add support for SE DMA mode
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, vkoul@kernel.org,
        quic_arandive@quicinc.com, quic_ramkri@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Dec 8, 2022 at 6:25 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> SE DMA mode can be used for larger transfers and FIFO mode
> for smaller transfers.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v4 -> v3:
> - remove cur_m_cmd field
> - add dma_addr fields to spi_geni_master
> - dont use dma_addr from xfer, use above
> - dev_warn instead of dev_err in handle_timeout
> - set xfer_mode to FIFO in set_cs
>
> v2 -> v3:
> - indentation change
> - readability change
>
> v1 -> v2:
> - replace writel_relaxed with writel
> - corrected order of performing FSM reset and dma_unprep
> - added more comments in geni_can_dma
> - removed redundant change in spi_geni_init(DMA as default xfer_mode)
> - removed redundant initialisations in setup_se_xfer
> - removed redundant null checks in setup_se_xfer
> - added dma_tx_prep failure handling(rx un_map) in setup_se_xfer
> - move handing return of setip_se_xfer to transfer_one
> - apply irq error handling for DMA mode too in geni_spi_isr
> ---
>  drivers/spi/spi-geni-qcom.c | 211 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 165 insertions(+), 46 deletions(-)

This looks reasonable to me now, thanks.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

A note to Mark since he was also concerned about the fact that we
aren't using the SPI framework to manage the DMA [1] and Vijay didn't
respond directly to him on this issue. The issue here has to do with
the fact that the driver wanted to use geni_se_tx_dma_prep() /
geni_se_rx_dma_prep() and that function overlaps with what the SPI
framework does. Eventually it seems like geni_se_tx_dma_prep() /
geni_se_rx_dma_prep() should be reworked so as not to overlap, but I
agree with Vijay that it can be future work. I'm at least happy now
that the driver is using its own storage for the dma_addr_t variables
now.Obviously, though, the final say is yours. :-)

[1] https://lore.kernel.org/r/Y4kxVP97C66oi0Bi@sirena.org.uk
