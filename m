Return-Path: <linux-spi+bounces-10727-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC52BF287A
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 18:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03BA4265F9
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 16:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809433030E;
	Mon, 20 Oct 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="vPAvdVW2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067932F75A
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979121; cv=none; b=A/y9oUuaI/zfpalJhOgX3Rpv06kFPwH8DKYb6aasJ130sXOzzPKiNeXIlcW8DUMXqfqUnoXEd0Grg/6Pi6GvmS3P9UatnrhARvVSvdu/lLI60KoNkRydIWL/Z6kNeuHuljHevd2QQh1ydpaC+1P2YJwQfDJJa7hWLF605rXE/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979121; c=relaxed/simple;
	bh=J4RnlkPmRis+4sZTPl73tqOpMLz4XTH3ddn132lst7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5I/eSzsehVQzShj6jCxr1duj8Ox4nrZfHuZfyOJ96RmkaqZVtupmviokr3lZ9sATnMkUdbOMK0vg3aaBBWSIXatV5xR2y8aEu2R3W+F6QoWeCBcdi0CH6r29+adLvhejOvz+u1Al1h1gbOnDcINT1be19y8WUn3fm4t+7pgPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=vPAvdVW2; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-940d2b701a3so179268339f.0
        for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979118; x=1761583918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuOxACCK+Imy4d0s9ApaTGaS6oXJ+8tFgrJY9fioEn0=;
        b=vPAvdVW2Aq9JKBgQQn5U/VBywZ4m8Acex6+JX/fjRcJJaOpU3lpjfyDQ7bBaE5C78P
         szpBB8M2ctfZjuo8n23fUVOs26/6WuHLoV8o02kPEX46Jn+VH7BAKf9PP1+8QT5sgSZs
         F1ASYRs7Rujbm6EUdaHFdftWev3KJkxMIGmJiInsHrWcyEVYEx1wuVTb4SxfVslsHKtB
         KrIKyQYH1RoERiQO3V/T8idechikUX9H6txIYF1b2oRuH30JFbmZ3PfspE/2pC1sKOBz
         zhauEgJttg2W/SY+erDONQXd5iUk8t5FLff+D41I+Le2tUwBN0+glcbU+U+uHeX5PrRC
         szcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979118; x=1761583918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuOxACCK+Imy4d0s9ApaTGaS6oXJ+8tFgrJY9fioEn0=;
        b=kg/QwWWUurRl70d4peoC3ODyWDTm35txZtcSEj+K5u1JpNFUBEn2c/FKUCsWJUqVa2
         ihKN/j+zG0TJj67VEYwCqycfvmY2gNOejkgR9wSe1iGeatsGFhGNZkJpSCnd+Ew+Acwr
         taFQXtKC0jz7aG+jKK0IouHehwIoqdvFtxHvlQQnDa9Tqxtw1KHvSEduKUpsqmx0vBgu
         KfTGIG4okGjzodbIOs2EOAWUVSRo+P2f6VO9ofyz7JKDBFI3hErCuUwQ6sczNS4jiC84
         o3jywOdRePEJm5KWgwps9q1Ii3eE4X3NxP5m+VXLOmS9lb6Zgr1dy85qavLTEysCU7IN
         IByA==
X-Forwarded-Encrypted: i=1; AJvYcCU0vxJq5QZtcHUNTDthbZ+MK0qMNmCTe3Hu+7C6qM4sNHohEGNGIY53Qee4EBwirWpUUfUyOLoLMh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTcSlla5GM5u5iQEFwW67dIUnz0FVwyMaMalsdT8O47Fcb/Wn
	FRpCcQyKri6djnSPljT6b08eINEUfgVfO/9WKYbZsUShGnuiy26Ctov6+M1r00mfzVQ=
X-Gm-Gg: ASbGncsCy+k/n+pobmIzSIMIBxY7Y1OfztZ7+keYFQvOFQvMaWj8vedR9J6XMFXOv8d
	RUpnYLo9BCAV61DKKl7z99/Nj9CPeJ0KuC4ry/WWIEEGUiN2NixfKIhvoHFT4wE4SQNW68G2J3t
	l/oNc2nL1JVP+jcomo6GEJ9ArEzEfuN5RKMcKR5VhlulXYAbapkHuFp4JIgZL4kl5O9OEpj892a
	OECSY28xJmv8EdydLDTQ+Xxk4IQJ4DGWMEr1YgYivZunJZWdJ46f90TXlI7YLVkFRzcScUqlfMV
	cdLA81wrxEyeW8MmS9ebYcC4ovUSM7TbDZm1tYAIgCKQK5BK0dCyIHO7t7Ovmi80HQ8PEM+KN09
	37bC6pQCcyVu7uoaRUVfGL3BuaBBsaOP6J8oK15ODWo1xw447t4Nna5Mop6O8Ty66hKviz/BpiP
	DMxvYlcuxyFj9l49G+Rm5ZP3il9WkjlFF9b02Nww//nX4=
X-Google-Smtp-Source: AGHT+IEC4oh/Jnvhjv0NLxKRomMypLMZRmo/rR+Ffv9+T12KDSfiODwIv7xt26rVmqA6jr2VlWiOZw==
X-Received: by 2002:a05:6e02:152d:b0:42f:9dd5:3ebb with SMTP id e9e14a558f8ab-430c529a04bmr188317305ab.24.1760979118533;
        Mon, 20 Oct 2025 09:51:58 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:51:58 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: spi: fsl-qspi: add optional resets
Date: Mon, 20 Oct 2025 11:51:44 -0500
Message-ID: <20251020165152.666221-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow two resets to be optionally included for the Freescale QSPI driver.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index f2dd20370dbb3..0315a13fe319a 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -54,6 +54,11 @@ properties:
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


