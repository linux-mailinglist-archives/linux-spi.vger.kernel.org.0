Return-Path: <linux-spi+bounces-11133-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9175C445D8
	for <lists+linux-spi@lfdr.de>; Sun, 09 Nov 2025 20:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 971FB4E2974
	for <lists+linux-spi@lfdr.de>; Sun,  9 Nov 2025 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3D222FF22;
	Sun,  9 Nov 2025 19:20:36 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F184C81;
	Sun,  9 Nov 2025 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716036; cv=none; b=YWZ/LAHwAmK3301Ilyts6ieMjsXBZWjj71AJpnATo5BWVm3T23TauNOEaZTsx4kDcvwfBU+GWGPv+nJRIbYi1413Cy2c3/jWXSornYAzEHVEoMnIHzpS5CiPw2gNVpgZAqmlcZJ6JW9x2fOzuFKOSCdANUlofssKLruiXTmC9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716036; c=relaxed/simple;
	bh=Bgx99z34e/6h/9HzjKaC25p2jZt0ZHHc7KW5LZEMiow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3Pd4+OKI8QMjsfh/X8viTyAmmMR8WiCuipFKZW6BhQKBa0Yus+/7qSRov0exIC4t6QgDycn2aiPl0vAOwgzvK/WYPkkqPq1itvcIDrnarTn8P7BSzE8omvuHQctD7shrCucnSsKJWLZIyjDZbxYISndyeMmI8+JCeYy9rcOL88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d4MT64pmLz9sS7;
	Sun,  9 Nov 2025 19:56:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id elgN_9VFtaew; Sun,  9 Nov 2025 19:56:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d4MT63kthz9sRy;
	Sun,  9 Nov 2025 19:56:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BF528B764;
	Sun,  9 Nov 2025 19:56:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id rD2WpwSJ8_KA; Sun,  9 Nov 2025 19:56:10 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E93BE8B763;
	Sun,  9 Nov 2025 19:56:09 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"florent . trinh-thai @ cs-soprasteria . com" <florent.trinh-thai@cs-soprasteria.com>,
	Sverdlin Alexander <alexander.sverdlin@siemens.com>
Subject: [PATCH] spi: fsl-cpm: Check length parity before switching to 16 bit mode
Date: Sun,  9 Nov 2025 19:55:50 +0100
Message-ID: <07d1ea39a0e9b56846395d79d489a5153206ff5c.1762714267.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=Bgx99z34e/6h/9HzjKaC25p2jZt0ZHHc7KW5LZEMiow=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQKPN7mqnBZfeY1y9lvdJfe/j1N9r3rhsdhSTH1X/5q2 4gmm1g/6ihlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQAT+ZPMyPB450kT/rVvNlxV MWPbc2Het/88lw3fC67T8Tvz/c4SsfgdDP9MpmYW/97X9Y51ZtcNFp5H9xjtvtpvMS759jt/25E f1pc4AA==
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit fc96ec826bce ("spi: fsl-cpm: Use 16 bit mode for large transfers
with even size") failed to checkout that the size is really even before
switching to 16 bit mode. Until recently the problem went unnoticed
because kernfs uses a pre-allocated bounce buffer of size PAGE_SIZE for
reading eeprom.

But commit 8ad6249c51d0 ("eeprom: at25: convert to spi-mem API")
introduced an additional dynamically allocated bounce buffer whose size
is exactly the size of the transfer, leading to a buffer overrun in
the fsl-cpm driver when that size is odd.

Add the missing length parity verification and remain in 8 bit mode
when the length is not even.

Fixes: fc96ec826bce ("spi: fsl-cpm: Use 16 bit mode for large transfers with even size")
Closes: https://lore.kernel.org/all/638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu/
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/spi-fsl-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 2f2082652a1a2..e845baa56cc66 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -335,7 +335,7 @@ static int fsl_spi_prepare_message(struct spi_controller *ctlr,
 			if (t->bits_per_word == 16 || t->bits_per_word == 32)
 				t->bits_per_word = 8; /* pretend its 8 bits */
 			if (t->bits_per_word == 8 && t->len >= 256 &&
-			    (mpc8xxx_spi->flags & SPI_CPM1))
+			    ((t->len & 1) == 0) && (mpc8xxx_spi->flags & SPI_CPM1))
 				t->bits_per_word = 16;
 		}
 	}
-- 
2.49.0


