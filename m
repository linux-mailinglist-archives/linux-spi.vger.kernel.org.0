Return-Path: <linux-spi+bounces-9391-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDED4B25282
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 19:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98994628B16
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3502882AC;
	Wed, 13 Aug 2025 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="QZAmmWeL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215DB298CC7
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107266; cv=none; b=ij3Puq0E9XLlNItd49Xk7pUdi4Ktdu4EuJyJ4IiyGTnGUKI0PAuR2ZPk0ogdDgWAJvdBylSHhBBkYCHQBYjnBpDNfauxoYCuNZy79WeQF6JVs4/Ywr4M65trncIhI7Hg+nS4S+dxjeQr0T4Uk2w8UgbOzYFPyjnTRkaKg0Pm/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107266; c=relaxed/simple;
	bh=gPMtN6w+Ex6/DTpmDnipaDUce4Mx3+FsbyqPZQrCYoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tv9G9GoUOvIEuTQsWpsRp8Jxi/gJ4YD6NSpyKBIYR1TnpM8f0VfUvjIpvgyC+u5yZoEkd3ac2JNvDHUOJIwDrpsMMhO4Ig3R3j18kx/LW+otg0NLrPRMLQBgTKg3DAStYHEhRtd9xZu1dcrPte0yYt3zy9b8WXGVOIPbnH1i/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=QZAmmWeL; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e8704da966so5595285a.1
        for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107264; x=1755712064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOqtWGRnguTuSIsC5EGTanl0XgtE1XRc/qnGhyYka2w=;
        b=QZAmmWeLRLMQhIuqHu/KvJDEJNjLk1Uhjp9KNU6Rv48HTqXR9Gi19PZdaAXnUSCUnd
         7nFtowisJIqJ/XLwX4ozYgLg/AS3OvJFFct8eTAPJIBvcy+kLgSwSKARMITt1GuRzOsE
         9gMEfS8p0PbnGIBvapoZMPO4IeDf2iDCvNs3zZ0G9FxVvIbL/EnE2JMCwMZhgcDqUNli
         VkepSqY5ARwJS9Ev9IbMI62wlC8Wd29ao7jcFAkulBHCA3cIoxRrDEwe8dAG72wh5KTX
         VpTkmOjUfXsoaYHn0xGWTVTe+k/HfAuyikK1SqdX0xgq0Ts/Ss/a3V0ikJpyzN6QTyMt
         W6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107264; x=1755712064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOqtWGRnguTuSIsC5EGTanl0XgtE1XRc/qnGhyYka2w=;
        b=L3Rk8a9V8kBrNRTDTYUlKTtBb6trjmIMb1olDkIkm9taIVH+bkxYPdQC+9nBmq5ZpR
         R3cFhsgbDFPU9oTsPeJqNDa0eZnoBxycz6S8dsRlIaXLYvlrdU5sNvyXXPctBRkLLulJ
         +Whf8DT1yMdtqTRxB4rUe/LAz0c+SvnZh4L9bBMww2GnqxQwltMtv58shcMU3VrHrvlN
         sOuQhwCNrxyzyRRLAwFWLNU9Y66aU7Jnz7o8cTEovLZjqRSxJN5puoxM1VpKJUvgyVGU
         H/ABht2rUu9ZbLHIVn5FP0CCcj98ko4oCtKmpZ4rSttL7Iyb95h+/zxDjWScWeIX5Z7l
         7OIA==
X-Forwarded-Encrypted: i=1; AJvYcCXK0JO9MuBmuaIj9Fw2CldqLuqH44ZWb1rlMkg3Dw0wOaWI595NG0SPFVJ1tVd4wH+HodqaLjkmDLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCD972by8jDqfwVrMhD9JPx1+4Wj8yCxxCFA5eykEqIs5W4Qeq
	gkr+nWharprPZZ3enPrG7f8yb2y7kPki0GRDohDUHQdrNA22psOEILqcvO0vRT47toY=
X-Gm-Gg: ASbGncvbF3vAgOdjMNgRO4UZEMzgdbJ/lHjnu/7MeBzMYp+OLr/sc1PEpKUdpEoKyT/
	D8Bodygj2Qve+3l3oGBZwAVvHJhGjzwJ5jFKsNn63OkuTXSTjnmnKI98ySnobDAmsnecvg7+C4Y
	fxKhSER9KEWqZB8iN4P5Es7YkbAcRVOeXV/NIPbKiOwBR/ySkPNrWG5hgIXUGlMdLFfRvvLsSPm
	wXXwV0+SM4Rw0q/I+xx68argoNZw4DSIOn0ttjbvmfxBfE7fF0C8BFF5SGNVpvMNqXNj39DwRUE
	xIwehQfJh+SAPsG1nUGQPJiQKd4Bsf5TLTUkoXz03Dj5QnDZ4dm+4q3bzNa1rDYcjNOTAGUm1lB
	YQMOSGcVLBXdx8yZoO29ohR8kN5YxzO9PSvxrF656rg==
X-Google-Smtp-Source: AGHT+IHM8gqvwU0dp99AsCx2aJSW6E+YiETEDgm//P8elY9qJZZswfVzec82j6i0ynh7rzsSjnHxBQ==
X-Received: by 2002:a05:620a:31a:b0:7e8:20cc:64a2 with SMTP id af79cd13be357-7e87035636bmr30883285a.26.1755107264026;
        Wed, 13 Aug 2025 10:47:44 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:43 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v9 3/9] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Wed, 13 Aug 2025 19:44:39 +0200
Message-ID: <20250813174720.540015-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813174720.540015-1-robert.marko@sartura.hr>
References: <20250813174720.540015-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the Microchip LAN969x ARMv8-based SoC switch family.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v9:
* Select ARCH_MICROCHIP when ARCH_LAN969X is selected as its now hidden

Changes in v8:
* Place LAN969x under ARCH_MICROCHIP as suggested by Arnd and drop review
tags due to this

 arch/arm64/Kconfig.platforms | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index bfea380100a6..31bddd1a17de 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -177,6 +177,21 @@ menu "Microchip SoC support"
 config ARCH_MICROCHIP
 	bool
 
+config ARCH_LAN969X
+	bool "Microchip LAN969X SoC family"
+	select PINCTRL
+	select DW_APB_TIMER_OF
+	select ARCH_MICROCHIP
+	help
+	  This enables support for the Microchip LAN969X ARMv8-based
+	  SoC family of TSN-capable gigabit switches.
+
+	  The LAN969X Ethernet switch family provides a rich set of
+	  switching features such as advanced TCAM-based VLAN and QoS
+	  processing enabling delivery of differentiated services, and
+	  security through TCAM-based frame processing using versatile
+	  content aware processor (VCAP).
+
 config ARCH_SPARX5
 	bool "Microchip Sparx5 SoC family"
 	select PINCTRL
-- 
2.50.1


