Return-Path: <linux-spi+bounces-10766-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C87BBF97DE
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 02:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DB474E76E7
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B2D1DE4C9;
	Wed, 22 Oct 2025 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZOq55LUq"
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334A1D61B7;
	Wed, 22 Oct 2025 00:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093730; cv=none; b=XSdNS1/rHkrhBDXkHCHOJ1HEn0Us0qDTCovZaFFppuMlYJCC0ZKYBrPmBGYBiphkpUUi4CTZ2uBCBKF1iUeEYhWNcShW7qAxyh96sXYoBpITdROPRI4bPq83/biajfcMJQ1P0FP+U6NBozuAAxyXHbshBUWXfLRZw3zWBXAtJZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093730; c=relaxed/simple;
	bh=lrlI8kaKnlQcc6WSTKi2AMrvVDVav+P/m/GQflMXKao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lb0l+p7FhK3Ei3FFAHb+u2ToVgpN4wIoVEwN/9hAwnnStOGaRu4JLHz7YXSAMAlWf24KbyEnOC3qXfPtU7yiVYzaefDVwQVx4+nsGfmSaxrA2j/bSlFFL63LTyXtZik3PgsJ4DC8b4h1GETi76cO6fodGyrzJbYFPeZ7ASa5AAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZOq55LUq; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=RsCiTjfAJVGKd8jls9/TBL277kk9xNpzA5VJ2++/V68=; b=ZOq55LUqsOYpHtsTa8MaDcX+xO
	MWsY9mqJYPBQLKWK0jBiOqVABz8CCKXIdOlnZbJ/jChV/HH3dxjEExavHZsP4ixZL7yL/78kJXuWW
	iqw/d5lbXy7Q/bs3kZzWa5xdZMUZzoQYT9DdKDnzxBU2b7mJaQTlVNMpXlpinoTJ5h3G+CVeToGAS
	/IkJGwW++ZpcQTNLFTaLmjPHjdbC8xnWrRuMWRkQazqLafdKH9xutHlcXEJnU1LfdByJPCPX87Uye
	IDJ/x85EeC1MjNm5QwLJv36Vrjjpbkk8leqpIsj3lmO9TvBoS+UAO+29vVUCBYV5+jGyxECr6XnRY
	uc96Ttkw==;
Received: from i53875b19.versanet.de ([83.135.91.25] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBMvT-0007Tx-2P; Wed, 22 Oct 2025 02:42:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: spi: spi-rockchip: Add RK3506 compatible
Date: Wed, 22 Oct 2025 02:41:59 +0200
Message-ID: <20251022004200.204276-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI controller found in the RK3506 SoC is still compatible to the
original one introduced with the RK3066, so add the RK3506 compatible
to the list of its variants.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 748faf7f7081..ce6762c92fda 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -34,6 +34,7 @@ properties:
               - rockchip,rk3328-spi
               - rockchip,rk3368-spi
               - rockchip,rk3399-spi
+              - rockchip,rk3506-spi
               - rockchip,rk3528-spi
               - rockchip,rk3562-spi
               - rockchip,rk3568-spi
-- 
2.47.2


