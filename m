Return-Path: <linux-spi+bounces-11373-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EE6C72F94
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 275123532F1
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FDC31062C;
	Thu, 20 Nov 2025 08:50:38 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F23307AF3;
	Thu, 20 Nov 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628638; cv=none; b=rxA+qRmDdIUVtgJdILf17QFBeOB5yB4O6Jv4RiTdzjDhjuJi+5fsm3c0mKUU85FXt8CFSqZhn+0BFU/poqQ/xtw6ULlSrsBnPIsYBgneQpWnoRiGZSloj0qa3+B9DFvX/FTTBhYob24AzhiKAmucC72uzeNgMMfpUGrfmSWw7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628638; c=relaxed/simple;
	bh=YXEuwywmxBkYpZosxSHNtG4VzTQR0mXrJmAC1VDFhBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlhB/gR6rR/4arEF9jlxGTSvsrrwhJXsJ9OQmGLTm6B0QLj9K2Zr9OFPP0fk6g3ZqxwLawjZ1vjowW7wY3df1WNFy1+hhMdLtb9z/s0zLzEi2mwGeNW8iRbS2SMbU4Ta76rkmhQlAQhEFlqMJHmMehvb3IwW072Mf/nrs8nKAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4dBs9T5DX2z9sTD;
	Thu, 20 Nov 2025 09:35:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fd5cKkgsgj89; Thu, 20 Nov 2025 09:35:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4dBs9S4C2Sz9sSn;
	Thu, 20 Nov 2025 09:35:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C5D78B76D;
	Thu, 20 Nov 2025 09:35:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 92U5nWTLlA_P; Thu, 20 Nov 2025 09:35:08 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B0608B763;
	Thu, 20 Nov 2025 09:35:07 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"florent . trinh-thai @ cs-soprasteria . com" <florent.trinh-thai@cs-soprasteria.com>,
	Sverdlin Alexander <alexander.sverdlin@siemens.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] spi: fsl-cpm: Check length parity before switching to 16 bit mode
Date: Thu, 20 Nov 2025 09:34:49 +0100
Message-ID: <3c4d81c3923c93f95ec56702a454744a4bad3cfc.1763627618.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=YXEuwywmxBkYpZosxSHNtG4VzTQR0mXrJmAC1VDFhBk=; b=kA0DAAoW3ZBwJryrz1MByyZiAGke0qvIJOmxgNNVp6vnvYsjQMByo+HWoNXcOHxXDQgIUSs8K 4h1BAAWCgAdFiEEx/8LupiK9GVvlbov3ZBwJryrz1MFAmke0qsACgkQ3ZBwJryrz1NqIgD/cwoQ IJ2HjrFPjCBPxTbdKq7vfJUfc4yYNWwb8JS6bnoBAKGs2xwM+npjfnQMdUmzEzIkW2D4FHwMWpH QB+ORDBkP
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit fc96ec826bce ("spi: fsl-cpm: Use 16 bit mode for large transfers
with even size") failed to make sure that the size is really even
before switching to 16 bit mode. Until recently the problem went
unnoticed because kernfs uses a pre-allocated bounce buffer of size
PAGE_SIZE for reading EEPROM.

But commit 8ad6249c51d0 ("eeprom: at25: convert to spi-mem API")
introduced an additional dynamically allocated bounce buffer whose size
is exactly the size of the transfer, leading to a buffer overrun in
the fsl-cpm driver when that size is odd.

Add the missing length parity verification and remain in 8 bit mode
when the length is not even.

Fixes: fc96ec826bce ("spi: fsl-cpm: Use 16 bit mode for large transfers with even size")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu/
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Sverdlin Alexander <alexander.sverdlin@siemens.com>
---
v2: Updated with comments from Alexander
---
 drivers/spi/spi-fsl-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 2f2082652a1a..481a7b28aacd 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -335,7 +335,7 @@ static int fsl_spi_prepare_message(struct spi_controller *ctlr,
 			if (t->bits_per_word == 16 || t->bits_per_word == 32)
 				t->bits_per_word = 8; /* pretend its 8 bits */
 			if (t->bits_per_word == 8 && t->len >= 256 &&
-			    (mpc8xxx_spi->flags & SPI_CPM1))
+			    !(t->len & 1) && (mpc8xxx_spi->flags & SPI_CPM1))
 				t->bits_per_word = 16;
 		}
 	}
-- 
2.49.0


