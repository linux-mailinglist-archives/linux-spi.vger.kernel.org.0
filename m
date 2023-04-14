Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BFF6E2755
	for <lists+linux-spi@lfdr.de>; Fri, 14 Apr 2023 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjDNPt3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Apr 2023 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjDNPt2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Apr 2023 11:49:28 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349E7B768
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 08:49:01 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54fa9da5e5bso151983477b3.1
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681487339; x=1684079339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmFm31Zgsnr/JAh9QTSGsVfx+ibrGoUUFemyLUbPtb4=;
        b=Rlt5TLsrmDQaF6QrL29STaJ8widYErvoHVHGL306lK6j+b2aQWb/UWMl/2yI0RqrwW
         5KgUckmm4yPBuzWXEb7czSz+ISdpwkLm78usJs1W8tGJg0ggbhFepN/tR2qN06v8kgC6
         /cHOuBdopwHD81KWmxN73TGt2jL9mHMADSvLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681487339; x=1684079339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmFm31Zgsnr/JAh9QTSGsVfx+ibrGoUUFemyLUbPtb4=;
        b=Vq+ak8HS8MABLdkMonb1o99lvE2tgjnOf4R97CEbIIyF6dWEfdYmm8NovFsmQlU+/w
         +lC77K8jur1r//FOl8l5DYuqp7bUSLsdpQ2PcmRVvnzSJIlzFa4GTl3nlm6urAZGbVpC
         IfOLSXPLNlzRuslS29etMBKGvIjG+kkusUMfbfkEXnUITpeGAeRhlaZgvJasPsIyofKh
         suTvGGDdCxgnvPrb/Md5MAABFRi5QR1XQhzsAKXsXBox/n3Ah0mZL6I4YCxo2q9+RRsr
         cP5k9sVy8FHlEMN0zgXd4kJ83ePSsgZrDwGyHj00lcAzOtZwjPHOtpJ105U3ysFEb313
         EX5Q==
X-Gm-Message-State: AAQBX9chCOBIPNOR4zJzzX3c0+XxaKn2zH9LJvFRbBA+rIX5G8Njjk62
        B4p67PYgwFGxwDfyL98tElhi5forBPdeFVsETkI=
X-Google-Smtp-Source: AKy350bVV64B2DXzeOhB+fYdhTc//P/9dObC2OkcOLuAQG1A8+38LHruQTKKGvOT90SynNJpWp8Ytw==
X-Received: by 2002:a81:88c3:0:b0:546:4626:bfc5 with SMTP id y186-20020a8188c3000000b005464626bfc5mr7663683ywf.31.1681487339086;
        Fri, 14 Apr 2023 08:48:59 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id q76-20020a81994f000000b0054f56baf3f2sm1246668ywg.122.2023.04.14.08.48.58
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 08:48:58 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-54ee0b73e08so354798837b3.0
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 08:48:58 -0700 (PDT)
X-Received: by 2002:a81:4106:0:b0:54f:b4e6:ae4e with SMTP id
 o6-20020a814106000000b0054fb4e6ae4emr4048259ywa.7.1681487337813; Fri, 14 Apr
 2023 08:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Apr 2023 08:48:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XU_SWzJTmtqoZZ1eTDu3WcWQOAFbkBS=Juaz9_DivZSg@mail.gmail.com>
Message-ID: <CAD=FV=XU_SWzJTmtqoZZ1eTDu3WcWQOAFbkBS=Juaz9_DivZSg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] spi: Add DMA mode support to spi-qcom-qspi
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

On Fri, Apr 14, 2023 at 7:06=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> There are large number of QSPI irqs that fire during boot/init and later
> on every suspend/resume.
> This could be made faster by doing DMA instead of PIO.
> Below is comparison for number of interrupts raised in 2 acenarios...

s/acenarios/scenarios

> Boot up and stabilise
> Suspend/Resume
>
> Sequence   PIO    DMA
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Boot-up    69088  19284
> S/R        5066   3430
>
> Though we have not made measurements for speed, power we expect
> the performance to be better with DMA mode and no regressions were
> encountered in testing.

Measuring the speed isn't really very hard, so I gave it a shot.

I used a truly terrible python script to do this on a Chromebook:

--

import os
import time

os.system("""
stop ui
stop powerd

cd /sys/devices/system/cpu/cpufreq
for policy in policy*; do
  cat ${policy}/cpuinfo_max_freq > ${policy}/scaling_min_freq
done
""")

all_times =3D []
for i in range(1000):
  start =3D time.time()
  os.system("flashrom -p host -r /tmp/foo.bin")
  end =3D time.time()

  all_times.append(end - start)
  print("Iteration %d, min=3D%.2f, max=3D%.2f, avg=3D%.2f" % (
      i, min(all_times), max(all_times), sum(all_times) / len(all_times)))

--

The good news is that after applying your patches the loop runs _much_ fast=
er.

The bad news is that it runs much faster because it very quickly fails
and errors out. flashrom just keeps reporting:

Opened /dev/mtd0 successfully
Found Programmer flash chip "Opaque flash chip" (8192 kB,
Programmer-specific) on host.
Reading flash... Cannot read 0x001000 bytes at 0x000000: Connection timed o=
ut
read_flash: failed to read (00000000..0x7fffff).
Read operation failed!
FAILED.
FAILED

I went back and tried v1, v2, and v3 and all three versions fail.
