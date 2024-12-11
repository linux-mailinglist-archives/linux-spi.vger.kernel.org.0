Return-Path: <linux-spi+bounces-6017-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D299ED57C
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 20:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0421A169DDE
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F620C48B;
	Wed, 11 Dec 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6/En3oH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AE237FF2;
	Wed, 11 Dec 2024 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943167; cv=none; b=LpPXAeFhFYgLS1aDwaB/G67mHT4ZxmKLyB/zhfuOYdmQh47NbVOFnHJYJIF9+hVvzmy/bNreaDLivYYOKC5F4HFqzJQTTq6zND0W7PUBR19nYPBA5jGlq62Sr1WzFrdWz5krt49p9CbN6LSt/zdHe9FyHWqABigXZGOOgy/uTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943167; c=relaxed/simple;
	bh=OdvefCJoWaj3RqWLpfvJpNkrDa5VhCq55NCBFCXKcb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmO1V8DdRLa7FPKD0dkOv+d1V512vzxPv3fT1xUw0lHdIIcyMq2dNqfnRehyi5P6qsjkqcYP6eLh9saUe49OPxZS2Gf6gEiECpAoZFdnKPFObX050hWeugWmrGJCjbe97iSlViYZ6Ct/dUKjT4zmOkUMJdNtKyRJ9iSJczbYcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6/En3oH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F46DC4CED2;
	Wed, 11 Dec 2024 18:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943167;
	bh=OdvefCJoWaj3RqWLpfvJpNkrDa5VhCq55NCBFCXKcb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f6/En3oHEhT2iZqBs3PTBcC4xDycNyGS6rUYOzIfJ20Rld4muLyp9cDZmWcM3pCwB
	 d0BTHPqbTLws2JrkMRg5ARDunN03jsvb1RD5SxSgshGd9L+Qqiz7Jerx3+PajeFpaj
	 GMOLq7nZ58WpZbRF9i8qlXOm2CcMnGLkS9iunhuWdFRSkkaYpWk7yA9UTaBo8xHgmD
	 4t9nM2f7iinNQtA7GlkeHFvWb6WG2vqqKk6frxvvMlFcxGovYhTWc09wEQISaSFwrX
	 /si2gybYi4FIOmRuHUlHLei5OW+uRFJqLhZnwOsUXoCMgq4p/eDs8gvdFMvrn/fwj6
	 dEWInzCmxyvUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aapo Vienamo <aapo.vienamo@iki.fi>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/23] spi: intel: Add Panther Lake SPI controller support
Date: Wed, 11 Dec 2024 13:51:52 -0500
Message-ID: <20241211185214.3841978-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
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


