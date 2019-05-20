Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02926243E0
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 01:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfETXEx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 May 2019 19:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfETXEx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 May 2019 19:04:53 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175382177B;
        Mon, 20 May 2019 23:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558393492;
        bh=bXuJgo8hi+txkmmEB+2+yyfv36aYgFaplaMU1TzAqjU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DE6H505Nm73AVFDHxOctcTPdHGIOzMt9Xkmb/BKFJYRa1qw+GO6QJ9lE1qmFnkgiV
         s9GtA8XkuiL/h+SK9ttZpaovTghiQO1TOXPwa7j3NyFAMrVSmNCdCvhY80Rlt2e6H0
         QIH2yfz8I8i54/vmLMGio/pU0fbdJBG5ijqw+X58=
Received: by mail-qt1-f182.google.com with SMTP id m32so18389429qtf.0;
        Mon, 20 May 2019 16:04:52 -0700 (PDT)
X-Gm-Message-State: APjAAAUAn7VuwdpF4BFpLYZR80zC70Nx1Sd4h5uW7g/RgOeG5wMlVmtZ
        frPc9BiaSiaOtQFcO8jGKd3aTFsROD2ti4UsGw==
X-Google-Smtp-Source: APXvYqyP29y6x6qjCGVunD3WlKkVN6G0vuEFCREuPouJsGmsk7zhWXz+qn63NuIOwg1Di2PrEOo5roFl/r+92wYANlA=
X-Received: by 2002:ac8:7688:: with SMTP id g8mr37805616qtr.224.1558393491311;
 Mon, 20 May 2019 16:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 20 May 2019 18:04:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ+GAgJuQy85bw1WoXCkpaqRY+V9G9HY8PUM3MGXqLyoQ@mail.gmail.com>
Message-ID: <CAL_JsqJ+GAgJuQy85bw1WoXCkpaqRY+V9G9HY8PUM3MGXqLyoQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: spi: Add YAML schemas for the generic
 SPI options
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 20, 2019 at 9:50 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The SPI controllers have a bunch of generic options that are needed in a
> device tree. Add a YAML schemas for those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v2:
>   - Change the nodename pattern
>   - Add a note to mention that the binding has moved
>
> Changes from v1:
>   - Rework the nodename pattern
>   - Limit the index of the usable chip selects to 256
>   - Rework the slave devices regex
>   - Remove the requirement on #address-cells and #size-cells
>   - Declare the slave and slave devices nodes as objects
>   - Add spi-max-frequency
>   - Fix the bus width range
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt         | 112 +-----
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 161 +++++++-
>  2 files changed, 162 insertions(+), 111 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-controller.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
