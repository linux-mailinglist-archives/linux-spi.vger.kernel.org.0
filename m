Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25B61A0F1
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2019 18:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfEJQGB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 12:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbfEJQGB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 May 2019 12:06:01 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E434217F5;
        Fri, 10 May 2019 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557504360;
        bh=LXZI74NTENEM7G5nr5VC4LMkdAJXskohMO2t1QZXpkc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C0hezQyrHwWq4j6aBaLax6yQNe3J942z0VL1VxKLJdwra7LU99W+DrJ+8254c9ZTR
         uCVW4/RRD2xK8PZ8AR6C4nPzZHtKX6ad5I3bXGSyNY6Clk5+VAy758y/NBtAJ0JCsx
         OJff8SHCRpz2Pnsg5f81+9RM2QtZh99gRKidr6ls=
Received: by mail-qt1-f182.google.com with SMTP id j53so7160997qta.9;
        Fri, 10 May 2019 09:06:00 -0700 (PDT)
X-Gm-Message-State: APjAAAVwbRhFaWz/iC32Khllb17yE5nlGd8NJPmp51Qxx7jmgy5aR0EY
        OImGXfh4mPEZimwW54yFIBxP7MQo/bsBFaqFuA==
X-Google-Smtp-Source: APXvYqzYEf6qHbKBboxIVepaRNkLODh5J40uKKOOt4R5M02W+EbV4RTaryGhH5cQGZunpHzvZWDXeSbPxUQblbSAGMM=
X-Received: by 2002:aed:306c:: with SMTP id 99mr10027559qte.38.1557504359227;
 Fri, 10 May 2019 09:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <1acc9ff7f59064b74cc319b7812479bcd842a897.1557386749.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <1acc9ff7f59064b74cc319b7812479bcd842a897.1557386749.git-series.maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 10 May 2019 11:05:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLRWSWk7cV=pYi1fbYsLJFUxE1fMo6Bm2FC99oPtS-88w@mail.gmail.com>
Message-ID: <CAL_JsqLRWSWk7cV=pYi1fbYsLJFUxE1fMo6Bm2FC99oPtS-88w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: spi: Add YAML schemas for the generic
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

On Thu, May 9, 2019 at 2:26 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The SPI controllers have a bunch of generic options that are needed in a
> device tree. Add a YAML schemas for those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
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
>  Documentation/devicetree/bindings/spi/spi-bus.txt         | 111 +-----
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 161 +++++++-
>  2 files changed, 161 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-bus.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-controller.yaml


> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> new file mode 100644
> index 000000000000..6258644249b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI Controller Generic Binding
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>
> +
> +description: |
> +  SPI busses can be described with a node for the SPI controller device
> +  and a set of child nodes for each SPI slave on the bus. The system SPI
> +  controller may be described for use in SPI master mode or in SPI slave mode,
> +  but not for both at the same time.
> +
> +properties:
> +  $nodename:
> +    pattern: "^spi(@.*)$"

Doing some testing with spi-gpio schema I'm writing, this needs to be
"^spi(@.*)*$" so that just 'spi' is allowed. However, that's not
enough for handling multiple instances of spi-gpio. So maybe we need
"^spi(@.*|-[0-9a-f])*$" to allow spi-1, spi-2, etc. Really, we need to
decide the larger issue of how we handle multiple instances when
there's no address space.

Also, this schema will be applied to any matching node name as it is
used for automatic selection if compatible schema is not present. If
we want to prevent that and only apply it when explicitly included,
then we need to add a 'select: false'. Without it, we get more
coverage, but it could slow things down and we'll get double printing
of errors.

Rob
