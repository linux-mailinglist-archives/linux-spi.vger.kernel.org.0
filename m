Return-Path: <linux-spi+bounces-8866-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165DDAECE91
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 18:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E966A188F208
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C42204F99;
	Sun, 29 Jun 2025 16:15:12 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B8189F39
	for <linux-spi@vger.kernel.org>; Sun, 29 Jun 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751213712; cv=none; b=t6J4iB8gwBj/QAGlHlNlMpIORu2t6VRhRNWuZ5C8XHQRMgsdT/SwWOgG/utufj2yOnJZQiGrSgQnN0/WWITLJ39nFA3JSYN2oD5FVc1tnufk1pGH9whXR06iQ5uiCV0wCecPSiZZJNdYjAnpLXajG+U4CjFWm2TnZ74GwQSZjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751213712; c=relaxed/simple;
	bh=mN/wZHU9MM8JPH787Vs2rHsQj+D9q0m/GT/tcvghFOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IiEj5Ad0gKLXvSXzfvq1RByS8GkQ9eqWNuxvNPedrjZhAS3A62wGRDQosHtoPlOfJrB1Ifhv7lyCS919bOnK5JekK8Y2nszqYbesJHskYll1V1tPebKIY1VlHYRInP1qD9rVY2qzA3HNCyyY8SaTuN+V0cXBqEft+vMeuQ2FCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:dea6:32ff:feb1:177a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 3110867B9C2
	for <linux-spi@vger.kernel.org>; Sun, 29 Jun 2025 16:15:00 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id DFE2943353C
	for <linux-spi@vger.kernel.org>; Sun, 29 Jun 2025 16:14:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 432C6433537;
	Sun, 29 Jun 2025 16:14:57 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 061b3ba5;
	Sun, 29 Jun 2025 16:14:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 29 Jun 2025 18:14:51 +0200
Subject: [PATCH next] spi: Raise limit on number of chip selects to 24
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250629-spi-increase-number-of-cs-v1-1-df791bf4b370@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAHpmYWgC/x3MywqDQAxG4VeRrBuwU7zQV5EunJnfNgujJLYI4
 rt3cPktzjnIYQKnZ3WQ4ScuixbcbxWlz6hvsORiCnVo6jZ07KuwaDKMDtbvHGG8TJycMxDDI6b
 cdD2VfjVMsl/vgRT7Rq/z/AMlw/5UcQAAAA==
X-Change-ID: 20250627-spi-increase-number-of-cs-deeb23bcd578
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=mN/wZHU9MM8JPH787Vs2rHsQj+D9q0m/GT/tcvghFOs=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoYWZ7EYbRFPNaiN8CnhmQuIn51t0fNI4TKs+hO
 kH9LA6iCpmJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaGFmewAKCRAMdGXf+ZCR
 nJAvB/sGPfng/XOC5atAlRIqOp9yIdAHx9EmSi9ylQpI3yZTx5GnkhSC3r/qlmhkZLazJnxotmn
 bdtnGp4iAjvJljZHokZ+WD0ql8YXXTRy/mZWmu3+fsmQ0XUDIx1xJu6qddYYrx6mQr5NswXqxO9
 n0HuFdOP6ukJNdp+aTJd3Zndr+Wc7UgQ20NHeFUaUW3hPnGKuYe55ascOGzM94r12gKFkDfUwu7
 v6z2nX3FbUi5Y2uhPxwQ/Hr50FUbd6dQEutJMTd42CYFlM1CHut5u6Y5MROFXPSc7wHo8imsKEN
 yVb6rt2+IBIbkoIM1xEI4foevt3KZ55/iLCLieh1+AQI9ngc
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

We have a system which uses 24 SPI chip selects, raise the hard coded
limit accordingly.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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



