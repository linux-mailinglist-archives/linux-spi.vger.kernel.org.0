Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F7528ED7B
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 09:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgJOHTk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 03:19:40 -0400
Received: from mail.v3.sk ([167.172.186.51]:52914 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbgJOHTj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Oct 2020 03:19:39 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 03:19:38 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 82DB1DF930;
        Thu, 15 Oct 2020 07:10:58 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ur9ICDrN_0zz; Thu, 15 Oct 2020 07:10:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D76FFDF9AD;
        Thu, 15 Oct 2020 07:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iU2Zi-HIVQGB; Thu, 15 Oct 2020 07:10:57 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 93C0FDF930;
        Thu, 15 Oct 2020 07:10:57 +0000 (UTC)
Date:   Thu, 15 Oct 2020 09:12:56 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] dt-bindings: misc: correct the property name
 cmd-gpios to cmd-gpio
Message-ID: <20201015071256.GA1092695@demiurge.local>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-7-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013160845.1772-7-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Wed, Oct 14, 2020 at 12:08:45AM +0800, Zhen Lei wrote:
> The property name used in arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts is
> cmd-gpio.
> 
> arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:235:
> cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Thanks for the patch.

I've sent out an equivalent one some time ago:
https://lore.kernel.org/lkml/20200925234805.228251-3-lkundrak@v3.sk/

In any case, either is fine with me.

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

> ---
>  Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> index b3c45c046ba5e37..c7a06a9650db2ed 100644
> --- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> @@ -24,7 +24,7 @@ properties:
>    compatible:
>      const: olpc,xo1.75-ec
>  
> -  cmd-gpios:
> +  cmd-gpio:
>      description: GPIO uspecifier of the CMD pin
>      maxItems: 1
>  
> @@ -32,7 +32,7 @@ properties:
>  
>  required:
>    - compatible
> -  - cmd-gpios
> +  - cmd-gpio
>  
>  additionalProperties: false
>  
> @@ -49,7 +49,7 @@ examples:
>        slave {
>          compatible = "olpc,xo1.75-ec";
>          spi-cpha;
> -        cmd-gpios = <&gpio 155 GPIO_ACTIVE_HIGH>;
> +        cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
>        };
>      };
>  
> -- 
> 1.8.3
> 
> 
