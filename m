Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E532CE46F
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 01:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgLDAXg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 19:23:36 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16962 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgLDAXg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 19:23:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc9815f0000>; Thu, 03 Dec 2020 16:22:55 -0800
Received: from [10.2.90.244] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Dec
 2020 00:22:55 +0000
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <20201202172721.GL5560@sirena.org.uk>
 <2257bc33-80ef-a6d8-8542-480defa32937@nvidia.com>
Message-ID: <be8291fc-8e69-b577-d8f4-20aeca0b45cc@nvidia.com>
Date:   Thu, 3 Dec 2020 16:22:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2257bc33-80ef-a6d8-8542-480defa32937@nvidia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607041375; bh=os3SsoQJuogSnBhNud5ZHwdxrswyR7qg6N2lKrWM8gE=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=nJMBR1YNf8UvJYya3G1mFxnISCDUikiwbe9TTQYvbHDMPLzOwMCOpt/9ndxxrBs2V
         c10O11M8E8MwvSNxuKuavkk5GpNdpVlBd7ptpXMbA6ea/C89EOaIAc/uHFBgWW8ZER
         UKOQZZg37CHy9ccbM0w/gDlVIc5wIGOnw9Mc9JmhpjrXVK5abnAyGbHpuHuSpgwKr5
         Anzm2ZzyjuDe32CqNMBGb1o5s3O2CVp0x2MGUB8Re0Yf9PjsMOQDtbPCPfNlY+v9QQ
         RCkHhVca335vBgxAFvGnF+LFCX+nR4q8AbRqiw1mi8UNCsRrQ+1jmJrP+rkzONOeZH
         10i/eg5fEAeCQ==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 12/2/20 11:17 AM, Sowjanya Komatineni wrote:
