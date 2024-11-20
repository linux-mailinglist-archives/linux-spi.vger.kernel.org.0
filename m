Return-Path: <linux-spi+bounces-5789-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E39D42D8
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 21:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B06B23420
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D0B1BE23C;
	Wed, 20 Nov 2024 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="wXYqH2Ud"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3D16F8E9
	for <linux-spi@vger.kernel.org>; Wed, 20 Nov 2024 20:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732133272; cv=none; b=OmcMLi19dSbdNkvc9XpzwrOjMwCCHwQtce2kqPu5ba6TVBy+PCy7xRMXPIGwibCT3r4A/6GIUoB253eS7J+AxTwM6OQwJ2I1ULyBncYRgTGwKMPpI4Giz9w8HiJ1zvXIEr93dIH2siZsWBXil60ljUlcA+K2GMEb0blDe1cdcP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732133272; c=relaxed/simple;
	bh=6NiALcqYFGdiKVaIC/04pSsZQQAzn5NTsUogkgdMVbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1Kk0kpVp7xUtnSS7g7xCZ5CKVCvicB4qSACGsKH6IWPZEmLKoDwjUgNA/NqR3lB14FzesxZfawumGw/1Adi7HNbEU0HYfV+5Qoyb6Bgq9PJ10EtMwXMf7kgQL1/DZ1q7x97e6rtDyPubmSuSbShW24Qnb9Gc6g17+P7IRteLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=wXYqH2Ud; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EF6702C02A7;
	Thu, 21 Nov 2024 09:07:45 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1732133265;
	bh=eg4tTMcA3GvqL/n+E8yi2QmwHXKEuoMBfkTqH9wxN+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wXYqH2UdVMYX3Zb0UZp1oyc/F4iTuKwpcbfFwD+7+0R9UxQ/YWwX2uuJrSHcShU7D
	 gXIZPiHvXZ7rhf7t0RFa0vJ5VjFvUx25asBi9A6ox1141kAsBefzcg0U3mffSOrWAB
	 CWX+Zi91KNOluy3MDcA7DOnauVFqscHeELXE9NpGJmRckkGsDtZINQ5sOkyh59rMJj
	 DnWyKMracYCul5tutkZnYdeA6Q7g71+754LIKoLA+vkzEbr65hvDE5jRRcYRewlWfy
	 JHR4+VncYAVOP7sawuwCmwCynYsHYixB3qIuzhx6BbLO3kzRMBXGCPHTkduLofjZrW
	 ElA+1xLHvrQgw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B673e41910000>; Thu, 21 Nov 2024 09:07:45 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id D34BC13EDD7;
	Thu, 21 Nov 2024 09:07:45 +1300 (NZDT)
Message-ID: <2a025df0-825c-43be-aa2a-c785bc6e1501@alliedtelesis.co.nz>
Date: Thu, 21 Nov 2024 09:07:45 +1300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 2/3] mips: dts: realtek: Add SPI NAND controller
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "markus.stockhausen@gmx.de" <markus.stockhausen@gmx.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
References: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
 <20241015225434.3970360-3-chris.packham@alliedtelesis.co.nz>
 <3c6f90bc-2223-447d-9094-81011a2815b0@alliedtelesis.co.nz>
 <Zz2lmMdaz6MFjrm6@alpha.franken.de>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <Zz2lmMdaz6MFjrm6@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gam0nhXL c=1 sm=1 tr=0 ts=673e4191 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=4lPRoJB1Zf836AtMCEkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 20/11/24 22:02, Thomas Bogendoerfer wrote:
> On Wed, Nov 20, 2024 at 02:41:15AM +0000, Chris Packham wrote:
>> Hi Thomas,
>>
>> On 16/10/24 11:54, Chris Packham wrote:
>>> Add the SPI-NAND controller on the RTL9300 family of devices. This
>>> supports serial/dual/quad data width and DMA for read/program
>>> operations.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> Has this one fallen through the cracks?
>>
>> I see you picked up a couple of my other changes for 6.13 but this seems
>> to be missing from mips/linux.
> hmm, I thought I saw some unresolved problems with the other patches...
> But if this is all good, I'll add it to my second pull request.

The binding patch got an r-by from Krzysztof. The driver itself was 
applied by by Mark, it did have a problem but that was fixed with 
another patch. So from my point of view this is good to go (please speak 
up if I've missed something).

I do intend to add a few more compatibles for other RTL chips that use 
this spi-nand controller but I'll do that as new patches.



