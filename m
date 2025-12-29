Return-Path: <linux-spi+bounces-12162-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ABDCE7FFC
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 20:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2DE630022CE
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059DB33D4EC;
	Mon, 29 Dec 2025 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="LyRSbbrq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D2033BBB1
	for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033639; cv=none; b=hLUhTEdj2u5qrOJibCTvpNhodJA/ZYtRQ5TGPg3dcdeLr5yI1EIo/9ChTMqO+NzQ9f2ZOj5zW9QiRQxxAfFh0O+csui5oTS7UPSlnrxJnBh74TZo+3+uANHyNjwE9vGhK53dYKwMzr8H1GjNTALDjFuFtxidwAeGrgvIUJYOhdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033639; c=relaxed/simple;
	bh=Q1obzpbb74AZt0ukfBT7/Xcte4bERP/uv0lOi/h0us8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jz8EaU8NOYmrv69vQ3yvR7RvchsReIpvhHkEs8k9AdmeljCc4MXMXrerXDZjtF+BPHeKrfle2aJ6SCl70PtTxNmaCz24wxfOsDYkkSViKrofoPjSOoNPlk3YN/AwJSuT+ItXPNFtUy/N1bfZkwCMgvj6E3wsq0YuQshWUk2TCnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=LyRSbbrq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so22431435e9.3
        for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 10:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033634; x=1767638434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD3TOo20gfVbUTTrRVEjhVDMuAvx6I5y/UndE2JGgIM=;
        b=LyRSbbrqhsYCVMar6TnbNq5OwUK6vM5vLOubw24DS+DHtGNV+bJd9Ws4YLFLcIaAk7
         HWPCtBIRseMv3/cnK5UmboWJt/jYxd0RuJWmcbt2Yc58+DpXPQwFcYmx5ERXgyz/VGnj
         V9qPrIkX8CwYabWmv/ku38VSqUqR3RGC4o789At+xV4gIlr9J+R+B5MA6mEnjByrB5D9
         6AGB6F9TcKy1iuVMGebdlKSCHbuE+vyg+Q01p4WIc/CbgEApewqay4CiCCRYEI2Eypo0
         a4p8Uo/of/KtQ63rWWRF9/G+a3GHxhBtDB30wW9cC//iynv4tt2gWEPfDR5IAzePQaxD
         wR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033634; x=1767638434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fD3TOo20gfVbUTTrRVEjhVDMuAvx6I5y/UndE2JGgIM=;
        b=PgkGCiatD2wPGwuEpCstLNLCewynnWdLE4cQn0G/soOYCvsDBgazHWEvn9yzRDZdvA
         kpy8Xs2ZQpiN7Pl+9shYIWi2lVGuV7IPm2YXBjoneVyEOFGikAMnp/v/8Rz+oF54Nw2g
         cdnFd6UKaP4hdXmmWfFpj/vTp3mmQsosvI76Y3JxmN1SwJJWsrLfmBb5ZO+OQ2+Pxvuz
         4UtR5AUgEJ6zb1BtpS+WT21TPKscZzedCsgBodMV3j/fMiFNOp8YWadVA2Y8GjOsLAQD
         NGbLUtmC6lO0xD6Wt42P9a2u/bKusGOFUSseZciai7+I6Ex+Wy6dN5214zPxFMeyyEzu
         b2RA==
X-Forwarded-Encrypted: i=1; AJvYcCVnl0zhfeAK1FcOB4VUbkMhBZp49K6RYTjBjniUkynBl9ykF+N1UzfyALqG2pVjzTpLuG+kiru9R8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/tYcAU0a32mKmsTmR4SRv0uhcl7ReCPcaLuLXes3SHBTcv6Lx
	zTig5z4zcE0TuVOrlhBe5C27wq2rs0KNRxaatJLMLIMLmcWuslJL1p3CjVsKpyMeX/Y=
X-Gm-Gg: AY/fxX7kFsmvS//5VMHXWrtnOg9AXG2lS+9n5KlMqYoGBQHF2DIWNTbC/tGCzZkFsnH
	j3SGdso4t4dqKVxclRsz0AzMs35fuyPb0ersy66aty6mrlXe7V5Na97jIJTs5PY6Qcu1qbDMra+
	WfomvrJvnm3Yb2Mgpt8p236nUX+NwVjq7MMWMzSpjvE1dKtrSpTJcvNoLwpHOz8Ym9hQTrXyXh3
	23PcsbihZa0Z8T0ZvfV+vEiuQmBrI3SJmci1Ec3J6CQv2Rm5up4fgEdQ1d1RHNryfk9LyILk+0j
	cYrUJUn3uyJcL8GxX8GmzddhS5KPpbJWQqEhwMHCTHYTMZ1Q699v6ni1FoZR7ffeUdtMBidS/RI
	WToR/xyw5tgmjBLeT5Eon3ircZAK98vl96rejIr/sO6PXteMv0jW3c1RedPQw0oj4P1k0m8d1XE
	xqNVLFGaf4pVomch+6oxYeBrUyBP43aHFZfvpkiJYZSrjibRrJyh90i1qS2sMK0ktjI1WSD+NcI
	jf4LjOMdOV403DVUENjZHNBfbbT
X-Google-Smtp-Source: AGHT+IEOW1WMqA9XyyxJdu/NN+RbiiVAdkX9+5SQ+X2Sm6Ndg4Ati/iuxawV+Wvcj48RXpcfvKGVGw==
X-Received: by 2002:a05:600c:c115:b0:47d:3ead:7439 with SMTP id 5b1f17b1804b1-47d3ead7574mr139091495e9.37.1767033634253;
        Mon, 29 Dec 2025 10:40:34 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:33 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 11/15] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
Date: Mon, 29 Dec 2025 19:37:52 +0100
Message-ID: <20251229184004.571837-12-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229184004.571837-1-robert.marko@sartura.hr>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document LAN969x compatibles for SGPIO.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 .../pinctrl/microchip,sparx5-sgpio.yaml       | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
index fa47732d7cef..9fbbafcdc063 100644
--- a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
@@ -21,10 +21,15 @@ properties:
     pattern: '^gpio@[0-9a-f]+$'
 
   compatible:
-    enum:
-      - microchip,sparx5-sgpio
-      - mscc,ocelot-sgpio
-      - mscc,luton-sgpio
+    oneOf:
+      - enum:
+          - microchip,sparx5-sgpio
+          - mscc,ocelot-sgpio
+          - mscc,luton-sgpio
+      - items:
+          - enum:
+              - microchip,lan9691-sgpio
+          - const: microchip,sparx5-sgpio
 
   '#address-cells':
     const: 1
@@ -80,7 +85,12 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: microchip,sparx5-sgpio-bank
+        oneOf:
+          - items:
+              - enum:
+                  - microchip,lan9691-sgpio-bank
+              - const: microchip,sparx5-sgpio-bank
+          - const: microchip,sparx5-sgpio-bank
 
       reg:
         description: |
-- 
2.52.0