>
> On 12/2/20 9:27 AM, Mark Brown wrote:
>> On Tue, Dec 01, 2020 at 01:12:44PM -0800, Sowjanya Komatineni wrote:
>>> Tegra SoC has a Quad SPI controller starting from Tegra210.
>>>
>>> This patch adds support for Tegra210 QSPI controller.
>> This looks pretty clean but I've got a few questions below about how
>> this integrates with the frameworks as well as some more minor issues.
>>
>>> +config QSPI_TEGRA
>>> +=A0=A0=A0 tristate "Nvidia Tegra QSPI Controller"
>> Everything else in this file is SPI_, even the qspi controllers.
> Will rename in v2
>>> +++ b/drivers/spi/qspi-tegra.c
>>> @@ -0,0 +1,1418 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (C) 2020 NVIDIA CORPORATION.=A0 All rights reserved.
>>> + */
>> Please make the entire comment a C++ one.=A0 It also appears that the "A=
ll
>> rights reserved" here conflicts with the GPL-2.0-only SPDX statement...
> Will fix in v2
>>
>>> +static void
>>> +tegra_qspi_copy_client_txbuf_to_qspi_txbuf(struct tegra_qspi_data=20
>>> *tqspi,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 str=
uct spi_transfer *t)
>>> +{
>>> +=A0=A0=A0 /* Make the dma buffer to read by cpu */
>>> +=A0=A0=A0 dma_sync_single_for_cpu(tqspi->dev, tqspi->tx_dma_phys,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tqspi->dma_buf_size, DMA=
_TO_DEVICE);
>>> +
>>> +=A0=A0=A0 if (tqspi->is_packed) {
>>> +=A0=A0=A0=A0=A0=A0=A0 unsigned int len =3D tqspi->curr_dma_words *
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tqspi->bytes_pe=
r_word;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 memcpy(tqspi->tx_dma_buf, t->tx_buf + tqspi->cur=
_pos, len);
>>> +=A0=A0=A0=A0=A0=A0=A0 tqspi->cur_tx_pos +=3D tqspi->curr_dma_words *
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tqspi->by=
tes_per_word;
>> It seems weird that this device needs us to do a memcpy() to do DMA,
>> most devices are able to DMA directly from the buffers provided by the
>> SPI API (and let the SPI core sync things).=A0 What is going on here?
>
> For transfers of size more than max DMA transfer limit, data transfer=20
> happens in multiple iterations with each iteration transferring up to=20
> max DMA transfer limit.
>
> So using separate dma buffers and on every iteration copying them to=20
> SPI core provided tx/rx buffers.
Also unpack mode needs to manually put the bytes together from read data=20
to SPI core rx buffer.
>
> Transferring data logic in this driver is similar as Tegra SPI driver=20
> except register changes and some QSPI specific register programming.
>
>>
>>> +=A0=A0=A0 tegra_qspi_writel(tqspi, status, QSPI_FIFO_STATUS);
>>> +=A0=A0=A0 while ((status & QSPI_FIFO_EMPTY) !=3D QSPI_FIFO_EMPTY) {
>>> +=A0=A0=A0=A0=A0=A0=A0 status =3D tegra_qspi_readl(tqspi, QSPI_FIFO_STA=
TUS);
>>> +=A0=A0=A0=A0=A0=A0=A0 if (time_after(jiffies, timeout)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(tqspi->dev,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "timeout waiting for fif=
o flush\n");
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 udelay(1);
>>> +=A0=A0=A0 }
>> It'd be good to put a cpu_relax() in the busy loop.
> Will update in v2.
>>
>>> +static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct sp=
i_transfer *t,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool is_f=
irst_of_msg)
>>> +{
>>> +=A0=A0=A0=A0=A0=A0=A0 /* toggle cs to active state */
>>> +=A0=A0=A0=A0=A0=A0=A0 if (spi->mode & SPI_CS_HIGH)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 command1 |=3D QSPI_CS_SW_VAL;
>>> +=A0=A0=A0=A0=A0=A0=A0 else
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 command1 &=3D ~QSPI_CS_SW_VAL;
>>> +=A0=A0=A0=A0=A0=A0=A0 tegra_qspi_writel(tqspi, command1, QSPI_COMMAND1=
);
>> This is worrying, the client device might be confused if /CS is doing
>> things outside of the standard handling.
>
> Do you mean to honor spi_transfer cs_change flag?
>
> Tegra QSPI is master and is used only with QSPI flash devices. Looking=20
> at SPI NOR driver, I see QSPI Flash commands are executed with one=20
> flash command per spi_message and I dont see cs_change flag usage=20
> w.r.t QSPI flash. So, using SW based CS control for QSPI.
>
> Please correct me if I miss something to understand here.
>
> Also Tegra186 and later QSPI controller supports combined sequence=20
> mode where command, address, data phases can be combined in a single GO.
>
> This saves some cycles in transfer and for this we need to use SW=20
> based CS control only.
>
>
>>> +=A0=A0=A0 of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &cdata->tx_clk_tap_de=
lay);
>>> +=A0=A0=A0 of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &cdata->rx_clk_tap_de=
lay);
>> These properties are not mentioned in the binding document.
> Thanks Mark. Missed them. Will add in v2.
>>
>>> +static int tegra_qspi_setup(struct spi_device *spi)
>>> +{
>>> +=A0=A0=A0 if (cdata && cdata->tx_clk_tap_delay)
>>> +=A0=A0=A0=A0=A0=A0=A0 tx_tap =3D cdata->tx_clk_tap_delay;
>>> +=A0=A0=A0 if (cdata && cdata->rx_clk_tap_delay)
>>> +=A0=A0=A0=A0=A0=A0=A0 rx_tap =3D cdata->rx_clk_tap_delay;
>>> +=A0=A0=A0 tqspi->def_command2_reg =3D QSPI_TX_TAP_DELAY(tx_tap) |
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 QSPI_RX_TAP_DELAY(=
rx_tap);
>>> +=A0=A0=A0 tegra_qspi_writel(tqspi, tqspi->def_command2_reg, QSPI_COMMA=
ND2);
>> The setup for one device shouldn't be able to affect the operation of
>> another, already running, device so either these need to be configured
>> as part of the controller probe or these configurations need to be
>> deferred until we're actually doing a transfer.
> We will only have 1 device on QSPI as we only support single chip select.
>>
>>> +=A0=A0=A0 /*
>>> +=A0=A0=A0=A0 * Tegra QSPI hardware support dummy bytes transfer based =
on the
>>> +=A0=A0=A0=A0 * programmed dummy clock cyles in QSPI register.
>>> +=A0=A0=A0=A0 * So, get the total dummy bytes from the dummy bytes tran=
sfer in
>>> +=A0=A0=A0=A0 * spi_messages and convert to dummy clock cyles.
>>> +=A0=A0=A0=A0 */
>>> +=A0=A0=A0 list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>>> +=A0=A0=A0=A0=A0=A0=A0 if (ntransfers =3D=3D DUMMY_BYTES_XFER &&
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !(list_is_last(&xfer->transfer_list,=
 &msg->transfers)))
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dummy_cycles =3D xfer->len * 8 / xfe=
r->tx_nbits;
>>> +=A0=A0=A0=A0=A0=A0=A0 ntransfers++;
>>> +=A0=A0=A0 }
>> This seems weird, there's some hard coded assumption about particular
>> patterns that the client device is going to send.=A0 What's going on her=
e?
>> I don't really understand what this is trying to do.
>
> QSPI flash needs dummy cycles for data read operation which is=20
> actually the initial read latency and no. of dummy cycles required are=20
> vendor specific.
>
> SPI NOR driver gets required dummy cycles based on mode clock cycles=20
> and wait state clock cycles.
>
> During read operations, spi_nor_spimem_read_data() converts dummy=20
> cycles to number of dummy bytes.
>
> Tegra QSPI controller supports dummy clock cycles register and when=20
> programmed QSPI controller sends dummy bytes rather than SW handling=20
> extra cycles for transferring dummy bytes.
>
> Above equation converts this dummy bytes back to dummy clock cycles to=20
> program into QSPI register and avoid manual SW transfer of dummy bytes.
>
>>
>>> +static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
>>> +{
>>> +=A0=A0=A0 struct tegra_qspi_data *tqspi =3D context_data;
>>> +
>>> +=A0=A0=A0 tqspi->status_reg =3D tegra_qspi_readl(tqspi, QSPI_FIFO_STAT=
US);
>>> +=A0=A0=A0 if (tqspi->cur_direction & DATA_DIR_TX)
>>> +=A0=A0=A0=A0=A0=A0=A0 tqspi->tx_status =3D tqspi->status_reg &
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (QSPI_TX_FIFO_U=
NF | QSPI_TX_FIFO_OVF);
>>> +
>>> +=A0=A0=A0 if (tqspi->cur_direction & DATA_DIR_RX)
>>> +=A0=A0=A0=A0=A0=A0=A0 tqspi->rx_status =3D tqspi->status_reg &
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (QSPI_RX_FIFO_O=
VF | QSPI_RX_FIFO_UNF);
>>> +=A0=A0=A0 tegra_qspi_mask_clear_irq(tqspi);
>>> +
>>> +=A0=A0=A0 return IRQ_WAKE_THREAD;
>>> +}
>> It's a bit unclear to me the value we gain from having this handler - if
>> we don't specify a handler genirq will already mask the interrupt until
>> we get to the thread anyway and we could just read the status in the
>> threaded handler.=A0 OTOH it doesn't do any harm, just struck me as a bi=
t
>> odd.
>
> I started QSPI driver by taking SPI driver as data transfer and=20
> interrupt handling are similar.
>
> So kept this handler for clearing status registers and masking=20
> interrupts as I did not see anything wrong with this.
>
>>
>>> +=A0=A0=A0 master =3D spi_alloc_master(&pdev->dev, sizeof(*tqspi));
>>> +=A0=A0=A0 if (!master) {
>>> +=A0=A0=A0=A0=A0=A0=A0 dev_err(&pdev->dev, "master allocation failed\n"=
);
>>> +=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
>>> +=A0=A0=A0 }
>> Please switch to using the devm_ version of the API to allocate
>> controller, it makes things much more robust.
> Will update in v2
>>
>>> +=A0=A0=A0 if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequen=
cy",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &master->max_speed_hz=
))
>>> +=A0=A0=A0=A0=A0=A0=A0 master->max_speed_hz =3D QSPI_MAX_SPEED;
>> The core will do this for you.
>
> Will remove this in v2.
>
> Thanks
>
> Sowjanya
>
