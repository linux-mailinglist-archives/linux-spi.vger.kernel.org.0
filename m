Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C82CF5F5
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgLDVFV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 16:05:21 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17507 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgLDVFV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 16:05:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fcaa4680000>; Fri, 04 Dec 2020 13:04:40 -0800
Received: from [10.2.90.244] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Dec
 2020 21:04:40 +0000
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
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <df8d6f25-c8cc-3b41-e4df-8e26c9b93475@nvidia.com>
Date:   Fri, 4 Dec 2020 13:04:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204185223.GF4558@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607115881; bh=G/lGwc5ryxROjh3OEPWNBFPMDo/r/Skiiy7Ingk24xk=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=QZMQcjHu4eHmnbZ+Fi3wPk1mhZv+PTn+ss0act9NW2+TTkZd117utTk5MyLB/FmP9
         B7HQE3V8sSkEYNy0RkJygXX1fzZoV7qk7lh5rjWuqTDzSTZD5h5TY/EdOOedtvaeFE
         6cPUSAB5kh5LgFYyqq4XLn4GbDxdOdmOWOcuP2V+UwGmX7xTanvnFSP3cAjgxr3gxI
         Asiygn8R+iUEwUzaNFEKrotPF8/Yv8Fm0qmcxXlJUjPOljZS5Ime2yXfqX2brmT1ZL
         CktrxCSYpZ7i1CibtqvpUTmmv0rMKIks39EqP37MRxtEOn7TuDy8+Wn5Fhvy+G2/Ow
         DRFaWpWk7EtKA==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 12/4/20 10:52 AM, Mark Brown wrote:
> On Thu, Dec 03, 2020 at 04:22:54PM -0800, Sowjanya Komatineni wrote:
>> On 12/2/20 11:17 AM, Sowjanya Komatineni wrote:
>>>> It seems weird that this device needs us to do a memcpy() to do DMA,
>>>> most devices are able to DMA directly from the buffers provided by the
>>>> SPI API (and let the SPI core sync things).=A0 What is going on here?
>>> For transfers of size more than max DMA transfer limit, data transfer
>>> happens in multiple iterations with each iteration transferring up to
>>> max DMA transfer limit.
>>> So using separate dma buffers and on every iteration copying them to SP=
I
>>> core provided tx/rx buffers.
> I don't understand this - there's no restriction on where DMA transfers
> can be done from within a DMA mapped region, the driver can do multiple
> transfers from different chunks of the source buffer without having to
> copy anything.  That's a very common scenario.
>
>> Also unpack mode needs to manually put the bytes together from read data=
 to
>> SPI core rx buffer.
> Could you be more explicit here, I don't know what "unpack mode" is?

Tegra SPI/QSPI controller support packed mode and unpacked mode based on=20
bits per word in a transfer.

Packed Mode: When enabled, all 32-bits of data in FIFO contains valid=20
data packets of 8-bit/16-bit/32-bit length.

Non packed mode: For transfers like 24-bit data for example we disable=20
packed mode and only 24-bits of FIFO data are valid and other bits are 0's.
So during TX for FIFO filling and during receive when FIFO data is read,=20
SW need to skip invalid bits and should align order from/to SPI core=20
tx/rx buffers.

