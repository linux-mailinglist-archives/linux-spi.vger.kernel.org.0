Return-Path: <linux-spi+bounces-7848-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B287DAA7072
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 13:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1183B1C0E
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84055230D1E;
	Fri,  2 May 2025 11:11:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D62417C5
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746184273; cv=none; b=AeoGyNYBqnwIFN9PuKBLetW/dro2bcHxW3QsfIpeaNu+Qr3/f/kG3YoVWUoTL7sTJc7D+/JaOJ5dsf7TNR4XQBcHCfshdugeRF+kolsOhFp5xmF8KLUtvDCIOqKqUXQOODLnlm03fzOTSha9hxbOTBtawfC9QVPrsJ3LXj+Yzak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746184273; c=relaxed/simple;
	bh=uCREbpoXZ/d4qu1maOPKLiBN7nJnfTaIKK/Mi8Y0w+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2mmeUpybL4qFJYrNItY9PK4DXTBTHLwiR9Bj2uXg8UPI3ashXCv47jHqaZ/eTZ26AKtwVrjAbBVc0za26OCrzci7EXW3cMl7BS29wXt+fR2IJOi36CFzI0ImTT4gyUP1NDlClXDOFY1HVLxl/elssP/uKB6aNsHAMvQ5ewQDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by michel.telenet-ops.be with cmsmtp
	id kBB72E00B4sst1106BB7rC; Fri, 02 May 2025 13:11:07 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAoII-00000000WaE-3ad4;
	Fri, 02 May 2025 13:11:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAoIN-00000008p0b-1Jyw;
	Fri, 02 May 2025 13:11:07 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Martin Sperl <kernel@martin.sperl.org>
Cc: linux-spi@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: loopback-test: Do not split 1024-byte hexdumps
Date: Fri,  2 May 2025 13:11:06 +0200
Message-ID: <37ee1bc90c6554c9347040adabf04188c8f704aa.1746184171.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_test_print_hex_dump() prints buffers holding less than 1024 bytes in
full.  Larger buffers are truncated: only the first 512 and the last 512
bytes are printed, separated by a truncation message.  The latter is
confusing in case the buffer holds exactly 1024 bytes, as all data is
printed anyway.

Fix this by printing buffers holding up to and including 1024 bytes in
full.

Fixes: 84e0c4e5e2c4ef42 ("spi: add loopback test driver to allow for spi_master regression tests")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 31a878d9458d95fd..7740f94847a883f3 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -420,7 +420,7 @@ MODULE_LICENSE("GPL");
 static void spi_test_print_hex_dump(char *pre, const void *ptr, size_t len)
 {
 	/* limit the hex_dump */
-	if (len < 1024) {
+	if (len <= 1024) {
 		print_hex_dump(KERN_INFO, pre,
 			       DUMP_PREFIX_OFFSET, 16, 1,
 			       ptr, len, 0);
-- 
2.43.0


