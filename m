Return-Path: <linux-spi+bounces-7849-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD5AA707B
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 13:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3838D189F602
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E724C8E;
	Fri,  2 May 2025 11:12:46 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B264242D8B
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746184366; cv=none; b=VlqX0mac57Xr33My8jAcAmK+E8H5sRKA5zcfDGBRL0QfrWeCKJS3XkY4qhm/H/4xYeihLFiW9nVhEfvWPNL7NPoRF65pFTtPYDaTl00myFGBZhqJjKYJ4Yr3XKeXPeT4aVVwux0y/U9Kq1fkx+ykGM/Vk8qZ0Xa5G5OJOGLrAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746184366; c=relaxed/simple;
	bh=FoHKU1Quq43ue6Mq6k+L3exih1jgftn8flH0qo/BRfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gE+lCu4oVBRa8uVZmoh5gKlv1aM8gyQsiV90KtHrjfqDowoYX5CTc+UJkwm2PZcYIWP/KXIDh/rh2SzFY7oN8iJWFqi8YbzOx8YH366fUPXk09HWoOvGm1r4wtqzHv58QI5DNT6i9DqCN6qw/FS+I788mCGl4lReJxlpFXCfLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by xavier.telenet-ops.be with cmsmtp
	id kBCg2E00E4sst1101BCgAd; Fri, 02 May 2025 13:12:40 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAoJn-00000000WaP-3vTS;
	Fri, 02 May 2025 13:12:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAoJs-00000008p3y-1gk2;
	Fri, 02 May 2025 13:12:40 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Martin Sperl <kernel@martin.sperl.org>
Cc: linux-spi@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: loopback-test: Simplify strange loopback value check
Date: Fri,  2 May 2025 13:12:39 +0200
Message-ID: <da612090f543c8c7cc99fb9dc6ef4abc9560abe4.1746184293.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply De Morgan's Theorem and drop superfluous parentheses to simplify
the check for strange loopback values.
While at it, add the missing zero in the related comment.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-loopback-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 7740f94847a883f3..a8a6e80c782e2592 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -635,8 +635,8 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 		} else {
 			/* first byte received */
 			txb = ((u8 *)xfer->rx_buf)[0];
-			/* first byte may be 0 or xff */
-			if (!((txb == 0) || (txb == 0xff))) {
+			/* first byte may be 0 or 0xff */
+			if (txb != 0 && txb != 0xff) {
 				dev_err(&spi->dev,
 					"loopback strangeness - we expect 0x00 or 0xff, but not 0x%02x\n",
 					txb);
-- 
2.43.0


