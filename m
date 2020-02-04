Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9F8151DBA
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 16:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgBDP5o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 10:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgBDP5o (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 4 Feb 2020 10:57:44 -0500
Received: from [192.168.1.32] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D8C2084E;
        Tue,  4 Feb 2020 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580831863;
        bh=g8HMHr9zNb7pwPbXgTl3NCZrwNVAu/yZtqlC5lUflyM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ed48RRYJBvc6dXMeKafRE6EQlt2V0XIfLCQFPzuEI6uGNs708ba6Dyx2HzowTy99+
         PIbz5V6c9lQf2BzQJnw8X/fYdMHaR+fmqKMMDwa/vvPwR2Urd8Di5ZkSpuytboh9EJ
         07pylRJ8Ntx8KnDa2O6azfsDdtABD+/TzcnhH8d0=
Subject: Re: [PATCH v8 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
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
 <0f079cf6-c146-8941-5bdd-f978ff3455ab@linux.intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d938fcc6-3e9b-2b5d-bf6c-1de7c8649798@kernel.org>
Date:   Tue, 4 Feb 2020 09:57:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <0f079cf6-c146-8941-5bdd-f978ff3455ab@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi

On 1/29/20 9:41 PM, Ramuthevar, Vadivel MuruganX wrote:
> Hi Simon,
> 
> On 29/1/2020 8:01 PM, Simon Goldschmidt wrote:
>> + some people possibly interested in this for the Altera platforms
>> (see below)
>>
>> Hi all,
>>
>> This is about moving the cadence qspi driver (which is used on TI,
>> Altera FPGAs
>> and a new Intel SoC) to spi-mem.Vadivel asked me to include some
>> Altera people
>> in the loop (see below), as this is the only platform currently untested,
>> I think.
>>
>> Right now, I'm not in the position to test this myself as we're
>> currently stuck
>> on an older RT kernel, so I cannot test with HEAD.
>>
>> Feel free to involve other Intel/Altera if you're interested in that
>> peripheral
>> not being broke for socfpga in one of the next releases :-)
>>
>> On Wed, Jan 29, 2020 at 10:18 AM Ramuthevar, Vadivel MuruganX
>> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>>> Hi,
>>>
>>>    Thank you for the query and confirmation.
>>>
>>> On 29/1/2020 4:31 PM, Simon Goldschmidt wrote:
>>>
>>> On Wed, Jan 29, 2020 at 8:25 AM Ramuthevar,Vadivel MuruganX
>>> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>>>
>>> From: Ramuthevar Vadivel Murugan
>>> <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>
>>> Add support for the Cadence QSPI controller. This controller is
>>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>>> This driver has been tested on the Intel LGM SoCs.
>>>
>>> So it has been tested on LGM and Vignesh gave his ok for TI. Is there
>>> anyone
>>> in the loop by now checking that this is valid for the 3rd platform
>>> using this
>>> (Altera)?
>>>
>>> Or am I wrong in thinking that this driver is meant to replace
>>> drivers/mtd/spi-nor/cadence-quadspi.c used on that platform?
>>>
>>> Absolutely , You are right, this driver is meant to replace to
>>> drivers/mtd/spi-nor/cadence-quadspi.c
>>> for Intel, TI and Altera SoC's using Cadence-QSPI IP.
>>>
>>> Meanwhile we have adapted to spi-mem framework (to support
>>> spi-nor/nand)and also didn't change the existing
>>> functionalities of spi-nor flash operations like
>>> hw_init/read/write/erase in drivers/mtd/spi-nor/cadence-quadspi.c,
>>> so it works fine (might be in Altera as well).
>>>
>>> Already I checked that Graham Moore <grmoore@opensource.altera.com>
>>> who has submitted the existing driver patches to upstream,
>>> His mail-id is bouncing back, then I decided that you are the right
>>> person to ask, could you please add them in loop if you know the team
>>> (socfpga platform engineers).

Thanks for including Graham, but he's moved on to a different career
that no longer includes Linux.

>> OK, done that. I mainly know them from U-Boot development, so I'm not
>> sure
>> who's responsible for the Linux drivers...
> Thank you for adding the team and respective members, let's see.
> 

I don't have the original patch series, but will monitor going forward.
As long as the new driver does not break legacy SoCFPGA products that
use the cadence-quadspi driver then it should be ok.

Dinh
