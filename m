Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3841F9E2A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 19:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgFORMO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 13:12:14 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39766 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFORMO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 13:12:14 -0400
Received: by mail-il1-f194.google.com with SMTP id p5so16032953ile.6;
        Mon, 15 Jun 2020 10:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G5WGUPUAIcBwza0/xjtURoDyzwjIEB/Wr5gpuV9swD0=;
        b=Fb5sDDB6HAlXnpW72K2SysMhHR6ikH+Ykhhe5p25LfdPbgbZU3KCUlvWMsslFZELKp
         DtMBAItYor6zb9jFTUl8fiKIltN9olwQPiklKgmBTECXNSA6PWQjru2vIiSfDztDKfbF
         Y+QguN10MtEVyGpCcOBLn9ujYjjq0Oj79fZsf9UFvcrv8pXQ9wJGOCIx9UJoNEc4ItOI
         ufeDI7+VN8iBt+daO3PbA61Ga14YuqBxrbCJOC2FMIvY7u8BK0ng8vr7b2vIQPZsYqX8
         r9MiFXVYWHZci//6BEZjOKiSXf64/K2vxYbFCWNV6M3xqmW9y4oyqg7K9gNOsmJaRCKO
         k48A==
X-Gm-Message-State: AOAM5335ITTZVqkEzSbq6JNhbwhasnj8HijusyMyXJ9ePCDn7QDuhB5E
        wBDsjGBN60FQFUvhUqjLmg==
X-Google-Smtp-Source: ABdhPJxkSrEaxMErK0l1AP6V19vUpDxfZBbTo5MTNzsZPQNLZcHrexQ20OfNYIzpl4S1RoaRPH6/Mg==
X-Received: by 2002:a92:d845:: with SMTP id h5mr27854230ilq.4.1592241131756;
        Mon, 15 Jun 2020 10:12:11 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id d71sm8551428ill.9.2020.06.15.10.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:12:11 -0700 (PDT)
Received: (nullmailer pid 1970644 invoked by uid 1000);
        Mon, 15 Jun 2020 17:12:09 -0000
Date:   Mon, 15 Jun 2020 11:12:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, marex@denx.de,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] dt-bindings: spi: Convert mxs spi to json-schema
Message-ID: <20200615171209.GA1968084@bogus>
References: <1591235731-15673-1-git-send-email-Anson.Huang@nxp.com>
 <1591235731-15673-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591235731-15673-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 04, 2020 at 09:55:29AM +0800, Anson Huang wrote:
> Convert the MXS SPI binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- add "unevaluatedProperties: false".
> ---
>  Documentation/devicetree/bindings/spi/mxs-spi.txt  | 26 ----------
>  Documentation/devicetree/bindings/spi/mxs-spi.yaml | 57 ++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/mxs-spi.txt b/Documentation/devicetree/bindings/spi/mxs-spi.txt
> deleted file mode 100644
> index 3499b73..0000000
> --- a/Documentation/devicetree/bindings/spi/mxs-spi.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -* Freescale MX233/MX28 SSP/SPI
> -
> -Required properties:
> -- compatible: Should be "fsl,<soc>-spi", where soc is "imx23" or "imx28"
> -- reg: Offset and length of the register set for the device
> -- interrupts: Should contain SSP ERROR interrupt
> -- dmas: DMA specifier, consisting of a phandle to DMA controller node
> -  and SSP DMA channel ID.
> -  Refer to dma.txt and fsl-mxs-dma.txt for details.
> -- dma-names: Must be "rx-tx".
> -
> -Optional properties:
> -- clock-frequency : Input clock frequency to the SPI block in Hz.
> -		    Default is 160000000 Hz.
> -
> -Example:
> -
> -ssp0: ssp@80010000 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	compatible = "fsl,imx28-spi";
> -	reg = <0x80010000 0x2000>;
> -	interrupts = <96>;
> -	dmas = <&dma_apbh 0>;
> -	dma-names = "rx-tx";
> -};
> diff --git a/Documentation/devicetree/bindings/spi/mxs-spi.yaml b/Documentation/devicetree/bindings/spi/mxs-spi.yaml
> new file mode 100644
> index 0000000..68c5d6d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/mxs-spi.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale MX233/MX28 SSP/SPI
> +
> +maintainers:
> +  - Marek Vasut <marex@denx.de>
> +
> +allOf:
> +  - $ref: "/schemas/spi/spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx23-spi
> +      - fsl,imx28-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx-tx
> +
> +  clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Already has a type, drop.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +    description: input clock frequency to the SPI block in Hz.
> +    default: 160000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - dmas
> +  - dma-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi@80010000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "fsl,imx28-spi";
> +        reg = <0x80010000 0x2000>;
> +        interrupts = <96>;
> +        dmas = <&dma_apbh 0>;
> +        dma-names = "rx-tx";
> +    };
> -- 
> 2.7.4
> 
