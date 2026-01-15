Return-Path: <linux-spi+bounces-12400-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C9D243D8
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29000309456B
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF53793C1;
	Thu, 15 Jan 2026 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="nKo4jwJp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C737BE72
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477264; cv=none; b=KDxEHMBOpFkMuZLoifHDFZUqeq8oJ+ME1h5Ea8FE3vAYsJkeFCHiymGdv3shZm5SYzpehJ5VDsw5iOl9gfhOLggOhzhES9koS+LNC6dyJMK1v0W/Tz2fYN4FMPDjG3xxz6b4I5nTMavITPGHbqHjeu1akHOC/GecWxagjpl5Hk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477264; c=relaxed/simple;
	bh=duZt8ClU+VlM+r6OEAYG4uNskSnrTgaQSTmGeRNkhp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkpfOFS+j1BSanMS62KjdUQLWkJPyS4KZ81XwWPpgCgLjm8nvSYpoqjr7AR5vUyiJwExrxyqe45Fzr0R418UaSYASwXhEQ5ppVCtAAU/spNmS2o+GmVfqJSh4jOtCJ3VGGxC5/QYGfFaTokC+2BqpV7gCdLZtpwrlrbzlwXBH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=nKo4jwJp; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233b953bebso1971534c88.1
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 03:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477262; x=1769082062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYThfrCqrT00LXV0OTAO8hRxDqFU2JdJDLnv+fTCySs=;
        b=nKo4jwJpMnc4Vk0Ox8Q6P8HgOkyIt7RA3SGsOkDD/t/5UYaonkGKrfEOmFfvso2+y/
         Ddn+Z4sVa4c2JpWnMSgyX9reJAkW/cGFScBU8vOjaivnM037CYI8EBlQzhc+Qtzi86iJ
         UNljlu4EIFyalv9hFGxHJmEO2WbSkxMU0kdKyffPzcUdAplNOWmSp59ancih/1AqtHzC
         OOE1V9SXAU0rOCvTnhNxGRVkZ6fIhOYp+C4Yg9iT0DkyZrvpnwRC5vS3iGCoMygMW7ev
         jq2QTwA3WiPq41HEAZOZk0J5z0vlNzB4V2+oHt9iISFciWMdNkunGhmHovIHc80BP3Ue
         ZaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477262; x=1769082062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cYThfrCqrT00LXV0OTAO8hRxDqFU2JdJDLnv+fTCySs=;
        b=s6nwvj1Tliqmlg+kkG39q3XynwLu11JDiBKFqX3QLqAsVWOceWp89sG3YDV/2OcLfC
         YGa/uV+zts/bYY2uTWmATghLfEKkIYQfLZf91QM3XnN4K4ev7KEaEYjAixGX+9ayM5Q7
         YLR7kT6aIHKH8vh2d2EFeDiO7pTsaXATcei9PV2h/loJCnuhqzd1emcJe0KcBSZ4ukTQ
         bPUAOgauC/Nhrhp3jzViiWuapDkHTjzvPEblX9MHvyQkmuDgmYX0R89MNbqGeTnc2Pqb
         EQlGCRxJ6Uzw5tNynAh6XuinAyBUJXFck40lrb24OxBDKvRyF0fjQ1tQb5/Ju5uf76gu
         etOA==
X-Forwarded-Encrypted: i=1; AJvYcCVLP4KkW4lGUN7WQfw8R3ARgznf+skijYO6MrdKhZ8HgxFftvGxmIfPwUOxXH+h2kz4JrqVdORpiyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YziOo5C8rBZFea04xQNJZuRolPfNRNEnbYzabJRf7UZIdFCLIQ5
	ehyaPincGYDdMDORpF8bO5elwE5Hl0Zdmh1XWdqaxjpsiXja05/mbPuMGqPkzzDsQYk=
X-Gm-Gg: AY/fxX7aD0xO6xvQMX/EfLRV81sgmadavl6GaDwnmqM1qI6B1HI+11doTzeiim6Tox4
	L9hy8vQ4tRSf+r4pOR1c5w134XvqUhvUfQxPnWnbkufluFy6PP1c00DnOdDTAF5OYT/FkbXXXPu
	Xqwatn5qfTW3Vy98nja1YIEGGZYRsaf7J7nCtuW9iph3vkKnSih1Z8GyTR4sos+1KeG0Qr8xRHC
	dVv5Ig57ciJ2q+4WMsbIXF90qrG5nbM04q5UuBD1CvNcP6tma/Y0JucxDnBAd4PblL1sWCIrjdp
	QuihT7gKZqGk4en+vWJpzXTF5uj68jl96h+rFM8IqrstDGsA3t5iZ8GEmnkDPS+KtRN/WbY1t/d
	dAvU/54Y9QcwWaaETdZetubg3qcIP+rCYZdIhsIroclqgMHCtEjhMjMj4j1bGqUsHaMcaOG1L1G
	25CHguaro4z0g2z//lCCPGglP0BHcCt0PO3COiJR/sBGNUPpDZoYs2c0FwcjE/d7UjPp4xb7fN/
	FqPjUMs
X-Received: by 2002:a05:7022:1101:b0:11e:353:57b0 with SMTP id a92af1059eb24-12336aabde5mr4547440c88.50.1768477262077;
        Thu, 15 Jan 2026 03:41:02 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:01 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 03/11] dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
Date: Thu, 15 Jan 2026 12:37:28 +0100
Message-ID: <20260115114021.111324-4-robert.marko@sartura.hr>
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

Document Microchip LAN969X TRNG compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
index f78614100ea8..3628251b8c51 100644
--- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
@@ -19,6 +19,7 @@ properties:
           - microchip,sam9x60-trng
       - items:
           - enum:
+              - microchip,lan9691-trng
               - microchip,sama7g5-trng
           - const: atmel,at91sam9g45-trng
       - items:
-- 
2.52.0


