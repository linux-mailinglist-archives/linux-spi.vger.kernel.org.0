Return-Path: <linux-spi+bounces-7043-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E251A50C39
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 21:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66668163600
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 20:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086D5253F01;
	Wed,  5 Mar 2025 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ECWDmZV8"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1519D06A
	for <linux-spi@vger.kernel.org>; Wed,  5 Mar 2025 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205386; cv=none; b=EYBpetOZ+Y6JNT/F2sHKDzxmi7twdh6M0pgcf3O8WQdb55ESKnDeiJb4kS/oHyCKbNb9PBojt7vJCSQDv1OgNcGk+IAlZumKdC/Ru0kIKJ7aKdwceVtDmEYY+0uKXbbhWsfRW+648sQMGJomo1epn/B8Dfu2AdBGXuQFLVEOADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205386; c=relaxed/simple;
	bh=ZYfoHYjHu4gie7PkyCPajVpd816qK49ono59YAS0uss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pi5SnlvS0Da1o/GTwv1zxjdXbRWbLK52QF3NELGszCDgWs3ppwhmVf01F4jCNJjABN/xSLv1nN3+iyFG77d4dmHs73Wo1ZhRd9/z7ERj7V77nMNMT7WmfZX0X1BoG48QlilwXKlUIcVi+LmMR18w7rZ9ESWAg+gme5cpkNKdNdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ECWDmZV8; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C576442AF;
	Wed,  5 Mar 2025 20:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741205383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UeNz5sA8MJeuM8Ar28Vz4xRF/UGUghryQMG+nBSAozs=;
	b=ECWDmZV85GD7wtdJo3IYZZG5aAY5QGN1IqXJ//WDDPThC8IyfR1nucxXE/qBCE/pEmWUI3
	UEy63PLJ8xPJD0KUojaTRmBx11gP+WjpWciwekEdX9U7R/Oaasrst0vVG9gfokan/JoFRb
	xY3ssjAtHteBn1pCuV24jZjqqObVvk3QPu9x+8oIfwAMfxyjQjMm/kuH+Z/rjZV2FPjDm/
	UBammk+nh2lTpCaXNUJCGb5rP8mr0FaMqJ4Q7L0LV9CGSmFglTb2ThyEolJU5AWuK/kwC1
	1Ug9diaZxevU91Qatk3hXGKxUX02xCgwBvImbsA8yiYLZoh4oVtMTOVtK/8mEw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/2] spi: cadence-qspi: Make it work on AM62A LP SK
Date: Wed,  5 Mar 2025 21:09:31 +0100
Message-ID: <20250305200933.2512925-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhjeeiveetlefggeehgedufeffudeutdfhvdekteegkefgffdvueeggfekgfegleenucfkphepledvrddukeegrddutdekrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrleeipdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegso
 hhothhlihhnrdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello, as part of some spi-nand duties, I came to work with a TI AM62A
low-power starter kit. I initially could not use the spi controller and
tried to find a working-while-not-breaking-the-others fix but TBH I am
not getting all subtleties of this driver so I might very well be in the
wrong direction.

I then observed a massive throughput difference when using the DAC mode,
and disabling it really improved things, so I am proposing to bypass it
as well on this platform (and some few others which would also be
impacted by the change).

Let me know what you think.

Cheers,
Miquèl

Miquel Raynal (2):
  spi: cadence-qspi: Fix probe on AM62A LP SK
  spi: cadence-qspi: Improve spi memory performance

 drivers/spi/spi-cadence-quadspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.48.1


