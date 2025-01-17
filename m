Return-Path: <linux-spi+bounces-6408-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 003DDA156A1
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 19:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E100169416
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8E1A23A1;
	Fri, 17 Jan 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hn9vJXLK"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D3126BEE;
	Fri, 17 Jan 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138676; cv=none; b=W0Upor6ZOhr773N9syn0OcBNzZ5fMKYoSYm/q1qX8lXX0OqmpmSJuAqdpMGs0HS8yrBiVQtBcV2JMFCggeGzAX0VxEv6i6sfE7VCjBLSkrfDQqx8EAfi+dov3aSYbVp5HWovv2xWvo5ucSbsgx/CRr1lLZN/JkccxDvBKvJqlE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138676; c=relaxed/simple;
	bh=CSqLovKCg0Wp1phThnzXec23DT+S5xG7EY7Nsy00BIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=obJV/XNOcIpprENJY3LeBxZrEFd3fKRTD9pmUVnb/hZUnmKt3dqVMOo0xpFZWFbZYMsDH88ui0dO9IW1WfrPKG6gS1CWwP2On9emuqf7k8ExmrrVYhzb6EXf4ox0+ZT5sHCaoiHYUpWAOq3Qi+fLjvUBLvxl4pOsgrAXrZ+87NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hn9vJXLK; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92D541C0003;
	Fri, 17 Jan 2025 18:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737138672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSqLovKCg0Wp1phThnzXec23DT+S5xG7EY7Nsy00BIs=;
	b=Hn9vJXLKu6LkTpChEDUUJjznRi+VKRwggVK+xEG6/3a6jAaPNwHMBByHy0vukBguPDTpuS
	tiPp/WJx0B+u0JM/N7+IhMS0BuZJ8nW/n/lpJt66rwMOpPOTPmmHfo5LU3RTFUXuCL4icw
	FXSMt+OodONG38+gnkMU6yuWJ3ejY5Mo0QA/J7fOjJ4nhd+DoAUAM73Or0vQ7UmoPcFRyD
	vzgnmysVphXHSIUIBy8xgbCqkh4NsnIQjItSeJZGXbgOK2Cty64dc8iz2eIOlsicBcijNr
	DsXb1DiA+zMj+kGYU243/dMgVWrf1Fae8pmVGTBkigK97ai3QyGCGkxx69aCKA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>,  Michal Simek
 <michal.simek@amd.com>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Jinjie Ruan <ruanjinjie@huawei.com>,
  linux-arm-kernel@lists.infradead.org,  Amit Kumar Mahapatra
 <amit.kumar-mahapatra@amd.com>,  Conor Dooley <conor+dt@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Rob Herring <robh@kernel.org>,
  devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] spi: zynqmp-gqspi: Improve error recovery by resetting
In-Reply-To: <5942e111-24ba-4d1b-bd4f-6b81dcc6c5dc@sirena.org.uk> (Mark
	Brown's message of "Fri, 17 Jan 2025 13:21:58 +0000")
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
	<5942e111-24ba-4d1b-bd4f-6b81dcc6c5dc@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 17 Jan 2025 19:31:08 +0100
Message-ID: <87h65xi977.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 17/01/2025 at 13:21:58 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jan 16, 2025 at 05:55:16PM -0500, Sean Anderson wrote:
>> This series adds support for resetting the QSPI controller if we have a
>> timeout. I find this greatly improves the stability of the device, which
>> would tend to break after any timeout.
>
> If you're hitting a timeout that tends to indicate there's already a
> serious stability problem...

Yes, unless the timeout is reached for "good reasons", ie. you request
substantial amounts of data (typically from a memory device) and the
timeout is too short compared to the theoretical time spent in the
transfer. A loaded machine can also increase the number of false
positives I guess.

Cheers,
Miqu=C3=A8l

