Return-Path: <linux-spi+bounces-5800-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D89D6032
	for <lists+linux-spi@lfdr.de>; Fri, 22 Nov 2024 15:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F121AB21EF3
	for <lists+linux-spi@lfdr.de>; Fri, 22 Nov 2024 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473C083CD3;
	Fri, 22 Nov 2024 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="sWtnn2ba"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FCD50285;
	Fri, 22 Nov 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732284795; cv=none; b=vDYKMHcAS7srDqYookDfpa2wC8rkEIQa22oVkPxgXxGRCqgpj3oYILuIcVwo2EPDAjxRS9iTZ7U1Nd5NOgEQa5QQtd2U4c72aPf9TjHzrQzi7P3//geeUlkYGT6Aj6OhoT0FfIZSkce6+vHEmKkAMDNGewzHSbLqobW3hsf/evM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732284795; c=relaxed/simple;
	bh=rp0g2gMEttojyRYI4uDvxDp6DkOIrfoVvMqrg8up9eE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ldUH5Fxm56E2ZenA9E3XdTcZ3ZDAd0uTm4zpBUVO57x8mkHfUNbrhq98sgT2IPY2fl0zTDdo/TQf31BS4TbMHAX3A1RDZy24zXpbwO4/JDQGkarwZqvSPl6n+2MwUIbohzI2j2vt1qhy7Ipc5viYtDOCjWvtStyNZn8APbQVo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=sWtnn2ba; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 92386A03A7;
	Fri, 22 Nov 2024 15:13:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=rS0h64lEvJkOELi9LIcTxMezSjA08oWQTk1+bZmTreU=; b=
	sWtnn2baWensTrkkaHkuUpwJM2czdi1p2y9W4swtcx1CRcy3N/dv9XFnsZrKDsiB
	PNpkUC1RR7hhJlrMV+KhD1QpZCaMKyyCWnqhhexQsSJU9lBc0iAgF7M+k/LZ0UBO
	hiFOIQ3/fFsovTZVR8xNw2g1Yacdrj0nUBirDodQZhoFyZIPjDgk7w87KaZ+Ad6K
	DX3NkAoLQ4kyjHD/P3IEbIHeYBcGi9HMswz9kKFIlvI23rnRqCmzM3VQAPP9aAtm
	0QRBeZK64+1VA7WAkAQcVBZUeKsq2GgiYrYgxyLRMqQOjwc/9s9MuBGbv2v2kFuC
	RMjrqgW8t6kBh65NXSETzEmRjw0RdW4Ie9inGhdjoNhMkdKTd91mhNXCp78df8sL
	lxBsw1Ym+SNw5n9Aq+ZYSuLqN3bLCGbsJ3CujGAGToMIX19ruHLuk+MDtaLHk1m4
	JzU7CJRuPiN36TnLjkBjnMI6/q5fMF8aYevNwd4PxHKMksKAgzZye37+yPlsoe34
	ci30W4z4yMjP3R31RNgX6H9RC3gxsqz8oXFB1BItc7vlXjngNDyPL0DX/dxRpADZ
	3kNUr7TrpEgMfvRHYgRtlLJgYFuPmTQUm/B3LXbWrUFKfBF+rE+LbYd/tuIvKUav
	XEljaGDkoqiSCjKPLr/BNrHY6XYlg870uo9XUOLMjYU=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH] spi: atmel-quadspi: Fix register name in verbose logging function
Date: Fri, 22 Nov 2024 15:13:02 +0100
Message-ID: <20241122141302.2599636-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732284790;VERSION=7980;MC=2726538235;ID=74493;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560736B

`atmel_qspi_reg_name()` is used for pretty-printing register offsets
for verbose logging of register accesses. However, due to a typo
(likely a copy-paste error), QSPI_RD's offset prnts as "MR", the
name of the previous register. Fix this typo.

Fixes: c528ecfbef04 ("spi: atmel-quadspi: Add verbose debug facilities to monitor register accesses")
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 91108ddfaef2..316bce577081 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -183,7 +183,7 @@ static const char *atmel_qspi_reg_name(u32 offset, char *tmp, size_t sz)
 	case QSPI_MR:
 		return "MR";
 	case QSPI_RD:
-		return "MR";
+		return "RD";
 	case QSPI_TD:
 		return "TD";
 	case QSPI_SR:
-- 
2.34.1



