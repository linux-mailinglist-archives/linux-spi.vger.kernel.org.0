Return-Path: <linux-spi+bounces-4450-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BB696508E
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981F5B22F13
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 20:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668F81BA890;
	Thu, 29 Aug 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9YsMfPi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423047A76;
	Thu, 29 Aug 2024 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962408; cv=none; b=f8/g/UdGQf+YeZgWUAy35k0Fv/A16C7+1QwvcOtS5fJ2TnUR8gWJgwgoreYhuCJmv2HNwV/xixXP/bsgPbQNS55HsIee4kyk0C8oPkfpnjsacpOfjDMx5izpji5F4Wcc+M4ga8Mxrc8gytxeSK2e/2cXwQykE/y41NzNywzRuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962408; c=relaxed/simple;
	bh=L8yGor/Pd3r8FfKGAvoo0s9mY2zuz2G4XDWD79i/AIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iElU2oIZiMH1bAfUPKYTLYWN70zVPMDzys+1Ty0dOHqHVEeX8Bt1pMJeXD+LT0QiQJX79Ymx6GvbdCKRk3QbOWdF8uFNIQP2Mku03rfI4+enMWBs1ED1JF2+iEtTd/TuOPCZoSq1AZ3UJNm58s0Nb8/lhUrlblhCjuXE3vpZHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9YsMfPi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202508cb8ebso7043075ad.3;
        Thu, 29 Aug 2024 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724962406; x=1725567206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwbWHd0cDt9rHGYesRh2eerLPT3bUxEuEt4XCIRM5Rk=;
        b=M9YsMfPiO+mQtKb6t0HeQs1cpcDQtLf4ogSJjZX41636Z1zZniORAHGKrBshG/Ory8
         mdgQgm5hcyh90vTmPUhJfWFX5LM31HOMD1WKLzMBXjSyj4JE1qCIrM5x/ey1KnRf9QjI
         TU4/OkYMmvbkXUHeTtwFv76rpF1H0h0gPnRDcQ039S4iWoFJ5p0E8P2sOHdFqtv5hLCf
         qPwmAdp8lToXbdJIl6GiqW8W4X/12lkiPjikbSwDcsezesD0itByKROvs/Z3dhSyeyia
         UOdU4Ao5WDIbMxQ/7CxE4vxbdHSiG9ryxeFPn9QrF45QFWd2i6cWfC4PgSu675kgH2Yn
         3nBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962406; x=1725567206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwbWHd0cDt9rHGYesRh2eerLPT3bUxEuEt4XCIRM5Rk=;
        b=Tbnkr/X0hH/dwuisv0ltBNFRP78MOXdvSDi5oiEs7+tND5W1KbQhXxnAnGBXYTkeg4
         WdmrKScmki0flchae9o/3aa9N0C9nWoRvHR3SKp1+Q6ONLl03lOgQ2Yk2NaIKUhLlxDq
         58W0uu6AISxvpFLMIcUFPJ8LLfs3gavt93TE/fZ7RBLxH/JeOmcb43iE+aSAujXrhK5/
         gnkpUIxF+r4sihec8IhfS1Ru4kYDwPhV04p8xfLCa2dn7BnkZStqWrQktoVrHVQxkdG8
         rvxD2F3lTgsK8oo1s2cKdP6EMHpDHsO9DtH+i7V19mFwusSRNqHVAvVOot3iW1BTT00q
         wzSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy1s9Ia8iAkeRIlK9nS3TNQ9V7kVdJZ4BoAyTxbIUT9hvT9Rei64uIIXDqVlclYLsxBQ6AW/2qYmbD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2E63NBCEdZrv8ZgdNT1CCBWFZH1WV6fmx27tgvD1D3h3vSSF
	7z/Qiv0Z238T/ML5Ol1bzGYQi1QTAY4zMIhkVEwCQQHoEZVB6xhI
X-Google-Smtp-Source: AGHT+IEDHHfIcbkJ+uwAz+VEEEsikiPRJIBefPjv3c1giYb/w15xknSqQESj74XPGmD4x1zbc8aVVQ==
X-Received: by 2002:a17:903:2449:b0:202:3174:9d53 with SMTP id d9443c01a7336-2050c3e3063mr44940855ad.30.1724962406110;
        Thu, 29 Aug 2024 13:13:26 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:adb0:3b7e:78c6:e307])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205227baebfsm1996165ad.247.2024.08.29.13.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:13:25 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] dt-bindings: trivial-devices: Add a reference to spi-peripheral-props.yaml
Date: Thu, 29 Aug 2024 17:13:15 -0300
Message-Id: <20240829201315.3412759-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829201315.3412759-1-festevam@gmail.com>
References: <20240829201315.3412759-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There may be cases where a trivial-device needs to describe
the SPI clock polarity and phase via spi-cpol and spi-cpha
properties.

Add a reference to spi-peripheral-props.yaml to allow that.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 75a5fad08c44..356b89ade6a8 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -424,6 +424,9 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 ...
-- 
2.34.1


