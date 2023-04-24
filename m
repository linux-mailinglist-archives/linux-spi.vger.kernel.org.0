Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD926ED0B4
	for <lists+linux-spi@lfdr.de>; Mon, 24 Apr 2023 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjDXOwP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Apr 2023 10:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjDXOwC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Apr 2023 10:52:02 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B319754
        for <linux-spi@vger.kernel.org>; Mon, 24 Apr 2023 07:51:37 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-763da065494so13444639f.0
        for <linux-spi@vger.kernel.org>; Mon, 24 Apr 2023 07:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682347889; x=1684939889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LGZkqwX4EU9DdgtbcEz0RVWmR0Z/MRzMUh+6ISg2Gg=;
        b=n3ljJaKJRitmjCYQxbozrVEQ2h8cO788afAtV786H78ezFQkhBKN37GdEnGvl4yeaR
         D8c3j+NG9CWq73qfOIPQfl6JIZGSgc5VpAsnNJZR5n8gPkcaojcZewYZvVcyXVADwqbC
         rb5QjG5wnVya7obfv0whz/id8Hi9Yx0Dih9Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682347889; x=1684939889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LGZkqwX4EU9DdgtbcEz0RVWmR0Z/MRzMUh+6ISg2Gg=;
        b=e6wetkaUcLltkWoIGWsw0xsHlhX7RQ184q41SlSdUOW9SwrXJC8tEVOGgPMo+OLqW9
         XbNCQXiAR4M/qE/9ncHQ1heWBiCbJEE4Vb897zt7h7yDHaEizmeHWDA5Ty+1sFIZ1BUb
         oMBXHh8oDcVpEnt6FeyrEwlEK3/2JiHBW3h6HVxAwHpOD1omRXSCewX02uC8cRr5+D7P
         VrAaoPGge/ad9ac9ScrUKtkxNyV//4ZhtZ1K7YPQEbbZwe6rzKhO4AucxArTqsrCnkeg
         80Phjh4pcFEqX7B7o4PX3JnM/94r48020Jq7OI9CF0rc1Y3e2EA359plBPfzJIXIJp1I
         Mi8Q==
X-Gm-Message-State: AAQBX9fJSTmvOYTIAvoZKRp7YOmtaQffMv5iLrHaCxhdgJkiV7E88rK0
        eMzg0/CFnEDhF37PMH+QNr0JpvD66v/1qFkXQdI=
X-Google-Smtp-Source: AKy350ZvPvP3sYQ+C8xTuHNzCH7HYwxFBvZXvuiDrQAxpJSLpeHLC/VG1+hUjE8FsS3yRqCIxTl5yw==
X-Received: by 2002:a92:cc0a:0:b0:328:bfbd:1e7f with SMTP id s10-20020a92cc0a000000b00328bfbd1e7fmr5681799ilp.5.1682347889596;
        Mon, 24 Apr 2023 07:51:29 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id el1-20020a0566384d8100b00411b2414eb5sm1587400jab.94.2023.04.24.07.51.26
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 07:51:27 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-328cb023b1dso1052215ab.0
        for <linux-spi@vger.kernel.org>; Mon, 24 Apr 2023 07:51:26 -0700 (PDT)
X-Received: by 2002:a92:c24c:0:b0:32b:5cff:3e3b with SMTP id
 k12-20020a92c24c000000b0032b5cff3e3bmr455771ilo.9.1682347886370; Mon, 24 Apr
 2023 07:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <1682328761-17517-1-git-send-email-quic_vnivarth@quicinc.com> <1682328761-17517-6-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1682328761-17517-6-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Apr 2023 07:51:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XEsLeAzFDqcXjeGAxovSwzVENeF4km5wLkhjgpSOKR5g@mail.gmail.com>
Message-ID: <CAD=FV=XEsLeAzFDqcXjeGAxovSwzVENeF4km5wLkhjgpSOKR5g@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] spi: spi-qcom-qspi: Add DMA mode support
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
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Mon, Apr 24, 2023 at 2:32=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Current driver supports only PIO mode.
>
> HW supports DMA, so add DMA mode support to the driver
> for better performance for larger xfers.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v4 -> v5:
> - dropped xfer_mode
> - clear all interrupts in handle_err()
> - dont log ptr value
> - dropped some dev_err()
> - converted some dev_err() to dev_warn_once()
> - drop few redundant comments
> - can_dma() disabled if iommus not present in dev_node
> - other nits
>
> v3 -> v4:
> - corrected tabs spacing
> - dropped dma data descriptors
> - dropped INVALID from xfer_mode enum
> - qspi_buswidth_to_iomode() to return iomode without shifting
> - dropped non-functional change in qcom_qspi_set_speed()
> - drop redundant call to wmb()
> - fallback to pio if dma fails to setup
> - use dmam_pool_create() the devm version
> - thus drop dma_pool_destroy()
> - set dma_alignment field in probe()
> - other minor changes
>
> v2 -> v3:
> - dropped Reported-by tag
>
> v1 -> v2:
> - modified commit message
> - addressed kernel test robot error
> - correct placement of header file includes
> - added more comments
> - coding style related changes
> - renamed variables
> - used u32/u8 instead of uint32_t/8_t
> - removed unnecessary casting
> - retain same MSTR_CONFIG as PIO for DMA
> - unset fragment bit only for last cmd_desc of last xfer
> ---
>  drivers/spi/spi-qcom-qspi.c | 218 ++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 212 insertions(+), 6 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
