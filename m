Return-Path: <linux-spi+bounces-12402-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FB3D24425
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 771263029F95
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C87337C10D;
	Thu, 15 Jan 2026 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="CtS//emF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65637C0FB
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477284; cv=none; b=kFoJfOErHVP3faPwAxI3PIL4+MwxSA/fD0N7yqpf5aDvmrqV74S5zs8gy2WYCWZ/FTOYhzRgBsdjuRsdGFKD3orkdkpuMn/rDPudz8La+cSmO8zbRu0XB5w9Bn7v/nU+vaBL+4TqE4XbbMeTRrK/gFgd2SlVVCMKl9wIFG/5U18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477284; c=relaxed/simple;
	bh=oZkxyNVxYkEwJ2vPpe6uc3+Y+pRPWdMC9g09igJuSnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QG7BZhBmikiWHKIR+iF6btcRxx3wI0WkmBLgFLi50RUexB8p6qc7dbr3M8UsvPnhbIT42vksaPGyTv34ZXajbXOHayvyVzhcz8icXvZuVBlKgtX9uRm6LVWkGw4rfBbbe2lMyHNT/ej8++llLKoPdfRK4Fkio72CXKObGZo9VNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=CtS//emF; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233b953bebso1972028c88.1
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 03:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477278; x=1769082078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMliUwDqBaPP5ftrxzLcCvtEBpKI0UiOIsqsdzxW70g=;
        b=CtS//emF+yK1ZnuPnD/oY+JHTsYeSeCJRHslgL13DIGHhrYLJR2WCsrABgc0FDz8tN
         B2v3/aJaX0rqioEPj7o6UvPnblVbJ5BPUMXs2FXhaRbIxfK0vsBzIbFeVHwdxxFaji4E
         8mHJHdwEiS4v814l7OR4XJBze1m8pxWiBGpMmTX0hbE5Ny43XDLAq0XZ01eYty2yYqYg
         SionVUSa0Q6EdmpcsoBEeUJTyDPEqbksBJ6YtE3S4YwwYt7lrHjinWVWjcSd5Dvm+0KH
         MeOibqCGEgq2WYCsaOOHC/5sPhmbpR56RhjmRHy6KRPCGEJnYoaNT8ETSEgIZnm5Y8Qr
         HoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477278; x=1769082078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gMliUwDqBaPP5ftrxzLcCvtEBpKI0UiOIsqsdzxW70g=;
        b=PsCw/5oovCDz5GTgUUDviuLkix99MIuPKn3u4LXghbET0V3osg6OUeNevpqq03KLYX
         +kusV5PO/oBDSBPOqGT8o9PefnX/3K1uJNUXmQIugtdeJGG41U0ZL4ymgiHCtCXAoT/1
         vcGbqFxSRsyD4CghBazlmGDoRnYDhr/r3I7QrdlAkJUY9bRWkpfG4YWSy3PzTLhVw7PJ
         QNtkpqzyFTtO7QKJdwQjv3FOpY3SABGKO24ls8acXfa/ktIGPFAz1lHOorvHfMKGB76E
         7hrKN7u3pW0tPUlKfc62153C+yQbC//zOS7yvtkiygxCQiYtxZLK75zETUhbKABQG8rv
         8HXg==
X-Forwarded-Encrypted: i=1; AJvYcCV4pGtzWI3388Fx2WArNyQ89AFegHJk+OfWpb1Aj4Ym8BJRtCja+VKGOM8SDMbhELsBxFQtxJ+fLcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQsq4MsImAwDQ+V4cBJ7ddk3asL6pfxg1rFIOaFFNIBcdbF3IQ
	3zPLk3TW6zhwb/SdZrX4yWbcycoxiCQtvEqxlYi4LyrYFEKfz1Vj5fhYriVh22DoP3k=
X-Gm-Gg: AY/fxX76RAVRlyDgiY7x/lA0SryzvTpmZ3AEesFK11iDeQNa+NG4c+LTfEj3aEGnlxy
	6QweB+bqtnWw89Ttmi0sUXM+CWf448PKp7hRt9JZ+YsxwBaO9+vss6kOCkrV9UNdd1pvPN26kw9
	X3no4bXf3GvtkY8/XONJTuMP8jy6PjIYhFwRQTEHdQk5RAlpXejJec/bqQbyVzLCaVWpbs+BAeV
	BkLy1H6sk344dyLyme/s6lFtao68KUGGNkhXkTmU9GzIjQrHNh/U4LtJ/RrSl1CQZadvzkjkdsR
	V8FTpW8eJ6nR28nDc7qi9fzv5QDL6JJB9mzdeEwCFeSe5ev9a9ylrcWb1R37u2sDgB420FtFgfb
	V2WxJYb5Tt5cFo0q+vnniTO9OBc5ayeNq9L1S9ZFBBP+WGeCe/JZ+4KOgDzEf/ZeHfTQtHOWebh
	I4kJhIbY0OKD6GvZXTFOa2l/4sAc8n29vAbBCyw5a6Q5zdAt2SrQRQrpbgB4v5fu50gZEuQfLhS
	HL9tTS0
X-Received: by 2002:a05:7022:c90:b0:11b:9386:7ed3 with SMTP id a92af1059eb24-12336aa83bcmr5197544c88.48.1768477278199;
        Thu, 15 Jan 2026 03:41:18 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:17 -0800 (PST)
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
Subject: [PATCH v5 05/11] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
Date: Thu, 15 Jan 2026 12:37:30 +0100
Message-ID: <20260115114021.111324-6-robert.marko@sartura.hr>
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

Document Microchip LAN969x SHA compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
index 39e076b275b3..16704ff0dd7f 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-sha
       - items:
           - enum:
+              - microchip,lan9691-sha
               - microchip,sam9x7-sha
               - microchip,sama7d65-sha
           - const: atmel,at91sam9g46-sha
-- 
2.52.0


