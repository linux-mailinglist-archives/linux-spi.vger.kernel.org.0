Return-Path: <linux-spi+bounces-6389-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A19CA14590
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 00:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE423A2A43
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B529F232438;
	Thu, 16 Jan 2025 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wqhW0WFx"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07561158520
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069911; cv=none; b=Q2M/hFDqFjrYnIkghzAvpTKQg3CZQawXl8XLPkbaytOfblLPm1UvDQV75OXeU0YmD5YWbjeIvPVW/+DPWrZLq/fudOqeGGD0Q849yi7fPROw4h+6Dx2J7AJSQfAaSOqbLAjasmylmUuG9mpLrOZdA8NwYo7HrBKsyP2P0bHReaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069911; c=relaxed/simple;
	bh=etZxt/LGaHa3lFvXOIfdHtGrrH6brHAF8kmR9/9k3NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hr/hD+dtxCejxiW1OWbXaVVNiEX17r/Gotc2F1aoYWJnKEPhk91BLn8s8KKVshiaxiJOdW3F6p6B/vol7SjwpBe2HG0t7nALz5b0QZDnouN2ctnsYeE61XkklZIheKo/O1cXROsFwF8jlOH5oWXC1PkKFIhZPUxCxSS1QdJTVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wqhW0WFx; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70cf86ab-cabf-45fe-90e4-985ce09cc44a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737069903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etZxt/LGaHa3lFvXOIfdHtGrrH6brHAF8kmR9/9k3NE=;
	b=wqhW0WFxE2clqe+JZ5jTrHM/9+ehW4FGv8Q0JueOxiTk0aC243y/osY5LR1/0oJapCoPAm
	F/clJ0P11wJY1c18nc6W6I6VNZOX/4kZrFzdEXril21DzzGPMcwfH+vFP/vXcNL9B0jAbp
	icu1AzM/BAB5kUQyLxGdiwPcbrlzwM4=
Date: Thu, 16 Jan 2025 18:24:58 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] spi: zynqmp-gqspi: Split the bus and add GPIO support
To: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250116232118.2694169-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/16/25 18:21, Sean Anderson wrote:
> As discussed in patches 1 and FIXME, this device really has two SPI

This should be "patches 1 and 5" (oops)

> busses. Split the existing "merged" bus in twain, and add support for
> GPIO chipselects.


