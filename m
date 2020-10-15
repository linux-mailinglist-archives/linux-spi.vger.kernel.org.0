Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8589228ED42
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 08:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgJOGzQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 02:55:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43482 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725208AbgJOGzP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Oct 2020 02:55:15 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DA764941533202C8BB5C;
        Thu, 15 Oct 2020 14:55:11 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 15 Oct 2020
 14:55:10 +0800
Subject: Re: [PATCH 2/6] dt-bindings: mfd: google,cros-ec: explicitly allow
 additional properties
To:     Rob Herring <robh@kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
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
 <20201013160845.1772-3-thunder.leizhen@huawei.com>
 <20201014133844.GA1555058@bogus>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2ab384ce-9700-3673-299f-3b8ab302d387@huawei.com>
Date:   Thu, 15 Oct 2020 14:55:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201014133844.GA1555058@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2020/10/14 21:38, Rob Herring wrote:
> On Wed, Oct 14, 2020 at 12:08:41AM +0800, Zhen Lei wrote:
>> There are so many properties have not been described in this yaml file,
>> and a lot of errors will be reported. Especially, some yaml files such as
>> google,cros-ec-typec.yaml, extcon-usbc-cros-ec.yaml can not pass the
>> self-check, because of the examples. So temporarily allow additional
>> properties to keep the comprehensive dt_binding_check result clean.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> There's proper fixes for these under review.

That's a good news.

> 
> Rob
> 
> .
> 

