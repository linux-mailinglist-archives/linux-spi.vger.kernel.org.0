Return-Path: <linux-spi+bounces-6421-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AD9A1824A
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 17:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E76167DD9
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7871F0E55;
	Tue, 21 Jan 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BF0W4vLB"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19A13BC0C
	for <linux-spi@vger.kernel.org>; Tue, 21 Jan 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737478287; cv=none; b=l2hXSIKErjcFcRvme9VtqAbE2XuyM6TZcozwtmY6ox1aaJvc+o2NZfyj/gXaHyZ8HByWEaWTYkpB8SHjJDQOnX/5SfTrjwkvNr7b2EKqe5/Vzpr96zjcQ+Fw036xfhbR/hxneUItDvBEB0xT4HAcThkLEyDlt8Ten96F16QgaNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737478287; c=relaxed/simple;
	bh=0kqvsuGInuXJkXCmuCX04lAcWyzOGssMeO6D6xEQy+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+Ub8Q+LSoYzjlOYuN14QnwuYYagRRP7IvsXJ/A2D/5qs/QpuQIXsBDy+qN0J7qx5VYmUQmEEZoMxBuWWemKSMpZt9Nn3DLqfuLbTFRcjhE4UJuSFvMbeTcsla87eCGR0pnsJbooUEeyUWWH/YRzWI4L6N9DkEJzni+dgEo1hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BF0W4vLB; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39ad89bf-880e-4ae9-bbdb-4d388dd14a7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737478283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrH1RqYlZPnCONVlyYdJjbHopCl+UukhIId4ykP7g4I=;
	b=BF0W4vLBBIhkOrkCGaWLvh1V9EBK5k05jB3Q5mlXWZUPzl7dB780k3OMzrc6xPWJnhYBAG
	hoTFfqwOgkhlX6rAjDM9FXJCLYK6iNfCkptx52WTh07TvNxurSEqJ5t9unx2zbAPpz3H06
	Za1T6Scpqg2MiECbO3yTeJY6jxTY3kk=
Date: Tue, 21 Jan 2025 11:51:18 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] spi: zynqmp-gqspi: Improve error recovery by
 resetting
To: Mark Brown <broonie@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <5942e111-24ba-4d1b-bd4f-6b81dcc6c5dc@sirena.org.uk>
 <87h65xi977.fsf@bootlin.com>
 <1026d44b-0907-4835-bc95-32f9bbcf4831@sirena.org.uk>
 <8c9e6a12-e64f-4658-94e8-77469f393a0e@linux.dev>
 <c1a3f172-700e-4079-a501-b3f3f08b41aa@sirena.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <c1a3f172-700e-4079-a501-b3f3f08b41aa@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/25 08:49, Mark Brown wrote:
> On Fri, Jan 17, 2025 at 04:46:23PM -0500, Sean Anderson wrote:
>> On 1/17/25 13:41, Mark Brown wrote:
>> > On Fri, Jan 17, 2025 at 07:31:08PM +0100, Miquel Raynal wrote:
> 
>> >> Yes, unless the timeout is reached for "good reasons", ie. you request
>> >> substantial amounts of data (typically from a memory device) and the
>> >> timeout is too short compared to the theoretical time spent in the
>> >> transfer. A loaded machine can also increase the number of false
>> >> positives I guess.
> 
>> > I'd argue that all of those are bad reasons, I'd only expect us to time
>> > out when there's a bug - choosing too low a timeout or doing things in a
>> > way that generates timeouts under load is a problem.
> 
>> There's no transmit DMA for this device. So if you are under high load
>> and make a long transfer, it's possible to time out. I don't know if
>> it's possible to fix that very easily. The timeout calculation assumes
>> that data is being transferred at the SPI bus rate.
> 
> In that case I wouldn't expect the timeout to apply to the whole
> operation, or I'd expect a timeout applied waiting for something
> interrupt driven to not to be fired unless we stop making forward
> progress.  

I don't know if there are any helpers we can use for this. To implement
this we'd need something like schedule_timeout() but where the interrupt
handler calls mod_timer() whenever it does work.

--Sean

