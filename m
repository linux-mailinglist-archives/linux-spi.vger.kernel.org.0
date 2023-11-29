Return-Path: <linux-spi+bounces-91-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD477FD827
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 14:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8881C208CE
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 13:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2A220328;
	Wed, 29 Nov 2023 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PvEEKZi+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZCeWPix"
X-Original-To: linux-spi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944E9D;
	Wed, 29 Nov 2023 05:32:26 -0800 (PST)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701264744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4kppMjNPf1GKwvIU18Ptl9YLUNAOWni/rWCQpmP6c8g=;
	b=PvEEKZi+brEqPQ8OQRPOWt0chNcNLzDHQoN0j2L2GW4V/8SPzJDhHYDof4k2PAkPf9B2jq
	9aMgfMdBtj09ljuQpoC/9h2WAKQy9JhSPz8Wa6eV5Vu2mGvTO9zzc28HG3g+ppLUt0Oz86
	B160SzuFerkL4ToSRxko96gJm6IrAvosekVRMR7aldlKEq9a3/QpTmxsjkFTEGah4dJpvM
	nGCZgwrRrHY5rflUNEMvGjpDVifP8mi6SmhQaa0O78YLuoD86Zpao7mPh+9cqa0O66kkAO
	nR9Ut5FCnp5TXiRpqihMg7OCe+p0DEon+u7V49OcX4yqBpMOseE4V1ONlVt4xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701264744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4kppMjNPf1GKwvIU18Ptl9YLUNAOWni/rWCQpmP6c8g=;
	b=cZCeWPixlXbm9/0ZN/s6Zf16kJHyUsdaXP+dwG+0mQ6kkKXSexhziIrvU57eBq/zAHiKPa
	PSo4cRDO9Ch7hMCg==
To: linus.walleij@linaro.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] spi: spl022: fix sleeping in interrupt context
Date: Wed, 29 Nov 2023 14:32:17 +0100
Message-Id: <cover.1701264413.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

While running the spl022, I got the following warning:
BUG: sleeping function called from invalid context at drivers/spi/spi.c:1428

This is because between spi transfers, spi_transfer_delay_exec() (who
may sleep if the delay is >10us) is called in interrupt context. This is
a problem for anyone who runs this driver and need more than 10us delay.

Patch 1 adds an error reporting mechanism, needed by patch 2 who switch
to use the default spi_transfer_one_message(), which fix the problem.

The series is tested with polling transfer mode and interrupt transfer
mode. I can't test the DMA mode, so some help testing here is very
appreciated.

One question: This series is quite big for stable trees, so how can we
backport this fix? We can:
  - Let it be released, and get tested for some time. After a while
    without any reported problem, backport it.
  - Have a small patch which fixes this problem. One idea I have is to
    switch the current interrupt handler to threaded interrupt handler,
    and switch from existing use of tasklet to workqueue. So that the
    driver can safely sleep if needed. And then add this series on top
    of that.
  - other options that I miss?

Best regards,
Nam

Nam Cao (2):
  spi: introduce SPI_TRANS_FAIL_IO for error reporting
  spi: spl022: switch to use default spi_transfer_one_message()

 drivers/spi/spi-pl022.c | 372 +++++++---------------------------------
 drivers/spi/spi.c       |   3 +
 include/linux/spi/spi.h |   1 +
 3 files changed, 70 insertions(+), 306 deletions(-)

--=20
2.39.2


