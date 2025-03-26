Return-Path: <linux-spi+bounces-7322-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B56A71957
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 15:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486177A70F9
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C41F3FD0;
	Wed, 26 Mar 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LW6QP3il"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723191EEA36;
	Wed, 26 Mar 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000589; cv=none; b=rPucMh/eGASjgTGIsUqO5dGQY4vzf7k5Yqa2qjpGhvUfZ5U4m7D0gwrGkplOihDQ16E2h0R0VXaBXWphh7y52dKWjOLXvJOyDa7CLQZT1LPVV1qZQ19P/oNxzQGbzEp5E9HDmTnSwzzdN4H6XrkQ02RSioUXZtS9ktLVxyRPxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000589; c=relaxed/simple;
	bh=xYk0auRz9Q8+16dg83y0wKUaBH/EeXKBzvwJLglzuJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLWNnbheyV6Qa/pjZew1uo2wR8b5QFPAlrupBBDUNcHEQDUUwf2AtQEvyopFfRxQ0hI6hJpVsviG/EgM4V451NZa/qTMbWLoLd2g3mszAM8cONaQR7HJc0b1kd3Si7pfntp2mDZodXeqJJNnePbhFOuonlzzzUVvILv78MoM0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LW6QP3il; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B70C432EB;
	Wed, 26 Mar 2025 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743000578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BANocZLjlDV8/uTYp9TCbf/5ElQ8CaMKQxWJxwAP4dk=;
	b=LW6QP3il8PmsYf7iO9sdSOqh3v899p3W+wSflWLQEsjv9+HUkjPeMl9aZ21IoOf4dos2zN
	UwGXhgp3uO8wK5SVTm89rV/xdqz/kVjCEIophpqVcUiQTMTZCY6MkeJFEqufW4sjinAaBx
	69HhmCStAk782cdr6fcahYz73zZumTybI0Qmxe903YH5eRbKTZ4wnkF4SZeMqH0NbJQ7ne
	PFZUhsX+FSIhm95MaayEcJ2FYELAaHcQZ7D7Cb5BuO/ccA0vJ4c4i2us23wkw0HsRg4IES
	WT77u4QgNpEPUXeAczt9NJIUcnt0zPOYlV7AOUz5x0ov6wzNa0HqHfDtLMkG+g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,  broonie@kernel.org,
  robh@kernel.org,  krzk+dt@kernel.org,  conor+dt@kernel.org,
  richard@nod.at,  vigneshr@ti.com,  linux-arm-msm@vger.kernel.org,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v15 2/2] spi: spi-qpic: add driver for QCOM SPI NAND
 flash Interface
In-Reply-To: <CAMuHMdUOt8PxbRt-vGfeD5=uEtMVV0TLPUridu=nCkzX9iP24Q@mail.gmail.com>
	(Geert Uytterhoeven's message of "Wed, 26 Mar 2025 15:24:03 +0100")
References: <20250224111414.2809669-1-quic_mdalam@quicinc.com>
	<20250224111414.2809669-3-quic_mdalam@quicinc.com>
	<CAMuHMdUOt8PxbRt-vGfeD5=uEtMVV0TLPUridu=nCkzX9iP24Q@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Mar 2025 15:49:37 +0100
Message-ID: <874izfrgn2.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehquhhitggpmhgurghlrghmsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgut
 heskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com


>> Change in [v11]
>>
>> * Changed "depends on MTD" to "select MTD" in
>>   drivers/spi/Kconfig file
>
> Why? This is the only driver that selects MTD instead of depending on it.
>
>> Change in [v7]
>>
>> * Made CONFIG_SPI_QPIC_SNAND as bool
>
> Why? The driver uses MODULE_*, so a janitor may remove the latter.

Good catch, I agree on both comments.

Thanks,
Miqu=C3=A8l

