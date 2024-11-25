Return-Path: <linux-spi+bounces-5828-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694B9D83FD
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 12:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03AEEB21950
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1818E37D;
	Mon, 25 Nov 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsahSdlA"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26A18F2D4
	for <linux-spi@vger.kernel.org>; Mon, 25 Nov 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529122; cv=none; b=i/3/0TrfMNTQtHeB9jFY26e8uPFZVEyfG+s1x/uDiVwZHc6hO5WDvoWIiyQ9Iqg3NyUSTSopyP459AckhlaAn6d4THpzub9JZzhwepA5+KMHE+pZLaGAUnH7N7Ymdn7d/PVipz7rObgbYgD/F+2fGSfUjDItXBwIQKRY8ljUkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529122; c=relaxed/simple;
	bh=3MWuG1ZzI3OgQIeB1y60nJdAC5Drf10sZu6qTYREd5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ta8eANppKvfC4pxv6KZfLRaNvXH9O8/unP8bS4YlQaAU9tbalgmSDvRg8cxdEprRYTyxRv6JYLa2s9eaVhtQTepS/BJUxqtIBbZqoFoIhCoBU87T6s41yn7MCyXW73jov9vm+e9UlsQ4A05ZuG/YGarwOr7u3mbYD2lqb42Vw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsahSdlA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732529118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVywh4e/koy/A61wMhqhkS+jZia4vcqxwXw5dmCqj94=;
	b=dsahSdlAhj01XwbdpPoq3X/flKK/TQWORGffFA1pMPusuCoYW2ukpI51F2xH8bc7dUsUQV
	WmQi7b2k/8TtZtWb6Iq79YYkkdVlHhi6KJRVanY8W/dId3uv4OVDafx1YBf4EgzLoluwtt
	n8vcKmf1SJ8fHZg83DOezQhFEwS/Kl8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-34tj5rDuOdq_SdA56OUdHQ-1; Mon, 25 Nov 2024 05:05:16 -0500
X-MC-Unique: 34tj5rDuOdq_SdA56OUdHQ-1
X-Mimecast-MFC-AGG-ID: 34tj5rDuOdq_SdA56OUdHQ
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5cfca7e901cso2871906a12.2
        for <linux-spi@vger.kernel.org>; Mon, 25 Nov 2024 02:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732529113; x=1733133913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVywh4e/koy/A61wMhqhkS+jZia4vcqxwXw5dmCqj94=;
        b=VaY2EPMJGT9I9asNAT/RF7+ykG693hBcP1zhXXaX6EhL+CohDJTBjPDbWvMiGKgOIf
         kdc380/7GXAZeb7DiI3L/nfPsDvXhCjC7iokKtgvzS8e8LOLwtdTLuID4pPq4M3MnnGJ
         EH9l7DQm6ZAvbPzvLytaJg/SN0sZ7w/KxazSmV3VFJIBMf8lFx77bkYHPuj3Y12XYQ9a
         o78tVZXJvaAakyKRqDg6mPUF6+UA5x3JRFTO1QdC89B9kkso1IncaAED5+q85LuVz+ag
         AzC73gRb0rFC5imWBsT3BGAx+lTzdaU6ABchpIlmVPOjGp4phDwkEa7dkLD3jWY5Hu3M
         sdpg==
X-Gm-Message-State: AOJu0YxQk/7bhPPSszi/b75L5m8c7NkZyENnLazqRGrDijoj56XW3SRw
	OkvlIhIiU4ahscxXV/ljqTY7bJaB3qxlAuP4TB13A8ofLm2cj8XRHpD/oNAvjbJ54n0+UWJUARa
	NZ8EucHewR+VkPKa1nXBtBdlcAHokFhhFqn7eZWU2xZLqUBPqtOnY/RaN1w==
