Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1D928EFAE
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgJOJ4e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 05:56:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727165AbgJOJ4d (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Oct 2020 05:56:33 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0093655E78CD6B281545;
        Thu, 15 Oct 2020 17:56:28 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 15 Oct 2020
 17:56:23 +0800
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
Message-ID: <03484922-1044-0a57-980e-85e1de768915@huawei.com>
Date:   Thu, 15 Oct 2020 17:56:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201013160845.1772-6-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lubomir:
 Can you review this patch? The results of all other patches are clear.


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

