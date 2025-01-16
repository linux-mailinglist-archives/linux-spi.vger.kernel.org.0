Return-Path: <linux-spi+bounces-6369-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6DCA144A3
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25973161F0F
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6861DAC8D;
	Thu, 16 Jan 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iNSCLc7Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4871D7E54
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737067320; cv=none; b=bEKRQ1cWmeglQQDonHCiVL3UPoPdoSMNUUGkdGcpvWI4ZHJdMtiKqTRSE9POClQuXZkJJBuDqOQie1X7ER2Tj3StXeBSDcjuIdF4QM4HuTCgRpeiuK0nqkks9SZC9hXX3ByjYW24Q9X+Y9lOxJxLW2GX81D96SIhI+uYnJhdEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737067320; c=relaxed/simple;
	bh=rW/lp8nDgF4DuC4ofpPChTnTAo9m3NRlz/sAlmNDpeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FVkpWIwd80K8AxM0AMuDA7XWv7I9qD9o6eVz2Soj9e7bKd6NgY3uhG1YXHWnciWfuclYdJdS0cVodyXHquhOi3V9TFLv6Xky7RJMQklii78w9sUxCqphu4ygpD9nBPr3OQRCttzcWhpc+Zo9txeQlct4624l6h6C2+H9xCkcjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iNSCLc7Q; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737067315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qF7XVPlipkzKdph9jZxT3W8mqripIYXZ72T/UKR/R3A=;
	b=iNSCLc7QkrgYa8T2Zn0XXzuXEKed8oSiPdHScp/VAbQF9hsSAGd8C9dWx5iNCNgz+fgqrE
	AMlK38cdxEIP80fJJOIvlt6zu/OJv6OHLdpY1mUnSm1i86cB42bl8DJ33/+bX/spac52wj
	S/lcuEKweYxHzTAZuk534DLc9tcck30=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/5] spi: zynqmp-gqspi: Clean up the driver a bit
Date: Thu, 16 Jan 2025 17:41:25 -0500
Message-Id: <20250116224130.2684544-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Here are a few mostly independent cleanups I came up with while writing
some other patches. Feel free to apply them in piecemeal if you like.


Sean Anderson (5):
  spi: zynqmp-gqspi: Reformat long line
  spi: zynqmp-gqspi: Add some more debug prints
  spi: zynqmp-gqspi: Add helpers for enabling/disabling DMA
  spi: zynqmp-gqspi: Clean up fillgenfifo
  spi: zynqmp-gqspi: Always acknowledge interrupts

 drivers/spi/spi-zynqmp-gqspi.c | 167 +++++++++++++++------------------
 1 file changed, 76 insertions(+), 91 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


