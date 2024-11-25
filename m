Return-Path: <linux-spi+bounces-5831-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4199C9D8594
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084DD284C7A
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269CF199EB7;
	Mon, 25 Nov 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzo/L6xb"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE81552E3
	for <linux-spi@vger.kernel.org>; Mon, 25 Nov 2024 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538666; cv=none; b=s65sLSgZcczkYDsIjBV7wI85panwHf/ex5hXqQKkU5QlKS+T2VdSHoc3iK6zjpwX7wFGJvsU7wg6wijfT3Z7wNzHqKmGec465a3MPGWXof1+9s3nNsvdVxpg/CHf/n8b9o5bHKHd5q1ELpi9E0GiLybX3uoQYAO/SxhRKsLx8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538666; c=relaxed/simple;
	bh=MJn0fZ1MRyW2tFRodlszZrZzuV3F7D62DPbLONbVXH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfdT3uaYMK3UYgqHz0aiFzsaa8Y25VPEUwyI4y/jUIrwWlK/jTjDy/6LgsDYxIC1dLKHXJ4PuMb/waO3Wmp/kYmXEdypDeAVJXMh1agj+P3wS3f4S7avIdk0oGGXACZeYBiM5Rw9pOyyXJp6ThwPqCMVOANivDSqv/jQxFc9o7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzo/L6xb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732538663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awXP1wHifmIxw1lyk+w0TwXO60IhiCE7zk3o8bFM2Tk=;
	b=gzo/L6xbx2vU2XYX6/UhTYXtEFO8B6MfKU2AhrKbQ07Jzh+8iEiK8qzrefqbasZAQFwhIi
	+ESje8MjtGu1XJzyF/qfhhXW9tylEH/tsY3Dzm64XgiL/H7iXee7+AbZn3wXoMNqr6xAO3
	S5GVUPy5bFfT7VMGe0MFGTAO6mMZeWM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-VW1LThGlMpG5NkHO85h2lw-1; Mon, 25 Nov 2024 07:44:19 -0500
X-MC-Unique: VW1LThGlMpG5NkHO85h2lw-1
X-Mimecast-MFC-AGG-ID: VW1LThGlMpG5NkHO85h2lw
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ffa81a2e9aso13515801fa.0
        for <linux-spi@vger.kernel.org>; Mon, 25 Nov 2024 04:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732538658; x=1733143458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awXP1wHifmIxw1lyk+w0TwXO60IhiCE7zk3o8bFM2Tk=;
        b=xJ5fndNeEDdTP93kJHV5mI5CKXoFZssQxX2PKqe4crCMyWfeBTL9xCcTAO/F3zdbjF
         acY0VwJm9fZqzhsWrCwaYIM8yLjQJsM2cg1XlLm3NIvVVXfKrp69ojHDfTkJ9xL3aLjn
         pjchQ+kjThrmXhJKLhhYoPlB+NzV+ICqimnjrH4jUPPk2cCO0DfH6VK/7l3zw8YWcOKZ
         31dTpWOqyhDqBunQJ7vxX4+sNZVsTGXOWUBJ9YkiECLEGn/xkCFV7r74GmiowsZN9ayn
         tvgKVFtJKZrgCs7OTmMxzMfwAfMFO9ktS54FZZGi8Z5fqP/VKtBdiS53IIDxRA8yChoQ
         MwHg==
X-Gm-Message-State: AOJu0YxEngGmmEfmcS2jRmr5GUVdu3SjWTTYJd5MsiHQKSOYFhjj77qB
	Sbfts98GKdN4OU1wEfn4pfc+3A3HorWd9ZrSkHfOFau8RrUkPmU40Rn3f7mT5sE9aFsS+LtPKJT
	w2AdeV2Mo8sKOaCi+1L8rztzvTwULkppv73MdG2rsJkltM1wgvk0/EMEy4w==
X-Gm-Gg: ASbGncsbq1ZRXR3oZpwgZMsM2Hwb+jpFRa6r0/ZP2y2/M9GFIUT2Tvb3Tx0FBB0jRe0
	cVF/2MHct2Qypcf91CCBc7G2snWdm3omVdaH1RZ91g7PeLmI9GSNqWAlvgWiBxINpzXN18wAkDo
	2qeKDRzcQnGJpaGtOWu9Jcq1Dt6B1Gj2u87OPNJX5mSLtUiLAqmfUd/XDeQFEBem8t5cZCFMhjC
	QORMqnlsGmLjoMi8ldkPYj+JTc2wGHIPu8yTizZLCoQt4jnRt6Q+AJuk/gUJksMOE1v8dIcLDDp
	IedB9MLOxtSDEUHbex0I2BGee1cirAPONSOSBKZat38hbdml49HJs++lFCedoS9JO+Cb4onkbcc
	jeQkTFSsIABdQleDGnwBJrAAw
X-Received: by 2002:a2e:bd87:0:b0:2ff:632f:7609 with SMTP id 38308e7fff4ca-2ffa7180cd3mr52241221fa.30.1732538657893;
        Mon, 25 Nov 2024 04:44:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgLls7XZeTUBJxLmDNpYpmhvnxVsdNeFSxZKSB3wPsC/p0dW/qBG0435tQ1To3L5a60cD/Fg==
