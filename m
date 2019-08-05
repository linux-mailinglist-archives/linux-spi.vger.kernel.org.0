Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177078272F
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2019 23:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfHEVvu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Aug 2019 17:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfHEVvt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 5 Aug 2019 17:51:49 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D270F2173C;
        Mon,  5 Aug 2019 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565041909;
        bh=MgPcfIWpdlyaz/4ct/wZ0UcAXhmKA32yt1LEiLncyHQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R0xHCpb0g7SHZbZSfnCgdwnbwgS4Xbgluirjaa3QaWH2G8g6B6sd7z9ojk6VdPM5u
         sx386MjPhHOvVxN/Ck5kcqoSwqN9ySJco3QIyEVapQpi+x8U3ZqAV5MDC/oRHyG0To
         gGGmgUyaF2zeJxhxDhuWoXYUJ1qK3tjP3Mi2LDHg=
Received: by mail-qt1-f173.google.com with SMTP id d17so3616700qtj.8;
        Mon, 05 Aug 2019 14:51:48 -0700 (PDT)
X-Gm-Message-State: APjAAAVWQ9TIQq7HlTwEpLEo73hUek5j1oIbfu/g865Esm6fG1i5Sh6S
        FzBUzHHaNBLx7z/w1DppMQ0zXIDNNbPp7WJW9g==
X-Google-Smtp-Source: APXvYqxZCbKR4+PbJDpQLUsmi/4xl7NR/p4fqmhm9SFCdgM1DYmSwogal7/7LXK8ld8NUdCwOW78bsSs41kuNcTohmI=
X-Received: by 2002:a0c:acef:: with SMTP id n44mr147329qvc.39.1565041907997;
 Mon, 05 Aug 2019 14:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190805120320.32282-1-narmstrong@baylibre.com>
In-Reply-To: <20190805120320.32282-1-narmstrong@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Aug 2019 15:51:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJzwtSXX0nrS7RBP8u-e=16SiWOBjLrvy8Amc08PfpXag@mail.gmail.com>
Message-ID: <CAL_JsqJzwtSXX0nrS7RBP8u-e=16SiWOBjLrvy8Amc08PfpXag@mail.gmail.com>
Subject: Re: [RFCv2 0/9] dt-bindings: first tentative of conversion to yaml format
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Aug 5, 2019 at 6:03 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This is a first tentative to convert some of the simplest Amlogic
> dt-bindings to the yaml format.
>
> All have been tested using :
> $ make ARCH=arm64 dtbs_check
>
> Issues with the amlogic arm64 DTs has already been identified thanks
> to the validation scripts. The DT fixes will be pushed once these yaml
> bindings are acked.
>
> Changes since rfc v1:
> - Fixed bindings according to Rob's comments
> - Added commit log
> - renamed yaml files using amlogic prefix
>
> Neil Armstrong (9):
>   dt-bindings: mailbox: meson-mhu: convert to yaml
>   dt-bindings: rng: amlogic,meson-rng: convert to yaml
>   dt-bindings: spi: meson: convert to yaml
>   dt-bindings: reset: amlogic,meson-reset: convert to yaml
>   dt-bindings: arm: amlogic: amlogic,meson-gx-ao-secure: convert to yaml
>   dt-bindings: phy: meson-g12a-usb2-phy: convert to yaml
>   dt-bindings: phy: meson-g12a-usb3-pcie-phy: convert to yaml
>   dt-bindings: serial: meson-uart: convert to yaml
>   dt-bindings: watchdog: meson-gxbb-wdt: convert to yaml

For the series,

Reviewed-by: Rob Herring <robh@kernel.org>

What's your merge plan? Do you want me to take the whole series?

Rob
