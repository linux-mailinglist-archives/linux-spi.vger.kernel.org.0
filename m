Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AE51B704F
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 11:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDXJM2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 05:12:28 -0400
Received: from mx.socionext.com ([202.248.49.38]:38499 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgDXJM2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 05:12:28 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 24 Apr 2020 18:12:26 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5A66E60057;
        Fri, 24 Apr 2020 18:12:26 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 24 Apr 2020 18:12:26 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 2AD8F1A12D0;
        Fri, 24 Apr 2020 18:12:26 +0900 (JST)
Received: from [10.212.22.225] (unknown [10.212.22.225])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 6F879120131;
        Fri, 24 Apr 2020 18:12:25 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: spi: Convert UniPhier SPI controller to
 json-schema
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1587087014-14598-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <1243a377-cb88-3fa5-fcf9-75da200d9a9c@socionext.com>
Date:   Fri, 24 Apr 2020 18:12:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587087014-14598-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/04/17 10:30, Kunihiko Hayashi wrote:
> Convert UniPhier SPI controller binding to DT schema format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>   .../bindings/spi/socionext,uniphier-spi.yaml       | 55 ++++++++++++++++++++++
>   .../devicetree/bindings/spi/spi-uniphier.txt       | 28 -----------
>   2 files changed, 55 insertions(+), 28 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml
>   delete mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml b/Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml
> new file mode 100644
> index 0000000..bab8bcc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/socionext,uniphier-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier SPI controller
> +
> +description: |
> +  UniPhier SoCs have SCSSI which supports SPI single channel.
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +  - Keiji Hayashibara <hayashibara.keiji@socionext.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  compatible:
> +    const: socionext,uniphier-scssi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets

According to spi-controller.yaml, the "#address-cells" is required.
And the "#size-cells" is also required because it specifies "const: 0".
I'll add them in v2.

Thank you,

---
Best Regards
Kunihiko Hayashi
