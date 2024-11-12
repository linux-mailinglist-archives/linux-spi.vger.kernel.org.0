Return-Path: <linux-spi+bounces-5684-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC09C5063
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2024 09:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81BC2B25243
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2024 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB9A20A5EB;
	Tue, 12 Nov 2024 08:16:45 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E8E209F4F;
	Tue, 12 Nov 2024 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399405; cv=none; b=jZWUpTxiXIzn4nq8paMprBL75AZ9xrRsfhXI3KJ0/WTOcpD1b20IlMizfw14exw6L0eMK1p3EN5VLj+AcCoMBN55EwbW7VlQMTCtS41WpiOj3zowcWkCGQjb206V4RLxEESzG2ZQfLx62UCcyN960c0YpTziDFyTAdvN5azI+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399405; c=relaxed/simple;
	bh=MmAltxcpHsJkOjqgCDIFBXvQoKMtkqt3UbTqi/E/aLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fZuLBTSzpWGLwfiYnJKIMnlrfa0AOuB4JGT8xXDIh9RJpn/ThkIa0xFmEKX3Q3IY8L+jGK5KUAPBjfraQNtY8frOFEbxBYIkAEjd05zu1+PwfzWYBkAbZmFm3fJ1qhR0e/2KjBKVXxTW63FbxlWMH3XcVzjtIj28FwC0safqknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee167330ee7b13-de428;
	Tue, 12 Nov 2024 16:16:39 +0800 (CST)
X-RM-TRANSID:2ee167330ee7b13-de428
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee967330ee6cc3-4d1ef;
	Tue, 12 Nov 2024 16:16:39 +0800 (CST)
X-RM-TRANSID:2ee967330ee6cc3-4d1ef
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] spi: Delete useless checks
Date: Tue, 12 Nov 2024 16:16:37 +0800
Message-Id: <20241112081637.40962-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Since "res" will never be null, just delete this check.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/spi/spi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 74e04a4b0f19..460a49d9a0de 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -984,9 +984,6 @@ static void spi_res_free(void *res)
 {
 	struct spi_res *sres = container_of(res, struct spi_res, data);
 
-	if (!res)
-		return;
-
 	WARN_ON(!list_empty(&sres->entry));
 	kfree(sres);
 }
-- 
2.33.0




