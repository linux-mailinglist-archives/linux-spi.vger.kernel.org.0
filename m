Return-Path: <linux-spi+bounces-3867-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4793217A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 09:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4394228111E
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460D84207D;
	Tue, 16 Jul 2024 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="g4XykmCb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe03.freemail.hu [46.107.16.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0FC2BB02;
	Tue, 16 Jul 2024 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116064; cv=none; b=qgyJNrY24O8RNk7XfpWtRlR3u8u8SMSK9v/xE7pQAyTeSdi03yMFMBDl7sAP8oQhHkKa4HtMReS0psxCHh7UuwObHdPb1SWUiBWeiqu2CEMQN2EMfoNsYvbb/RUzmRFpZsWwm4lx2I5Dgb93WF8qO0JP/SOhBkGndp8CvHO219M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116064; c=relaxed/simple;
	bh=WrS+6HvEAJ05DoVBEnz9akUoLCOs+YROndxCK6IfzDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oafD6SpiyO6LnROAiBQZicSK8HRPGbuNcLbp4O1Fj6yzJOpMWHmbXKFD3gpzvmyowiBRyr7367aSFkPtjlbOZKgLeTHakfJkzKNHOa0/U8kv6LRSKT/rNvWwf0KOJz82yZh812+NuZcuDH/OVjOitdrlpleTVt6EeVWi+fBnqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=g4XykmCb reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-188-142-163-175.catv.fixed.vodafone.hu [188.142.163.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4WNWGL52ypz2Rg;
	Tue, 16 Jul 2024 09:41:14 +0200 (CEST)
Message-ID: <8d18306c-8d36-4e59-bc1f-0fc83dd40ca4@freemail.hu>
Date: Tue, 16 Jul 2024 09:41:08 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spidev: add "generic-spidev" for compatible string
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240714202303.164-1-egyszeregy@freemail.hu>
 <31758947-5570-4b20-94e5-52ea77f4f4e3@sirena.org.uk>
Content-Language: hu, en-US
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <31758947-5570-4b20-94e5-52ea77f4f4e3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1721115675;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=1723; bh=p2Dp8KVoU2WSYmYWwdAPbTrM111PMle+diGiaz7JHwA=;
	b=g4XykmCbTIQrclRJ7BbuOjK4qIGAJGsZxc5bRzYFOW185JXhYVcV221jPHhkKNer
	sljj6+usD+uXdqxI6fn+Hlwo9hXKsNukPSllphw8EisOIWp+ycOrG07dcNfC2kvqn8v
	n3N0f1Pf6MOrfZZOSfUVdgum9CnlfbrL/psS/NPFKl7DBF78cGQqGi8LPnHeB6gFeUl
	A35dsLEzQw6IAeplkXyVHAPXo6pTDEyyob+aRePXy4DJbwVbALp8DMNExt3EwDVvpsG
	XRsvjcO0gLKiOaEQAt7aJXPZf7+6NMzLDHvqGEFj/x0QdDqT/XNJEnVVWzykTQTMuyn
	uNnr7wKpaw==

2024. 07. 15. 16:10 keltezéssel, Mark Brown írta:
> On Sun, Jul 14, 2024 at 10:23:03PM +0200, egyszeregy@freemail.hu wrote:
>> From: Benjamin Szőke <egyszeregy@freemail.hu>
>>
>> Spidev is a not an ASIC, IC or Sensor specific driver.
>> It is better to use a simple and generic compatible
>> string instead of many dummy vendor/product names
>> which are all just fake.
> 
>> Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
>> ---
>>   drivers/spi/spidev.c | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> No, as previously and repeatedly discussed the DT describes the
> hardware, not the software that happens to be used to control that
> hardware.
> 
> You also need to document any new bindings.

If DT describes the hardware, yes this is why need a generic compatible string 
for SPIdev driver. SPIdev driver is a typical driver for boards which have just 
header pin for SPI connection and it is not defined what IC/Sensor will be 
connected on it later.

In normally if a developer start to use an IC/Sensor which has not yet any 
driver in Linux he/she should start to make it in a regular way and not 
hardcoding these fake compatible strings inside spidev.c and use it for longterm.

By the way, please send some reference link about the rules what you say for DT 
and please send the link for SPIdev binding documents, i can not find it, but 
you point on it all the time.

devicetree@vger.kernel.org
Please start a normal discussion about it with devicetree maintainers who can 
decided it real what need in this driver code for compatible strings. I do not 
think it is a good idea to append these list for +100 fake devices in the future 
because you say this is the rules for it.

