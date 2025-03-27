Return-Path: <linux-spi+bounces-7337-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6CAA72C01
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 10:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0272518860B0
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 09:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6DE15B546;
	Thu, 27 Mar 2025 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="E61gGyTB"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B02E3392;
	Thu, 27 Mar 2025 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743066159; cv=none; b=Iwv+J3bgS26CxEuWhzsy1VwGQuiEanYd3OVtsw7MDDNtWKWRBsyTx7jGI/RCu8ScP0oKdM+bbtc4gfyEB/424w6v9FWSooNH7rv34XEGt6r/JHr4BD/Fw7U6SPxsuqAilhmQzG3lrgrxdWiZqS85zLnA66+ec4l3RjU+ZSDR8GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743066159; c=relaxed/simple;
	bh=vXbzMvI8xnmjgKw15kKlhD/TMZJmO6ZSLHM9wefS9+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a/jwEDeR/pX+S4YX3Eqm+FCCopHycHgOK69vB0jVufLE3BgaHCvqZg5uniSQZKt9qWC+WtY0hv/sLqbRwIT9voTX2wyPj17hNRTxXpV00w3ykJukwUAgwWuKsdXMKj7PVhTC2Wsj+bDc4eOATxhGs9V4r6PJaZFPsoaYYRQQr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=E61gGyTB; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 90F79A05BE;
	Thu, 27 Mar 2025 10:02:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=W1RiWtLO8VNQPU8YB74t
	HFSwgOx71KqqDsRGA0ES6vA=; b=E61gGyTBdifXDaAGlQu9TU0t1/vkLn5f1WTf
	kL8PBLD3Az5qSyISZLH806zyRlgvL7Rw7Qm1YLGyz9kC7aFrqcGV9VFPLpwCejTU
	0ezuyDl2ptXmQeWglg6cCEhn4HmSA1vovnVtZ5KRDbz10fnhDw51HjRdMHWBaP2R
	SyvkJ2QDfMQBib6rnPinoi2a/12vilb1ge3X8OgoOF7Ndou9ZvETZD22p/uOtZoV
	+DS+71SHF0E0qJ0sOnM/ntFmYrFvAUYdyH80YxQbqPXGoAsAI/kKPwlnzYxLEGEJ
	TqxGqncaQxKppJ62MuzY/WEJm9XZodBCFXiki26yz4G2/AlA3u0fonjFPPj7CsVu
	2QEN1dQ+PsBp5pLFbjlGeFc8+rZQ6fGUvKdgd+7AI+eFR8wrjwvTZ484E7aklffr
	KeQhOSP/KdGNISl7NNoCpLlgr6KIFzzPOqN7XgKcQF0HDEDE9OeDeNj17YWJmtJj
	78wmNC+OLf0TOoLcWWA2UTditlnM8MHPDXXDXluLxnGv2rB/Fhc+bw9dYaPGB/Dj
	Cu3+I7zwDWb1yClIuuxO2okVo151d7qQuJAKVxMnZm2Q/CkRMoKUbTJ2ATk2PEbY
	XxOWwI6vXod2Hu/w/EESuAgcHKu9J9eTYpOyzknI+wyczNgYmowoUh2bcHZ4gzHU
	i12a8V0=
Message-ID: <3e6d7071-1ba9-484c-9dcb-c5da6ad1ffe3@prolan.hu>
Date: Thu, 27 Mar 2025 10:02:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] pm: runtime: Add new devm functions
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Varshini
 Rajendran" <varshini.rajendran@microchip.com>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Len
 Brown" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, "Alexander
 Dahl" <ada@thorsis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Pavel Machek <pavel@kernel.org>
References: <20250317093445.361821-1-csokas.bence@prolan.hu>
 <20250317093445.361821-2-csokas.bence@prolan.hu>
 <CAJZ5v0hJZBxU6SSq9C8gp2peETFWu0jbhrM82B5GvQkVXPR+9Q@mail.gmail.com>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <CAJZ5v0hJZBxU6SSq9C8gp2peETFWu0jbhrM82B5GvQkVXPR+9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526C7760

Hi,

On 2025. 03. 26. 18:38, Rafael J. Wysocki wrote:
> I said I didn't like it and I'm still not liking it.

You didn't really elaborate further, but now I'm glad I could understand 
your dislike.

> The problem is that the primary role of pm_runtime_set_active() is to
> prepare the device for enabling runtime PM, so in the majority of
> cases it should be followed by pm_runtime_enable().  It is also not
> always necessary to call pm_runtime_set_suspended() after disabling
> runtime PM for a device, like when the device has been
> runtime-suspended before disabling runtime PM for it.  This is not
> like releasing a resource that has been allocated and using devm for
> it in the above way is at least questionable.
> 
> Now, there is a reason why calling pm_runtime_set_suspended() on a
> device after disabling runtime PM for it is a good idea at all.
> Namely, disabling runtime PM alone does not release the device's
> suppliers or its parent, so if you want to release them after
> disabling runtime PM for the device, you need to do something more.
> I'm thinking that this is a  mistake in the design of the runtime PM
> core.

Well, this is the order in which the original driver worked before 
anyways. As a quick fix, would it work if we created a devm function 
that would pm_runtime_set_active(), immediately followed by 
pm_runtime_enable(), and on cleanup it would pm_runtime_set_suspended() 
followed by pm_runtime_disable_action() (i.e. 
pm_runtime_dont_use_autosuspend() and pm_runtime_disable())?

> If there were functions like pm_runtime_enable_in_state() (taking an
> additional state argument and acquiring all of the necessary
> references on the parent and suppliers of the target device) and
> pm_runtime_disable_and_forget() (that in addition to disabling runtime
> PM would drop the references acquired by the former), then it would
> make a perfect sense to provide a devm variant of
> pm_runtime_enable_in_state() with the cleanup action pointing to
> pm_runtime_disable_and_forget().
> 
> If this helps, I can do some work on providing
> pm_runtime_enable_in_state() and pm_runtime_disable_and_forget() or
> equivalent.

I mean sure, if that's something you want to work on, but it sounds like 
it would entail much more work, plus it wouldn't be easy to backport it 
to 6.14.y stable later.

Bence


