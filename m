Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BDF17F1B
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 19:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfEHRdk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 13:33:40 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:60425 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbfEHRdk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 13:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=n5luhvHiM0S2zunUYkxxhDH7yla1XuKYDNTefmkVNrY=;
        b=ZU9dbk7a4BIzXF5tWxCWjmKr+OgPrDZK1q3OEwQX6l2ObUsleVysYwIjRSbuh1heMRVxHvpTwXhll6WcPEbDN942NXtVzrmaTEsBEcU56EZVdb+gCUhgCQpseWs8AlZXPI/ZvfKRhG7HUq+Ie88J9a+zm7BvwPxjpPKsc91cf+vOk2APtlNMuYqxKXTnxo0VUL/ObBNPW1i9ZRjOxUk7cTkCRcgB0d0spnOKuHeS+FJM+bod9mkxI/mppjBpJIWOihcfdrLICOArS2IIZD1Nzmb/ppTpZH3gp/62mnINvjAk+AEbVWeO/eeL3pSOkDZT+o+mC8+VtwLuMYqjLEGXlA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:62390 helo=[192.168.10.178])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hOQRk-0004fB-Km; Wed, 08 May 2019 19:33:36 +0200
Subject: Re: SPI regression with today's build
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Sperl <kernel@martin.sperl.org>
References: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de>
 <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
Date:   Wed, 8 May 2019 19:33:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

[cc:Martin]

Den 08.05.2019 19.07, skrev Nicolas Saenz Julienne:
> Small follow-up on this, and CCing Noralf as I forgot to add him on the last
> e-mail.
> 
> On Wed, 2019-05-08 at 17:01 +0200, Nicolas Saenz Julienne wrote:
>> Hi, This has been seen on a Raspberry Pi 3B+, using a w5500 Ethernet SPI
>> interface on the main SPI controller. The commit that introduced the issue
>> seems to be:
>>
>> c9ba7a16d0f1d2b1e70d47296eca5f612c753825 "spi: Release spi_res after
>> finalizing message"
>>
>> Here's the kernel log:
>>
>> [  170.085704] Unable to handle kernel paging request at virtual address
>> 0000000000100000
>> [  170.097773] Mem abort info:
>> [  170.101873]   ESR = 0x86000004
>> [  170.105222]   Exception class = IABT (current EL), IL = 32 bits
>> [  170.111599]   SET = 0, FnV = 0
>> [  170.115040]   EA = 0, S1PTW = 0
>> [  170.118484] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000ed70a017
>> [  170.125511] [0000000000100000] pgd=0000000000000000
>> [  170.130872] Internal error: Oops: 86000004 [#1] PREEMPT SMP
>> [  170.136532] Modules linked in: fuse vc4 cec drm_kms_helper cfbfillrect
>> brcmfmac cfbimgblt panel_raspberrypi_touchscreen cfbcopyarea drm hci_uart
>> btbcm brcmutil bluetooth cfg80211 w5100_spi bcm2835_v4l2(C) w5100 v4l2_common
>> videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev
>> microchip lan78xx crct10dif_ce drm_panel_orientation_quirks i2c_gpio
>> ecdh_generic edt_ft5x06 raspberrypi_hwmon ecc media rfkill snd_bcm2835(C)
>> input_polldev bcm2835_thermal spi_bcm2835 bcm2835_dma pwm_bcm2835 bcm2835_rng
>> rng_core virt_dma ip_tables x_tables ipv6
>> [  170.186506] Process spi0 (pid: 1335, stack limit = 0x00000000fb9981f5)
>> [  170.193133] CPU: 0 PID: 1335 Comm: spi0 Tainted: G        WC        5.1.0-
>> nico+ #116
>> [  170.200985] Hardware name: Raspberry Pi 3 Model B Plus Rev 1.3 (DT)
>> [  170.207343] pstate: 60000005 (nZCv daif -PAN -UAO)
>> [  170.212205] pc : 0x100000
>> [  170.214864] lr : spi_res_release.part.9+0x7c/0xb0
>> [  170.219631] sp : ffff000011303ce0
>> [  170.222987] x29: ffff000011303ce0 x28: ffff00001122bc30 
>> [  170.228373] x27: 00000000cccccccd x26: ffff000010ee96c8 
>> [  170.233759] x25: dead000000000100 x24: dead000000000200 
>> [  170.239143] x23: ffff000010d28b78 x22: ffff80002fa60e80 
>> [  170.244528] x21: ffff80002567b000 x20: ffff00001122bc88 
>> [  170.249914] x19: ffff00001122bc30 x18: 0000000000000020 
>> [  170.255297] x17: 0000000000000000 x16: 0000000000000000 
>> [  170.260682] x15: ffffffffffffffff x14: ffff000010ee96c8 
>> [  170.266068] x13: ffff000010fd3388 x12: ffff000010fd2fb7 
>> [  170.271453] x11: 0000000000000000 x10: ffff000011303ce0 
>> [  170.276840] x9 : ffff000011303ce0 x8 : 000000000000000f 
>> [  170.282226] x7 : 0000000000000005 x6 : ffff000010fd264d 
>> [  170.287612] x5 : 0000000000000000 x4 : 0000000000000000 
>> [  170.292998] x3 : 0000000000100000 x2 : ffff80002fa60e98 
>> [  170.298384] x1 : ffff00001122bc30 x0 : ffff80002567b000 
>> [  170.303769] Call trace:
>> [  170.306247]  0x100000
>> [  170.308550]  spi_transfer_one_message+0x268/0x388
>> [  170.313321]  __spi_pump_messages+0x200/0x508
>> [  170.317651]  spi_pump_messages+0x14/0x20
>> [  170.321630]  kthread_worker_fn+0xa8/0x188
>> [  170.325694]  kthread+0x120/0x128
>> [  170.328966]  ret_from_fork+0x10/0x18
>> [  170.332595] Code: bad PC value
>> [  170.335694] ---[ end trace d054c016d94fa755 ]---
> 
> It seems the SPI controller thread is racing with the device's thread.
> Something like this:
> 
>      SPI Controller Thread                       SPI Device Thread
> 
> 					    -> spi_sync_transfer() creates
> 					       spi_message on stack then
> 					       sleeps until finished
> 
> 			[SPI transfer happens...]
> 
> -> spi_finalize_current_message()
>    which wakes up SPI Device Thread
> 
>                                             -> spi_sync_transfer() returns, the
> 					       message disapears from the stack
> 
> -> spi_res_release() there is no more
>    spi_message and the memory is
>    potentialy used for something else
> 
> I've been looking at the spi_split_transfers_maxsize() code and can't think of
> a reason why spi_res_release() couldn't be placed before
> spi_finalize_current_message(). Which would solve the issue, but I guess Noralf
> has a better perspective on the topic.
> 

The problem was that spi_res_release() restored the original transfers
before spi_unmap_msg() is called in spi_finalize_current_message() thus
dma unmapping the original transfers, not the split ones that was mapped.

This is the accompanying change to the driver that hasn't been applied:
[v5,3/4] spi/spi-bcm2835: Split transfers that exceed DLEN
https://patchwork.kernel.org/patch/10899587/

Unless Martin Sperl, who wrote spi_split_transfers_maxsize(), has other
suggestions, I think we should just revert this patch.

Apparently I need to go back to the drawing board with this.

Noralf.

> Regards,
> Nicolas
> 
