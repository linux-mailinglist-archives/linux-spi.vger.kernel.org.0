Return-Path: <linux-spi+bounces-12407-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2DD244AC
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0889230E2E8C
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7736337F733;
	Thu, 15 Jan 2026 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="l53qBHHO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541137C114
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477320; cv=none; b=Sm1fk/tyaCrU3bTDMnYQNqjCm9Jxl3poaCCRpfxM74u01Zu3ejwa2b+wKz/b5nTAj9FCicjlIVtB5yiDPEVLb4oIscK6uToZnZdIU1AHC7pLiOiIU+r0ua0dW+beQkkBxHfHAoDYa/rCcxfJqh/BJK7KYwW4Jk8fIKuZJQxl1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477320; c=relaxed/simple;
	bh=mkQUI++SFEZY6715sy/bRzpJpUAliolL1r9lnHRs51k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpQ57DQThQVYfcBsrBwgmcxrCn4e5vmVFqLWGraxUq0FY0E8lamb5Fgkm1kiDqzD2rZE3nbk982+qm/vXUMwZK++NgOShc5V/DwHWXZeduVYfM/V6+isunEmx0+xspYNF2Wjjktq56KAlXZn1ODpSMcJ0CbzA10r1qhbqIIDgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=l53qBHHO; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1232d9f25e9so1439697c88.0
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 03:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477318; x=1769082118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmhD7xqaP3tJ0Ge3gQd2f9t6bDUERo+PNGIof7/k4qE=;
        b=l53qBHHOC3NN4gnjGmjzOZAahtk/NF+6fvAt9wqb9Im8E7JMc1M/45s2CqXUlB4W0a
         uuZHwx4eFrwNmU2bh3yp7Eoqb2WQitklVmlOsuVApYFjbE5nlv2cINFaj7P3hSAHunTe
         pxT/zsrKT3jXCVb542lNbKos3OrWTtwoQdJiYrKU1WflD0OQ1m8m/renMuVafFd28Gqr
         rFCo2UZhdRHYm+CMV1XgbKCZ7bJhNoY4ZNLDTqzC7wzp28ixZ0q/WqsPxCq8rlwFUG0k
         0Z/Wl4MKmwhFIkRPobQHpEa7OLi5f2q0uVYnp7z22N78r0M+hg8tJi9X5eKpxq2Z64yw
         mk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477318; x=1769082118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmhD7xqaP3tJ0Ge3gQd2f9t6bDUERo+PNGIof7/k4qE=;
        b=lbkcA6tmfVb4jRUeq4hBPMS7OTtzc+0aFOQfwaTFWJDwh1sbMCx2TUGoax0kmKkfQ3
         qEYUX1yN+HkUYHSYhyEy1BqUM3Jwe7TvPuzFTpg76TPmtXj0hzfSSZHXgEaKj4RldRc3
         veLaRQLh7uAt/9+nqInkd72lg/ijqcHEgXqPfPz/eFsJeYfe8vkNCqrBaPe8PPcIVxGz
         lr5mKS8kmh2SnmbGMNYRbmHlldgRCcIQl4tpCEs14pxS7zRYktj+KyY0uyCPmIoFGzPi
         zcZFE7yDTsWtmSX0VeB67UvBKN2XHfiYOxKzq4oCxEL4KP9jt6DLV0VDt9To+AwMGhZE
         RlrA==
X-Forwarded-Encrypted: i=1; AJvYcCVgtWpQ022yFmnQwGdy5qggSmyNS8+nn4XsBx73rpfNs4uOEARfOD/47UFZeIGU6Ih0nY7NOMSawrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQSYAgb3OiM2hIy8I8D4h7LGtZROQdqG2j6Z4rJgvHGlJS5jPK
	cfUEDSNAljEncnD09snq/KkdnMGd0CxElav3bDEfMG25LcAEjhEfiw98D+6NzCp9WIM=
X-Gm-Gg: AY/fxX5zr2GyJwCEaXY5Hkk9WG/MkpSFffa1H2yd1JzNeZDxl5WhgGkZyMW5xwr0blu
	9o92PZWsF5VpSpv8L6pzApzx6ERgUafrqBoupN8c86UufaTaFmW0rGWPkdr/y24HHr68J3wKETQ
	F/v/0oZtXJSbaXCQhYwu23rS6Xio+A9PyAoe390Q6HJESIdUFQZee3wsCM4RFykILPs7qYxaL1J
	QsRFxgEan9A5J0SdnHPUoEAgaphXuFxPg2RSp2LbPm6zBZ5eW6uOrNGSFQl871SiZUFpxppeFb8
	lOgn5rKGkl3oDblcPG5SPpuKTOaA6+IyTXxo/n2p+zqs2iY0YYCt/zt6udKBv6IlXs3BE5okkBP
	U62z77FS/guNR4aqdQg0vUiL2ENyAhV07BWJrWgQIR+ghipo2/eJ7VVJ1lSHriPi7n3poE0f5Ge
	nXRW2GSI6gzOhLVZ5EnVX9VStWJ47UKjo/hQ/jMk/bxlkcnVhsAE4/LkZ7q4r7osDlrMX75t57F
	w0pniil
X-Received: by 2002:a05:7022:6184:b0:11d:e2a3:2070 with SMTP id a92af1059eb24-1233778b5f3mr6944456c88.44.1768477317748;
        Thu, 15 Jan 2026 03:41:57 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:57 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v5 10/11] dt-bindings: net: sparx5: do not require phys when RGMII is used
Date: Thu, 15 Jan 2026 12:37:35 +0100
Message-ID: <20260115114021.111324-11-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x has 2 dedicated RGMII ports, so regular SERDES lanes are not used
for RGMII.

So, lets not require phys to be defined when any of the rgmii phy-modes are
set.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../bindings/net/microchip,sparx5-switch.yaml     | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index 5491d0775ede..75c7c8d1f411 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -151,10 +151,23 @@ properties:
 
         required:
           - reg
-          - phys
           - phy-mode
           - microchip,bandwidth
 
+        if:
+          not:
+            properties:
+              phy-mode:
+                contains:
+                  enum:
+                    - rgmii
+                    - rgmii-id
+                    - rgmii-rxid
+                    - rgmii-txid
+        then:
+          required:
+            - phys
+
         oneOf:
           - required:
               - phy-handle
-- 
2.52.0


