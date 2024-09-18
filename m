Return-Path: <linux-spi+bounces-4841-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB497B952
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 10:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CCD28443D
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 08:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C339516EBE6;
	Wed, 18 Sep 2024 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="Fum7bn6M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4E8175B;
	Wed, 18 Sep 2024 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648080; cv=none; b=PB5jwvlsqQNoOF1Q+og7CJxZRk/rSeydGVT8pXcv7KgR6KqbABrCR21MWvZPrvlYEVzUW6AyFPqc5viEBSZ+NNlS1ZsozSzXPcppmQpunKjdBuW1PxQhiDbiP3/ZmycfExBvjcRXJkMk3BzECcHn5vW+rLg3BqQ2Rrx/XIxghh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648080; c=relaxed/simple;
	bh=CFfUmRPQwZhTl/QMEhpHt8vit3wcbVNrrNrBXAmt5og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cJWpCstQrNNQ6NQsM8YRAEhh0z86w527/jsEynjx+80Tb3lxvnc6R9WUB5wm++aaxMiUQ63+9DIrw45m17PiaoaVSrYOxcVEInjzJfwZU1pwsYOWVs/RKkPJqUzo0mvihjOFnR95eqQqIr9RZ2dq/eT/A+lB6oBE/0OtkMpqIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=Fum7bn6M; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A36E31489733;
	Wed, 18 Sep 2024 10:27:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1726648069; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=drhLJCJD3fUeKeawJioBxbhjso2XLDpGbCh0ZnyLvyQ=;
	b=Fum7bn6MLQl7l3LIUsKq5vwrr9um5QJnUAgKK8SGNr7n3m98Mca85sjPytr8nWqhoSSSKc
	IbwmkPp6Mq/YEojLULxgLuREjdzqB48LMmxA1Ojd1XIh+k6QiZYu1yzQJOIRPz1imfSxeN
	+p0r5bmqkefSKK6tj+bIeZ4ysHZMT79Pgmu9c34FfFMBR0U92dItTWnzgg1plasLq37/fG
	2dmmozuSgVf6L8mnvdFpdUwvsbMaOmmFfQPftphjevZSXSX9z6rjgq8WPcmu7O0kbF0Lev
	fDWU4Bgqb34uJhOPKkn/SseAtdPySuFIZDIZoboUI1JCLE5bgeA0ROArY5NT9Q==
From: Alexander Dahl <ada@thorsis.com>
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] spi: atmel-quadspi: Fix and add full CS delay support
Date: Wed, 18 Sep 2024 10:27:42 +0200
Message-Id: <20240918082744.379610-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

when testing on a SAM9X60 based board with an FPGA implementing a custom
SPI-MEM protocol, we found the need to fully control the delay settings
the atmel/microchip QSPI controller offers.

Greets
Alex

(series based on v6.11, tested on top of v6.6.44)

Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Alexander Dahl (2):
  spi: atmel-quadspi: Avoid overwriting delay register settings
  spi: atmel-quadspi: Add cs_hold and cs_inactive setting support

 drivers/spi/atmel-quadspi.c | 50 +++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 10 deletions(-)


base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.39.5


