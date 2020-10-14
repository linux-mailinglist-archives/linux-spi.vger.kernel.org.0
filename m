Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF7A28D824
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 03:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgJNBww (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 21:52:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgJNBww (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Oct 2020 21:52:52 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6ED6BDA8A616D0B13FFA;
        Wed, 14 Oct 2020 09:52:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 14 Oct 2020
 09:52:43 +0800
Subject: Re: [PATCH 2/6] dt-bindings: mfd: google,cros-ec: explicitly allow
 additional properties
To:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        "Pavel Machek" <pavel@ucw.cz>,
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
 <20201013160845.1772-3-thunder.leizhen@huawei.com>
 <d2457f7a-625f-b046-9cfa-8f920de07377@ti.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0a3e1b00-df93-8c81-6ecb-355bd7693ab6@huawei.com>
Date:   Wed, 14 Oct 2020 09:52:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d2457f7a-625f-b046-9cfa-8f920de07377@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2020/10/14 1:53, Dan Murphy wrote:
> Zhen
> 
> On 10/13/20 11:08 AM, Zhen Lei wrote:
>> There are so many properties have not been described in this yaml file,
>> and a lot of errors will be reported. Especially, some yaml files such as
>> google,cros-ec-typec.yaml, extcon-usbc-cros-ec.yaml can not pass the
>> self-check, because of the examples. So temporarily allow additional
>> properties to keep the comprehensive dt_binding_check result clean.
> 
> My preference is to fix the binding to pass the checks and not just work around the issues. Working around the issues may mean the issues never get fixed.

I agree with your first sentence：don't just work around the issues. But these
errors are so annoying. Hope someone can add the description of the missing properties.
I'm not familiar with this module anyway.

And I don't fully agree with your last sentence. After all, the main properties are listed,
and the ones that are not listed should be minor ones.

> 
> Dan
> 
> 
> .
> 

