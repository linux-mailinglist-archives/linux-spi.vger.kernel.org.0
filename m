Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B436EE475
	for <lists+linux-spi@lfdr.de>; Tue, 25 Apr 2023 17:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjDYPH1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Apr 2023 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbjDYPHW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Apr 2023 11:07:22 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530E9CC17
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 08:07:21 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-32a7770f7baso15214095ab.2
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682435240; x=1685027240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpYAGainFDoBezMAz2LIC0vmyd867yd+Zieo+NHOeqA=;
        b=gthEI2ttMvW0cxQg5Il2ZqJitHKt9MbBKB7ONvoq6jSgrGsjkmfIx8Ta6ORB8VgLD8
         KqP31IxAKsdhS1ltIyuJZLaHYIxhz+nDGCQAFgy/LTr8kBJGiqUudRCxVC1+ft/wYKDp
         aMejtIB+NGInfIdG8T2bUl8GtFjppw3eFEu0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682435240; x=1685027240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpYAGainFDoBezMAz2LIC0vmyd867yd+Zieo+NHOeqA=;
        b=QBCsYlAQ34/4frLmsLb7AxbMhDIDHb2b79O0yTI2ViwUwO2BZvrDRZSg1DAJZUZYYV
         D+IZIWM8hryieLXHpdoIKsLBTwb4LVsgoHv2tXaGqwR33NVXpGkeJ/9tGEfWU321aT21
         l3WiwItjtkQabts3C8DVxkRM+yK4i3vjr2qzxbZ1EPzklDxe1NkWBH5zcLvXxmNvpPDO
         XinvVU8c9BtRNVQoCxwVRc+/4mMawW7+SnZoPRZbKY4lETmsrK5cpB6ML2cK1fk0HzNU
         Z0Zc33G2uxUwY8y9jtcSiTkKDTWPx5EItNMdgsAf3yEzIn8rPEEkJu8wZub5cwUQoGc5
         P/gg==
X-Gm-Message-State: AAQBX9dSk0JGDPe1zZ8OMjTJzO8xqHhNlnpODecUzDItst8QgRdbPohL
        a/bKIYP6gw5e1dExpv/zEAaHGpNHNWzc3kBX3hg=
X-Google-Smtp-Source: AKy350Z8COwOBBg2Rb66IxnfuF+WHiB9QOyGlG6DiQ/QetNG6AHW0yukRkKd0ytPetpqKPKYrYgKAA==
X-Received: by 2002:a92:da84:0:b0:32b:7258:710a with SMTP id u4-20020a92da84000000b0032b7258710amr7736017iln.26.1682435239860;
        Tue, 25 Apr 2023 08:07:19 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id y9-20020a05663824c900b0040f9e66095fsm3990879jat.134.2023.04.25.08.07.18
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 08:07:18 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-329577952c5so88455ab.1
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 08:07:18 -0700 (PDT)
X-Received: by 2002:a05:6e02:1d96:b0:32a:dc6a:3b97 with SMTP id
 h22-20020a056e021d9600b0032adc6a3b97mr320927ila.0.1682435237664; Tue, 25 Apr
 2023 08:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Apr 2023 08:07:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UKpe2rixisrp213w57dF6zgFK909v1-inTNXiu=FVLjA@mail.gmail.com>
Message-ID: <CAD=FV=UKpe2rixisrp213w57dF6zgFK909v1-inTNXiu=FVLjA@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Apr 25, 2023 at 1:42=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> The CS_TOGGLE bit when set is supposed to instruct FW to
> toggle CS line between words. The driver with intent of
> disabling this behaviour has been unsetting BIT(0). This has
> not caused any trouble so far because the original BIT(1)
> is untouched and BIT(0) likely wasn't being used.
>
> Correct this to prevent a potential future bug.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index ba7be50..8a7d1c2 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -35,7 +35,7 @@
>  #define CS_DEMUX_OUTPUT_SEL    GENMASK(3, 0)
>
>  #define SE_SPI_TRANS_CFG       0x25c
> -#define CS_TOGGLE              BIT(0)
> +#define CS_TOGGLE              BIT(1)

Looks right to me from the datasheet I have access to. It's definitely
specified in an odd way on the datasheet, which lists bit 1 as this,
bit 2 and 3 as reserved, but bit 0 is absent. ...but seems like this
is really supposed to be 1.

I guess this never mattered because all we ever did was clear the bit
at init time and it must have already been cleared? ...and, of course,
on many Chromebooks we moved to just using a GPIO...

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for
GENI based QUP")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
