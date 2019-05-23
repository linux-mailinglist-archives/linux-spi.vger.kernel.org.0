Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75128273D2
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2019 03:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfEWBKS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 21:10:18 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18878 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWBKS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 May 2019 21:10:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce5f2f50000>; Wed, 22 May 2019 18:10:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 May 2019 18:10:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 May 2019 18:10:17 -0700
Received: from [10.2.170.210] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 01:10:15 +0000
Subject: Re: [PATCH V5 4/4] spi: tegra114: add support for TX and RX trimmers
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-5-git-send-email-skomatineni@nvidia.com>
 <20190523010235.GA105588@archlinux-epyc>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <09040f7e-537c-4dd4-19d3-faa1aa45f0cf@nvidia.com>
Date:   Wed, 22 May 2019 18:10:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523010235.GA105588@archlinux-epyc>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558573813; bh=Om5qRlJmMYDBd6pppDmWgx6ImBSGofLGq85gMS4fwrM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=BLjbFIif7hT9p1KI8FRv5TSWQ1J7rvWDZjWHTwHZcrAnlITLUSXho4350pqTaaSyF
         T4+C0cIbC6o6jR5H5WaKfRaWqIWPijfUMouI9Fnvf9UUTWm/qixDL9Q3DsytLADKE+
         nignHV7jK1QLoLe2tQ0FS3oVJOpeowDcWk6kJaHGF9zaoSATOLZ/ZR5rvTrD5GOilp
         ux4QZ+cUV5g4YvgCuLWNGHLSERhxt2yCXbh82qBZjwD4wz895mcd6EAAQvDnWnpCm5
         VuRDEaJr2syqvpvJuqCRbFL7aRipVwWiOyqZSnxfZQCQUXGFj2S7Qfo+xNo09MnfMb
         8o4e1NbcqbdIw==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Nathan

Thanks for finding it. I missed to set it to master cleanup when I 
updated the patch.

Will send the patch fixing this.

Thanks

Sowjanya

On 5/22/19 6:02 PM, Nathan Chancellor wrote:
> Hi Sowjanya,
>
> On Mon, May 13, 2019 at 10:03:55PM -0700, Sowjanya Komatineni wrote:
>> Tegra SPI master controller has programmable trimmers to adjust the
>> data with respect to the clock.
>>
>> These trimmers are programmed in TX_CLK_TAP_DELAY and RX_CLK_TAP_DELAY
>> fields of COMMAND2 register.
>>
>> SPI TX trimmer is to adjust the outgoing data with respect to the
>> outgoing clock and SPI RX trimmer is to adjust the loopback clock with
>> respect to the incoming data from the slave device.
>>
>> These trimmers vary based on trace lengths of the platform design for
>> each of the slaves on the SPI bus and optimal value programmed is from
>> the platform validation across PVT.
>>
>> This patch adds support for configuring TX and RX clock delay trimmers
>> through the device tree properties.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/spi/spi-tegra114.c | 67 ++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
>> index e59ff7c1cee6..253a7f182fc9 100644
>> --- a/drivers/spi/spi-tegra114.c
>> +++ b/drivers/spi/spi-tegra114.c
> <snip>
>
>> +static void tegra_spi_cleanup(struct spi_device *spi)
>> +{
>> +	struct tegra_spi_client_data *cdata = spi->controller_data;
>> +
>> +	spi->controller_data = NULL;
>> +	if (spi->dev.of_node)
>> +		kfree(cdata);
>> +}
>> +
> This function is not called anywhere and it is marked as static so it
> triggers an unused function warning. Was that intentional?
>
> drivers/spi/spi-tegra114.c:938:13: warning: unused function 'tegra_spi_cleanup' [-Wunused-function]
> static void tegra_spi_cleanup(struct spi_device *spi)
>              ^
> 1 warning generated.
>
> Cheers,
> Nathan
