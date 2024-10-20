Return-Path: <linux-spi+bounces-5261-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1539A55BA
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801A3282DAE
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B827196D98;
	Sun, 20 Oct 2024 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL6eVOM6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5229782877;
	Sun, 20 Oct 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729448518; cv=none; b=C5OBpN0mEb9cWjRbllIZEUbOpNkPFOn5WU7ELernlSDD0k33ksW+TYoX6UvH0zaxDrQ+jjn7828+fZd8JnIK2ew446fdRQgeYk1S6adVb1jl+5W9XgvXoOjmU0xLG/DU7AiaxNjMQmEEZIQDbyau+GzbA9fuZQzqDvGreGjMQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729448518; c=relaxed/simple;
	bh=DkldCas8fd/TOO79V3sKLrNbOD1VOeQ9gN1N6icZKBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eugvvw8y+f8in63oukgzU51H+Hpu3YcPSljKkvOiZI2IrT/QCX0zyw6HPRdMewtA3EGKc7DPtfhPx/LntM54Zq9YxV0lluZSkqqT6EWuaFCj9yLlJ5ioIKXQlLBeEubvFHD/pqnBmnidAUvKCCEimHMZ3GWGQqx5043nVWtojjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL6eVOM6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431695fa98bso11658855e9.3;
        Sun, 20 Oct 2024 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729448514; x=1730053314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgHPZUl9EaK+x17xicr+Z/IZFB5BFkfL1GTqtrKe1qc=;
        b=BL6eVOM6cnWQyUCiAxf+cB3UWfp1CbQKkpXpmVyr7vd86zxUlHpFruFHTKWX0A5SDZ
         DFQAwBjQa/PAsV2UEpevh9fkfTb+rd+R1/6u3OomPAdAyRHhkoMdZGK+StpSf1OZEE0x
         ed7bOLc1AdLZebtUpuzHq1PygVmeJpwnOaC3EvuAm4h3LReT+Gtv2GRlr3KVmTBMtLkl
         mHogspdRjRuEwdMua9m4aqZv872xIWk2tri7I9vH+wpY2SusArAL2Qp70lqvMjBglB5U
         6pvriHxU6Mo3sb5oJDIbFzmx6HK2P2+AX3PSCwa//faaGIvXc9iLFREkFe1nw2f6IQAb
         TDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729448514; x=1730053314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgHPZUl9EaK+x17xicr+Z/IZFB5BFkfL1GTqtrKe1qc=;
        b=uHBBlW2+nzyqz2rtUstQjt9HENHLhPjB0XIzy4lLAYW+CCp5ywUvJUhVdp1XcEQc2o
         ltIDxmpOzCFefL73a1FnraddsIioIWhijPRG4OFkCw87vLZsddoBvk0bzwWx2fq+xa6D
         MCg2P3zXHXA/NLTP/+zr7UZwdIOTRavddoyP8dm7FMCh6vbTJcUTJjEYTo4lrIPtT6tx
         a5ZQGSSTew7D8PRRSRNe3A/DXMH98EWaBIxjvB575+NpT8r5mf4yTixOxF2F3WLfEzeb
         SwszTvr4+ZTaDysnd1ocqeAJKqqEKTndPUk8YPqlVuiklqSxfgQRKJSbMghEdqRaeuvs
         b5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVTZHvvLlVCRsdqvN2K7ElGNBpHybNe+4BXW79J9HPs/z90kasVjXsDwgY0e2FwSQ56EqdhjfMiUGl6QyKN1f+j8hY=@vger.kernel.org, AJvYcCWFzDbotVMjvk1HEBD+vNb+feFWZnhiRaMAFCxp80SAEi6oa6FXDVM5GQsPioQr4umykeYSygZ6pNekhYPY@vger.kernel.org, AJvYcCWfv1oZS5qMp46ygsdsfvgJCAV3DCpWIwKUdt3KD9ja0pgxjhantoaNYOCsmPdZ+4eEhDy2eXZvjlaC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3p7fZiGShiISQ3GklYT39ijZ4PYHOBiN/2jsUv0Dak7xm1Xc5
	QqHOFa2YC+HHYHXNRfxkniQhbbP9fUuuJQ4Wm7aBKTtwoHvExtwB
X-Google-Smtp-Source: AGHT+IHdx3gzdVZUTSBkNeFTqWYarou7I54xxoTfap9rW/19GUILqpLWd8sNsf7uhkB66uE7A4jnRA==
X-Received: by 2002:a05:600c:1c03:b0:431:3bf9:3ebb with SMTP id 5b1f17b1804b1-431616898a5mr72097295e9.24.1729448514362;
        Sun, 20 Oct 2024 11:21:54 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a48903sm2276459f8f.37.2024.10.20.11.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 11:21:53 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] dt-bindings: timer: exynos4210-mct: Add samsung,exynos8895-mct compatible
Date: Sun, 20 Oct 2024 21:21:16 +0300
Message-ID: <20241020182121.377969-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like most Samsung Exynos SoCs, Exynos8895 uses almost the same
Multi-Core Timer block with no functional differences.

Add dedicated samsung,exynos8895-mct compatible to the dt-schema for
representing the MCT timer of Exynos8895 SoC.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 774b7992a..02d1c3558 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -33,6 +33,7 @@ properties:
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
               - samsung,exynos850-mct
+              - samsung,exynos8895-mct
               - tesla,fsd-mct
           - const: samsung,exynos4210-mct
 
@@ -133,6 +134,7 @@ allOf:
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
               - samsung,exynos850-mct
+              - samsung,exynos8895-mct
     then:
       properties:
         interrupts:
-- 
2.43.0


