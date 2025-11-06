Return-Path: <linux-spi+bounces-11090-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE0DC3C1A8
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 16:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064C33BD1FA
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 15:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1782E2EF9;
	Thu,  6 Nov 2025 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="CxGpMew1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428A29D27D
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443090; cv=none; b=Si+TdNv/Ap085ti8t17nYUZHqEw8Fz4XvZRkGo/tJ0Sxh5p+3Wj+FZUcqZ59zfFFDvDgS4roCy8j4J+ppnMU+m0lVKIh0K6bcRQwc6f81oqpaY0zdUNm678Cr9D+YTH1VDbl4fnHCRoY6Z5e/hT6O7V7/8UOTBrQ3mx6P2T91Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443090; c=relaxed/simple;
	bh=d46gMm7iAqkq5ja/k89Jqo7GJI5rgDOyd5tUdQbUG1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV4XU9QuA/vUut7CjMxsGoAfR1CzyaLht/B3YNhsW06s67zGe4hmgH0+58g9+0wragNEAb53XZubNXy4XkepYdcT2fIIE70CYpgZIH6wo6zmTq4CjrQqNSP+OrLEzfsG4fgpN9lSLYFrYPvAqwGaniEnGq3Kz+D+sGCBfP5aKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=CxGpMew1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so768092f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 07:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762443086; x=1763047886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaXeZHBypXQ9AI6NR5KHVtefsgfrl7pnV/7arSANDLQ=;
        b=CxGpMew1KMsN98nuVQsyY87ch6ieaQFk4IdU/auNxZQ+3Vdr/xDHwSjwBm1kwA0SGV
         rIXs1dXXsRN/XSbYwzsLcZF2vMmS1/uo18bHtz6F8NfEyJ/LIOUW9qmuuO9R+eHk+8FR
         NJuzYCGDYqx79pL2wV9A8mKbq2B9yvXF2Tygs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443086; x=1763047886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaXeZHBypXQ9AI6NR5KHVtefsgfrl7pnV/7arSANDLQ=;
        b=JvOgYj4sWCms9fu9y56ytyX3TWTBhaUQh1fja0MwIPiVWxjO8xJGmyrmwPQjst47QB
         N+QzhC9A22D2THhEtBEtkk13dQqGkIZxdt/4znKJzBrRpAVl+kdvdTPguXV/a9xkH8ph
         WsAH9uXnsw1aWhbiNrM31IJkxKzlLc2+v3+5u909NYR81FS2J31+5aq6MgDfxCrW0nVP
         i/CdKRuYZ+NOhoL83p6SxjTmeXAfvORXuYdKMHXB43UkwejGWYU65xihBsQ1b1JegK0Q
         oMjI4VwmvOx5Wp65/OiDP3GhNaznPBpqnKEjulddaUZNzVAD4UV11ZDhDzVAgOBABGy3
         THUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPWTj+cqsuTsfqyeuicjxpwq5d4xt4Cl6tcRNkE81FMdbbGzJXViVkB9RGPLOe5/BE9aL7PF/C8nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqVai0b5AnWhpM4M8dDjfidieD4DE/yQFgoWniAYWWAte0Ar4
	ilAq74ldezgE05ltjRBwCfQ/n4sH6anh3x8iEqVU7NLGU0d3g66DmZ5G183VaiTCa8I=
X-Gm-Gg: ASbGncudg/dxWDqLNAzVYD1W8UK2Fg7Yzt4y6yP6mkg9NyelqJzEcLxVzt3+plwS08A
	v2ySjvD7LateT1kzFB/y6XsYe+YKfkplpT0A23jRWLwY5SiuX1mJe+hgtkDZkZmrO1qn5jcr4+p
	a+QjXJIipKll48p58ikpIGZz2KN+rQhM8lEP68Yufcw2mh0CsavvEfaJ8Ew7ihsIVj/C9JG+Hdb
	51+g50TJJDfqUP3vKOFnG5Rl16PWW7jyUqXC5eeEfe5ff8/ABiKg4mDmZxy66k7lvb/Up4+x6ri
	JF52oZ7GMIByCPJ/38d3LI7AxehY0JrpBaRQC8bKPHi4ZFy+WfjquJahhtc9+enXjkuZH+o3TJK
	zSDVPe62bMFtX8588s3Dg56XIsV8GF4YCaTZmtj16vujbhJyVlxjWAAU+BotKuVxMlW+9UakV68
	2JpzvxzvH5fq51Ftt7kYG9PuLT
X-Google-Smtp-Source: AGHT+IFyU9B6PrVivm8Ey9C3gGeg3vLDWayLnp/yQBozk7q8OZ+iEgdw4cIjtCmIUPVOhruID2h90w==
X-Received: by 2002:a05:6000:647:b0:427:6c6:4e31 with SMTP id ffacd0b85a97d-429e32e43e3mr7999624f8f.22.1762443086154;
        Thu, 06 Nov 2025 07:31:26 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm5966719f8f.32.2025.11.06.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:31:25 -0800 (PST)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
X-Google-Original-From: Riccardo Mereu <r.mereu@arduino.cc>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux@roeck-us.net,
	Jonathan.Cameron@huawei.com,
	wenswang@yeah.net,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	chou.cosmo@gmail.com,
	grantpeltier93@gmail.com,
	eajames@linux.ibm.com,
	farouk.bouabid@cherry.de,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	mm.facchin@arduino.cc,
	Riccardo Mereu <r.mereu.kernel@arduino.cc>,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH 3/5] dt-binding: arm: qcom: add arduino unoq codename
Date: Thu,  6 Nov 2025 16:31:17 +0100
Message-ID: <20251106153119.266840-4-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106153119.266840-1-r.mereu@arduino.cc>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Riccardo Mereu <r.mereu.kernel@arduino.cc>

Document Arduino UnoQ. Arduino UnoQ is a single-board computer
combining Qualcomm Dragonwing™ QRB2210 microprocessor with
STMicroelectronics STM32U585 microcontroller.

Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d84bd3bca201..1af19245b1d5 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -336,6 +336,7 @@ properties:
       - description: Qualcomm Technologies, Inc. Robotics RB1
         items:
           - enum:
+              - arduino,imola
               - qcom,qrb2210-rb1
           - const: qcom,qrb2210
           - const: qcom,qcm2290
-- 
2.51.2


