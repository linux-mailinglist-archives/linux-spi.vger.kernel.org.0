Return-Path: <linux-spi+bounces-2961-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3698CA15F
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 19:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC141F22426
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DAA13A885;
	Mon, 20 May 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="bXIVpLoz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe00.freemail.hu [46.107.16.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418BD13A417;
	Mon, 20 May 2024 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226052; cv=none; b=MUzV8m/ys4WmMKoKmTrhc4lRiNkE2tdpHLYihDWrsAjzA6lWNs+/Nl6dLKruE2M5joGDD4Tgb6UznRY9FQS9lZu/5KBfVbJ2eUDI7Wd6WpgLEhZIEDENGB8/a9KypNeDQfb5KICllsy8cV1pA2hAeRIO5P5tRzu5zRJAnsua87A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226052; c=relaxed/simple;
	bh=hZ9BTpanyVdzRqlVTlS9UoiB+8CRYDf1nsuDDju6yYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjWe3WIT+jwh8GbAI3efVWM7qMPOEBaL6Nc2dvlPC3orxsAv8c7Hj0+tzfE1p2wYsSE3Z0ArRtMIGrOyrnB5S//52fnOc4hDkNqysfudnPS0SaXA+fg/pStQxCngfZUb9Lt27/+TRGYCfMXiB8mdbSpTYaibTcvDKJh2Hg+ka5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=bXIVpLoz reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-80-98-74-198.catv.fixed.vodafone.hu [80.98.74.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4Vjkpp6dq1zqc;
	Mon, 20 May 2024 19:20:18 +0200 (CEST)
Message-ID: <9ae65e3c-f1fa-4ca9-8d74-12d92c51c5c6@freemail.hu>
Date: Mon, 20 May 2024 19:20:12 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spidev: Introduce "linux,spidev-name" property for
 device tree of spidev.
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240519211346.30323-1-egyszeregy@freemail.hu>
 <1ec9e8e5-0818-42b0-8776-d9cfb0585f42@sirena.org.uk>
Content-Language: hu, en-US
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <1ec9e8e5-0818-42b0-8776-d9cfb0585f42@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1716225620;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=3028; bh=cvIOdk4xUZa+dLTqg5VA9e7Melwr8hlOaowEyxAGAac=;
	b=bXIVpLozECHnvAP90I3d0K9994PrGE0swuIbqqeq77SjTOhiokcktCTix+gfkE9e
	8FehBfGyU+zH7ycndbsuXdwKLx5lmG3U6eTo/poY4Ydb0phNaEQFXaBDuHMMSJxbgzK
	uBSR+L7zVqdqyGPXz9eb/JpxRfA1nQ6EFYofVn/AA0tj/T6G3mHFkVq/EgPRHU7/dwP
	y+ZhVCC+zJwTtQDw2Lepwvl3kHllWVf/7GkkHYVa89MSl0WfHyB92+sjhxix9jfzr7X
	VEiEW1lIG1M4NlPx4NFmQOZoA5AzzYI90PX78nNFfx4c/cDECyJeqa3vQ/7nVmEB5EM
	JI+vvv0e8g==

2024. 05. 20. 15:20 keltezéssel, Mark Brown írta:
> On Sun, May 19, 2024 at 11:13:46PM +0200, egyszeregy@freemail.hu wrote:
>> From: Benjamin Szőke <egyszeregy@freemail.hu>
>>
>> Optionally, spidev may have a "linux,spidev-name" property.
>> This is a string which is defining a custom suffix name for spi device in
>> /dev/spidev-<name> format. It helps to improve software portability between
>> various SoCs and reduce complexities of hardware related codes in SWs.
> 
> This seems like what udev rules are for?

Hi,

Goal of this patch is to introduce this new mode to assign a custom name from 
lowlevel device tree to a spidev device. As i know udev can do it, but to do it 
from device tree is the best and easier way for this feature in my opinion.

It is more maintainable then use udev in userspace for it.
For example there are three different SoCs: i.MX7, i.MX9, ZynqMP.

In Yocto project, the Linux image's SW environment is nicely configurable 
independently from what is the target MACHNIE. But if i like to deploy a SW 
which uses peripheries like gpiobanks, i2c-dev, spidev these /dev/... name will 
be totally different on each SoCs, more over in ZynqMP and any other Adaptive 
SoC platform, the index number for the spidev, gpiobanks or other can be not 
deterministic if it probed in run-time. Goal is to easily make a Linux OS image 
which can support multiple SoCs in SW point of view easily.

So, in Yocto project build system point of view the best, if any Machine 
specific settings is stored in the device tree files of the target machine in 
driver levels/config, because it will be deterministic in 100% sure and it will 
be nicely separated from the SW meta layers which may not contains any machine 
specific hacking with udev and so on.

So this way to assign a custom name for a spidev from device tree is more 
efficient and more maintainable in SW developing point of view in embedded Linux 
and Yocto/buildroot world because i need to just define a name like 
linux,spidev-name = "sensor"; then use it with a fixed name in my generic SW 
under /dev/spidev-sensor name. And there are no need to care about what will be 
the index number of this spidev randomly after boot and how need to make an ugly 
append layer for udev config and make it for all of machine variants separately.

My opinion udev is ugly to use for it, and no longer beneficial for new Adaptive 
SoCs where they can be not deterministic what kind of index number they got in 
driver probing for many gpio, spidev, i2c-dev peripheries (you do not have info 
about that which need to mapping for what custom name, it can be different in 
many time based on PL FW). It is much better, safe and easier to assign this 
custom suffix/name explicitly from device tree, moreover it is a driver related 
things, i think the best place is in device tree for it not in a sys config file 
for udev.

DT binding would need to be documented later in a separated patch as a guideline 
mentioned it in Linux repo.


