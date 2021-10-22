Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14E1437455
	for <lists+linux-spi@lfdr.de>; Fri, 22 Oct 2021 11:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhJVJJQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Oct 2021 05:09:16 -0400
Received: from www381.your-server.de ([78.46.137.84]:54358 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbhJVJJQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Oct 2021 05:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=eduJIVATfLkD7YpanJYXPTfO1iLo2cbk2RSKl9hn5KY=; b=aGcPtbSnzD4UqxFHtFZvoguUXX
        QN5BO8sidNlwzvi6JILpNkInVHjgfOnnXs3Ora4r39tMDkqjdoFC8Otais7OptHY83DTymfKbQLGz
        xhvxB2gMIRpql3ULrwoRplHeM9FI4vdVZGZ5Mw3hyzBds1t4Q+lYDWSJ/I9X77SURy+HBwzRiQQ/H
        vcPLzIZg5haCFqn4zXrfFLUuOAu7YOwBmkU0bNXbxTvTM5pyfzsy6ylIbiF1kZrb9XjZLTr2DZdi/
        EWw0TNg6XLuhvwA8MjMM8deA15VE977DR0l/bCsYSp7ZpHoovMNhoMjHvS3iCC2N3yoHvB0Ndh9OF
        eqlUINFA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mdqVu-0007po-FB; Fri, 22 Oct 2021 11:06:58 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mdqVu-000UxI-BH; Fri, 22 Oct 2021 11:06:58 +0200
Subject: Re: spi enumeration process
To:     Henk Medenblik <henk@deathstar2.nl>, linux-spi@vger.kernel.org
References: <7247d1f3-552b-1e48-7fd6-e95edc12d016@deathstar2.nl>
 <d78426ec-3d23-7549-196a-c6802604d92d@metafoo.de>
 <138ff85a-b045-a87d-fa68-a4dabe80e626@deathstar2.nl>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b5ea7c2f-4954-f9fa-a6fd-61c52f7d4ee9@metafoo.de>
Date:   Fri, 22 Oct 2021 11:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <138ff85a-b045-a87d-fa68-a4dabe80e626@deathstar2.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26330/Fri Oct 22 10:18:07 2021)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/22/21 10:40 AM, Henk Medenblik wrote:
> Hi Lars,
>
> I don't think that the issue is here the two MODULE_DEVICE_TABLE 
> modaliases in my ltc6951 driver. I have them both for the 
> spi_device_id and also the of_device_id defined.
> And I believe that if any of them would be missing, then manual 
> modprobe of the ltc6951 driver would fail too.

The table itself is used for the probing process. But the 
MODULE_DEVICE_TABLE is only used to signal userspace that this module 
handles the devices that are listed in the table. udev uses this 
information to load the driver if necessary.

Manual loading will still work without the MODULE_DEVICE_TABLE. But of 
course not without the table itself.

>
> The issue is that it does not get automatically enumerated when my 
> custom spi controller get loaded (i can see after boot that the spi 
> controller is alive when looking into /proc/modules)
>
> However, the spi slave device is not alive. The strange thing is that 
> this does work if I connect the spi slave to the onboard SPI 
> controller which resides inside the Zynq MPSoC.. (after putting the 
> ltc slave in the tree under that controller)

Ok, that's a bit odd that it works with the MPSoC controller. What I'd 
do is check `/sys/bus/spi/devices/`. Your device will be there even if 
driver has not been loaded. And then check the `modalias` and `uevent` 
files of the device. Check if those files look different when using your 
controller vs. the MPSoC.

- Lars

>
> Regards
>
> Henk
>
>
> On 10/22/21 10:25 AM, Lars-Peter Clausen wrote:
>> On 10/22/21 9:55 AM, Henk Medenblik wrote:
>>> Hi all,
>>>
>>> I am using a custom SPI controller which I created in my Xilinx 
>>> MPSoC fpga part. On this custom spi controller bus I have one or 
>>> more SPI devices (in my case a custom LTC6951 driver) connected in 
>>> the devicetree under my spi controller.
>>> Because the controller is custom, I wrote the SPI controller driver 
>>> and also some slave device drivers which seem to work.
>>> These drivers are both created as out of tree loadable modules.
>>>
>>> My issue is that at boot of my SocFPGA I can see that my SPI 
>>> controller driver is correctly loaded during the boot process but 
>>> the spi slave driver which is connected to my controller does not 
>>> get automatically loaded.
>>> Therefore, I manually need to do a modprobe ltc6951.ko in my case 
>>> before the LTC6951 slave in my case is up and running.
>>>
>>> So, it seems like if I do not really understand the spi slaves 
>>> enumeration process or there is something else that I am missing 
>>> here. I was under the assumption that the slaves automatically get 
>>> enumerated (they are put as slaves under my controller inside the 
>>> device tree) whenever it's master controller becomes alive. 
>>
>> Hi,
>>
>> Modules are loaded by userspace, e.g. udev. It does so based on hints 
>> that are embedded in the module, these are called MODALIASs. When 
>> udev sees a device without a driver it will check all the modules to 
>> see if they have a matching modalias for the driver and then load the 
>> module.
>>
>> In your driver you define the modalias usually using 
>> MODULE_DEVICE_TABLE(type, table). E.g. for a SPI driver the type 
>> would be spi and will take a reference to the spi_device_id table for 
>> your driver. In addition if you are using devicetree you do the same 
>> for the of_device_id table with `of` as the type.
>>
>> - Lars
>>

