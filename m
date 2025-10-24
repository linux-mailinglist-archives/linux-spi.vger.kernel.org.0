Return-Path: <linux-spi+bounces-10830-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A994BC07DD4
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 21:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EC01C42AB6
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 19:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456BD36B96B;
	Fri, 24 Oct 2025 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="I37SDohO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BE36999B
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333360; cv=none; b=sBDConqSoYxAiFhQvuwFiYv3z7NR/IvdsxDhkuSqeWfPgCl0RfAWQ8y88eQp7TAQ0srcv+dnCuSDZCgLiBpE2vP2AgzpTUASubZFZ3YZUpr+C4k/8zQ8rUathz7jVbJKwOP8PtTj9jc5G364A9DKM8pZIUrOg/slIz/rcEwMSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333360; c=relaxed/simple;
	bh=spWtt1Pp8phvWIL1ongPyy50mYvbEr24rP0ZYo3c4jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mml6KVpRUa1Nkb/DrGDEsHD13g5j7/LIV8T3eAMdlAgUcvZSpE1MzDrwK+yafde593CBNMzdVoD4t03f6+CdGMWYp2zxo5EFuPL9aC93Zp2n1wRjv8NGo+uwvr76Kdo/6SMRfE0eCMsnW+tcYBCNy3uJA60ZYS8CG1cfdc3Unpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=I37SDohO; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430d06546d3so21262445ab.3
        for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333357; x=1761938157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0sSxMmpgJlm+DBHdJiFvMNmeUcFKdKvsAUrpyjqesM=;
        b=I37SDohOU9gXF7NJEis/lD7PE6Cb0yg0cb2EtUkTzmu1gqJC/M/9EwwzAVD79LzyQ1
         JSmtxoPffj4bmpPR+gTe6qvMG7ij1T3tuzpWYB/EYqXoQybGN/Y2GPDxoXM4z78gMzlV
         G/XzUgTv0rw2TPhhyn4l5PpvgASVzD0uTSqhsspGk6Lv4W60NtsxHEXVRKQMmdF1vTcp
         Q9zBT0BIs5PW2euaZsJo/fJhM7Sd6f5pZZ6Qs5SpJIxxkktliyPf6jrUHdCitEIx5Gpz
         uW4s/3XxVuxEMJqYleEHkm6r7xzkd0nL4F93Z+JKXSFTtk88DT64GuGOblLntsBq3L1U
         EfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333357; x=1761938157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0sSxMmpgJlm+DBHdJiFvMNmeUcFKdKvsAUrpyjqesM=;
        b=WUW2j6LlojTKZRePgS7t6qaMbRiJFsOeU5QNywHZMYbFuqtgCNBFZcGa19KKysy2ss
         OoIC7jvtqa1CFpXCZ4+CFYZjzw/odZSCLGIXXC67BLMG1PwPEbdQrmptwLqY3nQHmYkk
         Q9MhAXJbbiM6R4pn6lsFSYShR/hRv59xoIQoWGHq/rUbL0+LRDF6PLLEF6b3XVLqZubM
         cYVMIozY7QXhH8GVYhDhivN5fRES6gA0FJiy+3UioD1yhzKy19hEbrCYADS3dg/9wGFI
         Vj+k97653dk4knEvQuUd9uqmIH39Jm/3+G1nV++/xKcW/h8gc3EtHyyGYrp3DIuqHRP1
         Ziqw==
X-Forwarded-Encrypted: i=1; AJvYcCVyBYAZld94yNzloHr4nocQgskxX6gGqfO18esv9ghKpjBhKrWY8Pfx7Zf8Rq08YoeoZVbF9+D1DKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiG/Z3WJj+yRc5GqG/O5FUkJI2Slu9eWFCNrG/T1linjbvgnEQ
	45FMXGHcv0bQuvEnbMSCFTNG7eW/fY5ZH11zvh4EAuow/4xHuaM9CEMZPqbVmK0vKTo=
X-Gm-Gg: ASbGnctfswFUbkR147brbPl3vsbQXuJdhH1CcrEoZSC4qk9ccANqVz3B1KcfaLjuJBL
	8ms42aCX5mss9dJyt+/5W8FNggV3jqHf1XHd8NAzVOnZogGbFhVBkntPcFR17JH44HjaD1nZ3l2
	qkQmoSStcUjGRsOePmErVpwjTg4BydsJ3Hv1pkLh57RFZDbnwPzF7pP497dshHuQia4dw1uj+eq
	BvmUcyjjdNnDcu7j36adexwvFRizBF4yMpM8S7aiByKhEfdOjwCAbAwvO4fJ2yufUsQXCo7oN2q
	Bc66kuVGRB51UnzuXnHsWQ8hx9XakucihQY+zCHvmlbt39fe/jHAJBQsyKv0YUrmnsBBEa5CWQ5
	GrRaAYEHWNOdkImLMmh1EN7da51mH+KTX9VETiAmMuY1IIfTxLKr2RuT3OnwbzePAGBNH1NI21O
	YTxeNW4NZxma1SuJSvkbTIuEHj9CCr1aXYuDnTNFEC3p2TcaVzJ0JG4Q==
X-Google-Smtp-Source: AGHT+IHFcHZhfeKTHaIT8TeTse7w8bjG9Loy1iIsFUAysOy7saMHPhRTlKWgTzZuCkFXEhYPt8zLNQ==
X-Received: by 2002:a05:6e02:2590:b0:430:9f96:23c7 with SMTP id e9e14a558f8ab-431dc13b52bmr101093185ab.4.1761333357439;
        Fri, 24 Oct 2025 12:15:57 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:15:57 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/9] dt-bindings: spi: fsl-qspi: add optional resets
Date: Fri, 24 Oct 2025 14:15:42 -0500
Message-ID: <20251024191550.194946-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251024191550.194946-1-elder@riscstar.com>
References: <20251024191550.194946-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow two resets to be defined to support the SpacemiT K1 SoC QSPI IP.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - The reset property conditional is now under allOf

 .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index 5e6aff1bc2ed3..46e5db25fb107 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -11,6 +11,15 @@ maintainers:
 
 allOf:
   - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: spacemit,k1-qspi
+    then:
+      properties:
+        resets: false
 
 properties:
   compatible:
@@ -55,6 +64,11 @@ properties:
       - const: qspi_en
       - const: qspi
 
+  resets:
+    items:
+      - description: SoC QSPI reset
+      - description: SoC QSPI bus reset
+
 required:
   - compatible
   - reg
-- 
2.48.1


