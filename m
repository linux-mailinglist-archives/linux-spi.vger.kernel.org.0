Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4AA4373A2
	for <lists+linux-spi@lfdr.de>; Fri, 22 Oct 2021 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhJVI1k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Oct 2021 04:27:40 -0400
Received: from www381.your-server.de ([78.46.137.84]:42802 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhJVI1k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Oct 2021 04:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=7U4+mkPEZ6r1Wf0OBbsGZo6KqRjFHs7t7X09yMwyKZw=; b=nBjfIsuGMQc7l/iXkF76SqA2nB
        dzttzWQ19B6FxCyaWIdBXtJwheYB7pMJp3UGu+2gd36/mWKqiXwN3g0SLpV/IoBSc+VvUgyQjBB5D
        xAnO2X33H9UhkM1TS9cUNQUJDGhdNcG6ZCiOq9+NuxA7Q1AEQPjK/Tfl8QsCYMDaSmNYGJLu95cB6
        dSyb/H2oOmqBqnGoiCk4S5AfayBeGrQe9IAdtpekQ0z+GmiRXPu78KLuhk3cSalqnslejFJghOfLc
        bb+BS1V1LMFapy8EqpNf1mswi9RZteG3PJ9Ty/KCp3ODi2yiMmnQadfQzJuITOoKyVNHzRiUvwTCT
        n3f3bNCQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mdpre-0000kd-0J; Fri, 22 Oct 2021 10:25:22 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mdprd-000Tih-PG; Fri, 22 Oct 2021 10:25:21 +0200
Subject: Re: spi enumeration process
To:     Henk Medenblik <henk@deathstar2.nl>, linux-spi@vger.kernel.org
References: <7247d1f3-552b-1e48-7fd6-e95edc12d016@deathstar2.nl>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d78426ec-3d23-7549-196a-c6802604d92d@metafoo.de>
Date:   Fri, 22 Oct 2021 10:25:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7247d1f3-552b-1e48-7fd6-e95edc12d016@deathstar2.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26329/Thu Oct 21 10:16:40 2021)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/22/21 9:55 AM, Henk Medenblik wrote:
> Hi all,
>
> I am using a custom SPI controller which I created in my Xilinx MPSoC 
> fpga part. On this custom spi controller bus I have one or more SPI 
> devices (in my case a custom LTC6951 driver) connected in the 
> devicetree under my spi controller.
> Because the controller is custom, I wrote the SPI controller driver 
> and also some slave device drivers which seem to work.
> These drivers are both created as out of tree loadable modules.
>
> My issue is that at boot of my SocFPGA I can see that my SPI 
> controller driver is correctly loaded during the boot process but the 
> spi slave driver which is connected to my controller does not get 
> automatically loaded.
> Therefore, I manually need to do a modprobe ltc6951.ko in my case 
> before the LTC6951 slave in my case is up and running.
>
> So, it seems like if I do not really understand the spi  slaves 
> enumeration process or there is something else that I am missing here. 
> I was under the assumption that the slaves automatically get 
> enumerated (they are put as slaves under my controller inside the 
> device tree) whenever it's master controller becomes alive. 

Hi,

Modules are loaded by userspace, e.g. udev. It does so based on hints 
that are embedded in the module, these are called MODALIASs. When udev 
sees a device without a driver it will check all the modules to see if 
they have a matching modalias for the driver and then load the module.

In your driver you define the modalias usually using 
MODULE_DEVICE_TABLE(type, table). E.g. for a SPI driver the type would 
be spi and will take a reference to the spi_device_id table for your 
driver. In addition if you are using devicetree you do the same for the 
of_device_id table with `of` as the type.

- Lars

