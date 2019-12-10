Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29C1118D33
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 17:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLJQFn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 11:05:43 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33890 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfLJQFn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 11:05:43 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBAG5d3x125995;
        Tue, 10 Dec 2019 10:05:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575993939;
        bh=q2n3cFOrDQaP41QLEGeRYUWXTWguYdSDrbzEbDG54gw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MU2k445pEA+Pk/6ydp5veGUcIgIyHDJ36ofUCeVwUed0mdX/UiDbI2fyTJuEEwPj+
         0SNSriXVoWPEWmFVKLSLp5gkh7h+8WAZhLL9opyRMlcsR9QlICaPcopCOQFvVLI5Az
         aS8ZU7XJO2DkE2q9QI7kVqrPo5C9CicKPbnH9jEU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBAG5dg4055019
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 10:05:39 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 10:05:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 10:05:38 -0600
Received: from [10.250.133.44] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBAG5ZJQ054939;
        Tue, 10 Dec 2019 10:05:36 -0600
Subject: Re: [PATCH 3/3] TI QSPI: optimize transfers for dual and quad read
To:     Jean Pihet <jean.pihet@newoldbits.com>
CC:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-4-jean.pihet@newoldbits.com>
 <2efd2981-73d1-6975-a385-871809ec43f1@ti.com>
 <CAORVsuU8b1-50STYAbY7CJ-VkLWXHbEz0dDCfLYfS4YM36vSgg@mail.gmail.com>
 <6d6808af-77b3-72b2-b247-58ed033cb4dc@ti.com>
 <CAORVsuXehEMi0xy6bm_OZuUowvx0K_Ogp2tXAjeruck3mYX=PQ@mail.gmail.com>
 <b56f079f-9fc0-c745-6c39-384e76896d21@ti.com>
 <CAORVsuUj2QFaATk2vvwLAqdyiUVhao8QMn9kSgZza_xSkzLm6w@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <a1d36afe-1cf2-9c75-8993-916ae888cc48@ti.com>
Date:   Tue, 10 Dec 2019 21:35:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAORVsuUj2QFaATk2vvwLAqdyiUVhao8QMn9kSgZza_xSkzLm6w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 12/10/2019 8:38 PM, Jean Pihet wrote:
> Vignesh,
> 
> On Tue, Dec 10, 2019 at 2:17 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
[...]
>> Ah, sorry, there is no CS toggle, so this case will work. Although its
>> less efficient as you could have set WLEN to 32 and read entire
>> QSPI_SPI_DATA_REG in one transaction.
>>
>> But this patch definitely changes the behvior when t->rx_nbits = 4 and
>> t->bits_per_word = 32. Previous code did:
>>
>>                *((u32 *)rxbuf) = readl(qspi->base + QSPI_SPI_DATA_REG);
>>
>> This patch does:
>>
>> +             rx = readl(qspi->base + QSPI_SPI_DATA_REG);
>>                 [...]
>> +             case SPI_NBITS_QUAD:
>> +                     if (count >= 1)
>> +                             *rxbuf++ = rx >> 24;
>> +                     if (count >= 2)
>> +                             *rxbuf++ = rx >> 16;
>> +                     if (count >= 3)
>> +                             *rxbuf++ = rx >> 8;
>> +                     if (count >= 4)
>> +                             *rxbuf++ = rx;
>>
>>
>> So there is change in the endianess...
> Oh! The cases where bits_per_word is different than 8 definitely needs
> more thinking. I have tested the patches
> with SPI flash only. How to test it with 32 bits per word?
> 

My suggestion would be to restrict optimizations to just address SPI
Flash usecase, i.e  t->bits_per_word == 8. And not touch any other word
sizes.

See qspi_write_msg() on how this can be done for Single bit mode, same
can be extended for other modes.

Regards
Vignesh
