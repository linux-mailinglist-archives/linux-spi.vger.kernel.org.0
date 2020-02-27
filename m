Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265D21722E9
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 17:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgB0QLy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 11:11:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39126 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbgB0QLy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 11:11:54 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CEE0C2963C8;
        Thu, 27 Feb 2020 16:11:51 +0000 (GMT)
Date:   Thu, 27 Feb 2020 17:11:47 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR
 capability
Message-ID: <20200227171147.32cc6fcf@collabora.com>
In-Reply-To: <20200226093703.19765-2-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-2-p.yadav@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Feb 2020 15:06:53 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> Allow spi devices to express DTR receive and transmit capabilities via
> the properties "spi-rx-dtr" and "spi-tx-dtr".

Is the RX/TX granularity really useful?

> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  .../devicetree/bindings/spi/spi-controller.yaml        | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 1e0ca6ccf64b..7a84debed213 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -120,6 +120,11 @@ patternProperties:
>          description:
>            Delay, in microseconds, after a read transfer.
>  
> +      spi-rx-dtr:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Device supports receiving in DTR mode.
> +
>        spi-tx-bus-width:
>          allOf:
>            - $ref: /schemas/types.yaml#/definitions/uint32
> @@ -132,6 +137,11 @@ patternProperties:
>          description:
>            Delay, in microseconds, after a write transfer.
>  
> +      spi-tx-dtr:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Device supports transmitting in DTR mode.
> +
>      required:
>        - compatible
>        - reg

