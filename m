Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996DA437552
	for <lists+linux-spi@lfdr.de>; Fri, 22 Oct 2021 12:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhJVKSk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Oct 2021 06:18:40 -0400
Received: from outbound.soverin.net ([116.202.126.228]:43725 "EHLO
        outbound.soverin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhJVKSj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Oct 2021 06:18:39 -0400
X-Greylist: delayed 8452 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2021 06:18:39 EDT
Received: from smtp.freedom.nl (unknown [10.10.3.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 830C952
        for <linux-spi@vger.kernel.org>; Fri, 22 Oct 2021 10:16:21 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.127.71]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=deathstar2.nl;
        s=soverin; t=1634897780;
        bh=uol8lEHk1RN/YJjDcSGuaxg7LMZcVXW5vFl1C03KCv0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=munOA1qCjuF/9rU8SKR6YS7p7si2VkI0+cNXfJjBquhanpDd8NrzdCSZ8il5SMskw
         xwWUPtSiwbZNcclXW7gE75pfavUI0nbLLRGzoxOk2Rh59olg0WDDc8yIAUeVEhvI2m
         jAFKwosk4VDv8lh7kXQr0oofovM4Hcndb1fIjQDN8Ks7ZrP63EdKJAYiOdu16IrxAu
         QQGstIQzrapxu6Cfwc26VTvczstcFAoOA9xsAb3MIMAYLFmItEfKnpszOfTCiooTgT
         S/jZ7zjNYMBgPJwymE6yyXgQQ+ytSTgKpkrOKNtHu4auYr+UKYv1jVBp6gpLuzcuOh
         LFe1sr71/xiJg==
Subject: Re: spi enumeration process
To:     linux-spi@vger.kernel.org
References: <7247d1f3-552b-1e48-7fd6-e95edc12d016@deathstar2.nl>
 <d78426ec-3d23-7549-196a-c6802604d92d@metafoo.de>
 <138ff85a-b045-a87d-fa68-a4dabe80e626@deathstar2.nl>
 <b5ea7c2f-4954-f9fa-a6fd-61c52f7d4ee9@metafoo.de>
From:   Henk Medenblik <henk@deathstar2.nl>
Message-ID: <9c76cfff-2386-e22d-abaa-618469b49e7c@deathstar2.nl>
Date:   Fri, 22 Oct 2021 12:16:18 +0200
MIME-Version: 1.0
In-Reply-To: <b5ea7c2f-4954-f9fa-a6fd-61c52f7d4ee9@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lars,

On 10/22/21 11:06 AM, Lars-Peter Clausen wrote:
>
> Ok, that's a bit odd that it works with the MPSoC controller. What I'd 
> do is check `/sys/bus/spi/devices/`. Your device will be there even if 
> driver has not been loaded. And then check the `modalias` and `uevent` 
> files of the device. Check if those files look different when using 
> your controller vs. the MPSoC.
>
I checked these files after my system boot and with my custom controller:

root@star-module:/sys/bus/spi/devices/spi1.0# cat modalias
spi:ltc6951

root@star-module:/sys/bus/spi/devices/spi1.0# cat uevent
OF_NAME=ltc6951
OF_FULLNAME=/amba_pl@0/spi_ctrl@80020000/ltc6951@0
OF_COMPATIBLE_0=adi,ltc6951
OF_COMPATIBLE_N=1
MODALIAS=spi:ltc6951

Then have to do a manual modprobe of my ltc6951:

root@star-module:/sys/bus/spi/drivers# modprobe ltc6951
[  643.347655] probe ltc6951 driver ok

and after that one it finally pops up here:

root@star-module:/sys/bus/spi/drivers/ltc6951# ls
bind  module  spi1.0  uevent  unbind

and also shows up here:

root@star-module:/sys/bus/spi/drivers# ls
at25  ltc6951  max310x  mtd_dataflash  spi-nor  wl1271_spi

and pops up as an iio device:

root@star-module:/sys/bus/spi/devices/spi1.0# ls
driver           iio:device1  of_node  statistics  uevent
driver_override  modalias     power    subsystem


So I believe it isn't an issue with MODALIASs right? I still wonder if 
it has to do with the fact that both drivers are out of tree modules and 
not compiled in my linux kernel ?
That is not the case with the default Zynq MPSoc Cadence controller 
because that driver is compiled statically in the kernel.

Regards

Henk
