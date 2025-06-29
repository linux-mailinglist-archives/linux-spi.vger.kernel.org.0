Return-Path: <linux-spi+bounces-8867-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E570AECE93
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 18:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACFF16F8C3
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076A41A23BD;
	Sun, 29 Jun 2025 16:15:49 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35685189F39
	for <linux-spi@vger.kernel.org>; Sun, 29 Jun 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751213748; cv=none; b=ES0qKMGCCSdv2C79bq70cZSRij+2KxyUY3m4hsoJEanYZzHUDkXFDZDh9tju9GCb9U9RIpmV37Di/gm8Hsh861GZOPQC4qpW4vEeaQ/GrF3f2AqMfLxRIShIwkEaIKhnLb0TYKTL4gOTa/OiExoeezdxkZ+Pwu0Q77xNURRYuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751213748; c=relaxed/simple;
	bh=+Kt0k0jHnBiUtiTVq9BlDLOWC+Ty8iKPLlBDpt7c5fQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JxL0DSKZtgQ+TzWXKTTJgOKOpiAnlpWLnRa6z1FzCyCEhvxZJtAps20yJ8taSBkj3h1WngrLjM5pafTe703lQ29w1gtHy3u8gkqe0mzzovRUCyxTw03DpMFdfHiHNE7NLl7a9A6rPl9/Qu5hPxFHUFThLfb4hrB0w7s1Z9AaBU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:dea6:32ff:feb1:177a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 680C067B9CC
	for <linux-spi@vger.kernel.org>; Sun, 29 Jun 2025 16:15:45 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 38B58433549
	for <linux-spi@vger.kernel.org>; Sun, 29 Jun 2025 16:15:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7B4F9433544;
	Sun, 29 Jun 2025 16:15:43 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7d7f6a66;
	Sun, 29 Jun 2025 16:15:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 29 Jun 2025 18:15:32 +0200
Subject: [PATCH next v2] spi: Raise limit on number of chip selects to 24
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250629-spi-increase-number-of-cs-v2-1-85a0a09bab32@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAKNmYWgC/32NwQ6CMBBEf4Xs2TW0iBVO/ofhQNst7MGWtEAwh
 H+3IZ49vpnMmx0SRaYEbbFDpJUTB59BXgowY+8HQraZQZayLu9SYZoY2ZtIfSL0y1tTxODQJLR
 EWlba2Fo9IO+nSI630/0CT9sMXU5HTnOIn/NwFWf3czd/3KtAgdapRmh305UqnxP5YZlj8LxdL
 UF3HMcX2J7q5s0AAAA=
X-Change-ID: 20250627-spi-increase-number-of-cs-deeb23bcd578
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=+Kt0k0jHnBiUtiTVq9BlDLOWC+Ty8iKPLlBDpt7c5fQ=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoYWarNhBJ/vnFb5ggl/9EHFSR+D84ywXNUe3dV
 g1/GEHyktOJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaGFmqwAKCRAMdGXf+ZCR
 nKvYB/47vXnqQEmeX63Y1zCwvX+ii0QA/QcS6T1L9yX6JVeTVl6NxINi3ao81DIiTLuPdPlgHxx
 E1xh8NDiAkzDMuQEMGK06FYW7j/s0sg8OjX4AL3L/0zsafrCyeseaGrpaYY4sS0/q3RYTeVIRmQ
 0fM1u/E+Ue/BayTmT/dcHylVFiQtI4pA/CjRM7S2r3cjTBgJu3JEkbPCx+6iVK/nox/cJXzcYxs
 G1vtxnH1K0y4tnPLgU/A4c3UTq0lTwENU6hKEf/0ax74Go4zCDnY7qwCFm5C1Kk0XuDzvhobodB
 vLW3FZ0FRYtOHIoRCLGCaBBI+boxjdKSoRh343SHuuBULdEW
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

We have a system which uses 24 SPI chip selects, raise the hard coded
limit accordingly.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20250629-spi-increase-number-of-cs-v1-1-df791bf4b370@pengutronix.de
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4789f91dae94..e9ea43234d9a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -21,7 +21,7 @@
 #include <uapi/linux/spi/spi.h>
 
 /* Max no. of CS supported per spi device */
-#define SPI_CS_CNT_MAX 16
+#define SPI_CS_CNT_MAX 24
 
 struct dma_chan;
 struct software_node;

---
base-commit: 3e36c822506d924894ff7de549b9377d3114c2d7
change-id: 20250627-spi-increase-number-of-cs-deeb23bcd578

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



