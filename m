Return-Path: <linux-spi+bounces-6399-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C05A153EA
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 17:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA2C1637BB
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429C919AA56;
	Fri, 17 Jan 2025 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A4Bc9BkC"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65719C574
	for <linux-spi@vger.kernel.org>; Fri, 17 Jan 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130374; cv=none; b=Px11vsk8Jmaa3hZOeqESkq66238XgmE+APlRtsFGWc0O2QWv816g3ZePCSYFygcNLIqLf1XzhYcaN52r4pfTr9kLeFvW/FgGdjL9JopqBMJ+z6Uz+Q/j6OwlZtWt/GY6XoHLU4ADcdXpDObwcHLLUoeTK55DXEndTHRSXNF6ePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130374; c=relaxed/simple;
	bh=3Bc+552ulck3enjTeqB4sPMdlOzt0DLyE+UdHTW0SrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBLpz1c+99Nljkf8zIqP7N5PS5dKjd/5U+8+Pexc4HHjj8/3cvmji0WbsGPkAgv3SqBQhxw6reUBagBHiK4a6hd+3Gh4G4yjNjn6qMovKUk6+gAU/DphB4Z6Oo/MGUUXYp0OLOh4f+V5CmAG6JJkjik8UlXxq90ENrY3Lgmnf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A4Bc9BkC; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <28f44815-355d-49cc-aed3-8383320b2d72@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737130370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3oNfu1Kk8lwcsuRc6AdBu0ZTa3qawlKPCReGrf7HMQ=;
	b=A4Bc9BkC4qEo2VQEi3EzBWQBn1yuj9AByeeoq7swNdbnCzWR1Iuf4OXtsT8u8C8ZwJINXV
	hEuKQJp4axaYbA1DSl7zvAcWfKvlyjxli88T7GcnjmxDhG06CDZYW0IiUUmsxdbCSEsKQb
	5FSbxasVb++TWGhew5W+hi1zgCNHchE=
Date: Fri, 17 Jan 2025 11:12:44 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] spi: zynqmp-gqspi: Allow interrupting operations
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <20250116225521.2688224-5-sean.anderson@linux.dev>
 <87y0z9j0ha.fsf@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <87y0z9j0ha.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/25 03:41, Miquel Raynal wrote:
> Hello Sean,
> 
> On 16/01/2025 at 17:55:20 -05, Sean Anderson <sean.anderson@linux.dev> wrote:
> 
>> Some operations (such as reading several megabytes of data from a flash)
>> can take several seconds or more. Users may want to cancel such
>> operations. Allow them to do so now that we have a way to recover.
> 
> I fully agree with the observation, I tried myself interrupting too long
> transfers with another spi controller:
> 
> e0205d6203c2c ("spi: atmel: Prevent false timeouts on long transfers")
> 
> But there were issues reported, so we limited the signals to SIGKILLs:
> 
> 1ca2761a77349 ("spi: atmel: Do not cancel a transfer upon any signal")
> 
> But jffs2 plays with sigkills, so for spi memories it does not work
> well, we had to revert:
> 
> 890188d2d7e4a ("spi: atmel: Prevent spi transfers from being killed")
> 
> Same thing was also observed on Zynq7000:
> 
> 26cfc0dbe43aa ("spi: spi-zynq-qspi: use wait_for_completion_timeout to make zynq_qspi_exec_mem_op not interruptible")
> 
> I would however hint to use a specific helper for deriving your timeouts
> if you play with spi memories, because it is interesting to adapt the
> values nevertheless:
> 
> d8e4ebf870187 ("spi: Create a helper to derive adaptive timeouts")

Hm, ok. I wasn't sure whether this was allowed, but I saw a lot of
interruptable users under drivers/spi.

I guess I'll drop this patch for v2.

--Sean

