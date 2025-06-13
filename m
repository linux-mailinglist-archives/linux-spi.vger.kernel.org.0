Return-Path: <linux-spi+bounces-8502-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DC3AD8AE3
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 13:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D492F189D683
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0462E6D23;
	Fri, 13 Jun 2025 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="rS089sCC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B4C2E62A1
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814935; cv=none; b=o948ey8W8+wZiv0Ka/rOL/ZUDCovb6b7LFPT+v+RRO0jEv5eN2M6n2EVQb4VJcKGQZBClL95N86QaMJ70WTY2nqz1cSj0MZ1IQFR+a0FVt9PjzWBf9SLcP1oHRNfZjAy8R9Z6VgFQ52WZzFrQZ6nPBN/hHgJHasVGnKq93irxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814935; c=relaxed/simple;
	bh=NeAtc85pNHGt2Bai6eksDz8QG2jTguYaO2Sb/fwRluw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InDXX4IedbE/R4OF41B7xYaIIca7PgL3kbdz4KiSUQA3R2ByguWrA8Tol7duu61ha2SbBJ49xxSpu7HZQxC/4/p5jZZl0XPy3y4BrtILar6F9kk2I0P61njmTuVrfp8a5V9Jc4cOgj8Xm3VnIhZ34NFubcKi+sqRGJhRK25Rd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=rS089sCC; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a58ba6c945so38482251cf.2
        for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1749814932; x=1750419732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP34e2q5Xb/n9epu9K3/GerhfTkPidCRzY+znM8yDWs=;
        b=rS089sCCi7q9xklN7ra53x1njs+9nCw8pf1r+Zu0GXeLIgkFtWC3a32IswDYXj7DAT
         bjiBjlsBhREhb/0VbNe6x+uC0vDQn+5bd/Wyc9f0THQTkUm2Y+ZmhfOGrWdqsuOiQKph
         cH22pL4cCUVl/90jYWSp+rrtB+QdqE3BzvXPIVs7c8xIWKygA63uV99M9CE1xntGRMOG
         9daASeLc4cH4AyAUofnGXi2EQRObXsITNqeK+gDSsYCpFLJcHzZ5wR0ET3fPqZ7EjaA3
         HFwkL/N39MH45MD8+KUoCQ1YgAi+tMjdrv+hhVBJsOV0GZElAyOp0Q0GGfcmvVebm3vG
         JojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814932; x=1750419732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hP34e2q5Xb/n9epu9K3/GerhfTkPidCRzY+znM8yDWs=;
        b=REL04ygSgU6xVsStr5cqnMbFSFUc73sUHWIrbTNGd2utohUpWeXgST26djlpLhQB9J
         mD4U6q8FhfmgWuNY/PgL9tQXLBeF4V54l68iVi45zj5KRFv4Hsf04YDP9Os2ZlJLK/fn
         DgVA2pi6zz872jEQYRyRrwrPRdEBZj91egWdIH2YpMrAWrP+EAOZ4qRlCTJCI7e0XSBY
         SKBoGce4zHVcMtHMkh/gQIIA+0zTU5TJTxT5lFYV6t6BGiKUOrCOVuAK66WSBqy98cGv
         h+ACuKctkiKrA/CTE1xF5+OQvgnFAfKkmuCIwaobw0vZz6l8AstsxScYGlbihD+sicw+
         1D4g==
X-Forwarded-Encrypted: i=1; AJvYcCW0H8XzHFQgZzSX+VgWKIWE5iRAScnm8JdHXRmS/QAhGgwdPa8UVryU4tSl1IHf3ugExu4X/eAyM24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VMtd9lZ3iIpIiIR+LmaDyfxSJ1fFynkwY84UtNCvoZD5lo6e
	euBv0tQbLsHkQcvIP89kbrHLVRaujIT3P9hU71NSR1UaW8ToF8Hl+dOO958Q5q0CwHs=
X-Gm-Gg: ASbGncu5NPXlvu91Fp3+e+M21kImHZ6XWrKu9H3qd54wtIAEN8jciEsMwI7Ue/C9Iz7
	aP7mhzIfRESJ+39MB33o7vU8H+0jdZuKpxzWoEIn0xD+WLJWnHQvyFqViahYbGvWSkuWSe7jSpK
	y24F380qTVmxQe5CHnp9/D0WOUbWVtLPqaho3HY5d51HdL/HrQDIstoy/KBMzA2523a5/DTo5IY
	CLN3dTyg9LDIrms0lh6SLLXB/M/Fn9pj4jMJWalomSKU84UI52JfyMBRXi/0LMh81nzDc1KKwaS
	/p4G9rCnpgp1XdPCveQU10gCmIRrb/3z0qTYPxkEPzzdBMRzjh2Du6CJJAKkHPoFocGvtXR784z
	6NCRb2ylbM315qTDnOOlj5w==
X-Google-Smtp-Source: AGHT+IEvwSeOVrcJVMZPPA8Mgajhh3j4DaXHPn6mHw+5/rNyArLRJaLGgxD9f3JE53WDOm92ws1YcA==
X-Received: by 2002:a05:622a:4807:b0:494:a447:5bbb with SMTP id d75a77b69052e-4a72fec2119mr49140131cf.16.1749814931845;
        Fri, 13 Jun 2025 04:42:11 -0700 (PDT)
Received: from fedora.. (cpe-109-60-82-18.zg3.cable.xnet.hr. [109.60.82.18])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6fb35b3058fsm20558206d6.37.2025.06.13.04.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:42:11 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	ore@pengutronix.de,
	luka.perkov@sartura.hr,
	arnd@arndb.de,
	daniel.machon@microchip.com
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v7 5/6] char: hw_random: atmel: make it selectable for ARCH_LAN969X
Date: Fri, 13 Jun 2025 13:39:40 +0200
Message-ID: <20250613114148.1943267-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613114148.1943267-1-robert.marko@sartura.hr>
References: <20250613114148.1943267-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses Atmel HWRNG driver, so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index c85827843447..8e1b4c515956 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -77,7 +77,7 @@ config HW_RANDOM_AIROHA
 
 config HW_RANDOM_ATMEL
 	tristate "Atmel Random Number Generator support"
-	depends on (ARCH_AT91 || COMPILE_TEST)
+	depends on (ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST)
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
-- 
2.49.0


