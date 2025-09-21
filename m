Return-Path: <linux-spi+bounces-10190-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7485B8DA0E
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 13:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C523D7AF70F
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD91259C9C;
	Sun, 21 Sep 2025 11:26:58 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC08155A30;
	Sun, 21 Sep 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454018; cv=none; b=HSMPWuyUMl1gLln+JYqyUQRMB6j1pY4u6k9yLjz4CWpQIQJJu03G2FLAtysIB2WliyTpvsTelj9zzh8Y/WnIdYwG3U/wkKTSzPBd6D4fSx/A69Trh2RxMUp84n0d65ZGqNH30AbT63qn5cN9JYCSkubOOWE/hq7uUSCoaCTrbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454018; c=relaxed/simple;
	bh=MXaN4lqHWmNLiQj0aNxMlqMXhlsjkwpE6bc+WacQvD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+wSxz41/vnUWZwZxsXQUAO38vRGMPPccRBdZe65+3Ab3FDdvllnDBVBPKtUBN5AtDIq7vIOGX42MkVz9wK/v5p8Xkcr8EWPwtM2lZEdHw23eE9B5Pbj5J5OEBrg4vO6VFgFoNwswDWyaZEepQgcHc9IxS/8ITh7P2EvajwQD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: unZIpQdzT2e1W3YHxHenCg==
X-CSE-MsgGUID: 24E8VZ+LSWGZHE7hwKHgnA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Sep 2025 20:26:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 786FB400E4E4;
	Sun, 21 Sep 2025 20:26:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 0/2] spi: rpc-if: Add resume support for RZ/G3E
Date: Sun, 21 Sep 2025 12:26:44 +0100
Message-ID: <20250921112649.104516-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On RZ/G3E using PSCI, s2ram powers down the SoC. After resume,
reinitialize the hardware for SPI operations.

Also Replace the macro SIMPLE_DEV_PM_OPS->DEFINE_SIMPLE_DEV_PM_OPS macro
and use pm_sleep_ptr(). This lets us drop the check for CONFIG_PM_SLEEP
and __maybe_unused attribute from PM functions.

Biju Das (2):
  spi: rpc-if: Drop deprecated SIMPLE_DEV_PM_OPS
  spi: rpc-if: Add resume support for RZ/G3E

 drivers/spi/spi-rpc-if.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.43.0


