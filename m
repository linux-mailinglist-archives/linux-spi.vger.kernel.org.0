Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F328D329
	for <lists+linux-spi@lfdr.de>; Tue, 13 Oct 2020 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbgJMRdO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 13:33:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51046 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbgJMRdN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Oct 2020 13:33:13 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09DHWilB082495;
        Tue, 13 Oct 2020 12:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602610364;
        bh=03oHbNp7Hhmx3bT4O0yNh/QWvev1CKkiW+v4b99Tzrc=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=QJW1ZGYJDTObunx1FO/8amAtcnryE+k8XWkNZOqAGtyQD+nnFwMQrVzJEGgRGjQL8
         TYamejuuU5/LBQ4W75GyWKOk0Bzw7a8I864+gwt83rJfGKGuSCjV04BvythkYZopLY
         DLuxipCbSoY0uA6UvfcQKwGK/QGHbgxMmuDQ5Qo4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09DHWiwR112683
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 12:32:44 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 13
 Oct 2020 12:32:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 13 Oct 2020 12:32:43 -0500
Received: from [10.250.67.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09DHWhi7053640;
        Tue, 13 Oct 2020 12:32:43 -0500
Subject: Re: [PATCH 6/6] dt-bindings: misc: correct the property name
 cmd-gpios to cmd-gpio
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-7-thunder.leizhen@huawei.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <bda5f620-7140-51fb-fadd-6ebd3c0db935@ti.com>
Date:   Tue, 13 Oct 2020 12:32:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013160845.1772-7-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Zhen

On 10/13/20 11:08 AM, Zhen Lei wrote:
> The property name used in arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts is
> cmd-gpio.
>
> arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:235:
> cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> index b3c45c046ba5e37..c7a06a9650db2ed 100644
> --- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> @@ -24,7 +24,7 @@ properties:
>     compatible:
>       const: olpc,xo1.75-ec
>   
> -  cmd-gpios:
> +  cmd-gpio:

Preference is gpios not gpio. But Rob H accept or reject

Dan

