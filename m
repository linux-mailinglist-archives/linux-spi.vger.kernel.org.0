Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0D1C1F87
	for <lists+linux-spi@lfdr.de>; Fri,  1 May 2020 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgEAVZu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 May 2020 17:25:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42622 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVZu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 May 2020 17:25:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id m18so3630801otq.9;
        Fri, 01 May 2020 14:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IODh8vaskvY8EIkReJH8wMEH0J80lOImbjARnLzzvcQ=;
        b=elMrq0mXwjDSMLe6oddIdoCpFVPAuhPOBnTwmJgHoFY2JwT+kmi6oejqKlOzAA7+B7
         xIyEfvAPSZt7gyR3Lce48cgsTcRR8mO4KWX2Ktl1gSLb6VhHJOxDzbcswQTEPGHGNDkr
         B5z5R9y6GDWPZThGrPjsGq9gOuV85jzEDYP6ixS4VsGqreKVBQgnq8fNNYqd10L7lBmX
         rRKc2FUItMx+DShHq8k+dhbCzISClfKu8+MKq8/FD8/sVZaB7lKTw7sVpMcnyCs/wjM/
         cp98W3raKjUGiMDdgQmDmEf36sjpi0iN6ugwlK2gbaTUOAtgs7AXwe8scsN8mpHGLy6S
         fHWg==
X-Gm-Message-State: AGi0Pubk+T4kJyB1CS5FplyVmYNIE1sCwEWUhwPxvJ7WjSLFmrlOIcOh
        /GcHbWvPr3vBT2Cq6S4lTA==
X-Google-Smtp-Source: APiQypK6GnwgIp5q8Fl8YttocWPKhKXxC4m7JVG3OzxdYotva83r0Pcn/EVz6ZtR+YXkGyZH07amqQ==
X-Received: by 2002:a9d:7f04:: with SMTP id j4mr5397739otq.185.1588368349023;
        Fri, 01 May 2020 14:25:49 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b19sm269926oii.1.2020.05.01.14.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:25:48 -0700 (PDT)
Received: (nullmailer pid 25490 invoked by uid 1000);
        Fri, 01 May 2020 21:25:48 -0000
Date:   Fri, 1 May 2020 16:25:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: memory: document Renesas RPC-IF
 bindings
Message-ID: <20200501212547.GB15294@bogus>
References: <812e6e58-d13f-3f44-5f55-22266b690c57@cogentembedded.com>
 <116683d1-d402-4d7f-3357-1c8cde807076@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <116683d1-d402-4d7f-3357-1c8cde807076@cogentembedded.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Apr 30, 2020 at 11:47:25PM +0300, Sergei Shtylyov wrote:
> Renesas Reduced Pin Count Interface (RPC-IF) allows a SPI flash or
> HyperFlash connected to the SoC to be accessed via the external address
> space read mode or the manual mode.
> 
> Document the device tree bindings for the Renesas RPC-IF found in the R-Car
> gen3 SoCs.
> 
> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> Changes in version 2:
> - rewrote the bindings in YAML.
> 
>  Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml |   88 ++++++++++

Not where we normally put SPI flash controllers...

>  1 file changed, 88 insertions(+)
> 
> Index: linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> ===================================================================
> --- /dev/null
> +++ linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0)

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/renesas,rpc-if.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas Reduced Pin Count Interface (RPC-IF)
> +
> +maintainers:
> +  - Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> +
> +description: |
> +  Renesas RPC-IF allows a SPI flash or HyperFlash connected to the SoC to
> +  be accessed via the external address space read mode or the manual mode.
> +
> +  The flash chip itself should be represented by a subnode of the RPC-IF node.
> +  The flash interface is selected based on the "compatible" property of this
> +  subnode:
> +  - if it contains "jedec,spi-nor", then SPI is used;
> +  - if it contains "cfi-flash", then HyperFlash is used.
> +
> +allOf:
> +  - $ref: "/schemas/spi/spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        renesas,r8a77980-rpc-if # device is a part of R8A77980 SoC
> +	renesas,r8a77995-rpc-if # device is a part of R8A77995 SoC

Not valid yaml with tab and not valid json-schema as 'enum' is a list 
(needs '-').

> +      - enum:
> +        renesas,rcar-gen3-rpc-if # a generic R-Car gen3 device
> +
> +  reg:
> +    items:
> +       - description: RPC-IF registers
> +       - description: direct mapping read mode area
> +       - description: write buffer area

Wrong indentation.

> +
> +  reg-names:
> +    items:
> +      - const: regs
> +      - const: dirmap
> +      - const: wbuf
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":

^flash@... if you're that restrictive.

> +    type: object
> +    properties:
> +      compatible:
> +        oneOf:
> +          - const: cfi-flash
> +          - const: jedec,spi-nor

enum is better than oneOf+const.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/renesas-cpg-mssr.h>
> +    #include <dt-bindings/power/r8a77995-sysc.h>
> +
> +    spi@ee200000 {
> +      compatible = "renesas,r8a77995-rpc-if", "renesas,rcar-gen3-rpc-if";
> +      reg = <0 0xee200000 0 0x200>,
> +            <0 0x08000000 0 0x4000000>,
> +            <0 0xee208000 0 0x100>;
> +      reg-names = "regs", "dirmap", "wbuf";
> +      clocks = <&cpg CPG_MOD 917>;
> +      power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +      resets = <&cpg 917>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      flash@0 {
> +        compatible = "jedec,spi-nor";
> +        reg = <0>;
> +        spi-max-frequency = <40000000>;
> +        spi-tx-bus-width = <1>;
> +        spi-rx-bus-width = <1>;
> +      };
> +    };
