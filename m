Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8681E2CF943
	for <lists+linux-spi@lfdr.de>; Sat,  5 Dec 2020 05:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgLEEKv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 23:10:51 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6095 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEEKu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 23:10:50 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fcb08220000>; Fri, 04 Dec 2020 20:10:10 -0800
Received: from [10.2.90.244] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 5 Dec
 2020 04:10:09 +0000
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
To:     Mark Brown <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <20201202172721.GL5560@sirena.org.uk>
 <2257bc33-80ef-a6d8-8542-480defa32937@nvidia.com>
 <be8291fc-8e69-b577-d8f4-20aeca0b45cc@nvidia.com>
 <20201204185223.GF4558@sirena.org.uk>
 <df8d6f25-c8cc-3b41-e4df-8e26c9b93475@nvidia.com>
 <20201204224648.GI4558@sirena.org.uk>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <77693de0-4e9e-79b9-0f73-0eaa35ace8e0@nvidia.com>
Date:   Fri, 4 Dec 2020 20:10:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204224648.GI4558@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607141410; bh=EJn9bCc/bzceGa4mhUri+2vE6quib5lTTiAGB/7fag8=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=Yk7mlXv9CQ0eUF0j3Nvh66ccS9mPKobhfaARlm/ng4TQRVylGlT1g+089+iGRB7BS
         dgeZtzfxZgN75a+XUUgIjReEYLmPntG+Scg/Y9IXmNjFpRiZgeP+RGZmBBurrwmANi
         h7UyvAnK3tbEwCVZw0p1byT8sIRGwKgliXB9i4GKwxH6XcJWro18Twq14U4IrmzmG/
         kQAOfkRbSA70YOdw2zchD40QLKXBKfzo9RSUi+xEqElmYpMGAbxeiRKDsFxGpH+F+J
         5mkbahiAiXp28kzycUP5xawfnxJgvu4d84JRmZcfnDTzj2rru6IJWRuUPdQNNhphdK
         RQMWCnOuhGNtQ==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 12/4/20 2:46 PM, Mark Brown wrote:
> On Fri, Dec 04, 2020 at 01:04:46PM -0800, Sowjanya Komatineni wrote:
>> On 12/4/20 10:52 AM, Mark Brown wrote:
>>> On Thu, Dec 03, 2020 at 04:22:54PM -0800, Sowjanya Komatineni wrote:
>>>> Also unpack mode needs to manually put the bytes together from read data to
>>>> SPI core rx buffer.
>>> Could you be more explicit here, I don't know what "unpack mode" is?
>> Tegra SPI/QSPI controller support packed mode and unpacked mode based on
>> bits per word in a transfer.
>> Packed Mode: When enabled, all 32-bits of data in FIFO contains valid data
>> packets of 8-bit/16-bit/32-bit length.
>> Non packed mode: For transfers like 24-bit data for example we disable
>> packed mode and only 24-bits of FIFO data are valid and other bits are 0's.
>> So during TX for FIFO filling and during receive when FIFO data is read, SW
>> need to skip invalid bits and should align order from/to SPI core tx/rx
>> buffers.
> That's pretty surprising - is it really worth the overhead of using
> non-packed mode compared to just doing the transfer in 8 bit mode?  In
> any case it seems better to only do the memcpy() stuff in the cases
> where it's actually required since it looks like fairly obvious overhead
> otherwise, and the code could use some comments explaining why we're
> doing this.  It may actually be that the implementation is already doing
> the most sensible thing and it just needs more comments explaining why
> that's the case.

Understand the overhead but If any device specific transfers use/need 24 
bits per word, without non-packed mode we should fail the transfer.

Tegra HW has non-packed mode for such cases.

OK. Will use dma_map/unmap for packed mode transfer and for non-packed 
mode will use dma buf for fifo data and then can fill SPI core rx_buf 
with valid bytes from dma buf contents.

Sure will add comments for non-packed mode logic.

>>> This is not a good idea, attempting to reverse engineer the message and
>>> guess at the contents isn't going to be robust and if it's useful it
>>> will if nothing else lead to a bunch of duplicated code in drivers as
>>> every device that has this feature will need to reimplment it.  Instead
>>> we should extend the framework so there's explicit support for
>>> specifying transfers that are padding bytes, then there's no guesswork
>>> that can go wrong and no duplicated code between drivers.  A flag in the
>>> transfer struct might work?
>> As per QSPI spec, Dummy bytes for initial read latency are always FF's. So
>> its not like guessing the contents.
> The guesswork I was thinking of was deciding to do this rather than the
> pattern being output - the bit where the driver figures out that the
> intent of that transfer is to provide dummy bytes.
>
>> Tegra QSPI controller HW supports transferring dummy bytes (sending FF's
>> after address) based on dummy clock cycles programmed.
>> To allow Tegra QSPI HW transfer dummy bytes directly, controller driver need
>> number of dummy bytes / actual dummy clock cycles which core driver gets
>> from flash sfdp read data.
> Sure, the use case makes sense.
>
>> So, we can add flag to transfer and based on this flag if controller HW
>> supports then we can ignore filling dummy bytes in spi_mem_exec_op but
>> controller driver still needs dummy_cycles value. So probably along with
>> flag, do you agree to have dummy_cycle as part of transfer struct which can
>> be set to nor->read_dummy value?
> Yeah, or given that perhaps just skip the flag and do this by specifying
> dummy_cycles.  Or if this is always a multiple of 8 (which I guess it
> must be to do it using normal byte transfers) perhaps just have the flag
> and use the existing length field to infer the number of cycles?  I've
> not actually looked at the details at all so one or both of those
> suggestions may not actually make sense, please take them with a grain
> of salt.
>
> I'd recommend doing this as a followup to introducing the base driver,
> start off with the less efficient explicit writes and then add the API
> and add the support in the driver - that way the new API can be
> reviewed without it holding up the rest of the driver.

ok I think adding dummy_cycles to transfer is enough without flag.

If dummy cycles is 0, definitely no dummy bytes transfer.

So will get rid of code that detects dummy bytes xfer phase from list of 
transfers.


Thanks Mark.


Regards,

Sowjanya

