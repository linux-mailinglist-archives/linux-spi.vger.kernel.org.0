Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FA86E288D
	for <lists+linux-spi@lfdr.de>; Fri, 14 Apr 2023 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjDNQmU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Apr 2023 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDNQmT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Apr 2023 12:42:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE0399
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 09:42:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i20so23205824ybg.10
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681490536; x=1684082536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klmJSKu8yF5i4DA+2b2ZNZNl1VQBRXbMDryaSg05ypA=;
        b=CAY5YtsvhpQgGk0e8vJHY7zeHke/49Hf+xSdqY/qWSL5qAf06qNTqI7celLaeCAvvv
         EphJua1Vo1DN2SJ/E6spR3bVzhEiTeWuWeqtJS9gdQ0hGmVcBBVMI7r7yuRrL/zqExUT
         pGKH8nhhetJgV5EikUfNSYQru+d7mF/7bNyng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490536; x=1684082536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klmJSKu8yF5i4DA+2b2ZNZNl1VQBRXbMDryaSg05ypA=;
        b=e08XTA2kD0yaiyq20hx/mjXpbaRVkpgvvYo8gylyUfXfa7UXj+Y+6Se7r3YNjjn9QT
         kESrGlPY+/rCfarUnhJELpBf4METkp8sr5IZU2/VFMgZKAmS24FOyqA7beDRTLTVsWMR
         bMuGtTqdp8Xt5czJmgktZp6YyKM7/qZJiZ8U4SlHHPZmeOqr9RNLsiHnNHCaipBoGyqD
         A6AgtiFoMMaKgPA4h0MbVvEBTOLtvf7XuWhHyzFxNcszvQYCgMUoHWOectew9mh3uCEh
         hBZcw21rkbW3E9TfryETb8gRtgcJddRhAr7iy2O/LeAUwakZV53sRZcrdLkRlkONo2F5
         TG/Q==
X-Gm-Message-State: AAQBX9fVYlghRClOndZ93HrzUsb1EvUiSLxjhcRTRpcttefu72zaDN3J
        SlQ7g/vp0sXRowx/Ndk4zvXWwlWVyOrUKd1igrY=
X-Google-Smtp-Source: AKy350abvots6o5yJsEYh8wuFcdMp3tAZ9OgFWx0eNVFb+gvOjUtmHcd+3V1LX30n0UcBykA3PKcRg==
X-Received: by 2002:a05:6902:1542:b0:b8b:e7da:5abc with SMTP id r2-20020a056902154200b00b8be7da5abcmr6974616ybu.44.1681490535859;
        Fri, 14 Apr 2023 09:42:15 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 22-20020a810b16000000b0054fae5ed408sm1279012ywl.45.2023.04.14.09.42.13
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 09:42:13 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-54bfa5e698eso508810667b3.13
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 09:42:13 -0700 (PDT)
X-Received: by 2002:a81:b667:0:b0:54f:cc40:cf68 with SMTP id
 h39-20020a81b667000000b0054fcc40cf68mr3335826ywk.7.1681490532860; Fri, 14 Apr
 2023 09:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com> <CAD=FV=XU_SWzJTmtqoZZ1eTDu3WcWQOAFbkBS=Juaz9_DivZSg@mail.gmail.com>
In-Reply-To: <CAD=FV=XU_SWzJTmtqoZZ1eTDu3WcWQOAFbkBS=Juaz9_DivZSg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Apr 2023 09:42:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W8ML4A9Yp3o1PzO1xRSJ3Z+9g-SdMDwLTMqhmMw0q99g@mail.gmail.com>
Message-ID: <CAD=FV=W8ML4A9Yp3o1PzO1xRSJ3Z+9g-SdMDwLTMqhmMw0q99g@mail.gmail.com>
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

On Fri, Apr 14, 2023 at 8:48=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Apr 14, 2023 at 7:06=E2=80=AFAM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
> >
> > There are large number of QSPI irqs that fire during boot/init and late=
r
> > on every suspend/resume.
> > This could be made faster by doing DMA instead of PIO.
> > Below is comparison for number of interrupts raised in 2 acenarios...
>
> s/acenarios/scenarios
>
> > Boot up and stabilise
> > Suspend/Resume
> >
> > Sequence   PIO    DMA
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Boot-up    69088  19284
> > S/R        5066   3430
> >
> > Though we have not made measurements for speed, power we expect
> > the performance to be better with DMA mode and no regressions were
> > encountered in testing.
>
> Measuring the speed isn't really very hard, so I gave it a shot.
>
> I used a truly terrible python script to do this on a Chromebook:
>
> --
>
> import os
> import time
>
> os.system("""
> stop ui
> stop powerd
>
> cd /sys/devices/system/cpu/cpufreq
> for policy in policy*; do
>   cat ${policy}/cpuinfo_max_freq > ${policy}/scaling_min_freq
> done
> """)
>
> all_times =3D []
> for i in range(1000):
>   start =3D time.time()
>   os.system("flashrom -p host -r /tmp/foo.bin")
>   end =3D time.time()
>
>   all_times.append(end - start)
>   print("Iteration %d, min=3D%.2f, max=3D%.2f, avg=3D%.2f" % (
>       i, min(all_times), max(all_times), sum(all_times) / len(all_times))=
)
>
> --
>
> The good news is that after applying your patches the loop runs _much_ fa=
ster.
>
> The bad news is that it runs much faster because it very quickly fails
> and errors out. flashrom just keeps reporting:
>
> Opened /dev/mtd0 successfully
> Found Programmer flash chip "Opaque flash chip" (8192 kB,
> Programmer-specific) on host.
> Reading flash... Cannot read 0x001000 bytes at 0x000000: Connection timed=
 out
> read_flash: failed to read (00000000..0x7fffff).
> Read operation failed!
> FAILED.
> FAILED
>
> I went back and tried v1, v2, and v3 and all three versions fail.

Ah, I see what's likely the problem. Your patch series only adds the
"iommus" for sc7280 but I'm testing on sc7180. That means:

1. You need to add the iommus to _all_ the boards that have qspi. That
means sc7280, sc7180, and sdm845.

2. Ideally the code should still be made to work (it should fall back
to PIO mode) if DMA isn't properly enabled. That would keep old device
trees working, which we're supposed to do.

-Doug
