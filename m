Return-Path: <linux-spi+bounces-7341-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B6CA7334F
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 14:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2A6188F834
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA5E215044;
	Thu, 27 Mar 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="T2v/kcmB"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334121BC41;
	Thu, 27 Mar 2025 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743081877; cv=none; b=GrnRGW/jb7QOtLrHe858kKP3M5eACn3E/M3zKcnl10pO8rmyByLtaXbCoDFyT8E+hMLcM8aOblPqF+g7dJbzvTA5B7I/YUYU5hNy6+Riadhe5zb65Osf/traRyQW46maeyzyTLiIJFHCA+olA89vCAP3WsBC3wSdMCVIxp+OThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743081877; c=relaxed/simple;
	bh=sY6FV5/uKBCe6AyMiZCOLlHCJID+Ian9uQiSoj3WWWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HzuJQ/OigmYqm3aDXioTzoF7wjmR7rRo7bwXby/xIUF63CbE8h2/JpISn5+m0DkR+/AOdOp1kHXC0eMoLTR5Bxbp5S2e/NcLI0eXuy4yQ12Na8F02joanzKCym/nGgBW4dYDUdo90PURiedlyv2U2yW23+fAODWp9Qi9FLJncls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=T2v/kcmB; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 43674A0796;
	Thu, 27 Mar 2025 14:24:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=tPQ5Rb+uDwVDwRdIPGfF
	+58tdlTfGsVmd3yos4V09g8=; b=T2v/kcmB6tFbyuMu5NwmyUBgQSYcIZKoLVvT
	oKdfDBwuWwd4mEaI427gIs6DV11zNLJqBlNPkTB9q9VCSbGoKQeTgrOwT7pHo7HW
	XV/aWJIA2l/KtrQPr93rwrfzoR4jPfCNPRYyqO488WRHxe53iuk+QI9fYjXnJPFs
	EU5v8tOejto2U2l7GGUVyQ/5tPvPWN58lJKONcUFQKLjZFrTikFLcHvacHfSj8na
	6E6mMKWQaSFwkTqdogWkpHOXieAF1mlON2XkbEdsZ+ZSqG9lkRZ40DnkVr7alnKu
	jwFnQMY3U9ulEYHW/h6P7sItZibRIllIGHAMf6o+JcWNY7eOQJLvoq1FH0PISx5u
	S5tvsFJ8olJ/17CZ9vyv5ggtr7I5hw2hnyDMjVgFr0X0FKtDkWFnwkNX39065bHx
	6McZHOM0D88TSlA9qGKNev5v0qtiZfD/Z/X8wwjo90USD6Xo9wbFgyoJx5iEmQCn
	yJV8Z+Xkzgbq5Z9AD/iEgJGJO6T99nJjGSqsUIM2J5ysC+OX5KPq1BUCbLXwOREc
	a+uCIKoD8GtLJ06TpNDepzG9A1DZPgwW89JlnV5LA2FOOeW7W6sQxC4tJXlNjfTg
	LpuEFSuLYs/B7MGNgsBDjFV30EQa7a+Q312BfYb8uP4XQp4/pfKpttQOfnAoGPd4
	UkLAqw4=
Message-ID: <d926d2c2-8cc9-4a71-b8ca-b5f03ac9afb8@prolan.hu>
Date: Thu, 27 Mar 2025 14:24:28 +0100
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
 <3e6d7071-1ba9-484c-9dcb-c5da6ad1ffe3@prolan.hu>
 <CAJZ5v0jka2r9PaKsF0FE2qJaFfnVNGd8sZRE6Aay-Ugpzot44w@mail.gmail.com>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <CAJZ5v0jka2r9PaKsF0FE2qJaFfnVNGd8sZRE6Aay-Ugpzot44w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526C7766

Hi,

On 2025. 03. 27. 12:08, Rafael J. Wysocki wrote:
>>> Now, there is a reason why calling pm_runtime_set_suspended() on a
>>> device after disabling runtime PM for it is a good idea at all.
>>> Namely, disabling runtime PM alone does not release the device's
>>> suppliers or its parent, so if you want to release them after
>>> disabling runtime PM for the device, you need to do something more.
>>> I'm thinking that this is a  mistake in the design of the runtime PM
>>> core.
>>
>> Well, this is the order in which the original driver worked before
>> anyways. As a quick fix, would it work if we created a devm function
>> that would pm_runtime_set_active(), immediately followed by
>> pm_runtime_enable(), and on cleanup it would pm_runtime_set_suspended()
>> followed by pm_runtime_disable_action() (i.e.
>> pm_runtime_dont_use_autosuspend() and pm_runtime_disable())?
> 
> On cleanup you'd need to ensure that pm_runtime_disable() is followed
> by pm_runtime_set_suspended() (not the other way around).  Also
> pm_runtime_dont_use_autosuspend() needs to be called when runtime PM
> is still enabled.
> 
> With the above taken into account, it would work.

Ok, so which is the correct order then?

1. the way it is done now in [PATCH v5 2/2] (which is the same order the 
driver has been using before anyways):

     pm_runtime_use_autosuspend()
/-- devm_pm_runtime_set_active()
|   /-- devm_pm_runtime_enable()
|   |   /-- devm_pm_runtime_get_noresume()
|   |   |
|   |   \-> pm_runtime_put_noidle()
|   \-> pm_runtime_dont_use_autosuspend() &&
|       pm_runtime_disable()
\-> pm_runtime_set_suspended()

or,
2. swapped set_suspended() and runtime_disable()

     pm_runtime_use_autosuspend()
/-- devm_pm_runtime_set_active_enabled() [new fn]
|    == pm_runtime_set_active() &&
|       pm_runtime_enable()
|   /-- devm_pm_runtime_get_noresume()
|   |
|   \-> pm_runtime_put_noidle()
\--> pm_runtime_set_suspended()
      pm_runtime_dont_use_autosuspend()
      pm_runtime_disable()

Bence


