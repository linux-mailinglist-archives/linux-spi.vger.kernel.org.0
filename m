Return-Path: <linux-spi+bounces-12404-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2FD2446D
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79F7330C8911
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C1D37F733;
	Thu, 15 Jan 2026 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="bgojcElQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD737B416
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477297; cv=none; b=FgaAZXAGd0JM7+o1GdtRxYtbbLiQUfV1sN08+MnjV/tSwgj/ENSbBU2Wpq+q/OFAzgnOBK0HnfisWT1DnURuqeIIVwt5Th/VDZv8ugyoHYOmqHaNCPLS0XVs9AfUZVTUUJbs9QRGXhQOmFgx1O4UD1NDzDXN7L712IyuZrpfWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477297; c=relaxed/simple;
	bh=kGLAInhaNaEk5rc2QTU8x+5FcCE5pgYroSfVZcUveHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHoZ2P9iD5jmmwirmu7pYvqisZ/xrwIoYby5Ia1EPxxuWTJEGI0j0WJCgwxByUWgenbwKwQ+wxp7j1vrAVY2IA8X0o7dJTZ1sgCYGBa3+BMXvESTj2Kzp7XnxGHIFS5Gh7+pEGZKWwCi01bCJu9xa50ry7e6Fi4XsXDGpJdyfRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=bgojcElQ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233c155a42so926153c88.1
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 03:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477294; x=1769082094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6Hh4x4yU6+a4AjWH4xSBmP3UWp5wIhlMj96VEo5V8g=;
        b=bgojcElQFKHWk8J2QDM7bzI7VeTyPtMU5yByyGLHBGEn0Yzh6BeApsylOLgTpadW4C
         KTO1oV5OARVmQgoUL2M7aMX8JxJbTyaGXnuY1QlkT9ZTwtT4DFVNXsbB7oM/L3ESDuh+
         IVs1btTKYgCKpoOZMrBCkWDrae+Qk25O2wHtNBudsylq5Gdj9fYDS2GIRpqIIdBYA2jF
         hsfBZOtSrnv2D+T1AfKZxKG/klbK0DitTvy5qNG9gy1RmjLb/J+wl2WooBVlzq4LRMJP
         vwoW4R36Rj15ZIavj6NtwxzN41g92CfBvH2dEcieMaVZeOXyIIIJw137E7xK7o4Zmtrc
         sZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477294; x=1769082094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A6Hh4x4yU6+a4AjWH4xSBmP3UWp5wIhlMj96VEo5V8g=;
        b=BvDQxenwZFyB5M8HqIO2D34xb+cXddrS1XVbIP4RMa7/Y5yc14cdLKSwJme/w7mf3S
         7G+sFsXRGPXDrZ/30VITILtqBxuwtdH5+EvOQYdb5rUKTsVjv64O9LFLw1WiCx0GzOaq
         y2PzFQ8YDOpD7+//1LSkH6fj7yegQM30VoCGKPfwPjHFuYrg9aAqolUuZKaPBh+8PFB3
         TGU/2oJnIHmykPHV4kOsNUP0lo2MOxay7KgBZ0IFpVDXHbEBZjvzznW6wRUW8Bb/9laC
         hSSFBtqOkeJbhox0MwHjYBisttZTyTphgIEP1BaHLEiZKV2foA4xuvIvGIBJ3PF/+ARU
         NIhA==
X-Forwarded-Encrypted: i=1; AJvYcCV5y+lgar2g7I1G6ZDGohz1hUS4CO7rN13CpmfF38vZS2/kd0WD4f9BSZhllXOCTlDphMf6AejCziM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZ/NF2ha2MtmejqIpAC/n0wc2u23UcFfFlu0yVuD+GHdrBN8X
	KOxQ6+E3HZt9FDgeLbGPukoNKlOdbY8YKxA2IgL6QlgARGppHSuMq7p18WQGb6Rh1mc=
X-Gm-Gg: AY/fxX74eQMbTSRKmuEv4up48lyfWETVYi8Xz9ZAiO+mScDYWMox8pTCVayBiQSxbkW
	BToExJRvEVsaB9dRU4xOmrLp5dpFZETVvj3dmgjAWOemLgPpcMS5V60AbdwkT9X2Tx3/AJXKL9j
	irMpIpN3hLTX85agphAGguUL02WU+t0dgivUCXe5yJBwGWuuNMKtfAyLbaV6UZqQ/+e90JQ2FuT
	hkAUfCjoQNwPhk0jnMfygkCMysyodOl+b9iji5RENxQA7NrO6UN3XDfqUBpeIx9M1Rw7nNRk20m
	jRG2BaEXrkZX2qxKJK9bmVPQk/2arbJk6wKUaWAko7hPR3y5y9LIXBjYM0kviSgw4dz4LdAvCYz
	T3Iit0x3QGlAJP4Q+EfTmNbpn42RLTJemU6oXMrxBWMds9WxF+c40xxYw6smDcwYfkaUXiSipue
	KkaApTLokKkK7FggHXzW+Awa58ohoBrg7pfbGPNSAfWiIhtEt1TGKlFyAmfQI6mCEmfvYaZmMlZ
	T5TDd2Q
X-Received: by 2002:a05:701b:220b:b0:119:e56b:98bf with SMTP id a92af1059eb24-12336a82526mr5837069c88.38.1768477294058;
        Thu, 15 Jan 2026 03:41:34 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:33 -0800 (PST)
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
Subject: [PATCH v5 07/11] arm64: dts: microchip: add LAN969x clock header file
Date: Thu, 15 Jan 2026 12:37:32 +0100
Message-ID: <20260115114021.111324-8-robert.marko@sartura.hr>
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

LAN969x uses hardware clock indexes, so document theses in a header to make
them humanly readable.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v5:
* Relicense to GPL-2.0-or-later OR MIT to match DTSI

 arch/arm64/boot/dts/microchip/clk-lan9691.h | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm64/boot/dts/microchip/clk-lan9691.h

diff --git a/arch/arm64/boot/dts/microchip/clk-lan9691.h b/arch/arm64/boot/dts/microchip/clk-lan9691.h
new file mode 100644
index 000000000000..0f2d7a0f881e
--- /dev/null
+++ b/arch/arm64/boot/dts/microchip/clk-lan9691.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */
+
+#ifndef _DTS_CLK_LAN9691_H
+#define _DTS_CLK_LAN9691_H
+
+#define GCK_ID_QSPI0		0
+#define GCK_ID_QSPI2		1
+#define GCK_ID_SDMMC0		2
+#define GCK_ID_SDMMC1		3
+#define GCK_ID_MCAN0		4
+#define GCK_ID_MCAN1		5
+#define GCK_ID_FLEXCOM0		6
+#define GCK_ID_FLEXCOM1		7
+#define GCK_ID_FLEXCOM2		8
+#define GCK_ID_FLEXCOM3		9
+#define GCK_ID_TIMER		10
+#define GCK_ID_USB_REFCLK	11
+
+/* Gate clocks */
+#define GCK_GATE_USB_DRD	12
+#define GCK_GATE_MCRAMC		13
+#define GCK_GATE_HMATRIX	14
+
+#endif
-- 
2.52.0


