Return-Path: <linux-spi+bounces-7573-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1D6A8855C
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 16:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A25C567333
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5962C1E13;
	Mon, 14 Apr 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="t9pCPRQ2"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC727FD7D;
	Mon, 14 Apr 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639335; cv=none; b=F1+6XPkbiQr45XjqDchGSGUjQKZVaXu5Nsg1ueW+TnV6fF7capHEsQ3OvkUbcMhj7zBS0gxnideduSzlRtAtWzCA0xtguyjpevfQSHoAdnfewX1jEpRae0mDAfRpL60y4Ia3rOPWcZaPZ3F/cjIBhXont/MpWF+Wbhao0NzVyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639335; c=relaxed/simple;
	bh=CndQFGuLnQ703+fOAOJDmmHIDhuS/2SEJT3iDiK/hvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xf9S0Ler6W4VNGoMqKB/f7064MxTKWW9aw49ET07mo//ikBfl1hLxe4mftJzpAelhwHxtpe+Cef4SY4GcxRQD/+uBJKlnQQSI8+xLzzPJ2ebnlGCjPLwPh6jG7tBrvDGi4sJuo19mp57KWSY+bYzijMnrJvCFnxoqddpyg9nVD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=t9pCPRQ2; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B451CA0370;
	Mon, 14 Apr 2025 15:56:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=8fUTt49ngH9LwQeutmpq
	Atan+y77TmFvSLDx00ftJms=; b=t9pCPRQ2tmxUZmdzLFDzbVZeoRtXZjDfgQoU
	JMJpuozYaayHGe5M8rtZeul0OU/+F9X4CpMRAVyMFQFkPO7wR8zzEFtkI74Ye0dI
	ADOz7gwLOQPJeZujzuajq635AW7etk4of6jaKUDWUnjyUgcgFHA4wFSlBn/Wema8
	h8PFPH2UyOzNqCyjL2KDQXPqbCYhed4NZ+0Rdyx3IVfp7MVupbKlIeo055aR5zyn
	HiCcr96E4uWhI47L71f0twy8JsoxjMausdIw6mCa8yjWiEtCvWdk6CGx7J6CHx0T
	3vuIVBNAzb4osY94mucmeauKFPNuFOfSdxzd9dJ8utOPILJ/OE8X5nPlPxMHeiMC
	wVXUT1b961oG1BveaAZz2BIctqzdxleO5HU5r+7ayNSEvR5IdBqo6C18d17+1q/k
	6OfkDYosROTg7TUakxHUyXJ8/R5NGwv3dJcEYDWEujln53H1zsGk5oI6J/J0KlkT
	D6Sfd2ElQtNUWMqubsWtaD+9X51Ux5MhtelheK6OGoHUbcfr/RTY2UgGmTWZJrVd
	zrgeq4F2WGqcvULyHEHgHmQqicc3w6dcEJqT07jV+Rc7UpvLaUahU8thqM5ebD+i
	PQ0nPK8VdUJDejG2Hffd2qnwkKH5+R/XbwdIHNuP1hKpkDZkJbL0w8fkZJkLUI+F
	Y3cED88=
Message-ID: <832eb5e3-7e2d-4ed2-8571-eca9fe129013@prolan.hu>
Date: Mon, 14 Apr 2025 15:56:47 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] pm: runtime: Add new devm functions
To: "Rafael J. Wysocki" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Varshini
 Rajendran" <varshini.rajendran@microchip.com>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Alexander Dahl <ada@thorsis.com>,
	"Nicolas Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Pavel Machek <pavel@kernel.org>
References: <20250327195928.680771-2-csokas.bence@prolan.hu>
 <20250327195928.680771-3-csokas.bence@prolan.hu>
 <CAJZ5v0jmuzvo-xzGBDhGVBbY7svbrqEdi-SeJrx5BG=qtN6ZiQ@mail.gmail.com>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <CAJZ5v0jmuzvo-xzGBDhGVBbY7svbrqEdi-SeJrx5BG=qtN6ZiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94853647464

Hi,

On 2025. 04. 09. 19:43, Rafael J. Wysocki wrote:
> On Thu, Mar 27, 2025 at 8:59 PM Bence Csókás <csokas.bence@prolan.hu> wrote:
>>
>> Add `devm_pm_runtime_set_active_enabled()` and
>> `devm_pm_runtime_get_noresume()` for simplifying common cases in drivers.
>>
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> 
> I can apply this one alone if you want me to do that, but I could also
> apply the other patch in the series if it got an ACK from the driver
> maintainer.

I think you can apply it and then Mark can apply the SPI part to his 
tree. @broonie what do you think?

Bence


