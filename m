Return-Path: <linux-spi+bounces-3906-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E917937708
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 13:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7C528301D
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6637C84A3F;
	Fri, 19 Jul 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2D8JtT0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35CF1C32;
	Fri, 19 Jul 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387584; cv=none; b=ttnpajm7UAepxT5G5P3JT2T6rLOLb/mBBb+PWbyL9ztqDTRvd3Dc0RUcaRoj+M7IkrrYVxO3D3r7slTCT/lGjAvyIhBogzc9SYTgmrtphV2MTxbvHPnzcFF9sS8dbmIcj08uQKjt6FQ26gKqK77yDRExl0h/likVBTHO+n1/VUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387584; c=relaxed/simple;
	bh=DeBhZN/NmpG6IA9JiOUw90IwSuXl2le2Lnod9F51GCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SL741pi0B55D8Z387LRo98/nr6IdzhSK5F0hgm5ebRiXWPx+u4sXJisKp4N6HM6+m3wvtQnLICBJ6/s4HQSyWW/zBA1oC40BEymcIM2pDlUlf0HokVVeYd5vzM/SqdAVMpYBQXMjEcxBjideX5sCHUl+k6Nymra0biaSZLvHndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2D8JtT0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc0f82e4f5so1936075ad.1;
        Fri, 19 Jul 2024 04:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721387582; x=1721992382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYKGgQCnwBW6C3iTDEr9XU8l1I80Ty/xTymBkUfjgJc=;
        b=h2D8JtT02wrLYHqpypr+zhJzaYmKNu0FLGsa8v7WTedYuZVIhFr3j9zcmyiuXUdPHA
         NbHzWSwDZcXl5BrAc6l9GurPVxECPEfYX043gFPoHkSzeyu45pfgTS2mznO1zMpytfoi
         wrxHeY+1zx7D4yOLq0UBW9W1gvSrLPtmr3rE1GvbGs8ZFaC+KZ+lCdemI5z9H+Wa+bZz
         OyPJMFyUJVgYu65lH+1kCNXW23yYBH29bUfBGis/WUVKUp3v8Fk4Gme/AnpCO8RejggO
         TEP/GadnKEOiXd9GO4ocbZsFJ//xn2KR8F4oWpic65IFOk9JYJHyyaCcv1FKmvd03qMz
         Wdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721387582; x=1721992382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYKGgQCnwBW6C3iTDEr9XU8l1I80Ty/xTymBkUfjgJc=;
        b=kZU03OZkYsQtgrKSxo+PVlP7rYGyGWoYbQYDugRMNkkcAEbz3V/jLOlBCaUnKlEgSB
         xAbCvet5G4/LfelV7FncmZDPi2hnnhBjWHYESoB8BOHsDYtPaARQFLGKWjLwjc4fcDpS
         vSPwm8RcoKxHUcVK6ed3NHklKVOxTHHB4PXkPMBTiJrkzOXHw8c404JcBwXOGEm6fmuN
         C4IBnj0A9L1fIqEHcIJy4JgJ0HcPNHyyfWZ6UdBYWPVrEa+6KqDFgWKeE0cEOoq9+MNF
         dZZnQYIOyABU94k5mPovWPLb5FYMIvPEpREniqrJ879atHTCAGBIJgUlL2b5qppNfq6m
         uzzg==
X-Forwarded-Encrypted: i=1; AJvYcCVlGUh8HhsIkZC9+bKstNhelJoCqGR/ehGfIHLedxtZYISzXrPkcvaL7Fc5RI5c7m0OxQOB7/degV/K+P6VB5II+7bp3LBopsIsMA==
X-Gm-Message-State: AOJu0YyGVNckoHER0rP6tJDMlyGKuZgH7eAvSj7wQdQpndWmdlYl9fMR
	+B+o6ONg1p8Hubi6vui2uoQNR9YiFvlnsTtxxeGCgAXXV6O1a96e
X-Google-Smtp-Source: AGHT+IFaBTGNZlYOMOiTEHq0noqi68VMshqvGTkVLKUwb831GCirfNOBRHwWQ+d0kfnVSmJO775dmw==
X-Received: by 2002:a05:6a21:c91:b0:1c2:8ad4:35db with SMTP id adf61e73a8af0-1c4180137a4mr1435949637.1.1721387582049;
        Fri, 19 Jul 2024 04:13:02 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc92:63f4:6f0e:1985])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb76a619e8sm2303031a91.0.2024.07.19.04.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:13:01 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
Date: Fri, 19 Jul 2024 08:12:08 -0300
Message-Id: <20240719111210.1287783-1-festevam@gmail.com>
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
---
Changes since v1:
- Use a more specific compatible string. (Conor)

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


