Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D14E5F07B7
	for <lists+linux-spi@lfdr.de>; Fri, 30 Sep 2022 11:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiI3Jex (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Sep 2022 05:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiI3Jee (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Sep 2022 05:34:34 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2446E2BAE
        for <linux-spi@vger.kernel.org>; Fri, 30 Sep 2022 02:33:11 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id cj27so2304733qtb.7
        for <linux-spi@vger.kernel.org>; Fri, 30 Sep 2022 02:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PYm5bFW31avn3HIgXHUxpQSepzVm19867uFbmSS4+2s=;
        b=eNPo/t8Edi24zCOB5Psf6qrvql+Cw3DWqflYBamM6add11h8y+fxdia06mad3d/n4T
         dkD6bAV2litAQvM4NMl7XD6ros5p0Z578kO2FVyURJq2rjBK3grU96fjBdfJWH7WMn/e
         O7KF+Wtw+WP+uRfHl/0YOesS6hmjCZSm6HT6Z8N/CadebXng0iotGGeX+ES4T/vXX1Jj
         cxs5NfaqKRRya/JNljjzEdcJ4SOPCONBUzUKs1BE9g1rdibtlwXpGanFTK7eTLXVSUag
         XYcd6f8Qy6C5+IrEXLOWECEkEsBWl5hBngHSuUUK8yqFSmgMlmIwaVEkRSH+qM4O4j0q
         QoFA==
X-Gm-Message-State: ACrzQf1icOSuBUtfrAs8NxHj8BVHXvF2A5gASTkx6ucHK4n7p0zrufS1
        fL5rtGQZMU5QyrcDnbeSCyNAwCtbm0Kdfw==
X-Google-Smtp-Source: AMsMyM5qsaVyMs8HvZJNSCLG/QHzsOAM2fwWv5plcuSvyenYKeAl8BVCbJtycGKP+Aym9LsN90B9nw==
X-Received: by 2002:ac8:584c:0:b0:35c:ceee:197a with SMTP id h12-20020ac8584c000000b0035cceee197amr5872914qth.662.1664530390516;
        Fri, 30 Sep 2022 02:33:10 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id cb24-20020a05622a1f9800b0034355a352d1sm1410422qtb.92.2022.09.30.02.33.10
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:33:10 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-356abb37122so5732187b3.6
        for <linux-spi@vger.kernel.org>; Fri, 30 Sep 2022 02:33:10 -0700 (PDT)
X-Received: by 2002:a81:848c:0:b0:356:e173:2c7a with SMTP id
 u134-20020a81848c000000b00356e1732c7amr308824ywf.502.1664530389731; Fri, 30
 Sep 2022 02:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220929132041.484110-1-yangyingliang@huawei.com>
In-Reply-To: <20220929132041.484110-1-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 30 Sep 2022 11:32:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1JMs3uAgJ6CS0sHxD69mp1Atx+YtsYuhy0ZUqsTHRQw@mail.gmail.com>
Message-ID: <CAMuHMdX1JMs3uAgJ6CS0sHxD69mp1Atx+YtsYuhy0ZUqsTHRQw@mail.gmail.com>
Subject: Re: [PATCH -next] spi: introduce new helpers with using modern naming
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Yang,

On Thu, Sep 29, 2022 at 3:04 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> For using modern names host/target to instead of all the legacy names,
> I think it takes 3 steps:
>   - step1: introduce new helpers with modern naming.
>   - step2: switch to use these new helpers in all drivers.
>   - step3: remove all legacy helpers and update all legacy names.
>
> This patch is for step1, it introduces new helpers with host/target
> naming for drivers using.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for your patch!

> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -356,6 +356,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>   * @max_speed_hz: Highest supported transfer speed
>   * @flags: other constraints relevant to this driver
>   * @slave: indicates that this is an SPI slave controller
> + * @target: indicates that this is an SPI target controller
>   * @devm_allocated: whether the allocation of this struct is devres-managed
>   * @max_transfer_size: function that returns the max transfer size for
>   *     a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
> @@ -438,6 +439,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>   * @mem_caps: controller capabilities for the handling of memory operations.
>   * @unprepare_message: undo any work done by prepare_message().
>   * @slave_abort: abort the ongoing transfer request on an SPI slave controller
> + * @target_abort: abort the ongoing transfer request on an SPI target controller
>   * @cs_gpiods: Array of GPIO descs to use as chip select lines; one per CS
>   *     number. Any individual value may be NULL for CS lines that
>   *     are not GPIOs (driven by the SPI controller itself).
> @@ -535,6 +537,8 @@ struct spi_controller {
>
>         /* Flag indicating this is an SPI slave controller */
>         bool                    slave;
> +       /* Flag indicating this is an SPI target controller */
> +       bool                    target;

To avoid subtle breakage when accessing these fields directly,
this should be a union:

    union {
            bool slave;
            bool target;
    };

>
>         /*
>          * on some hardware transfer / message size may be constrained

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
