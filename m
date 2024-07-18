Return-Path: <linux-spi+bounces-3900-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA56393524D
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 22:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AE11C2100B
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9501448C9;
	Thu, 18 Jul 2024 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI2DY2b1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB9C69D31;
	Thu, 18 Jul 2024 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721333150; cv=none; b=fQzzFoSCTrmM3fqQJEWSw2ywU3SoIzcu/aENLuTjhWH0iIiYSfKYaBhX9i0hSQfWr5d5nudAumo/puocq3WzS0bkI1ElxgetW+fDhVtPtRnJJ4WqA3TaFqljN2F5hQyZJcic2Vpa2P6puWd6k4AxciTzal2LNRfcL5Z7YSlv0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721333150; c=relaxed/simple;
	bh=sWojNL8X3rJmlXPs3cnoX095NrxoBO7ydIDoBqIVh5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BguIFUsMmYZ60YSGEoSq6HIfczCXg5U3YYk5fIh1ozYSW2msKm/mapBr4+6YGe/hDswufPQP+iQoXcOXr3VGUIXaqVvbpOqt7D4z3zk8c+d/vnR0YjVYvMxr1V8YZ1i6r1vG8k/vlBwi7uSK8AkjbUgYiqFq/9a2m+OK3GqtKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI2DY2b1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc5a93ce94so1332385ad.1;
        Thu, 18 Jul 2024 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721333148; x=1721937948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXheKtONB63mZnV81Atvib1hdZFKffpvx2FPmF7KKQk=;
        b=cI2DY2b1V/1k1FppRBkgWujuQC6gpTGoYzuWOKjpn+dzyeMP2WQKcFkLG8s1lrhQxV
         32f1HnYzRvKoBD9MncuVjRi68ZCUgP9+eXxe4H7zxs4lH9JzD4ePpHG6s2aRCmRQrnpJ
         wf5m7EDTdSpRzmV+PwUEThfCGQyx9YGdnY7Payqvq3l4ByqOutWZa+7yk1Qa09Qzcu+Q
         AKVuiwEi0hA/Tbo7j1hNiqnXYux5UQ8yS3ICPHG5M9AJDsicMkq0ULte4lSWmKHDtCc7
         Xv5Kx5tnJi6YLe8tCopmacAU3vvUR0Va49kxeHzeScQYPUtjd87JQD8XVHTYz8djjTZy
         sqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721333148; x=1721937948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXheKtONB63mZnV81Atvib1hdZFKffpvx2FPmF7KKQk=;
        b=jmgSoOo6qJ4shNeu/mVq0Pln+kwPoNXcQ49CixvcKHeA2Blxd5/OTupAUzrC1tapOm
         qs0IutDGfpFkbWYR2B/Cefu3fiSxxsoYFXkDRRaOkU8WbzIGN18wPxnpJjLshZdlbnPv
         AElRjlGt7QR/8XBDed4gsY2K7B3LitGvECZ5EQQgygcCXDaQrbAM801pQafJWix41krG
         UVo1jJ1RxHJFpFsaQokdotio7XPtT/zXjeNmOpeKNHn+cOxM7a1MlF4C6LuFBcGI/Hw/
         Lg/et69H4bG7s+65rV2dhcYJd+35ZLfyO0iSxMOl2USaWKfGUqyUrH1oOSJJdCE6eoAN
         vmhg==
X-Forwarded-Encrypted: i=1; AJvYcCVXtqVoh1msYrCSo214fe8uIpia0XSOjAOGid/vAukXcloyVBZXHCyUlRooctm4M33tRoUos+k4z2g5AgNsSk+acWgCU5CiUi+Few==
X-Gm-Message-State: AOJu0YzUOBfBFeSLNK0J0BHbIq8Z27LsBJtdzwITm3RKiskGE8aLHhZ4
	Ncxk4Q7UyhIMjmoUX78fSjbMb5jihnscCHEp6rn1CIgVTS12s55ubcdwXg==
X-Google-Smtp-Source: AGHT+IF/IYe/2Zw1VOR52xWQar1QPSGSUaRwwnE259Ei27/3y9xxHfshZ3hbsIINHgM0Huyo4fIvxg==
X-Received: by 2002:a17:903:2302:b0:1fc:52f4:1802 with SMTP id d9443c01a7336-1fd5ed5e4b3mr4589835ad.10.1721333147956;
        Thu, 18 Jul 2024 13:05:47 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc92:63f4:6f0e:1985])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb74145sm97350135ad.3.2024.07.18.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:05:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] dt-bindings: trivial-devices: Document elgin,spi-lcd
Date: Thu, 18 Jul 2024 17:05:38 -0300
Message-Id: <20240718200540.955370-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.

Add an entry for the "elgin,spi-lcd" compatible string.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7913ca9b6b54..49dee2a1f6b4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -110,6 +110,8 @@ properties:
           - domintech,dmard09
             # DMARD10: 3-axis Accelerometer
           - domintech,dmard10
+            # Elgin SPI-controlled LCD
+          - elgin,spi-lcd
             # MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
           - fsl,mma7660
             # MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
-- 
2.34.1


