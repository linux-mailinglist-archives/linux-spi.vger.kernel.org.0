Return-Path: <linux-spi+bounces-6403-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D591A154DE
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 17:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF34188183E
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C71993B7;
	Fri, 17 Jan 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mGEsmIWN"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1690F1991CA;
	Fri, 17 Jan 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132706; cv=none; b=XmRO7qP1OAghYzEU4nMeqtpiq8Tj+1AAtdbmUFptYGS7/8WXHDhcQRRwwo61MsfFbezRU/X4dBmKYV2b8VWZWrSh7G2bG9tRAuBUhVR8nRHg6xuyNWguhft8IITBt/OheylOcgrsqI4BHkI9zi2s+xw62c1K9cjparky3ZQrdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132706; c=relaxed/simple;
	bh=GTECVoOxSWQmuPGTp2EnG9NlL7hqOFVJftS3fBiuovw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZzN/IqU8EJlzKj+jx0oYANWpfp0RGSEcszxTJKrJ1l8USB5fxfEiqTkYdfzovBBCr3ZIjM4AvBNKKQej8QUwjeNI1QyGdRrFsdQMncchz7vCZtL344whdafYE6bF3rpKFfyafUBCDHdk+e23TlHd9K08vddrdMmt5F0za70+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mGEsmIWN; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3f8bd4e2-02ed-44c1-8925-5c16a98d90cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737132692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXz9gJ3SbgLtGHYvtSFN2yMJaQoRdfWikhkGx2vKuJs=;
	b=mGEsmIWNO5ttoaJhkFf+SEn+tKZsOEf5l7f2t/vG3QeHxPfJuyy3dlPu7kcvBuFtdBSVjH
	GYNHfdqNnhC8XOwPWJFXLR7BHriDFP64cfJFF929rhy+MHdKD+NQkiNRN+f7fNfrPfgg9z
	k+yQecvM0t+SOXr1CwHWEfkYMue9fM0=
Date: Fri, 17 Jan 2025 11:50:41 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] spi: zynqmp-gqspi: Improve error recovery by
 resetting
To: Mark Brown <broonie@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <5942e111-24ba-4d1b-bd4f-6b81dcc6c5dc@sirena.org.uk>
 <3a38cc06-d052-420d-812e-7f3c0c6ef24c@linux.dev>
 <f694cd3e-f2be-48e0-8d84-038579cfca7d@sirena.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <f694cd3e-f2be-48e0-8d84-038579cfca7d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/25 11:48, Mark Brown wrote:
> On Fri, Jan 17, 2025 at 11:17:35AM -0500, Sean Anderson wrote:
>> On 1/17/25 08:21, Mark Brown wrote:
> 
>> > If you're hitting a timeout that tends to indicate there's already a
>> > serious stability problem...
> 
>> This was mostly hit when I was hacking on the driver. But of course
>> there are probably still bugs lurking in this driver, so I think it is
>> good to handle the exceptional conditions in a more-robust way.
> 
> I'm not saying it's a bad idea, but your changelog is written in a way
> that makes it sound like timeouts are normal.

I've updated my cover letter for v2 to include the above blurb. Hopefully
that clears things up.

--Sean

