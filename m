Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908BC2B4A2C
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbgKPP7U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 10:59:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43504 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgKPP7U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 10:59:20 -0500
Received: by mail-oi1-f193.google.com with SMTP id t143so19251623oif.10;
        Mon, 16 Nov 2020 07:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SJJPyWX2YfUe3Oo/pSRmO63ep2/WK35OXd5bs3M2IcQ=;
        b=c6/xKqnxyy4sBROghcDLpPwbkHY6cQlgjBRg6IynbSfGuQZzwDOgbyrJUQX0B72c6u
         VkMrf+Hri8ffWTpeZ+KWDd2jw+dVdySiMqr39T/rHjJSoTDxmtkBcbMNlqa6q+Oe9hWR
         AA4vU+6KVMfI6WBH+Y6blE9Hv6ZJlprPbMbUMJw8BpzBaeOBwFL1KTj+d5pziH34kfHa
         9ZGZe0w8Gl6gN+UxG0lEyxVXUUFl1uvWTFcIngdjArpYbb0pbCH6baM7SNIgkIAarZof
         enKFVt/wQLWGnLxB7iRJa9r55RAmFDfnk+ufmYBLeRBzkmS9tTu+DDB/4QAhqZ/AxAyM
         extQ==
X-Gm-Message-State: AOAM533Kvgom6kI7SgyQIDz24gFR3KxcpjQec2KoXMLk3ePFR3O2sCCo
        Ng2edO2//HHEqBlWzTHrwQ==
X-Google-Smtp-Source: ABdhPJzQVVlCe5JBQgZWAhVNGpgd/3mlIHTXO3Qh2MI/c+q0LPqR/euoc7LLgVnhVEWw5aDq2rcggQ==
X-Received: by 2002:aca:b156:: with SMTP id a83mr78786oif.150.1605542359327;
        Mon, 16 Nov 2020 07:59:19 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w22sm209679oie.49.2020.11.16.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:59:18 -0800 (PST)
Received: (nullmailer pid 1725008 invoked by uid 1000);
        Mon, 16 Nov 2020 15:59:17 -0000
Date:   Mon, 16 Nov 2020 09:59:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        vigneshr@ti.com, p.yadav@ti.com, devicetree@vger.kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v7 5/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20201116155917.GA1719083@bogus>
References: <20201116031003.19062-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201116031003.19062-6-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116031003.19062-6-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 16, 2020 at 11:10:02AM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/spi/cadence-quadspi.txt    |  67 ----------
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 147 +++++++++++++++++++++
>  2 files changed, 147 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> deleted file mode 100644
> index 945be7d5b236..000000000000
> --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -* Cadence Quad SPI controller
> -

WTF?

> -Required properties:
> -- compatible : should be one of the following:
> -	Generic default - "cdns,qspi-nor".
> -	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
> -	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".


> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - cdns,qspi-nor
> +          - ti,k2g-qspi
> +          - ti,am654-ospi


> +examples:
> +  - |
> +    qspi: spi@ff705000 {
> +      compatible = "cdns,qspi-nor";

I give up.
