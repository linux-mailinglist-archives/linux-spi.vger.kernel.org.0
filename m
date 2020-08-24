Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC44024FF4F
	for <lists+linux-spi@lfdr.de>; Mon, 24 Aug 2020 15:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHXNxV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 09:53:21 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:42072 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgHXNxJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 Aug 2020 09:53:09 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 07ODqlC5020592
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 15:52:47 +0200
Received: from [167.87.131.75] ([167.87.131.75])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07ODqgJ2007613;
        Mon, 24 Aug 2020 15:52:44 +0200
Subject: Re: [RESEND PATCH v3 7/8] mtd: spi-nor: Convert cadence-quadspi to
 use spi-mem framework
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, marex@denx.de
References: <20200601070444.16923-1-vigneshr@ti.com>
 <20200601070444.16923-8-vigneshr@ti.com>
 <a86aebbc-943d-6cb3-191c-797709692f80@siemens.com>
 <00394d38-20d9-60a5-0068-5f9f023520c2@ti.com>
 <20200824140438.14e72ca6@collabora.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b24b667b-a71d-d937-bd13-fdb37a1a30d0@siemens.com>
Date:   Mon, 24 Aug 2020 15:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824140438.14e72ca6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 24.08.20 14:04, Boris Brezillon wrote:
> On Mon, 24 Aug 2020 17:14:56 +0530
> Vignesh Raghavendra <vigneshr@ti.com> wrote:
> 
>> Hi Jan,
>>
>> On 8/24/20 11:25 AM, Jan Kiszka wrote:
>> [...]
>>
>>>> +MODULE_AUTHOR("Vignesh Raghavendra <vigneshr@ti.com>");
>>>>  
>>> On the AM65x, this changes mtd->name (thus mtd-id for
>>> parser/cmdlinepart) from 47040000.spi.0 to spi7.0. The besides having to
>>> deal with both names now, "spi7" sounds like it could easily change
>>> again if someone plugs or unplugs some other SPI device. Is this intended?
>>>   
>>
>> You could use DT aliases to make sure OSPI0 is always at given bus num
>> (say spi7):
>>
>>         aliases {
>>                 spi7 = &ospi0;
>>         };
> 
> FWIW, we've added the ->get_name() method [1][2] to avoid such
> regressions.
> 
> [1]https://elixir.bootlin.com/linux/latest/source/include/linux/spi/spi-mem.h#L218
> [2]https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-fsl-qspi.c#L810
> 

OK, that reads like I was not the first to run into this.

Vignesh, please use it so that I can drop the local workaround.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
