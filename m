Return-Path: <linux-spi+bounces-6806-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 162F7A3399B
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 09:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E857A4701
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2991204C1E;
	Thu, 13 Feb 2025 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiyrcJo7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88D20B1EB
	for <linux-spi@vger.kernel.org>; Thu, 13 Feb 2025 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433826; cv=none; b=bI9ETPK0Xet0/OKP6TWKhxzUgCqnzPi6JNTUkJFKm6O0d1xFTbRB22iXH2u5/aC/Mw+ToI8dSwGLA+nQACYl0BpSjS9cKrjSk+HFXU3BHANrDzktyVtGZYpjm0pI3LrR70fDtLmlxY7NHf5MN4/IBHukqqR5aq8iDe5jhuJH9hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433826; c=relaxed/simple;
	bh=+cpwtn6ft5Mp1NhR7zmBNBss1tR3VCn4bdRQWVgKgxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pvk6E7z0eH2pu+fC75w8rhGzoZoxqlFUwh0PQNRKG8sBU28E/E0fSMg0Dgx8A6Vk8/GKgmPM6U7VI744R7twsYdzwiyfPHtGyXkvMfdLJRd4ILHH82nCQe7juJLLe8dNJ4P9n51Kk71uOdTPTaINlIx+fvyE3L2kW4YsUXPKabQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiyrcJo7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4395b367329so3193615e9.3
        for <linux-spi@vger.kernel.org>; Thu, 13 Feb 2025 00:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739433823; x=1740038623; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGK3HdKnBHt0qxrB+06GFcGxYYwUkBzqpNHrEbv5UZU=;
        b=XiyrcJo7CS8HZPkF0topJHiuw29adWu8qIJnNevPhfODeclsmsV9Oq2S3wuGusQuFN
         HAXqGLRZxv8p6nAYSSD9htN22fbue+bWTHvroG3ucDIEXCEInRZNotr5GwvNbHxuz7fl
         kX2dVrxF1o8CrnFBv0rijcAaouzNMfa5BVpKXYDLh7jIksbSn1D/R5TfoQK+DR5xpa4C
         gE12VrY1V/SsOY372JEgOuWg7m2Qk2tFeM7ewF0KoPHmSLZ1BnBJpIZUlN54hkBSuaRb
         aOi3MZMhZpTiS6o/XOm5mfrD1I5UVdQ0f5Dcz6AxNmTqEur+OsFpzr5jp/5eNi9idOv4
         Z0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739433823; x=1740038623;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGK3HdKnBHt0qxrB+06GFcGxYYwUkBzqpNHrEbv5UZU=;
        b=laVoHpds/rNUDQOzC99T7ZnS15aS7WmltMc68QJiTssHZIYB6aOqQ/5oFtFEMVM5cX
         uzkSjfq5x5Tmgzy2QmjHcE39uECC4qvmU/jyBn0jBYixszedGT9yuszWWVKCVGA0G0Da
         lyq0GEMqPPbawWtlrc4zq24YqWz6iId6d6yXwv3DiG/65yL5EeQQZF8EaeYSD2VnB8DX
         wh6ISUme/l1NXuxvmp6W7yZ8gE78OWA5DuSKDT/IqUuF1DGo+hbEBXcWJGCVDZvegK0k
         uLHQnGNYXvgIcg5lRd+mFuDKxlqImWohM5Bg/AKLv61Znnmvg99TSylAuK06Hkq1OvUK
         4VAA==
X-Gm-Message-State: AOJu0Ywn1kxiCR05QSBVeWY1Xot2MD8E1P4YcCGTvzK7n+CrnUWKm8aM
	o25QVXqVcZioirHEw2StZJ3yXvjPd/CtjwoiQPiFiLWsCI9ME+FBvWhSKHeXwdQ=
X-Gm-Gg: ASbGncvKW3ZNAiuQuK7cDD9q+OUemBSHs7Zugd6QLvzUjh0mM8HJFLGkb9K/J37uQ9v
	mAwY5FT1AP8TrYT+Fyegl83YaEK8moITDKsX2b3YCZBuCQ4dKFUYkcvXSxtI3K6nikXDmclsT5C
	R8pwPlMfv7eEHYhDiNSSiA2elf02eYP/kyI7fR5mLUAcQpFrEuiBGrrKrJyLQlb6zOBkuXaphaI
	TWNm7kkKxD8tSKRWQ9RUH4sc8WrHNQIR7K7kphZ87fTMqwjcHq07tvmXQkuHLZDGOB8eRRo6ScI
	Ro4ec2FvYjzmi8w+I2L7gr0nzPIHFV5+mO1ZlpXIoO+X+qAsRtqOvJ5/fpObhEBgb0VWVfU=
X-Google-Smtp-Source: AGHT+IGZkzm+ZCs9+jSrDpnGJaY+GxRIoci0mFIiMpdQIHQKUikeFgRtM+1vP6tmyadIVBpcdlOFPA==
X-Received: by 2002:a5d:5a4f:0:b0:38d:db7b:5d90 with SMTP id ffacd0b85a97d-38f24511f69mr1969873f8f.41.1739433822766;
        Thu, 13 Feb 2025 00:03:42 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7987sm1090185f8f.87.2025.02.13.00.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 00:03:42 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 13 Feb 2025 08:03:41 +0000
Subject: [PATCH] MAINTAINERS: add tambarus as R for Samsung SPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-gs101-spi-r-v1-1-1e3ab8096873@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF2nrWcC/x3MMQqAMAxA0auUzAaa2g56FXEQjTVLLQ2IUHp3i
 +Mb/q+gXIQVZlOh8CMqd+qgwcB+bSkyytENzrpgHY0YlSyhZsGCZ+CJePT+IIJe5MKnvP9tWVv
 7AMY86kldAAAA
To: Mark Brown <broonie@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739433822; l=819;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=+cpwtn6ft5Mp1NhR7zmBNBss1tR3VCn4bdRQWVgKgxI=;
 b=V0TVNrZONVF18PgyIPUrkSg+90Fdb4bF3PkyGBIktk0EIp1w5MP6VNcK7zk8EtNvkz2lo1yC6
 zFjjtdA4YjkBEr3saIxrOIi37Mw/0N599Jc7/WhVBLRDKVMceEK7emT
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

I'm currently working on a Samsung SoC which includes SPI.
I'd like to be Cc'ed to further contributions and help on reviewing
them. Add me as reviewer.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..254175fbe34f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21030,6 +21030,7 @@ F:	include/linux/clk/samsung.h
 
 SAMSUNG SPI DRIVERS
 M:	Andi Shyti <andi.shyti@kernel.org>
+R:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-spi@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250213-gs101-spi-r-f5e91e344d11

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


