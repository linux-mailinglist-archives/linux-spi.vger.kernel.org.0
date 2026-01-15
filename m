Return-Path: <linux-spi+bounces-12401-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1992D24402
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D04ED30A53EA
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4E537C110;
	Thu, 15 Jan 2026 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="O5lnGvCp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B637B3F8
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477272; cv=none; b=DAXrn/SBJcx/Y3eLWZYQJqmnil14/mJmHq4D+/TkvfChks4sXDVu90NI3BITRhaANnrj+I+9C/6ohqIP7sJUi6uArHHsalVs1v5MrJ0gf0kR018QwIUgaDCwhqRhdF5jK2zVymNMLj8SYfZpVfr2WW4jaYsF+hAvqONnmVs5BsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477272; c=relaxed/simple;
	bh=ooKaWydLYAU6ZinUS3YSKV/BPM0KTw6HZzaYhJx/zZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRykarMIXa/VseMWVESPnQEEWRJ0mIC8qBh1IcWRQq+Ij3oWLTj7/P7W1TaeRNgps4uQpfG3s2320zvvxyhKyjKIK1EmIoDY7pfb8gemh0HcgTVnVDKDllxKPv2I2B3ujQK4QY2bwaLauDYevbwgn874ffeb2cf4NOTIQHae/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=O5lnGvCp; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12332910300so2054020c88.0
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 03:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477270; x=1769082070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyqWPUPdksTIWYuKZmgo4nd2lHSjHXcu6SXb4jlQ4Xc=;
        b=O5lnGvCp5bru6pC2QaWeoBDVHfK15uwu/E3xAeyAUrr9SjEKNdMJFD808ELIWWp8/P
         cT1hffs6A20FXgIcfPjrhRBE/hnQ4mT7Cdn5difSKDrwyd2hfnL+VBgve9xW0YEZo/mK
         BWpmhZEsY0pVJb3Ze+8VNhQ3fjwCJFeMmyElICoDzR9t7Tm46dWQKLCA3fYhx4CQVHT2
         qxTosX+FWOY8D4BqXIDxbpEGADEzw9xh+L8NnwM67RGSd7pTqsiUedvqnRJm6445hNaA
         pK/cG0ss6J5hDKrm1Ag3z2x/qoAeHC3xbnYbZ8jcUMwAMJUqeCEBR1fGzp9vT/vOqmX6
         FI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477270; x=1769082070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jyqWPUPdksTIWYuKZmgo4nd2lHSjHXcu6SXb4jlQ4Xc=;
        b=HD5cba5SeTpjiGwnFg+YFiHERmTHH1vOvGUj01ekR0wswgyjrfV2IAaDxf/+MaR+Lq
         XkUXNHwv/PT0JFxoPY5fibalvjFadoko1gAjJk0W2rHDgX09VWYqMGh0HVrM1d9zFHIr
         pSzA5nIuAEh9M0zgH2VlIyhsFUuLA5C7a6yCpfkNE+ZU8wyE1uA5wQ5vYLooDPo7pQDx
         slXAM6PtCwkoiOU89eDsYLMrDwv8OhHAZUk3x6a7p/Ip/YQlvcj7A1Udrw0CaeyXTe0u
         9qX0R8hD/eNsP3YuIdZWRCdvmmXpAXe5KJFmqKKebd3GFHGwWB9nQiAFBm3U5cZOsuey
         +4fw==
X-Forwarded-Encrypted: i=1; AJvYcCXYTApcM+KEvOzij73P/51Ma+Uyb3+QGDfh9qUWvKBsSSB0WNzumyj5CRcro1YOeg1V//YaFxYAx5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0NoksU3p8TdlupU84Meivg1DRiGK/w08hgpL4OH/7e43Oonlp
	f45GUtYtHrkfOWgg2NQBVVuBEJFTSYlt0INFOVwIbN1zLZdUcwaXoLyuZSVLSjPF3wI=
X-Gm-Gg: AY/fxX5kMBszQ6mcztbB7Lb6aykd1ikl/uMR0TJVLiyaKonhu81+jVk0NH4//XgS1Um
	SahDeCOsA+x2NoWRmkspKPynKd/Oa8z3yfg0TRuCgQhdLjsbJf9BFQLQr3DcCrRclqqW4yuzZqu
	fS1N+YT1BhRqVMLRKkzOcA8KaZRic1bc1EUG0PZ/NeO5CGFD4oCL4lHwwtBBC4CjTAluw5DRVrU
	wqinLYMrXjd5xGzHG+nBmvHe1zadQePWZR2bfXq1NYdbNmlSjNr5Zc54YG48dQ0QuJ41R56o29+
	Aujav8V9V+EpgdlG5WzNeEic6hBDj3I4w0pic/8+nRCipmVK9yO/MkLkuM6QOCM4SdG397W5TqP
	6Q3evS0zvR3JkolQBmndjoNPOYc72njD/m//rhhUe6EXfe0ogYyUvYAIMhU6O3InyoJBf2UW5XA
	eWfY9Fz7moU1bU9qu/llOp0kDW6wmEX08Y4uRrj29gSJ0oB3ji61PJWZEH1HmGh8h68YxHA9CKb
	fGQelAw
X-Received: by 2002:a05:701a:ca0e:b0:123:2c98:f6af with SMTP id a92af1059eb24-12336a45a0bmr7461678c88.14.1768477270097;
        Thu, 15 Jan 2026 03:41:10 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:09 -0800 (PST)
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
Subject: [PATCH v5 04/11] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
Date: Thu, 15 Jan 2026 12:37:29 +0100
Message-ID: <20260115114021.111324-5-robert.marko@sartura.hr>
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

Document Microchip LAN969x AES compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
index 19010f90198a..f3b6af6baf15 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-aes
       - items:
           - enum:
+              - microchip,lan9691-aes
               - microchip,sam9x7-aes
               - microchip,sama7d65-aes
           - const: atmel,at91sam9g46-aes
-- 
2.52.0


