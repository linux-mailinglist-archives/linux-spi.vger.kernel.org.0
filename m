Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9B7252376
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 00:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHYWUm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 18:20:42 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37163 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHYWUl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Aug 2020 18:20:41 -0400
Received: by mail-il1-f194.google.com with SMTP id v2so131810ilq.4;
        Tue, 25 Aug 2020 15:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k3KGmLJGZaOAZkv6OSfgLj0L7NmLhPE7zQczouh7MEU=;
        b=Osys/usJ78FVhYjt6m5AckJ4c106dBCdzMGkn/WVXs7vIp6VbinlnFdHL7y+3az5CE
         859AoNFZ4NYQSIn7Sv0oC1lOYPk2dI4BcdUgeifZafjkoCODHmVfvv3FeAORkMdECiqt
         Nb6x8xtfQacV9o4BTW7wsWws1nAi6tuqq38kHNv36H2H9+4yr0j9nhc+c1Kck4lw9Cm+
         AQvwpJjVG9DbXs12iRS66P/VoLuco6L+t9TF8XI0vi9x2uaiLljS9D8pPvA84vIDW6Im
         HczMTqZvQpYHlLEK7NVRMJHDTBqwdRfpnVkFqGJ01LstbeWNmQbdqq9FIKV0DXZNQZno
         bP8w==
X-Gm-Message-State: AOAM531Iev/rOGth+x0rbpFE66TX9IKreec2iLjRWRAfD088TbhWWF02
        CwqUWt3v5CujjqqzfKfOpA==
X-Google-Smtp-Source: ABdhPJzvk8+3fhcPALS9UgRxvDmg4rJYVAmWzKAM0VmpBUEr/br5MUyUK52jUlLc3MBVxtZH4RMmfw==
X-Received: by 2002:a92:cf09:: with SMTP id c9mr11410277ilo.38.1598394040539;
        Tue, 25 Aug 2020 15:20:40 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id p77sm224314ill.39.2020.08.25.15.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 15:20:39 -0700 (PDT)
Received: (nullmailer pid 1447409 invoked by uid 1000);
        Tue, 25 Aug 2020 22:20:37 -0000
Date:   Tue, 25 Aug 2020 16:20:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: Convert spi-mtk-nor to json-schema
Message-ID: <20200825222037.GA1443219@bogus>
References: <20200820052827.2642164-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820052827.2642164-1-ikjn@chromium.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 20, 2020 at 01:28:27PM +0800, Ikjoon Jang wrote:
> Convert Mediatek ARM SOC's serial NOR flash controller binding
> to json-schema format.
> 
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
>  .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 82 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi-mtk-nor.txt   | 47 -----------
>  2 files changed, 82 insertions(+), 47 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> new file mode 100644
> index 000000000000..1e4bcf691539
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/mediatek,spi-mtk-nor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Serial NOR flash controller for MediaTek ARM SoCs
> +
> +maintainers:
> +  - Bayi Cheng <bayi.cheng@mediatek.com>
> +  - Chuanhong Guo <gch981213@gmail.com>
> +
> +description: |
> +  This spi controller support single, dual, or quad mode transfer for
> +  SPI NOR flash. There should be only one spi slave device following
> +  generic spi bindings. It's not recommended to use this controller
> +  for devices other than SPI NOR flash due to limited transfer
> +  capability of this controller.
> +
> +allOf:
> +  - $ref: /spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt2701-nor
> +              - mediatek,mt2712-nor
> +              - mediatek,mt7622-nor
> +              - mediatek,mt7623-nor
> +              - mediatek,mt7629-nor
> +          - enum:
> +              - mediatek,mt8173-nor
> +      - items:
> +          - const: mediatek,mt8173-nor
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock used for spi bus
> +      - description: clock used for controller
> +
> +  clock-names:
> +    items:
> +      - const: "spi"
> +      - const: "sf"

Don't need quotes.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names

interrupts was required.

Add:

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      nor_flash: spi@1100d000 {
> +        compatible = "mediatek,mt8173-nor";
> +        reg = <0 0x1100d000 0 0xe0>;
> +        interrupts = <&spi_flash_irq>;
> +        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> +        clock-names = "spi", "sf";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@0 {
> +          compatible = "jedec,spi-nor";
> +          reg = <0>;
> +        };
> +      };
> +    };
> +
