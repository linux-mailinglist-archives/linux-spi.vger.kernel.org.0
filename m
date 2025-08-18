Return-Path: <linux-spi+bounces-9494-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DE5B29C35
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 10:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC413A6697
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638E22206B1;
	Mon, 18 Aug 2025 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rv0VYgRD"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6429E10B;
	Mon, 18 Aug 2025 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505750; cv=none; b=UYDcwAdmXq7u+uEIpa0/QYf4+paSespmxHbs1gOl/YP/sUdyNaDm6FLJ3xbFi4xOUimE3W9NaMtvSg+3cbwgz1kqQbQMCOwtY8h8BWdeMBw+i37J2ec7G0/BUYZjZNURFv/r1lsd8FyHniuBbE+IcNpPPitY85phsaS9WUC7+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505750; c=relaxed/simple;
	bh=uWwh60w/bduOIheSKC80XdABGLZBKKCVzC9/FNAQlSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SedYGvfjT31hngWJ1WzcVp7fljGBg51cWtVHj/tPXyz8V9dmonraKtlo6FdwYx22VqW6juAYJLAjDi40QRapRkYKdn0gcgSA446Q+12jpVQai9V4JXaDp7nKKp/CWLzyd3Gjs4mWLu6NsGwTQngKyqEpWpDu0yaYkgmkkXuBUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rv0VYgRD; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 737AF4317D;
	Mon, 18 Aug 2025 08:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755505739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqSlpzzBjh5abP5Ep10OGKmrH1NoW6pA+tFSYa8a7oU=;
	b=Rv0VYgRDLz+wpcDNTv/5vHuI3YEpR0ijBjEG2iXuknPIRNS9iN/wnY/AHHIdfssdu22ZpQ
	F3GRdf0YrrFHP7SL6azasxNjKl+/zt9FRxxbeWJ884EhY0+pXsbtcYXg4z1eVMjae1qTa4
	A3RE21DnrdFcuw2jun2fqbr8xo8sS3JdrrF8fHRRqOGwaPV0iEQa+4ddYSxXiSmy21PKzq
	ljhf1okCHY97hEpf/JSrf4/k+0aZ6J6zzD8O97E1KMfGoeeh9O2zgAOAAaZnzKVsXcr732
	uSP7+u2ueFbKs3SEZ9eoMUhcGH8fptMlHuvWjq4aSiI/xeXuuy5cNJLGfSAlPg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Sean Anderson <sean.anderson@linux.dev>,  Mark Brown
 <broonie@kernel.org>,  Michal Simek <michal.simek@amd.com>,
  linux-spi@vger.kernel.org,  Jinjie Ruan <ruanjinjie@huawei.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
In-Reply-To: <ded7ba99-089b-47a7-95b9-ca6666dc3e29@baylibre.com> (David
	Lechner's message of "Fri, 15 Aug 2025 10:49:40 -0500")
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
	<20250616220054.3968946-2-sean.anderson@linux.dev>
	<ded7ba99-089b-47a7-95b9-ca6666dc3e29@baylibre.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 18 Aug 2025 10:28:58 +0200
Message-ID: <87frdp119x.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepughlvggthhhnvghrsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehsvggrnhdrrghnuggvrhhsohhnsehlihhnuhigrdguvghvpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrghlrdhsihhmvghksegrmhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopehruhgrnhhjihhnjhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

>> +  spi-buses:
>> +    description:
>> +      Array of bus numbers that describes which SPI buses of the contro=
ller are
>> +      connected to the peripheral. This only applies to peripherals con=
nected
>> +      to specialized SPI controllers that have multiple SPI buses on a =
single
>> +      controller.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1

>
> Finally have some hardware to test this series with using 2 or 4 buses.

Out of curiosity, what is the practical use case and intended benefit?
Maybe an example of such device and an explanation of how useful this is
would be welcome, as it does not seem to fit the initial spi idea
(which has been greatly "improved", not saying it is bad, just unusual).

Thanks,
Miqu=C3=A8l

