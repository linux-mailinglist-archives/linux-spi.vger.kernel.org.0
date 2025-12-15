Return-Path: <linux-spi+bounces-11926-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8118ACBF25B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 18:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3471D302039D
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D1133CE95;
	Mon, 15 Dec 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Ak7lyKPT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597133ADBC
	for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816761; cv=none; b=KFl8VezWQ78HLN2HWj3oE8N263ZJqp3UsS8hHBq+iHtm+qKGxmb/ShFf9WdiiQ1MMR7FYuXfJjbX3H+NAyBM0pTh7I43MJj9zN1AomRR9qCnrTUyB1QGJe0gPPDn2nmkorChuIwH25M3ELOrwPMXgxDOM5BQezqcLtZ7/ZeTiPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816761; c=relaxed/simple;
	bh=MatarePl5a5XyouzXF+9ZryyErb8D312+5WkUP2SbUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUzNt1X+lDNmH8uAiJoAsC6xxemmfkkFF/yryOSo1QmIdKSo2pSy6ZljlgOmpee8GTWcIWcFPTeecCLGNDPL2D2VvW41QYR7JTMN4ETe1b3HSHK7OQlM+bTlMHrqbJSFE/oE7kgsI2Gm1X2HQVpZbvKy22tdoF8Ds/TaEenHs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Ak7lyKPT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47a8195e515so30240535e9.0
        for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816750; x=1766421550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8YcHY5v5BL8p7Cq7PHlLyAS2e/CqidtOgzAnVomKxs=;
        b=Ak7lyKPTdvJT/5Yv+iN/8LSGRVf5YK/mE3nJ40Yv8v5WMEygg6FZqSllz4L9oiC6g6
         cVzdeYT+IXU2lNR1S9VuWsHsONOsbxwjqKUQUGF/bXURX2ZECo9CEKUcMdm4FbZocUdm
         2i0wVhkFw8JWyji/ASYx2hz40xV5ycXhF77Uo11OdNHF5/+f9r/2mQtbTpjB3TSfXh6L
         YYQkoLq5+xTuie5xaF48zIMd1GQKQg+73FbhoRQhJifJZ1gSqMtPxYHCa6AzJ9AD1/ab
         oD2K8HRM/EnxuEWq/plNpjMA2kCTVieijCNKzQpUH7KbXIx93gk1euQD6vOPM5SzUX1o
         gsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816750; x=1766421550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8YcHY5v5BL8p7Cq7PHlLyAS2e/CqidtOgzAnVomKxs=;
        b=emJ+1ycorymfRlRe9Ed3v8PEmRGiz2SRa+qGc0RL0Vgka8uSTLuz2g3NUcCJtmeWgG
         TSMYhbO1dCH4R2++Iw1/TkeS13saw+5FzhpzsWvPb7pXbyFJdti10mTMc1x3bRvzpSXC
         SvVbBrcTnLSt8SyTUeODDwecBfGBygh5VkwTSoxCcAv9dGEFxjLg7n5Ban0SGRYW6C8l
         2g2fl/KixxL0GFMG/LZcqaUW9Yeym5t4Jpn8pZxTYVjFZ0f+zDTEYOCLE1n5qvJ5edBX
         i342w1RJ6sROmI0uy+1OZ/d1i2ECufw+9g5RQt3ua9KjUbD2JaZPBS9ZVefjSPq9cFr0
         BMJA==
X-Forwarded-Encrypted: i=1; AJvYcCXzS72NTvtidY8K36TfyUO8gG32pof+B2F8FPxoerXFmrcdQXrrZWNh9gAVTztv1txFkHZ4gjeGCyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwltpAevTXLcj5UPclQdV6UodG5qms3FaWt5p54SiAij6f2KMF
	euUn2cRw7IPpTzj6gSmWMPEUFaxyV4qgeJCCesRoiprHQnOuvgIZ5ohTICmFtARJcnQ=
X-Gm-Gg: AY/fxX5UEwHukxFkEaf+uKfDF/iwwtZDyqzkM9QwXs4toGDxcYCO/VINypryVOApaq5
	ZmVghUKwxI/MM/s2CKSMtInaWGYJX0Rc/5ajKNO9JT/90Och2jVO1oLhQNYjgAW6tn+Kb2MSUSk
	UQdE9nKd3WTxAYgmRSnqs+/rcY3s8zklztMbcAwGWGpuQX7lz4pGqT/7i7o1Kkt7TEZCc/TCtxe
	2TDBe0krZFI9O2MuBK/QSTHoWDKec2T/JSmrDTKso5WpaDqjOnnv5ezeKqTTVhLnAGclkDyRMys
	HzA7/HeeGhIFYWjAglrVutz0GuleyP9/joTV7+cEgBgMA7DV+xhaO9nu0yakUu/r0oBTiZOYJYI
	f2Go1O1RAHTXNiEO5rRsJkekybHGZh/8nsGZHVjMHTXNKxWycTYJIH8/3NXx3KZrCb0xincVpKM
	EjC2pUJFJxgYHqmTcgMoA4qnsW8WKAk4KDcYADBk6up5UT
X-Google-Smtp-Source: AGHT+IH7LP1zL48BN4L4uNrnTgDczVYK0VmpeljjcZUIjxNDtnXInUvDJihsME7YWq6t8mes39E9Hg==
X-Received: by 2002:a05:600c:4f86:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47a8f9057fdmr118557835e9.24.1765816749513;
        Mon, 15 Dec 2025 08:39:09 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:39:09 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com,
	Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com,
	tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com,
	kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org,
	mwalle@kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 18/19] dt-bindings: arm: microchip: document EV23X71A board
Date: Mon, 15 Dec 2025 17:35:35 +0100
Message-ID: <20251215163820.1584926-18-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215163820.1584926-1-robert.marko@sartura.hr>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip EV23X71A board is an LAN9696 based evaluation board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/arm/microchip.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/microchip.yaml b/Documentation/devicetree/bindings/arm/microchip.yaml
index 910ecc11d5d7..b20441edaac7 100644
--- a/Documentation/devicetree/bindings/arm/microchip.yaml
+++ b/Documentation/devicetree/bindings/arm/microchip.yaml
@@ -239,6 +239,14 @@ properties:
           - const: microchip,lan9668
           - const: microchip,lan966
 
+      - description: The LAN969x EVB (EV23X71A) is a 24x 1G + 4x 10G
+          Ethernet development system board.
+      - items:
+          - enum:
+              - microchip,ev23x71a
+              - microchip,lan9696
+          - const: microchip,lan9691
+
       - description: The Sparx5 pcb125 board is a modular board,
           which has both spi-nor and eMMC storage. The modular design
           allows for connection of different network ports.
-- 
2.52.0


