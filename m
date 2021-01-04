Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD012E9C14
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 18:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbhADReJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 12:34:09 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16128 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbhADReJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 12:34:09 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff351690000>; Mon, 04 Jan 2021 09:33:29 -0800
Received: from [10.2.52.156] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Jan
 2021 17:33:24 +0000
Subject: Re: [PATCH v5 2/9] dt-bindings: spi: Add Tegra Quad SPI device tree
 binding
To:     Rob Herring <robh@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <lukas@wunner.de>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <linux-tegra@vger.kernel.org>,
        <broonie@kernel.org>, <tudor.ambarus@microchip.com>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <thierry.reding@gmail.com>
References: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
 <1608585459-17250-3-git-send-email-skomatineni@nvidia.com>
 <20201231183357.GA2112085@robh.at.kernel.org>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <4ac13c7b-dcf1-0a7d-c573-83890cba6a67@nvidia.com>
Date:   Mon, 4 Jan 2021 09:33:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201231183357.GA2112085@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1609781609; bh=FflGbQbz9Rt+mAPwIs31x4CA96a3hQ7Bfw2cSc8cimI=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=Sd4nzTZeJqYepDeRiaEpnnwJcHFyDyi70DxTMBdkAB8oEWXEOlimXwUPeC4mPyPeg
         U9tRy7UoglIY6dxqdCJ+MxSbbtWNRibthmNSJg1+vGih8W7eD80ISNdSv5lJvNiWwT
         zyYi6hPSxOAoEd+0xOwWYiZhTgBImw9vvPgfMgDJG2oUonOmyY5JbkV9bgJ9NhgRcQ
         bHUemHsFCSZNfgTURFhQPluPfA83MMUwgUiNlab6HVxCvUOiO6sJAmWZpJpMmp25z3
         z7RE6mIWxugRwpPPlciMvaKVbW7cLAbeocCqSllov8JRX/ufqAHcGdJGJfPqfUR25r
         3ZaYVt/L00l4Q==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 12/31/20 10:33 AM, Rob Herring wrote:
> On Mon, 21 Dec 2020 13:17:32 -0800, Sowjanya Komatineni wrote:
>> This patch adds YAML based device tree binding document for Tegra
>> Quad SPI driver.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   .../bindings/spi/nvidia,tegra210-quad.yaml         | 117 +++++++++++++++++++++
>>   1 file changed, 117 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
>>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.
>
Sorry Rob. Missed to add tag from v4 to v5.

Regards,

Sowjanya

