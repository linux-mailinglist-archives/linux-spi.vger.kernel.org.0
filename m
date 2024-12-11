Return-Path: <linux-spi+bounces-6015-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5399ED655
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 20:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4792D188A2F7
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 19:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EDF243B70;
	Wed, 11 Dec 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0hgi7oo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB31243B66;
	Wed, 11 Dec 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943090; cv=none; b=X6bx3pASYC2JNhqNYdBMR+rmfxPO8Z+MxEhZpCSNDla5WqvIDLGdLU7pwCxQ2Y4/yvg+hWz3iA6cae8UgwoX0Zpfg0H6B9YVO3u401syPQxpmxw3FrL3md3K0aqY2q/rdsed7De1GsSucWl1WMuEoZlhqBMG9p2GfA2JUgudXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943090; c=relaxed/simple;
	bh=OdvefCJoWaj3RqWLpfvJpNkrDa5VhCq55NCBFCXKcb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL/lBTajVVSAJ/XKDBE9IPqWwDnlwgzwmWJ5+nfOovzTP7FfpEFXr/qtpXHWPWKbRE+pTZqqLAFMCOw+gwSMyk1ZeiD4/MmZ0raxYJmElGN1xkBs95HASyauMAmQPdHJbSBKc6kLB04sMK6WbugI9FLNNjWSi1TWjKdQuis4YBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0hgi7oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4882BC4CED2;
	Wed, 11 Dec 2024 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943090;
	bh=OdvefCJoWaj3RqWLpfvJpNkrDa5VhCq55NCBFCXKcb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0hgi7oou1hmKViPZg7C6J08uft9s4g8yS73/NNfdW9EVZBpjcR7c4jfk4OqwyDif
	 YFoq0cZIjmVuBVbfqHdyqUwWBT4awhmEUgQOzSsundquy+VlBI8qvS4yl0oforqmIb
	 /Zal6JCJg1K7ZSj4s1gVYWRxXSPovn0PJHN6PmSk6vkmcDEICio1CuhPPRnZuCaW5L
	 LvgT+e8Y494cLfd6jM7zpA+Hno9azVWVFuiplqTW0HJwxkeO4hMlgXwFtTNIWmatPx
	 1AhyIXWwSwkx5F8iRPz6AxsPh7NGhc+ksgB83u8ybJMZ0x7jirYnfKHoYzxGhsBfWM
	 J7QD2jWSwyK/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aapo Vienamo <aapo.vienamo@iki.fi>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 23/36] spi: intel: Add Panther Lake SPI controller support
Date: Wed, 11 Dec 2024 13:49:39 -0500
Message-ID: <20241211185028.3841047-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: Aapo Vienamo <aapo.vienamo@iki.fi>

[ Upstream commit ceb259e43bf572ba7d766e1679ba73861d16203a ]

The Panther Lake SPI controllers are compatible with the Cannon Lake
controllers. Add support for following SPI controller device IDs:
 - H-series: 0xe323
 - P-series: 0xe423
 - U-series: 0xe423

Signed-off-by: Aapo Vienamo <aapo.vienamo@iki.fi>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://patch.msgid.link/20241204080208.1036537-1-mika.westerberg@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-intel-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 4337ca51d7aa2..5c0dec90eec1d 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -86,6 +86,8 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa823), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xe323), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xe423), (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
-- 
2.43.0


