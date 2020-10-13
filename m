Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E472528D20B
	for <lists+linux-spi@lfdr.de>; Tue, 13 Oct 2020 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbgJMQSi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 12:18:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46836 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgJMQSi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Oct 2020 12:18:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09DGI0xF029301;
        Tue, 13 Oct 2020 11:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602605880;
        bh=uB7tfsQ7VyKREysedNmTmoS1dzXtefnn5LzROwbyCc0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=O2PaahNrpQ8AK6FvHL5mqgshIgpYOlE7iIzI2VtOts49fX6HiyadcNJKgaYTxmQd4
         MeTt1l4CGMetafCt1fggchjONn5jnMViMuqV9dw9Llal1g8TeDCxUCGv1HrhqwJnw6
         PZewCuKFKhMq9HBYJXPhwh6hAx89R9NCJvaRRpfk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09DGI0tG001867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 11:18:00 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 13
 Oct 2020 11:17:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 13 Oct 2020 11:17:18 -0500
Received: from [10.250.67.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09DGHHmf075021;
        Tue, 13 Oct 2020 11:17:17 -0500
Subject: Re: [PATCH 1/6] dt-bindings: leds: choose correct color value of
 multi-led
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
 <20201013160845.1772-2-thunder.leizhen@huawei.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <1565f22c-7be9-e771-7def-afbb28ec07a7@ti.com>
Date:   Tue, 13 Oct 2020 11:17:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013160845.1772-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Zhen

On 10/13/20 11:08 AM, Zhen Lei wrote:
> The color value of multi-led is fixed to "const: 8 #LED_COLOR_ID_MULTI",
> which is required by leds-class-multicolor.yaml.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   Documentation/devicetree/bindings/leds/leds-lp55xx.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> index 58e974793a7976b..cd877e817ad1a1c 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> @@ -197,7 +197,7 @@ examples:
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  reg = <0x2>;
> -               color = <LED_COLOR_ID_RGB>;
> +               color = <LED_COLOR_ID_MULTI>;
>                  function = LED_FUNCTION_STANDBY;
>                  linux,default-trigger = "heartbeat";
>   

This is not correct.  ID_RGB is the correct variable here.

https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/commit/?h=for-next&id=3d93edc77515c6f51fa9bbbe2185e2ec32bad024

Correct fix is to update the leds-class-multicolor.yaml

Dan

