Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DED2DEB61
	for <lists+linux-spi@lfdr.de>; Fri, 18 Dec 2020 23:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgLRWCm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Dec 2020 17:02:42 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13862 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgLRWCl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Dec 2020 17:02:41 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdd26d80007>; Fri, 18 Dec 2020 14:02:00 -0800
Received: from [10.2.61.1] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Dec
 2020 22:01:57 +0000
Subject: Re: [PATCH v4 5/9] spi: spi-mem: Mark dummy transfers by setting
 dummy_data bit
To:     Mark Brown <broonie@kernel.org>, Pratyush Yadav <p.yadav@ti.com>
CC:     Boris Brezillon <boris.brezillon@collabora.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <lukas@wunner.de>, <bbrezillon@kernel.org>,
        <tudor.ambarus@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
 <1608236927-28701-6-git-send-email-skomatineni@nvidia.com>
 <20201218092106.skwej2g6bk3oksbb@ti.com>
 <20201218105759.43789ccf@collabora.com>
 <31c395ee-d7a6-edc5-a790-89fad91a0a27@nvidia.com>
 <20201218191936.hb6sq7zr3zdirar7@ti.com>
 <20201218204102.GF5333@sirena.org.uk> <20201218204414.GG5333@sirena.org.uk>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <c9343475-44b2-c9c4-1790-f6b50ec9c1bd@nvidia.com>
Date:   Fri, 18 Dec 2020 14:01:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218204414.GG5333@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608328920; bh=8Acq9GMc6nnEBbII98wXaf5fZtYBkqKtmc92tqPAku0=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=IBjIy3g1xJgPT0QS1nye2wOATxRT9+dPfxL8LVtbKHPbqmixzQGaxpIDYKewcilpT
         LI6ZoTrTtku07/y8t9ZZPc9yl9ZwsUyideM/rDRhxVIM1sNNbvXqPWKjWa3at9kuxs
         fwyG32gBi7m9E8gWFVQLy75NMJraywk9hBmbV/e9N2fIdG14syJNk7RElqbr9akQQt
         QIEG6YjZxgjx59UgkgFRpp6+eFWy9yIJLrxbCaaffk3aqyxsy4vg/+bzZfxmgp1UFH
         X0yTNbj/mKSBYUTGxMcg8P8CrE8F5XVWyqkHJZgWUBjy92iwnsMi9aTWFow6QRlNuF
         TgpTtcb05ScGA==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 12/18/20 12:44 PM, Mark Brown wrote:
> On Fri, Dec 18, 2020 at 08:41:02PM +0000, Mark Brown wrote:
>> On Sat, Dec 19, 2020 at 12:49:38AM +0530, Pratyush Yadav wrote:
>>> Anyway, if the SPI maintainers think this is worth it, I won't object.
>> This gets kind of circular, for me it's a question of if there's some
>> meaningful benefit from using the feature vs the cost to support it and
>> from the sounds of it we don't have numbers on the benefits from using
>> it at present.
> ...although I do have to say looking at the implementation that the cost
> seems low, it's just a flag set on an existing transfer.  The only issue
> is if we'd get more win from coalesing the entire transaction (or entire
> transmit) into a single transfer that could be DMAed and/or requires
> fewer trips through the stack which does make it seem like an unclear
> tradeoff from the point of view of client drivers

Using HW dummy cycles save extra software cycle of transfer which 
involves transfer setup register writes, writing dummy bytes to TX FIFO, 
interrupt processing.

Implementation wise it just a single bit field added to spi_transfer and 
on Tegra controller driver programming dummy cycles with prior transfer 
and skipping sw dummy transfer which is actually not complex.

 From quick check, I see HW dummy cycles transfer of 128KB shows 18 Mb/s 
while SW transfer of bytes shows 17.3 MB/s on average.

When back-to-back read commands are executed using HW dummy cycles will 
definitely save cycles.

