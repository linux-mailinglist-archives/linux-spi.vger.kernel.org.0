Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C7A4373C3
	for <lists+linux-spi@lfdr.de>; Fri, 22 Oct 2021 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhJVImm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Oct 2021 04:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhJVImm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Oct 2021 04:42:42 -0400
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:65::8:228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA425C061764
        for <linux-spi@vger.kernel.org>; Fri, 22 Oct 2021 01:40:24 -0700 (PDT)
Received: from smtp.freedom.nl (unknown [10.10.3.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 240EB51;
        Fri, 22 Oct 2021 08:40:23 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.127.71]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=deathstar2.nl;
        s=soverin; t=1634892021;
        bh=Ckbl7l5KsxpKZRaO2SHCMhQIjZjmLA0Hz0bu0ZsBzZU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=DxfvQ9MNPwhZj74fqPVATDSzmPOx1+fs9kvnzxu8oVU3dqD4y+Ben/Zqtb8K6jk4J
         SgMqZracTLO2lsVr1Bf41enxVpActLpKBpvTXy2eXvrNNw+3mwcBDvydlC2zhV3BbQ
         jwmq02wT9wAQRYQ5kY2Rmy2oCUgQ+qUlNkasnyRyJH1P4QB118wVSwhycr6KIT7JML
         g+3X/s92C30ZiOZJBZ8cx8SR7MpcXFKH6VnxmQstaEP/KoI6Pkd0XmfdtZOud0NpfW
         8qkcqWWcRZo8PcURb3+KzOKJBmligzIDTOS1qeGoULQfWa/gb1Jd3OraSZrDEU7O7x
         p46rQjVZicdNA==
Subject: Re: spi enumeration process
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-spi@vger.kernel.org
References: <7247d1f3-552b-1e48-7fd6-e95edc12d016@deathstar2.nl>
 <d78426ec-3d23-7549-196a-c6802604d92d@metafoo.de>
From:   Henk Medenblik <henk@deathstar2.nl>
Message-ID: <138ff85a-b045-a87d-fa68-a4dabe80e626@deathstar2.nl>
Date:   Fri, 22 Oct 2021 10:40:18 +0200
MIME-Version: 1.0
In-Reply-To: <d78426ec-3d23-7549-196a-c6802604d92d@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lars,

I don't think that the issue is here the two MODULE_DEVICE_TABLE 
modaliases in my ltc6951 driver. I have them both for the spi_device_id 
and also the of_device_id defined.
And I believe that if any of them would be missing, then manual modprobe 
of the ltc6951 driver would fail too.

The issue is that it does not get automatically enumerated when my 
custom spi controller get loaded (i can see after boot that the spi 
controller is alive when looking into /proc/modules)

However, the spi slave device is not alive. The strange thing is that 
this does work if I connect the spi slave to the onboard SPI controller 
which resides inside the Zynq MPSoC.. (after putting the ltc slave in 
the tree under that controller)

Regards

Henk


On 10/22/21 10:25 AM, Lars-Peter Clausen wrote:
> On 10/22/21 9:55 AM, Henk Medenblik wrote:
>> Hi all,
>>
>> I am using a custom SPI controller which I created in my Xilinx MPSoC 
>> fpga part. On this custom spi controller bus I have one or more SPI 
>> devices (in my case a custom LTC6951 driver) connected in the 
>> devicetree under my spi controller.
>> Because the controller is custom, I wrote the SPI controller driver 
>> and also some slave device drivers which seem to work.
>> These drivers are both created as out of tree loadable modules.
>>
>> My issue is that at boot of my SocFPGA I can see that my SPI 
>> controller driver is correctly loaded during the boot process but the 
>> spi slave driver which is connected to my controller does not get 
>> automatically loaded.
>> Therefore, I manually need to do a modprobe ltc6951.ko in my case 
>> before the LTC6951 slave in my case is up and running.
>>
>> So, it seems like if I do not really understand the spi  slaves 
>> enumeration process or there is something else that I am missing 
>> here. I was under the assumption that the slaves automatically get 
>> enumerated (they are put as slaves under my controller inside the 
>> device tree) whenever it's master controller becomes alive. 
>
> Hi,
>
> Modules are loaded by userspace, e.g. udev. It does so based on hints 
> that are embedded in the module, these are called MODALIASs. When udev 
> sees a device without a driver it will check all the modules to see if 
> they have a matching modalias for the driver and then load the module.
>
> In your driver you define the modalias usually using 
> MODULE_DEVICE_TABLE(type, table). E.g. for a SPI driver the type would 
> be spi and will take a reference to the spi_device_id table for your 
> driver. In addition if you are using devicetree you do the same for 
> the of_device_id table with `of` as the type.
>
> - Lars
>