X-Received: by 2002:a2e:bd87:0:b0:2ff:632f:7609 with SMTP id 38308e7fff4ca-2ffa7180cd3mr52241041fa.30.1732538657449;
        Mon, 25 Nov 2024 04:44:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28f6e6sm464652566b.35.2024.11.25.04.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:44:16 -0800 (PST)
Message-ID: <b61d8cc6-f655-4596-b1b0-2ee603c3e2fe@redhat.com>
Date: Mon, 25 Nov 2024 13:44:16 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: intel_vsc probe issues on XPS 9320 (was Re: [PATCH] spi: Fix acpi
 deferred irq probe)
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20241122094224.226773-1-stanislaw.gruszka@linux.intel.com>
 <D5UNKGVDHH2G.308OGWQSNXP21@bootlin.com>
 <3ee5e7bb-2f54-4051-b36b-5e2d4be7cd42@redhat.com>
 <D5V9HIKF2P4H.33JQG23AJP4K8@bootlin.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <D5V9HIKF2P4H.33JQG23AJP4K8@bootlin.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3hvBv_VcMt6rsxO8O0M0OYEbxNr9-MzJIs6Fr_pdGko_1732538658
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 25-Nov-24 1:34 PM, Alexis Lothoré wrote:
> Hi Hans, thanks a lot for the the help !
> 
> On Mon Nov 25, 2024 at 11:05 AM CET, Hans de Goede wrote:
>> Hi Alexis,
>>
>> On 24-Nov-24 8:23 PM, Alexis Lothoré wrote:
>>> Hello,
> [...]
> 
>>> I systematically observe this issue (probe failure with -22) on each boot,
>>> and reached the same intermediate conclusion (IRQ failing to register, and
>>> spi->irq value being -EPROBE_DEFER).
>>> I can confirm that this patch makes the vsc-tp -22 error disappear on my
>>> machine, and that I have now /sys/devices/platform/intel_vsc.
>>>
>>> Unfortunately, I now encounter a new issue preventing the camera to work
>>> (ipu6 still fails with -EPROBE_DEFER, I now have
>>> ipu_bridge_get_ivsc_csi_dev failing while searching for child device
>>> intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da).
>>
>> This sounds like you may not have the actual MEI driver enabled or
>> that it is not binding.
> 
> You were right, it looks like I have been missing CONFIG_INTEL_MEI_VSC. My
> config is comming from the archlinux kernel, there may be a miss here.
> 
>> Do you have both CONFIG_INTEL_MEI_VSC_HW and CONFIG_INTEL_MEI_VSC enabled?
> 
> So now with this change, I still have no success with ipu loading, because
> of new errors on vsc-tp, but those errors have actually changed:
> 
> $ dmesg|grep vsc
> [    8.594501] vsc-tp spi-INTC1094:00: wait rom failed ret: -110
> [    8.594506] intel_vsc intel_vsc: hw_reset failed ret = -110
> [    9.138269] vsc-tp spi-INTC1094:00: wait rom failed ret: -110
> [    9.138287] intel_vsc intel_vsc: hw_reset failed ret = -110
> [    9.678712] vsc-tp spi-INTC1094:00: wait rom failed ret: -110
> [    9.678729] intel_vsc intel_vsc: hw_reset failed ret = -110
> [    9.678750] intel_vsc intel_vsc: reset: reached maximal consecutive resets: disabling the device
> [    9.678755] intel_vsc intel_vsc: reset failed ret = -19
> [    9.678758] intel_vsc intel_vsc: link layer initialization failed.
> [    9.678761] intel_vsc intel_vsc: error -ENODEV: init hw failed
> 
> I have seen some mentions of this -110 error in the many redhat bugzilla
> issues you have been helping with, I'll check more thoroughly if some hints
> and/or patches have emerged from there.

Right. So this is a problem where the VSC chip is unresponsive which we
still do not fully understand. power-cycling the laptop; or sometimes
a power-cycle + if things still don't work a reboot after the power-cycle
clears this.

> For the record, I am doing my tests with the current Archlinux kernel
> (6.12.1-arch1), with those 3 patches on top:
> 
> "mei: vsc: Do not re-enable interrupt from vsc_tp_reset()"
> "media: intel/ipu6: do not handle interrupts when device is disabled"
> "spi: Fix acpi deferred irq probe"

You may also want to throw these 2 into the mix. I've some hope that
those will avoid the VSC chip getting stuck, requiring a power-cycle
again (they do not help to "unstuck" the chip):

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=5c5d8eb8af06df615e8b1dc88e5847196c846045
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=2481af79671a6603fce201cbbc48f31e488e9fae

>> And do you get a driver symlink under /sys/devices/platform/intel_vsc
>> indicating that a driver has bound to it ?
> 
> With the updated config: no, but I guess the dmesg output above explains it.

Right, the dmesg explains that.

> Sorry for the thread hijack, that's totally fine for me to continue the
> discussions elsewhere if relevant.

I have changed the topic to reflect the new somewhat offtopic discussions.

Another place to discuss the -110 error would be:

https://bugzilla.redhat.com/show_bug.cgi?id=2316918

Regards,

Hans



