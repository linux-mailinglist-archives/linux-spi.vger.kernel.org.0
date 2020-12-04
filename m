Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C052CE8CC
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 08:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgLDHta (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 02:49:30 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9376 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgLDHta (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 02:49:30 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CnPvk0BCgz78QY;
        Fri,  4 Dec 2020 15:48:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Dec 2020
 15:48:42 +0800
Subject: Re: [PATCH 5/6] ARM: dts: mmp2-olpc-xo-1-75: explicitly add
 #address-cells=<0> for slave mode
To:     Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-6-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <698a7d6d-eceb-6c27-cca2-517218aec78f@huawei.com>
Date:   Fri, 4 Dec 2020 15:48:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201013160845.1772-6-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi everybody:
  Can somebody apply this patch? When I do any YAML dtbs_check on arm, below Warnings always reported.

arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
  also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
arch/arm/boot/dts/mmp2-olpc-xo-1-75.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'


On 2020/10/14 0:08, Zhen Lei wrote:
> Delete the old property "#address-cells" and then explicitly add it with
> zero value. The value of "#size-cells" is already zero, so keep it no
> change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
> index f1a41152e9dd70d..be88b6e551d58e9 100644
> --- a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
> +++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
> @@ -224,7 +224,7 @@
>  
>  &ssp3 {
>  	/delete-property/ #address-cells;
> -	/delete-property/ #size-cells;
> +	#address-cells = <0>;
>  	spi-slave;
>  	status = "okay";
>  	ready-gpio = <&gpio 125 GPIO_ACTIVE_HIGH>;
> 

