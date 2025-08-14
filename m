Return-Path: <linux-spi+bounces-9446-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9925B270A1
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6EA3AD20E
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 21:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6C5319876;
	Thu, 14 Aug 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bMAF2nsj"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819F25A65B
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206129; cv=none; b=Fmvv2Jbm4liDD9/JXL+1iFtitW4aM4mwCGfYqzw6tIDNFDC9y5/hjJNhGWZHQfibhT9SBdySqFbWd0M4e/gb4dXmzZQDuIzCP/fOLKj9+6Hz5kO2ZtUOQbv/uaNjamqVs/5o8HbnA8eT9QDvn3pRXacnmORkmVblp9VQH2razKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206129; c=relaxed/simple;
	bh=dOfn4PQIaJRFRCXF9UTMtNKIU6HnBh9xbJrfP9kII6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7stDJjvgvvFfAavqbJe2oqXtJRMdzovvYCsBS1DtCRywpTX7hJ0hV0773Ks83rawud/Qo/dsBCq+54x+w3iSZz2ikD7GNp0ts0vqdsivCwSCDsSXPEplC8J1ONtwtCEazzSWHQPFwEda0ANczPJPkM1ihIfCRrsbVpuIN/n6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bMAF2nsj; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b02293b-9c86-441b-9344-2d0263eb1659@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755206120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKQKCKdoQNfp6rtU1TUv2GGPhoix0PV4K5iXj8bqWVM=;
	b=bMAF2nsjqddUD0FSYINQ4+GBoC9IZeWo495h5DH87tu6YK7wtPoGD8Wb/rPZluT9MZy6b1
	xn/uaQvYYVjtIi+72cpFNweM+3Lczt/G9OtQsx3HvzytEBPbXUZjbpxmGGfz+CAa0GSVR9
	BvlDAAiqioSHtDAYeNhhpiDQ0/Y45Qk=
Date: Thu, 14 Aug 2025 17:15:14 -0400
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
 <1a87f436-317b-40e0-a655-cd82f969f22e@baylibre.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <1a87f436-317b-40e0-a655-cd82f969f22e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/14/25 16:55, David Lechner wrote:
> On 6/16/25 5:00 PM, Sean Anderson wrote:
>> From: David Lechner <dlechner@baylibre.com>
>> 
>> Add a spi-buses property to the spi-peripheral-props binding to allow
>> specifying the SPI bus or buses that a peripheral is connected to in
>> cases where the SPI controller has more than one physical SPI bus.
>> 
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
> FYI, Mark's filters won't pick up `dt-bindings: spi:`, we need to change
> the subject line to `spi: dt-bindings:` on the next revision.
> 

Sounds like he should fix his filter then.

--Sean

