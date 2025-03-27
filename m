Return-Path: <linux-spi+bounces-7349-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE6A73667
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 17:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E857A3C0C
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0279119CC11;
	Thu, 27 Mar 2025 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="gF+WV++Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029F7E9;
	Thu, 27 Mar 2025 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743091899; cv=none; b=gJbeL/3alAVE3M4afOsOkTXJN/IgrzXrPzU9EX95sWdXKHvVE0VZQvQWipjyBnGVvJI+bgLJKJfRGoEqg4Tff8nLF9I1lIxtn/I27zgKKrtIuqiN4m3jMYLNGrsHGd0adRIgI/btQNs8C4z2sFweRLYeRossZq8tdf9pY584C3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743091899; c=relaxed/simple;
	bh=BzzrJ79e4VaP/rWh74LJKOWYu9gwJBEyiYSvS2rW33s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ifKkzrdXfKKrl2QN29u4HIMWOioJ6mk4RhV3c4J6BX47uuY/C3S6TQGKmuClVYTZiqI6dTSrToF/6IFKJf3QJnzfrj9DQqf4YcNw/oKWy/LpfwyEEzRtRU1Mj84F0U9FSwNcaEIRAuVq7MQrgy1J5jtOkeV87RQUacP69skl8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=gF+WV++Z; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 364C4A0BF9;
	Thu, 27 Mar 2025 17:11:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Cfcxu0sFDt25T4HE+Z+C
	QUKV/MoRpGB/hgvYzRHCAGI=; b=gF+WV++Z6x+CTx8iHxNPG6AW8cN06hUy3NXR
	A5rWWYT1XYCcytzTkQvRJLRAs9AoiFvMROELzM7ICCBy7Ep+GvIE/TpO3mIsdYlR
	WDWT9Bdewa7JwON1oT34SkEaiU5Pc08DIxMtrfPzDO/HI7ZhRcggRbOw0sh19Q33
	KEtIZEPYEJlNCb3BYYBaSVrD3+FvOhqfmDRWdVrbLT0oes5a7nLyUM++Amnewh5y
	6iDiP7uhhF0EEZpqLhN1kyzX99LIOMbJV33D4GeT+MR0QHFo4fDsHixRZLwpsLNh
	gw459/KQV+V8l/Rq+yfaUFF4RMmnXGY6bf7TUWmDkn6kpWxwE/BLlesksxh8fxEr
	tOnF2EX+oirKYTfHure+/+quqUP9GmTVDBh5Pp0s76jr8y0oC16G7menfczU8kvA
	YZ26mnlkle4XkE3TbiCrHiq+sQJMtqc4YAKjnRI0JdLqnZG0yBirktXNy2phjt4Y
	Ak/OtR1AudC1GHpuvQMWyc+apm2F6HXjHA3z+rSB7RBK8N+3t7ysFuNYyFVnzR1/
	eOjGxWrf8qnBojyZA6DBcwA/n+RDN5lOV+Mi3rpDGb+IEuD6DZsAZk+XhD3HyjWM
	GCBrcwFhh0PJWFFjxsY5W0WPQ9DAsOC9ep1CFjSEeaZG6Xg/RuZOItOLpD6Hrio6
	kO8psU4=
Message-ID: <bcf363db-8fff-4fb1-b29e-300f7b8bc090@prolan.hu>
Date: Thu, 27 Mar 2025 17:11:29 +0100
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
 <d926d2c2-8cc9-4a71-b8ca-b5f03ac9afb8@prolan.hu>
 <CAJZ5v0iS20uPhqNOnkj36rTBGQF3fecF6Hq4JU4=wz4pSzrFyg@mail.gmail.com>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <CAJZ5v0iS20uPhqNOnkj36rTBGQF3fecF6Hq4JU4=wz4pSzrFyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526C7764

Hi,

On 2025. 03. 27. 15:14, Rafael J. Wysocki wrote:
> /-- devm_pm_runtime_get_noresume()
> |   /-- devm_{pm_runtime_set_active() + pm_runtime_enable() (in this order)}
> |   |   pm_runtime_use_autosuspend()
> |   |
> |   |   Note that the device cannot be suspended here unless its
> runtime PM usage
> |   |   counter is dropped, in which it would need to be bumped up
> again later to
> |   |   retain the balance.
> |   |
> |   \-> pm_runtime_disable() + pm_runtime_set_suspended() (in this order)
> \-> pm_runtime_put_noidle()

Ah, so basically what I've done originally, just calling 
`devm_pm_runtime_get_noresume()` _first_ instead of _last_, right?

> And pm_runtime_dont_use_autosuspend() is not really necessary after
> disabling runtime PM.

It was done this way in devm_pm_runtime_enable() already, see commit 
b4060db9251f ("PM: runtime: Have devm_pm_runtime_enable() handle 
pm_runtime_dont_use_autosuspend()"). I didn't change anything 
behaviourally there.

> Also, I think that the driver could be fixed without introducing the
> new devm_ stuff which would be way simpler, so why don't you do that
> and then think about devm_?

Sure, I could quick-fix this, go through all the possible error paths 
and whatnot and ref-count in my head, but it doesn't fix the underlying 
problem: in order to properly use PM, you have to do a bunch of calls in 
some set order, then undo them in reverse order on error and remove -- 
exactly the thing devm was designed for, and exactly the thing where 
it's easy for a human to forget one case by accident. Thus I prefer to 
use the *real* solution, devm.

Bence


