Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80B02EBA5E
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 08:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbhAFHPB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Jan 2021 02:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbhAFHPA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Jan 2021 02:15:00 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A17C06135E
        for <linux-spi@vger.kernel.org>; Tue,  5 Jan 2021 23:13:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id w1so3677111ejf.11
        for <linux-spi@vger.kernel.org>; Tue, 05 Jan 2021 23:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rT4Dc8swlK31/4OXAMfRD8Dy9QIvv8YpGOiKzBJjVS0=;
        b=kW/FIQ9UMgiQ4U+TkdADVoEYk5gZPV3uhWmFEaBISm60k6X7HKncaLJMcm7Te12ixW
         DmozTsbCxinSR4kw60jnPkTRpJcI2yoqWEX3PsYD1Gobe1MgtRCRsAYMvDuT6a2OmRZe
         JA5aIaNzC2Qz1QI2pjKK7hj+qAEnukuAv07b9W7M8pBoGmUjZmXbHaL5522RR1fvjBcC
         aUOByaCkN/CFtegf2L0lfAhcsuMiZ+e/Z0kGD0hJrq1CBcozlTfyZi2pX2qyg5tLtp5K
         qfoj7U94CqKy1yfDXJToNFtVkn5zEBI7/9XBDJd/bwiyCn1gMrTQ4lsyGmJDatnR3P5D
         m6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rT4Dc8swlK31/4OXAMfRD8Dy9QIvv8YpGOiKzBJjVS0=;
        b=E2qK2elZZzEiCvxboxvYfu1saLJ/2+JGJbpxPm7hNkNshb1FnSONX+J8UdUd9NQ38P
         uZk8wCgoejGs6DRhsz93gM2Dhske2nh3FO3O07vN98eYkw7DHsOmQOU/oLWx+a0i8pLr
         Dp0zJFl2hcaZQh9ylwwFSFESzuDEnv8JKSMbTl/n3ZcSL1eaHiLlUUEXhoytscp/kaWJ
         7NkebIYkOJsw8qyUxrKGK12o9wNGHiGPvBuJqH+ow6hNGPovoigpN5Rz6PtCndwUEetp
         BtatYQdmX4/SzKoUJKjC2smE2ZrrO/fSRUd39YN6WsWw6q5tgoPhqsk+qVy5C2xNQLkA
         fvIQ==
X-Gm-Message-State: AOAM531IBMVKdhRddPtaZHU7qAU3m02h6R3J/O8NPIDzLoszScHEtXlc
        GvjSFxixCSrC19a2b/nzjbVj0rUqbB+3Px+W/tdNSQ==
X-Google-Smtp-Source: ABdhPJz7NZsjb4UgOGiErAdqwk42sh/yXenAjVlhxnzAVaOFNfM5U6i5Q3E7GI/VvU/IA448wOjGCY/95IeDdC3rxz4=
X-Received: by 2002:a17:906:8594:: with SMTP id v20mr1986708ejx.470.1609917218321;
 Tue, 05 Jan 2021 23:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20210104230253.2805217-1-robh@kernel.org>
In-Reply-To: <20210104230253.2805217-1-robh@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 6 Jan 2021 08:13:27 +0100
Message-ID: <CAMpxmJVFFu6q53-O_iWCyhY3M3up2Hg1TMY_DpmOvED4eN8bJQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add missing array size constraints
To:     Rob Herring <robh@kernel.org>
Cc:     linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-ide@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        linux-drm <dri-devel@lists.freedesktop.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-spi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jan 5, 2021 at 12:03 AM Rob Herring <robh@kernel.org> wrote:
>
> DT properties which can have multiple entries need to specify what the
> entries are and define how many entries there can be. In the case of
> only a single entry, just 'maxItems: 1' is sufficient.
>
> Add the missing entry constraints. These were found with a modified
> meta-schema. Unfortunately, there are a few cases where the size
> constraints are not defined such as common bindings, so the meta-schema
> can't be part of the normal checks.
>

[snip!]

>  .../bindings/gpio/gpio-pca95xx.yaml           |  1 +

[snip!]

> diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
> index f5ee23c2df60..57cdcfd4ff3c 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
> @@ -81,6 +81,7 @@ properties:
>      const: 2
>
>    reset-gpios:
> +    maxItems: 1
>      description:
>        GPIO specification for the RESET input. This is an active low signal to
>        the PCA953x.  Not valid for Maxim MAX732x devices.

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