>
>>>> This is worrying, the client device might be confused if /CS is doing
>>>> things outside of the standard handling.
>>> Do you mean to honor spi_transfer cs_change flag?
> At least, yes - more generally just if there's any feature to with chip
> select then the driver will need to open code it.  The driver should at
> least be double checking that what it's doing matches what it was told
> to do, though just letting this be handled by the generic code if
> there's no limitation on the hardware tends to be easier all round.
OK Will honor cs_change flag at end of transfer and will program CS=20
state based on that.
>
>>> Tegra QSPI is master and is used only with QSPI flash devices. Looking
>>> at SPI NOR driver, I see QSPI Flash commands are executed with one flas=
h
>>> command per spi_message and I dont see cs_change flag usage w.r.t QSPI
>>> flash. So, using SW based CS control for QSPI.
>>> Please correct me if I miss something to understand here.
> Someone might build a system that does something different, they may see
> a spare SPI controller and decide they can use it for something else or
> there may be some future change with the flash code which does something
> different.
>
>>>>> +=A0=A0=A0 tegra_qspi_writel(tqspi, tqspi->def_command2_reg, QSPI_COM=
MAND2);
>>>> The setup for one device shouldn't be able to affect the operation of
>>>> another, already running, device so either these need to be configured
>>>> as part of the controller probe or these configurations need to be
>>>> deferred until we're actually doing a transfer.
>>> We will only have 1 device on QSPI as we only support single chip selec=
t.
> It's quite common for people to do things like add additional devices
> with GPIO chip selects.
Will move tap delay programming to happen during spi transfer..
>
>>>>> +=A0=A0=A0 /*
>>>>> +=A0=A0=A0=A0 * Tegra QSPI hardware support dummy bytes transfer base=
d on the
>>>>> +=A0=A0=A0=A0 * programmed dummy clock cyles in QSPI register.
>>>>> +=A0=A0=A0=A0 * So, get the total dummy bytes from the dummy bytes tr=
ansfer in
>>>>> +=A0=A0=A0=A0 * spi_messages and convert to dummy clock cyles.
>>>>> +=A0=A0=A0=A0 */
>>>>> +=A0=A0=A0 list_for_each_entry(xfer, &msg->transfers, transfer_list) =
{
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (ntransfers =3D=3D DUMMY_BYTES_XFER &&
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !(list_is_last(&xfer->transfer_lis=
t, &msg->transfers)))
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dummy_cycles =3D xfer->len * 8 / x=
fer->tx_nbits;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 ntransfers++;
>>>>> +=A0=A0=A0 }
>>>> This seems weird, there's some hard coded assumption about particular
>>>> patterns that the client device is going to send.=A0 What's going on h=
ere?
>>>> I don't really understand what this is trying to do.
>>> QSPI flash needs dummy cycles for data read operation which is actually
>>> the initial read latency and no. of dummy cycles required are vendor
>>> specific.
>>> SPI NOR driver gets required dummy cycles based on mode clock cycles an=
d
>>> wait state clock cycles.
>>> During read operations, spi_nor_spimem_read_data() converts dummy cycle=
s
>>> to number of dummy bytes.
>>> Tegra QSPI controller supports dummy clock cycles register and when
>>> programmed QSPI controller sends dummy bytes rather than SW handling
>>> extra cycles for transferring dummy bytes.
>>> Above equation converts this dummy bytes back to dummy clock cycles to
>>> program into QSPI register and avoid manual SW transfer of dummy bytes.
> This is not a good idea, attempting to reverse engineer the message and
> guess at the contents isn't going to be robust and if it's useful it
> will if nothing else lead to a bunch of duplicated code in drivers as
> every device that has this feature will need to reimplment it.  Instead
> we should extend the framework so there's explicit support for
> specifying transfers that are padding bytes, then there's no guesswork
> that can go wrong and no duplicated code between drivers.  A flag in the
> transfer struct might work?

As per QSPI spec, Dummy bytes for initial read latency are always FF's.=20
So its not like guessing the contents.

Tegra QSPI controller HW supports transferring dummy bytes (sending FF's=20
after address) based on dummy clock cycles programmed.

To allow Tegra QSPI HW transfer dummy bytes directly, controller driver=20
need number of dummy bytes / actual dummy clock cycles which core driver=20
gets from flash sfdp read data.

So, we can add flag to transfer and based on this flag if controller HW=20
supports then we can ignore filling dummy bytes in spi_mem_exec_op but=20
controller driver still needs dummy_cycles value. So probably along with=20
flag, do you agree to have dummy_cycle as part of transfer struct which=20
can be set to nor->read_dummy value?


Thanks

Sowjanya

