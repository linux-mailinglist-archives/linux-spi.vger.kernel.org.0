Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D216E9A92
	for <lists+linux-spi@lfdr.de>; Thu, 20 Apr 2023 19:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjDTRVA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Apr 2023 13:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjDTRU7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Apr 2023 13:20:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A73F3580
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 10:20:54 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id j15so2675049ybl.10
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682011253; x=1684603253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASlcFMe+UBtl/yEkw/ihBI+w8rG6+336g8ZGmASVmQA=;
        b=LhESfJk7yZ83e23Lvbrp0jhDyz2vtI5OJhKxXpg3QawcdfBTm2Dsru0A6uZSNuAulC
         4Zcn5nWdO6TxN7KnxrMAIeQRlN4EThenYxHdvBK/mCsfF3gxyJw67nUl/dygpBSXpKt3
         Gr+kJkt8me1yBQGUWkXe045msiihJba+ez4sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011253; x=1684603253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASlcFMe+UBtl/yEkw/ihBI+w8rG6+336g8ZGmASVmQA=;
        b=Gsz9b8AQtjkDD8XKhlEiz1KvJGBCm+ZSnAF4lQP8zxWWerAgDQ+rJTw0YYsjvV7Nq1
         brcnIaZ4fZ0xlt9R2XMuDEBZjDowCvtP/Nm9C5qZokb6q21VA4DGm9j58tSvYjV/Y0pk
         TvDul09xcchIctMLFKsPd1Y8/oTaykW6luJMwHVLjePM8NA4Itlfc7tGs6Zu1WrU7ADZ
         +vZdb070L6dqSDo+IE8Acx9jqi5lF89jDTnyTdfumR4/gT6UUqCi23D41xPqEX3TBzr0
         suX00acogn409SHpWuEkz17znK8XgHc6/xNz/kA0nb9ScgX2HZn/7qpVZV+3jm7MxSpZ
         p5ow==
X-Gm-Message-State: AAQBX9dqKnOyqXDk6FndujWuV1VCMiNXShKVSzk4h/j7dcNrf3BpnU31
        KX4puhXQoWsywHdpq5NsepWx9JqB9JlVDqyWvKk=
X-Google-Smtp-Source: AKy350aagrWH62woOynYVEt72rclMNcsJYbISsBUAJSCJaYcFnN3LFHsPKyk36ME434WVE3GF6Z1fQ==
X-Received: by 2002:a25:abcb:0:b0:b8f:4a52:15db with SMTP id v69-20020a25abcb000000b00b8f4a5215dbmr2164153ybi.60.1682011253450;
        Thu, 20 Apr 2023 10:20:53 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id o132-20020a25d78a000000b00b8f2d726471sm417597ybg.3.2023.04.20.10.20.51
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:20:51 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id m14so2767894ybk.4
        for <linux-spi@vger.kernel.org>; Thu, 20 Apr 2023 10:20:51 -0700 (PDT)
X-Received: by 2002:a25:c807:0:b0:b95:2315:a2c4 with SMTP id
 y7-20020a25c807000000b00b952315a2c4mr1169128ybf.0.1682011250803; Thu, 20 Apr
 2023 10:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com> <1681996394-13099-4-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1681996394-13099-4-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Apr 2023 10:20:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XxbLsaxJc7YKH+beaPFTxq7x_jS_oQQ+KHXXQ=LgX3ag@mail.gmail.com>
Message-ID: <CAD=FV=XxbLsaxJc7YKH+beaPFTxq7x_jS_oQQ+KHXXQ=LgX3ag@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
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
> v2 -> v3:
> - modified commit message
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
