Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2392B14D562
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2020 04:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgA3Dl6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jan 2020 22:41:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:57283 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgA3Dl6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Jan 2020 22:41:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 19:41:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,380,1574150400"; 
   d="scan'208";a="229827225"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 29 Jan 2020 19:41:56 -0800
Received: from [10.226.38.32] (unknown [10.226.38.32])
        by linux.intel.com (Postfix) with ESMTP id 1093C5803C1;
        Wed, 29 Jan 2020 19:41:53 -0800 (PST)
Subject: Re: [PATCH v8 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Tien-Fong Chee <tien.fong.chee@intel.com>,
        Marek Vasut <marex@denx.de>
Cc:     Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200129072455.35807-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200129072455.35807-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qszwQ5sJw4G_fM5vKjYu24xs03CuW371gyFE4G0hNJHdXw@mail.gmail.com>
 <abaae0fa-c2b8-bbe0-b64d-0ee4c95c1479@linux.intel.com>
 <CAAh8qsxRPx8KDyqvp=8zcrGCE82YJ_9O9cJXrgKdH7VwXeGQgg@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <0f079cf6-c146-8941-5bdd-f978ff3455ab@linux.intel.com>
Date:   Thu, 30 Jan 2020 11:41:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAAh8qsxRPx8KDyqvp=8zcrGCE82YJ_9O9cJXrgKdH7VwXeGQgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Simon,

On 29/1/2020 8:01 PM, Simon Goldschmidt wrote:
> + some people possibly interested in this for the Altera platforms (see below)
>
> Hi all,
>
> This is about moving the cadence qspi driver (which is used on TI, Altera FPGAs
> and a new Intel SoC) to spi-mem.Vadivel asked me to include some Altera people
> in the loop (see below), as this is the only platform currently untested,
> I think.
>
> Right now, I'm not in the position to test this myself as we're currently stuck
> on an older RT kernel, so I cannot test with HEAD.
>
> Feel free to involve other Intel/Altera if you're interested in that peripheral
> not being broke for socfpga in one of the next releases :-)
>
> On Wed, Jan 29, 2020 at 10:18 AM Ramuthevar, Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> Hi,
>>
>>    Thank you for the query and confirmation.
>>
>> On 29/1/2020 4:31 PM, Simon Goldschmidt wrote:
>>
>> On Wed, Jan 29, 2020 at 8:25 AM Ramuthevar,Vadivel MuruganX
>> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>>
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for the Cadence QSPI controller. This controller is
>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>> This driver has been tested on the Intel LGM SoCs.
>>
>> So it has been tested on LGM and Vignesh gave his ok for TI. Is there anyone
>> in the loop by now checking that this is valid for the 3rd platform using this
>> (Altera)?
>>
>> Or am I wrong in thinking that this driver is meant to replace
>> drivers/mtd/spi-nor/cadence-quadspi.c used on that platform?
>>
>> Absolutely , You are right, this driver is meant to replace to drivers/mtd/spi-nor/cadence-quadspi.c
>> for Intel, TI and Altera SoC's using Cadence-QSPI IP.
>>
>> Meanwhile we have adapted to spi-mem framework (to support spi-nor/nand)and also didn't change the existing
>> functionalities of spi-nor flash operations like hw_init/read/write/erase in drivers/mtd/spi-nor/cadence-quadspi.c,
>> so it works fine (might be in Altera as well).
>>
>> Already I checked that Graham Moore <grmoore@opensource.altera.com> who has submitted the existing driver patches to upstream,
>> His mail-id is bouncing back, then I decided that you are the right person to ask, could you please add them in loop if you know the team
>> (socfpga platform engineers).
> OK, done that. I mainly know them from U-Boot development, so I'm not sure
> who's responsible for the Linux drivers...
Thank you for adding the team and respective members, let's see.

Regards
vadivel
>
> Regards,
> Simon
>
>> Regards
>> Vadivel
>>
>> Regards,
>> Simon
>>
