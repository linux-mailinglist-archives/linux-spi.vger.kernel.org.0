Return-Path: <linux-spi+bounces-6375-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D6A144D9
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BADA3A0F64
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A321CEAD3;
	Thu, 16 Jan 2025 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XIkYNUOn"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8D18A6A8
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068136; cv=none; b=TqRS17DAEIeG/otYVxnerMV2PFsdDd/3dFspJ7Vxs9nSmi/Zu5AYNCsKnMPdR323IgNuTxFQF23pY8Le7b5zt9pbDzeu5YA6GukaBZfmy7qA2KSN5MVDrDaCvjGW1CRgwQnih712amMsY/PS8AloneCcm8myrv8wm+tlIPkzoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068136; c=relaxed/simple;
	bh=3SrMr/Jpx8XG9K5YUVmcBrgmtmKZBWkBlblLo/AdIhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vb5f0teeYdonhsdDxO60zSBTauzYcOOVxnqI7OqEintWL4z+RjD3giD3x2KcNhcAaT2bX2Fd8B7Zof5SXgwi47UxIu4Us0ZI+3qWzH4ClifHq7Nd5zucrX46Q32mm056LpcsOQ8HcOZu9RFR9XeiQFYvGlEaKJd49Fy8EsSRYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XIkYNUOn; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737068127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HpB5lB6azzxlrJkYukifNhmmPqI9KsgkZ1X5toy37xk=;
	b=XIkYNUOnuOMNraYswo1GWPm8iADUy2F3zZ3ceaUdiQFQiTUudbzNs78J2Qnx3AbJneWydC
	wQcHTwdtvO36b+cXEwGNCXu3UMTtvD6SSrqkCEAnYQjzvGrmh2Hbfs8SpFeExTraRmlaXX
	I99lNcLrzt3vJjIDZbK6EdCv9Ze8kSg=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 0/5] spi: zynqmp-gqspi: Improve error recovery by resetting
Date: Thu, 16 Jan 2025 17:55:16 -0500
Message-Id: <20250116225521.2688224-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series adds support for resetting the QSPI controller if we have a
timeout. I find this greatly improves the stability of the device, which
would tend to break after any timeout.


Sean Anderson (5):
  dt-bindings: spi: zynqmp-qspi: Add reset
  spi: zynqmp-gqspi: Reset device in probe
  spi: zynqmp-gqspi: Abort operations on timeout
  spi: zynqmp-gqspi: Allow interrupting operations
  ARM64: xilinx: zynqmp: Add QSPI reset

 .../bindings/spi/spi-zynqmp-qspi.yaml         |  6 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  1 +
 drivers/spi/spi-zynqmp-gqspi.c                | 64 +++++++++++++++----
 3 files changed, 59 insertions(+), 12 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


