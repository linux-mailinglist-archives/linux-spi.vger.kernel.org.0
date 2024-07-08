Return-Path: <linux-spi+bounces-3773-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD16D929B28
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 05:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81081C20D8D
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 03:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B92570;
	Mon,  8 Jul 2024 03:53:53 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6565DAD2C;
	Mon,  8 Jul 2024 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720410833; cv=none; b=lN3cBIXBksZNzQqRajyq75IBbEnFkHrkb4iNxTxfYnSI/n5kNndgGQYFjRi/EizkzGWvofdN/Q5lOutno96LtNVWEaaNqXDKjXVDC8Ud3B9bfTNF7MjlndPiiyj1NyPP1MRNm+N+TvhFczgBPphieO6j6COJ+nb3MCo66PChyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720410833; c=relaxed/simple;
	bh=q5EHY7U+Pu/wGwLPV9BYSYENr4LtnAwMhfePpdUBFQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=t28/Hv9uIyhKY7I5PhQeIPxN4e6UqXkdIv1skuaiC0lQooiuXTEVisp/2jKqnr+ERNCtgeQ7SHTEnbGSWezPdjEwaxAjp6dwXo5yI5k98TZNlyym6G8rMQlZBA+pMFLQzFrjPoatGs2naT50QljrKTKNPRXgAIQX50rFomne8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id 6313D6053C91D;
	Mon,  8 Jul 2024 11:53:27 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?spi:=20spi:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20rc?=
Date: Mon,  8 Jul 2024 11:53:20 +0800
Message-Id: <20240708035320.14241-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rc is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fc13fa192189..bb731ab697a8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2594,7 +2594,7 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct spi_device *ancillary;
-	int rc = 0;
+	int rc;
 
 	/* Alloc an spi_device */
 	ancillary = spi_alloc_device(ctlr);
-- 
2.18.2


