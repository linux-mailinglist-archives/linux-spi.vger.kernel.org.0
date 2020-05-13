Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830DD1D0A3E
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgEMHtk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 03:49:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49168 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgEMHtk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 03:49:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04D7ncGK097655;
        Wed, 13 May 2020 02:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589356178;
        bh=/N6ncEuKJTmEmVjkKxoOVRrkjQZg7dhNEmECsEcg4q4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bwOEqlvoZW3rOQ8jYVLD+1F9KJqCaSwBbF2f8RdmF4dfpRtHGg2K9CkSex89IBpMV
         vvLC+wtcISAgdVr5C2bf64CBxnd6j4LmmkfJdF2QcRa7zbKGfhuZT2y1D1kUZqjdIW
         Sy5wSU8B9tHzCXntZ/svNTp3aDiOHE8Kn3xrZAe4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04D7ncgc077922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 02:49:38 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 02:49:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 02:49:38 -0500
Received: from [10.250.234.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04D7nYbO078570;
        Wed, 13 May 2020 02:49:35 -0500
Subject: Re: [PATCH 4/5] dt-bindings: ufs: ti: Add missing
 'additionalProperties: false'
To:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
References: <20200512204543.22090-1-robh@kernel.org>
 <20200512204543.22090-4-robh@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <394531de-05cd-3e2e-60f4-a84694208726@ti.com>
Date:   Wed, 13 May 2020 13:19:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512204543.22090-4-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 13/05/20 2:15 am, Rob Herring wrote:
> The ti,j721e-ufs schema is missing an 'additionalProperties: false'. Add
> that and and the missing assigned-clock properties.
> 
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---


Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

>  Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> index b503b1a918a5..4d13e6bc1c50 100644
> --- a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> @@ -25,6 +25,12 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    maxItems: 1
> +
>    "#address-cells":
>      const: 2
>  
> @@ -47,6 +53,8 @@ patternProperties:
>        Documentation/devicetree/bindings/ufs/cdns,ufshc.txt for binding
>        documentation of child node
>  
> +additionalProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> 
