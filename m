Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F691469C8
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 14:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAWNvz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Jan 2020 08:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgAWNvw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 23 Jan 2020 08:51:52 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7902467E;
        Thu, 23 Jan 2020 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579787511;
        bh=vLvMBfKBDUNVaF/aoU4PfN2HEsbDc54gpbCoCV6eEbk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b1iJ2GrWbJ6sOxtCE6X6YZSNhYFzNIpM/kQYgA7f2/wGJ1koX74CO1m1w/MCm5No0
         BPLG4NXoQP5wOgn4QhptHUFzhR6166fKfS6Kxce1LEQd9yrrm3KsQU88+1pGGo0Au7
         LREyoiAW0bRXR/meubXNdV6fucp7AraKrvthmWK0=
Received: by mail-qk1-f171.google.com with SMTP id d10so3470716qke.1;
        Thu, 23 Jan 2020 05:51:51 -0800 (PST)
X-Gm-Message-State: APjAAAWtw3Red/ht3cdA8QN6luNT0Uj5cczoElWDB42a0jS4cHNLWSdV
        bS0ZbErdlCANEm2Grher6dMU8XN/gz5pdItuHQ==
X-Google-Smtp-Source: APXvYqwfO87Q0/W6AzS8yzHZDgljp8mtFonCDEPSQx1uYWjdYoPARCRWT3YmVbhrRhH7b66Aa6HwT9mSNtLWLu4ZXEM=
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr14856515qkl.119.1579787510715;
 Thu, 23 Jan 2020 05:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20200123012317.14808-1-chris.packham@alliedtelesis.co.nz> <20200123012317.14808-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200123012317.14808-2-chris.packham@alliedtelesis.co.nz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 23 Jan 2020 07:51:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLvM34WSBE29beBgJj0jLA6P_UwQUbTuEQcYJgrkg3v1A@mail.gmail.com>
Message-ID: <CAL_JsqLvM34WSBE29beBgJj0jLA6P_UwQUbTuEQcYJgrkg3v1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jan 22, 2020 at 7:24 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add binding documentation for the spi-mux driver. This allows a generic
> multiplexer to be used to provide access to multiple SPI devices.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v2:
>     - update license
>     - make dt_binding_check clean

Sure about that?

>
>  .../devicetree/bindings/spi/spi-mux.yaml      | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> new file mode 100644
> index 000000000000..4bdb31e2257e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-mux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic SPI Multiplexer
> +
> +description: |
> +  This binding describes a SPI bus multiplexer to route the SPI chip select
> +  signals. This can be used when you need more devices than the SPI controller
> +  has chip selects available. An example setup is shown in ASCII art; the actual
> +  setting of the multiplexer to a channel needs to be done by a specific SPI mux
> +  driver.
> +
> +        MOSI /--------------------------------+--------+--------+--------\
> +        MISO |/------------------------------+|-------+|-------+|-------\|
> +         SCL ||/----------------------------+||------+||------+||------\||
> +             |||                            |||      |||      |||      |||
> +      +------------+                        |||      |||      |||      |||
> +      | SoC  |||   |                      +-+++-+  +-+++-+  +-+++-+  +-+++-+
> +      |      |||   |                      | dev |  | dev |  | dev |  | dev |
> +      |   +--+++-+ | CS-X  +------+\      +--+--+  +--+--+  +--+--+  +--+--+
> +      |   | SPI  +-|-------+ Mux  |\\   CS-0 |        |        |        |
> +      |   +------+ |       +--+---+\\\-------/   CS-1 |        |        |
> +      |            |          |    \\\----------------/   CS-2 |        |
> +      |   +------+ |          |     \\-------------------------/   CS-3 |
> +      |   | ?    +-|----------/      \----------------------------------/
> +      |   +------+ |
> +      +------------+
> +
> +allOf:
> +  - $ref: "/schemas/spi/spi-controller.yaml#"
> +
> +maintainers:
> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +properties:
> +  compatible:
> +    const: spi-mux
> +
> +  mux-controls:
> +    maxItems: 1
> +
> +required:
> +   - compatible
> +   - reg
> +   - spi-max-frequency
> +   - mux-controls
> +
> +examples:
> +   - |
> +     mux: mux-controller {
> +       compatible = "gpio-mux";
> +       #mux-control-cells = <0>;
> +
> +       mux-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
> +     };
> +
> +     spi {
> +       spi-mux@0 {
> +         compatible = "spi-mux";
> +         #address-cells = <1>;
> +         #size-cells = <0>;
> +         reg = <0>;
> +         spi-max-frequency = <100000000>;
> +
> +         mux-controls = <&mux>

Missing semicolon.

> +
> +         spi-flash@0 {
> +           compatible = "jedec,spi-nor";
> +           #address-cells = <1>;
> +           #size-cells = <1>;
> +           reg = <0>;
> +           spi-max-frequency = <40000000>;
> +         };
> +
> +         spi-device@1 {
> +           compatible = "lineartechnology,ltc2488";
> +           reg = <1>;
> +           spi-max-frequency = <10000000>;
> +         };
> +       };
> +     };
> --
> 2.25.0
>
