Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3A38C374
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2019 23:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfHMVTR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Aug 2019 17:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfHMVTQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Aug 2019 17:19:16 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC1020842;
        Tue, 13 Aug 2019 21:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565731155;
        bh=JBsXkG9yjV9pbDty8DqzOGotTUIFrOYtaCE16hbum0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=crdeyHeUCm2qAB/OFjwFqysrHfSLR+UetxBzbXV/OkhxIzZfVtCcy8QUXWO3fAxFd
         2KmAbggtL+55hUlR84ISmfdKkirvhsBnEQBoP/uxSi32b2CwTR1v2IV+trggF1jN+B
         8eECl3mkn8psCrRYD3Xw2D9PO80/YYBYHiSRZJFw=
Received: by mail-qt1-f169.google.com with SMTP id d17so28957848qtj.8;
        Tue, 13 Aug 2019 14:19:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUyIjDiiCsezqewY84HQlrASvCaByVgvYt7uZjb1u8k/D+Ie+xj
        hJ+lkwKE8FxBYaDkugqG6ro5Ayp7FESZLYwMuA==
X-Google-Smtp-Source: APXvYqyYbgP4TBRZegMhEKfIghK9abGk/VBtufyF+J98q6CTeTofBSY0orANz1i3T/gclh3hbfmdnJ7cT6pao2tVfEA=
X-Received: by 2002:a0c:acef:: with SMTP id n44mr228291qvc.39.1565731154671;
 Tue, 13 Aug 2019 14:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190808085139.21438-1-narmstrong@baylibre.com>
In-Reply-To: <20190808085139.21438-1-narmstrong@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Aug 2019 15:19:03 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rBUWCBo0CnhnJX91o+8QF4gO5cJYqFgKEJeekAeuVxg@mail.gmail.com>
Message-ID: <CAL_Jsq+rBUWCBo0CnhnJX91o+8QF4gO5cJYqFgKEJeekAeuVxg@mail.gmail.com>
Subject: Re: [PATCH 0/9] dt-bindings: first tentative of conversion to yaml format
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

On Thu, Aug 8, 2019 at 2:51 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
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
> Changes since rfc v2:
> - Collected Rob's, Martin's, Philipp's and Guenter's tags
> - Removed mhu maxItems: 3 to leave only minItems
> - Fixed flash@0 in spifc example
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

Series applied.

Rob
