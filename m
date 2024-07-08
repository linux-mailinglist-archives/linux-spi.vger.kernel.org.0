Return-Path: <linux-spi+bounces-3774-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E520929B42
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 06:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18181F21952
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 04:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24066FCC;
	Mon,  8 Jul 2024 04:14:38 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C2FE511712;
	Mon,  8 Jul 2024 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720412078; cv=none; b=dvnrbcyMNG3BN9zuaGylcF2ykf+Nf6DECyJQS6iZF9aBFvr/VuOuPgG6GCaZCS/0FpByo1fWt/ybuRUDrnbWPzr8ESR4skOxwonDP/G+Wnx3RrYkkdViAjpzV+3FKz0JaV4Pbvsy36ggIPJpJSYUi/LjCpSYm3F/9ZLOPXedK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720412078; c=relaxed/simple;
	bh=DsDpniR6BJcsEraxp43vnh43KbE2Z47Whw/LL1tE14s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aOlg/3pmNBc+ZJiM1LmSgu3De01USSTAuu6rvZAbPZmMbSQAWMNlm6uZKc8KBL0PTKlaaZLwvlOXGvpatg3A2qr34qcbnQuPN/9ABTEjBIxZISGlI6RkbJbOSOD7RizkR/bjX8EpxuPaalxuYl1ukHFFEoq6trkLri1xGyYk9ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id 944896053E71A;
	Mon,  8 Jul 2024 12:14:18 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?spi:=20spi:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20status?=
Date: Mon,  8 Jul 2024 12:14:11 +0800
Message-Id: <20240708041411.14424-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

status is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bb731ab697a8..b1d85036d384 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3925,7 +3925,7 @@ static int spi_set_cs_timing(struct spi_device *spi)
 int spi_setup(struct spi_device *spi)
 {
 	unsigned	bad_bits, ugly_bits;
-	int		status = 0;
+	int		status;
 
 	/*
 	 * Check mode to prevent that any two of DUAL, QUAD and NO_MOSI/MISO
-- 
2.18.2


