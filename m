Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBDE2D806F
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 22:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394959AbgLKVIA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 16:08:00 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5362 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394954AbgLKVHp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 16:07:45 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3df780000>; Fri, 11 Dec 2020 13:07:04 -0800
Received: from [10.2.60.59] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 21:07:03 +0000
Subject: Re: [PATCH v2 2/9] dt-bindings: spi: Add Tegra Quad SPI device tree
 binding
To:     Rob Herring <robh@kernel.org>
CC:     <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <thierry.reding@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <lukas@wunner.de>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
References: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
 <1607706088-1437-4-git-send-email-skomatineni@nvidia.com>
 <20201211205614.GA905591@robh.at.kernel.org>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <2c0501b1-71c9-e0d8-96e7-67e59f01b985@nvidia.com>
Date:   Fri, 11 Dec 2020 13:07:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211205614.GA905591@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607720824; bh=1T0NKV2aHT1IdfpsOWuGOCXfqnCjjpLWvkONzNsmaXA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=Fl/lpUzuqzqjMIejv6mxyjCHm3FzZuDQ1+2K9QyosSPzxgy9ewWKQfCjZoOzfTN+P
         Sppm06FbD5WDkjd2bHVe/6UItMVS7iPFhgo5fuAMkPJSj9ZyQGZwZxanfateeU7t+b
         Dv2BmsXMXnKOI1si6my9B7Q8DjHaVqyD7WMMon6g4fRaXx5iJv1+rVRUIeKPcKxm1T
         aukIzQQvlgV3WYVeUgCEXVKGpw7GyCEti2SvOWpeMjaupi+PFVuviPIbJRN0CE7KRq
         E8cNuYaKYtMm52oH3RXcV2o3z0DLuZy53lw7fcIDO/YivPb9dVN/+8biwpMF9xsher
         w8EZ+Wtp93srA==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Sorry rob, mixed patches went out accidentally.

Will resend v2

On 12/11/20 12:56 PM, Rob Herring wrote:
> On Fri, 11 Dec 2020 09:01:20 -0800, Sowjanya Komatineni wrote:
>> This patch adds YAML based device tree binding document for Tegra
>> Quad SPI driver.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   .../bindings/spi/nvidia,tegra210-quad.yaml         | 130 +++++++++++++++++++++
>>   1 file changed, 130 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
>>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dts:29.38-39 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1364: dt_binding_check] Error 2
>
>
> See https://patchwork.ozlabs.org/patch/1415094
>
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
