Return-Path: <linux-spi+bounces-6410-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371F0A1592D
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 22:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E430188C7BD
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 21:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C84198851;
	Fri, 17 Jan 2025 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uK1wSFOo"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F061A83EE
	for <linux-spi@vger.kernel.org>; Fri, 17 Jan 2025 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737150404; cv=none; b=SPk7cjvdREskEfrIYVF4a57qNwYfFbdPdAv8plgZccfINBWsFt7ROlLqxcCqLQIRZYi/8kfdGEDTahRkI+fEhiXrRQQX/jQFtYe59cvhJu6ZF146odfhg1PaJCulLPuOaVC96txTokX61zM7jVeHOirSwAXFgxjLKMDQOfcke9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737150404; c=relaxed/simple;
	bh=5KSb2aqbLM5tvKNqVDwZd4EtPtJ9QaF/TAK22Rk/27c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHoqd1izq9gpsQdT7o+OZ3KY0iJhgNk1GjTaApPV50uvJW0uOjK93jJ6kOSTgomvPft9AlulLgZY1GJzjFwGyEmAjZC61Ee7ugAJHbDuNQqLB62TIYgYJ9TR7VRyNte+ndC3CRwOVK3EArxLLYoCpk8rLEC2bsUGT9wXyOXtGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uK1wSFOo; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c9e6a12-e64f-4658-94e8-77469f393a0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737150389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAf0cQEhbeq9uQn2HgBxJwToemXIDO+RTwUH+VMF7LE=;
	b=uK1wSFOoJ9c+9g/m/XG1HVsnP6alX8ieCy4PrcuxpIKWs5YnuxnT64mQ2qBUqvi8DkmqyD
	VK0P2Nl5SczZOcYUF+vTT93a/jtrPPypdcz/ErkE/9hf6uPZpCakuUJWwx2xi6yIDmbM/q
	zwu8IHvKLes80K/irnBdxtm32rStltU=
Date: Fri, 17 Jan 2025 16:46:23 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] spi: zynqmp-gqspi: Improve error recovery by
 resetting
To: Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <1026d44b-0907-4835-bc95-32f9bbcf4831@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/25 13:41, Mark Brown wrote:
> On Fri, Jan 17, 2025 at 07:31:08PM +0100, Miquel Raynal wrote:
>> On 17/01/2025 at 13:21:58 GMT, Mark Brown <broonie@kernel.org> wrote:
> 
>> > If you're hitting a timeout that tends to indicate there's already a
>> > serious stability problem...
> 
>> Yes, unless the timeout is reached for "good reasons", ie. you request
>> substantial amounts of data (typically from a memory device) and the
>> timeout is too short compared to the theoretical time spent in the
>> transfer. A loaded machine can also increase the number of false
>> positives I guess.
> 
> I'd argue that all of those are bad reasons, I'd only expect us to time
> out when there's a bug - choosing too low a timeout or doing things in a
> way that generates timeouts under load is a problem.

There's no transmit DMA for this device. So if you are under high load
and make a long transfer, it's possible to time out. I don't know if
it's possible to fix that very easily. The timeout calculation assumes
that data is being transferred at the SPI bus rate.

That said, in the common case (NOR flash) writes don't work like that.
To write a flash, we make a short transfer (such as an eraseblock) and
then poll the status register before making another transfer. With short
transfers there is less probability of timing out because the extra time
makes up more of the duration.

--Sean