X-Gm-Gg: ASbGncvZkTi0pWrPXOambiTPWdg/DIcPvSSsytYpaH+hNCGGrvWS3Oa/msgI5VN4NkR
	YDnsFyRoOUXMLbJjbiq79T21e+gXFa0uMDHdGAU0k7FZse7QrXHKPcmnTAZlJI2nQl0he4O5HBP
	u6X4qwygt3666/06Rp5Hy/1ZFJZ2PjhljYuZKeTtjtnPjy3J7HuTdPX+1AizybJtTjjh0TOyxmY
	Z3vA48YXvzhSCHpv8jPLFddMhS+fwTHUO6XrH6LQqQzLwiykwfzAZ5gEFjlxfhyAE230dsjoJI4
	msZkI8VdwVJtAutsgADpwpCqvVo+YGv5xXMhxb2EulreXfPtNkuOjMjgpVPaOripYb92tz7EN09
	dk/ddFmPHwEQgUTNK31bOhyLc
X-Received: by 2002:a05:6402:35c4:b0:5cf:a830:d84f with SMTP id 4fb4d7f45d1cf-5d02062549bmr12185300a12.15.1732529113072;
        Mon, 25 Nov 2024 02:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxHwFq1yE1cp0uPGlTCJyz8QPTgdcvf2Eya8gY6m9HYa378OGDo75KZqTKdUnvb75SJ+zt9Q==
X-Received: by 2002:a05:6402:35c4:b0:5cf:a830:d84f with SMTP id 4fb4d7f45d1cf-5d02062549bmr12185275a12.15.1732529112660;
        Mon, 25 Nov 2024 02:05:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3a2dc5sm3976752a12.14.2024.11.25.02.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 02:05:11 -0800 (PST)
Message-ID: <3ee5e7bb-2f54-4051-b36b-5e2d4be7cd42@redhat.com>
Date: Mon, 25 Nov 2024 11:05:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: Fix acpi deferred irq probe
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20241122094224.226773-1-stanislaw.gruszka@linux.intel.com>
 <D5UNKGVDHH2G.308OGWQSNXP21@bootlin.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <D5UNKGVDHH2G.308OGWQSNXP21@bootlin.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dni8-exu4ePyPMfmTKQRGBNPxkLLeukXB5toMpmd-Hw_1732529113
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alexis,

On 24-Nov-24 8:23 PM, Alexis Lothoré wrote:
> Hello,
> 
> owning a Dell XPS 9320 and struggling to make the freshly merged IPU6
> support to work on it, I was about to send a call for help on the media ML,
> when I eventually spotted your observations on Redhat's bugzilla ([0]), and
> this corresponding patch.
> 
> On Fri Nov 22, 2024 at 10:42 AM CET, Stanislaw Gruszka wrote:
>> When probing spi device take care of deferred probe of ACPI irq gpio
>> similar like for OF/DT case.
>>
>> From practical standpoint this fixes issue with vsc-tp driver on
>> Dell XP 9340 laptop, which try to request interrupt with spi->irq
>> equal to -EPROBE_DEFER and fail to probe with the following error:
>>
>> vsc-tp spi-INTC10D0:00: probe with driver vsc-tp failed with error -22
>>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Fixes: 33ada67da352 ("ACPI / spi: attach GPIO IRQ from ACPI description to SPI device")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> 
> [...]
> 
> I systematically observe this issue (probe failure with -22) on each boot,
> and reached the same intermediate conclusion (IRQ failing to register, and
> spi->irq value being -EPROBE_DEFER).
> I can confirm that this patch makes the vsc-tp -22 error disappear on my
> machine, and that I have now /sys/devices/platform/intel_vsc.
> 
> Unfortunately, I now encounter a new issue preventing the camera to work
> (ipu6 still fails with -EPROBE_DEFER, I now have
> ipu_bridge_get_ivsc_csi_dev failing while searching for child device
> intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da).

This sounds like you may not have the actual MEI driver enabled or
that it is not binding.

Do you have both CONFIG_INTEL_MEI_VSC_HW and CONFIG_INTEL_MEI_VSC enabled?

And do you get a driver symlink under /sys/devices/platform/intel_vsc
indicating that a driver has bound to it ?

If not any related messages in dmesg ?

If yes what is the output of:

ls /sys/bus/mei/devices

and of:

ls -l /sys/bus/mei/devices/*/driver

?

Regards,

Hans





