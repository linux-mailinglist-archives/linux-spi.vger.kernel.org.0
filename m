Return-Path: <linux-spi+bounces-4419-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC04B964314
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 13:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8561C22B28
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22F191F8B;
	Thu, 29 Aug 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBDfWahS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C3191F7C;
	Thu, 29 Aug 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931143; cv=none; b=o9vwLiTFpdh109jJ3bfnbWhKh/dNfkjuOZDGn2ngocC8p7EvJiguC6vYHcTRTfC1T7m3FPEPj0mxYDMmEswubMbOAfmk3tEhZ1y4cYwIt1FVoRIh6/kXZLO7FUz+DvMcIU7ks0kA05Wn7NGadwH6Ry9E6wyciNTaM2ft6/H7pFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931143; c=relaxed/simple;
	bh=pSzL8+iex+y1HoezB4Vyvz8lDz6X110zen72jeHN6Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EIzHbEMSH3cgevyT8DgFZGdqR3Oo5P6XN4sZYyPWThiedyi0udWQq4ayf1GkaM6bTm4NMVUztZnEwDHYl4X+3UKsYhIFaBb9t1Cw5vkEPCMpKky96tav6O2nlIWK3ir7g5Gq1qynGLVsFliT+DWqk+TCtU8dJyR8RGp/Df0vUSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBDfWahS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2050b059357so4192095ad.2;
        Thu, 29 Aug 2024 04:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724931141; x=1725535941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9dFeEuVzWMuvvn1W4iFKeU+WmoZ2qQhJ2AGD0R5zNo=;
        b=VBDfWahSLjMk4SwgvlSZm8Tcuoxq/uSeDqM6rIy3SFjDQWQncsjYL2XZPrCi+d+pk7
         ed2aQ9q7WIlpLhenKqpwYE+GeyRD/jc+6Jy0+VZfwtO+qQEbqlom8l2MOVizFx+gzE2w
         AGGcwPvetqs452MS8MOB5lktEenCCz7xCSCv+fwHVg94gk7oGhGQC3dgXEgnxdVYdw+k
         xI01GmFJoj0/xt/0zF7o/x3/sNvW9werb0iZCIgvfMH9u5F95TeUxbpZRGSATy106i0F
         28lDn5li2UFL6tBSl19gE23095LgideMOs6NTjqNk4InMmjtaO83qEMFciq5Duufq46h
         12XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931141; x=1725535941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9dFeEuVzWMuvvn1W4iFKeU+WmoZ2qQhJ2AGD0R5zNo=;
        b=aeymXCqvDldtZ9Sxx/zPOudhfLkU6SA49tW6ExMA8J7+Iy4hwkz0wF5HPZmLwMSffG
         Fkh4NQgaai9Dn89Ib/i0mFC0yj1EnBaHSbGYczONTecu0PjyIsArPc8sPx3ixdt8yQa8
         TFaLlEyw0iRY3dia8zEZZzgTPy5nT3aWpwt+zxeuxENpw/C+lmYUIgR/IYVP030kCnU2
         J1AaJ+wGABnfAFpwOT9BXtYDEGa9pRI+HDvxBXEDAQAtc6yuPZyl0JexbCPDtyuvfUdt
         MKmImRTKVfUdNpynr3Yvz2Qr/CL7bFksohY07HLsISVn/YnvhJ1oHjF0gZg1JRtzT+Dn
         yGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXLz6JbLEOqOFpcycTDWCnIOmCt8z+RNRnNaqDdw6REJTZzLFwKQnMLYJHphu+CM8N/IccPT+BhfFQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGthDjDzD9Tb8vk20Y0WUVklKu5xZOvMGTyoh9zN3FxxISgUO
	r7Bx+D6YCx1ByIWKZhVFD6lPdX1oNSOTJXSlq0EleKMTJIBp4Rt+
X-Google-Smtp-Source: AGHT+IFQhh7udGPBs22mw+Lo+i/8VI1g2emb2HGTxl8960WIJyHFVuhx9mNCv6sr4LklBf3KwNDLRw==
X-Received: by 2002:a17:902:c94f:b0:202:32f7:2326 with SMTP id d9443c01a7336-2050c3b91a8mr23847675ad.17.1724931140984;
        Thu, 29 Aug 2024 04:32:20 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:adb0:3b7e:78c6:e307])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20514fce4fdsm9652665ad.0.2024.08.29.04.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:32:20 -0700 (PDT)
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
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
Date: Thu, 29 Aug 2024 08:31:56 -0300
Message-Id: <20240829113158.3324928-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
The marking on the LCD is JG10309-01.

Add an entry for the "elgin,jg10309-01" compatible string.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
Changes since v3:
- Fix the series numbering version.

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
+          - elgin,jg10309-01
             # MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
           - fsl,mma7660
             # MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
-- 
2.34.1


