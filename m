Return-Path: <linux-spi+bounces-5832-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 922469D871D
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 14:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A44B27651
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0960E18C322;
	Mon, 25 Nov 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ns/m3pQo"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2D18872F
	for <linux-spi@vger.kernel.org>; Mon, 25 Nov 2024 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542007; cv=none; b=YW/OQix4O0qdIOCjuzPE1nVqR29k6TAky333l9Z8d+eX4EEPG+MTLb5QdFzNySLQCt2TVxJ053LBn/cGO9uQV2J5PN69NMvoKjCc68WNSt3IxiRqwi2hlKbXIQM3AL4QAwrcNP+mv78V/ztgZvsKENSuTqyStwiMZqOf1YaIzX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542007; c=relaxed/simple;
	bh=+h/emiCk8kqSAKY7xrhZGER4lLoSJLXt5WsF7hmdQoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw/itTYys3GJJ+UIZalaYeGPZqUFTJS+0XV7iBoIGfZzSXx25tQo6yEENxQ+NK7IqbZmZIcKBiFYM9stNncAZYKUpvpeJb3LVghRqvRb8E9sahm3u+WxOnkpJzmj9A5uUWw8yDk9uDLtfOoAPvptCYkvOvcZUhB/oOok+S7QKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ns/m3pQo; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85D96FF810;
	Mon, 25 Nov 2024 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732542003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ienOVOytLYrYTpFxID6ysncVXV/jCSi+OJUpeqgYmGc=;
	b=Ns/m3pQodZoz3EmDqEV7i6gZiL9xM1yE3Bm8dnDXRhEkFtdIveoBxvjr1K8CZUYAOg2s3i
	mKbL+MIU0rFCcTj5g7s4aT18mYQkCrLUxg+ej//jtQmokPrizJsO1YXzYwIpT2Mdf538NV
	C52PrMuzuJcxx5+Bye2Vai4fr+ZFTaLRXtdZRIDnaa4YDYMWQ+FQ/b3BL6u/tEGvOUCAyz
	HJKk7YDkNFZgS5qswBw/5KLV1clqdtZAI3WRh4Pz8tKAhr6nk3K7vyzMWCiBFP4hdCIr65
	WUfKaFXvyXzav0xCd1bkkWe2Y3Tnl6KB0gijScEBBALoYp1nDMG7I1kWfxc77g==
Message-ID: <80328dd3-22c3-4fce-a4f9-c389abfc1869@bootlin.com>
Date: Mon, 25 Nov 2024 14:40:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: intel_vsc probe issues on XPS 9320 (was Re: [PATCH] spi: Fix acpi
 deferred irq probe)
To: Hans de Goede <hdegoede@redhat.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20241122094224.226773-1-stanislaw.gruszka@linux.intel.com>
 <D5UNKGVDHH2G.308OGWQSNXP21@bootlin.com>
 <3ee5e7bb-2f54-4051-b36b-5e2d4be7cd42@redhat.com>
 <D5V9HIKF2P4H.33JQG23AJP4K8@bootlin.com>
 <b61d8cc6-f655-4596-b1b0-2ee603c3e2fe@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <b61d8cc6-f655-4596-b1b0-2ee603c3e2fe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 11/25/24 13:44, Hans de Goede wrote:
> Hi,
> 
> On 25-Nov-24 1:34 PM, Alexis Lothoré wrote:
>> Hi Hans, thanks a lot for the the help !
>>
>> On Mon Nov 25, 2024 at 11:05 AM CET, Hans de Goede wrote:
>>> Hi Alexis,
>>>
>>> On 24-Nov-24 8:23 PM, Alexis Lothoré wrote:
>>>> Hello,
>> [...]
>>
>>>> I systematically observe this issue (probe failure with -22) on each boot,
>>>> and reached the same intermediate conclusion (IRQ failing to register, and
>>>> spi->irq value being -EPROBE_DEFER).
>>>> I can confirm that this patch makes the vsc-tp -22 error disappear on my
>>>> machine, and that I have now /sys/devices/platform/intel_vsc.
>>>>
>>>> Unfortunately, I now encounter a new issue preventing the camera to work
>>>> (ipu6 still fails with -EPROBE_DEFER, I now have
>>>> ipu_bridge_get_ivsc_csi_dev failing while searching for child device
>>>> intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da).
>>>
>>> This sounds like you may not have the actual MEI driver enabled or
>>> that it is not binding.
>>
>> You were right, it looks like I have been missing CONFIG_INTEL_MEI_VSC. My
>> config is comming from the archlinux kernel, there may be a miss here.
>>
>>> Do you have both CONFIG_INTEL_MEI_VSC_HW and CONFIG_INTEL_MEI_VSC enabled?
>>
>> So now with this change, I still have no success with ipu loading, because
>> of new errors on vsc-tp, but those errors have actually changed:
>>
>> $ dmesg|grep vsc
>> [    8.594501] vsc-tp spi-INTC1094:00: wait rom failed ret: -110
>> [    8.594506] intel_vsc intel_vsc: hw_reset failed ret = -110
>> [    9.138269] vsc-tp spi-INTC1094:00: wait rom failed ret: -110
>> [    9.138287] intel_vsc intel_vsc: hw_reset failed ret = -110
>> [    9.678712] vsc-tp spi-INTC1094:00: wait rom failed ret: -110
>> [    9.678729] intel_vsc intel_vsc: hw_reset failed ret = -110
>> [    9.678750] intel_vsc intel_vsc: reset: reached maximal consecutive resets: disabling the device
>> [    9.678755] intel_vsc intel_vsc: reset failed ret = -19
>> [    9.678758] intel_vsc intel_vsc: link layer initialization failed.
>> [    9.678761] intel_vsc intel_vsc: error -ENODEV: init hw failed
>>
>> I have seen some mentions of this -110 error in the many redhat bugzilla
>> issues you have been helping with, I'll check more thoroughly if some hints
>> and/or patches have emerged from there.
> 
> Right. So this is a problem where the VSC chip is unresponsive which we
> still do not fully understand. power-cycling the laptop; or sometimes
> a power-cycle + if things still don't work a reboot after the power-cycle
> clears this.
> 
>> For the record, I am doing my tests with the current Archlinux kernel
>> (6.12.1-arch1), with those 3 patches on top:
>>
>> "mei: vsc: Do not re-enable interrupt from vsc_tp_reset()"
>> "media: intel/ipu6: do not handle interrupts when device is disabled"
>> "spi: Fix acpi deferred irq probe"
> 
> You may also want to throw these 2 into the mix. I've some hope that
> those will avoid the VSC chip getting stuck, requiring a power-cycle
> again (they do not help to "unstuck" the chip):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=5c5d8eb8af06df615e8b1dc88e5847196c846045
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=2481af79671a6603fce201cbbc48f31e488e9fae

ACK, I'll do the tests with those as well, and check if some power cycles help
as well.
> 
>>> And do you get a driver symlink under /sys/devices/platform/intel_vsc
>>> indicating that a driver has bound to it ?
>>
>> With the updated config: no, but I guess the dmesg output above explains it.
> 
> Right, the dmesg explains that.
> 
>> Sorry for the thread hijack, that's totally fine for me to continue the
>> discussions elsewhere if relevant.
> 
> I have changed the topic to reflect the new somewhat offtopic discussions.
> 
> Another place to discuss the -110 error would be:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2316918

ACK, I'll perform the tests mentioned above and report back to this issue.

Many thanks again for your support !

Alexis


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

