Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6751C13CC78
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 19:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgAOSqP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 13:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgAOSqN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jan 2020 13:46:13 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127D42467E;
        Wed, 15 Jan 2020 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579113972;
        bh=FOsge55tBvLYEwlzzKuLeN6gBOiH1dEahfHM7dijZEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LSGcEUXbSKsbd9ds0arTnLwToy4tfyimSrxa9soZRGtsja83+M8zMqmVeY0dOO2Rl
         8lRECXd1A582Qnj3rIZnjFXyMcNjwq1Kj6aEaauB2B2V6oAkYIZkgjs9XjCCdCcFmq
         5TXRoCz1Ic0gWbSk58JVZMj87o9dkCkGQm7/9txc=
Received: by mail-qv1-f45.google.com with SMTP id u10so7864922qvi.2;
        Wed, 15 Jan 2020 10:46:12 -0800 (PST)
X-Gm-Message-State: APjAAAVgXeigop/mkdmNQzEkUh6PbbA+HeSzwORBc9UVdCV0wdiK3eFP
        gNR2JEtG5bVZcOu+P9sDLo4u7tchFxAZq7LByw==
X-Google-Smtp-Source: APXvYqwQhjjzzNFgQnH5Gk5PRAKtRXel22AUyoHHJ3Medi+wBx9id7b4qDaR088fF4MRTSFeU19h0F3baEcf1arCNNo=
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr26956612qvo.20.1579113971121;
 Wed, 15 Jan 2020 10:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20200114233857.25933-1-chris.packham@alliedtelesis.co.nz> <20200114233857.25933-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200114233857.25933-2-chris.packham@alliedtelesis.co.nz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Jan 2020 12:45:59 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+AOiFV4Kcu=r3-kz42ZqSVR_0ZuKtnz8ak_sksW0D0wQ@mail.gmail.com>
Message-ID: <CAL_Jsq+AOiFV4Kcu=r3-kz42ZqSVR_0ZuKtnz8ak_sksW0D0wQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        anthony.derosa@syscall7.com, linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jan 14, 2020 at 5:39 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add binding documentation for the spi-mux driver. This allows a generic
> multiplexer to be used to provide access to multiple SPI devices.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/spi/spi-mux.yaml      | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml

Be sure to run 'make dt_binding_check'.

>
> diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> new file mode 100644
> index 000000000000..1026d03a69c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

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
> +properties:
> +  compatible:
> +    const: spi-mux
> +
> +  mux-control:
> +    $ref: "/schemas/mux/mux-controller.yaml#"

That file doesn't exist. If it did, it would still be wrong as that
would be the provider side and this is the client.

The correct name is also 'mux-controls'.

You can assume it has a schema already and you just need to define how
many entries it has (maxItems: 1).

> +
> +required:
> +   - compatible
> +   - reg
> +   - spi-max-frequency
> +   - mux-control
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
> +       spi-mux {

spi-mux@0

> +         compatible = "spi-mux";
> +         #address-cells = <1>;
> +         #size-cells = <0>;
> +         reg = <0>;
> +         spi-max-frequency = <100000000>;

I don't think this makes sense here. The mux doesn't really have any
frequency given the clock and data lines aren't routed thru the mux
(though maybe that's possible if some isolation is needed).

> +
> +         mux-control = <&mux>
> +         mux-control-names = "spi";

Not documented. Drop it as it's not all that useful when there's only 1 entry.

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
> +           compatible = "spidev";

Not a valid compatible.

> +           reg = <1>;
> +           spi-max-frequency = <10000000>;
> +         };
> +       };
> +     };
> --
> 2.25.0
>
