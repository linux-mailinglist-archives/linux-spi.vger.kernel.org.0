Return-Path: <linux-spi+bounces-4344-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC42962077
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D367B23CB8
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB947158858;
	Wed, 28 Aug 2024 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="T6pw5Tjz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m32125.qiye.163.com (mail-m32125.qiye.163.com [220.197.32.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CCA157494;
	Wed, 28 Aug 2024 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829351; cv=none; b=ryhnv2qSs0C5NVGf5ksqdu4t3QlC8xyHKJTADJzjNtCqd3p5BOmW/Umf/JH34gVpxUsziGrd1EBVJ8S6uguQO7Lfnlj55ufEHjzuMeGG3Pl+e41aefYPzGjrx7L/f/wUBXFIEHgeikTLsd21D73SS8ks1MK6KOg7GvGBmbqlqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829351; c=relaxed/simple;
	bh=2DRei0xh8IG3dHnQTrRRgM27hc7usdtRTZxdpRVqL/k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sJvFZsbrxTr1CydU1QuGf+1bzHbEVJdXu9MfeJMFb4yOukLsll3ix5vbJ0yILO+hpbm52MvPs4nhkCAhWiqInwflmoDQEY2FWy3axmByLhV2oyLQ0VQvzvbrTKlvJG+b1OT4+xIfgHkgKEzMC0Sq2QywI7WLvVho9fRMuDtnVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=T6pw5Tjz; arc=none smtp.client-ip=220.197.32.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=T6pw5TjzhkZeoM9+vE5+txJeWtc6GR/CltdCCFq6j32BF3wX15KG8FSgGvtpKX6Sgw+G51nl9HND1vNQSVM7DAKy1ZwVYJNqDk5aRfp7pMU6GybiGtnbMJUWwo6NcSxWq5bxAJkE5XQiKya8Fb/7gGLqXd/cPNtrcmH+r0nMpN0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=VRUuy/rQsF1UW0Wpg+PnWZ4+AI6Wx/jDa7V8CDPYisg=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.28] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 6D59F6E0AE8;
	Wed, 28 Aug 2024 15:09:08 +0800 (CST)
Message-ID: <c5726963-69a6-47d8-a576-86cebd481ef2@rock-chips.com>
Date: Wed, 28 Aug 2024 15:09:08 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jon Lin <jon.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip: Avoid redundant clock disable in pm
 operation
To: Brian Norris <briannorris@chromium.org>
Cc: broonie@kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
References: <20240825035422.900370-1-jon.lin@rock-chips.com>
 <Zs0BRsNdZdI69aXM@google.com>
 <27302919-5bcd-4bcd-bdad-02aa48e628e9@rock-chips.com>
 <CA+ASDXMjN7dVUQWgfMULcD2KgF448-q=Ue2+MYUftK6Ra8MWhw@mail.gmail.com>
In-Reply-To: <CA+ASDXMjN7dVUQWgfMULcD2KgF448-q=Ue2+MYUftK6Ra8MWhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlKT1ZMS0JCHkgfGEIdHxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
X-HM-Tid: 0a9197d1194609d5kunm6d59f6e0ae8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kzo6KBw6TDIxHhcUMClMKTcr
	DDZPCwNVSlVKTElPQ0lDQk9CTktMVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFIQkpLNwY+

On 2024/8/27 10:59, Brian Norris wrote:
> On Mon, Aug 26, 2024 at 6:33 PM Jon Lin <jon.lin@rock-chips.com> wrote:
>> On 2024/8/27 6:27, Brian Norris wrote:
>>> It seems like you'd really be served well by
>>> pm_runtime_force_{suspend,resume}() here, and in fact, that's what this
>>> driver used to use before the breaking change (commit
>>> e882575efc77). Why aren't you just going back to using it? (This is the
>>> kind of thing I might expect in your commit message -- reasoning as to
>>> why you're doing what you're doing.)
>>>
>>> And in fact, I already submitted a patch that resolves the above problem
>>> and does exactly that:
>>>
>>> https://lore.kernel.org/all/20240823214235.1718769-1-briannorris@chromium.org/
>>> [PATCH] spi: rockchip: Resolve unbalanced runtime PM / system PM handling
>>>
>>> Do you see any problem with it?
>>>
>>
>> I have reviewed your submission and although the code has been
>> simplified, the execution efficiency has decreased. So although it is a
>> commonly used processing solution for SPI Upstream, I still hope to
>> retain a more efficiency approach as I submitted.
> 
> What do you mean by "efficiency"? You mean because there's
> indirection, via the PM runtime framework? If so, I doubt that's a
> priority for this piece of functionality -- simplicity is more
> important than a function call or two when talking about system
> suspend.
> 

Your code is fine, and I have tested it locally. The interface 
simplification is indeed in line with the direction of community 
development, and your solution can be used as a solution.

> Additionally, simplicity has additional benefits -- it heads off
> questions that your more complex code doesn't address. For example,
> are runtime PM and system PM mutually exclusive? Do we have to
> coordinate with any pending autosuspend? (Reading through
> https://docs.kernel.org/power/runtime_pm.html, I believe these are not
> actually concerns, but it's really not obvious and takes a bit of
> reading.) But your patch makes it more likely that runtime and system
> PM states get out of sync.
> 
> Anyway, if the patches really are equivalent, I suppose it can be the
> maintainer's choice as to which is preferable.
> 
> Brian
> 




