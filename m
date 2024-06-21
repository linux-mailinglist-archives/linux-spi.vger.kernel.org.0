Return-Path: <linux-spi+bounces-3522-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB8911E85
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 10:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC7228262C
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 08:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50F16D9C3;
	Fri, 21 Jun 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="evd2eRBz"
X-Original-To: linux-spi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF116D9AC;
	Fri, 21 Jun 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958092; cv=none; b=HCN1W6tqB2tK+UGVX1EmqU4EYkb781WBdHSFANVsXjARnr6uORLG90Ei/TKgTMn31q30ZKwIPGvJ7bQrQf+EkjtnuEhbxwyKoq03Dp3HjgYI37wAgp0qRh8n7bIgYSj378bUYmyUoACd3B52JI76LPZ6BdwyLni13uEprhZmNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958092; c=relaxed/simple;
	bh=K+R2RKmiuFqLEon+vHwnwnwqTqmBWoIoUN07WehQFFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlKmj1oRfdwATKoTwByzta/1UUB7/gjI7SZWMWobE2Ar1XN+h3wspr5Ws2Zo29nHF2gn1ZKmP+VbnPE8E/2ugMmfnC4CiVbwbXtmvmzTUY5WD3HyfI50oIOhOAQP2Snutkjf/uzYlC0G0aljaoD116r9i1qwHf53/uhYHuCfbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=evd2eRBz; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=C7AamCqstwrWaOAl+kCPc5rixsS4G4AQ56sFqgwTcz0=;
	t=1718958090; x=1719390090; b=evd2eRBzbrXEYrumqIhIv1mDubpM7/ZAsCYCSZPL3oyVckd
	368w382J+GUjMiabds0W4wxf+ISIMARA8qKNvhiB7ElBTVhL3ZGmpe+F5sDLKD0VyrvxTYFEsoUy3
	ZExR6QYSTmtFzpm0R2HsUViK1KP2S5ZjllLM6dq3UC8osxrhM3qrED2xZjXtCihP3RquRjYNM15rx
	mf8WID3N4T7xQGFkSnA+EhlFi0+t0ri3hMPAb99fHl8rQTkalLxM0KfVEQb6ap7Bgv9CB1YRP2N5y
	tmFCHW1Wk2YOTnOewiqSTe5cBgXqgU/1Mxzg08PTPC1k8fhFUPuoJaiIFDCGlKNg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sKZWQ-0005mj-Vr; Fri, 21 Jun 2024 10:21:27 +0200
Message-ID: <acaf2d70-d821-4951-9072-931cb56b1b9f@leemhuis.info>
Date: Fri, 21 Jun 2024 10:21:26 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: omap2-mcspi multi mode
To: Colin Foster <colin.foster@in-advantage.com>,
 Mark Brown <broonie@kernel.org>, Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 miquel.raynal@bootlin.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <Zl/V0dU6SjAMkpLG@colin-ia-desktop>
 <ZmFt7yfZFFJdsZuJ@localhost.localdomain> <ZmJ7E305ow91ez2U@euler>
 <ZmMrJ8uaw85a03Ce@finisterre.sirena.org.uk>
 <ZmhdWw/dV5HRU/Nh@colin-ia-desktop>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <ZmhdWw/dV5HRU/Nh@colin-ia-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718958090;66025cb3;
X-HE-SMSGID: 1sKZWQ-0005mj-Vr

On 11.06.24 16:21, Colin Foster wrote:
> On Fri, Jun 07, 2024 at 04:45:43PM +0100, Mark Brown wrote:
>> On Thu, Jun 06, 2024 at 10:14:27PM -0500, Colin Foster wrote:
>>
>>> So I think the question I have is:
>>
>>> Should the CS line be de-asserted at the end of "spi_write"?
>>
>> Absent bodging with cs_change after any spi message the chip select
>> should be left deasserted.
> 
> Do you have hardware to reproduce my results of two spi messages no
> longer toggling the CS line and leaving the line at GND through the
> transactions?

Hmmm, I might have missed something, but it looks like nothing happened
since that exchange. Did this regression fall through the cracks or can
I consider the issue resolved for some reason?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke



