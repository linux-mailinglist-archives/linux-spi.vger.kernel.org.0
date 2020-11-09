Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0772AC7E6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 23:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKIWBI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 17:01:08 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34612 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIWBI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 17:01:08 -0500
Received: by mail-oi1-f193.google.com with SMTP id w188so6392810oib.1;
        Mon, 09 Nov 2020 14:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7wxEK8r93xFMQRm+C6rEop1thQQpZHU7Kw+qAO4PP6o=;
        b=MCfmvuo8vBhtk0gjgiX2EomuegjcS6o2jwwEjsMg0rMitNTfhOVwgXwKySwTKrHuiH
         w8uDKHmpg13MUyQu1n5qL3jjBt/7V+/Axj9FZ9YBeKeaQbVAKqCnC9IlUOFZcyBVWQe4
         MLpGfB40y0Vb4Ith8NTDN2FGogwfZIl9hoJ1SntBARyTh0ewlN33i5euy56w1TxyotO0
         dicaripQ+wLuIE/zskfcoZrLMFD3CKPDHfdxuoCdPkNBH3scDRNzoYnWG8wZmii5lT9j
         +VeewEY9WMg2ZxZSm/ru0Z6mBWyJYb7Er3XbkflLkOYIZerU10LIHGNK0BEK/XNyzTeU
         Qggg==
X-Gm-Message-State: AOAM531BEe0X3PAgYnh4lsEr0IVrkLp7LZvvd6iB8vpLSXomn4V2sry3
        nms8ifC5I3GpPgzu5MWjpw==
X-Google-Smtp-Source: ABdhPJyW9JGGk1VpbrzoajOyxnNt6WDJHvuOvs4tyQbZGJ6qyr3YYwnsnYbumefAA8c0DHcsISbu1g==
X-Received: by 2002:aca:4a51:: with SMTP id x78mr903938oia.86.1604959266864;
        Mon, 09 Nov 2020 14:01:06 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k20sm2821577ots.53.2020.11.09.14.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 14:01:06 -0800 (PST)
Received: (nullmailer pid 1832318 invoked by uid 1000);
        Mon, 09 Nov 2020 22:01:05 -0000
Date:   Mon, 9 Nov 2020 16:01:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 21/32] dt-bindings: Add Kendryte and Canaan vendor prefix
Message-ID: <20201109220105.GA1830760@bogus>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-22-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-22-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 07, 2020 at 05:14:09PM +0900, Damien Le Moal wrote:
> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to include
> "Kendryte" and "canaan" as a vendor prefix for "Canaan Inc."
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 2735be1a8470..f53d4d8e7f2a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -179,6 +179,8 @@ patternProperties:
>      description: CALAO Systems SAS
>    "^calxeda,.*":
>      description: Calxeda
> +  "^canaan,.*":
> +    description: Canaan, Inc.
>    "^caninos,.*":
>      description: Caninos Loucos Program
>    "^capella,.*":
> @@ -537,6 +539,8 @@ patternProperties:
>      description: Ka-Ro electronics GmbH
>    "^keithkoep,.*":
>      description: Keith & Koep GmbH
> +  "^kendryte,.*":

AFAICT, this is a marketing name for a series of SoCs? That's not a 
vendor.

> +    description: Canaan, Inc.
>    "^keymile,.*":
>      description: Keymile GmbH
>    "^khadas,.*":
> -- 
> 2.28.0
> 
