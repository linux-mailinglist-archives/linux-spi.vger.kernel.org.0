Return-Path: <linux-spi+bounces-4478-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0B29667D5
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 19:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD69C1C23AF1
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83611BA286;
	Fri, 30 Aug 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGBsSjYV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A941AF4ED;
	Fri, 30 Aug 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038340; cv=none; b=lRNyMjgceCSw2ywpzeM3ZFxMmD38I1W0mX54TDSNPSWqxbUq0ZDrxwDWBDMeGtsLD43HUNOO7PgPS6Q5Zb/2d3OyBo6iL4U+iEcQhalxACZde3amLXtyG5tGVs/OLxZM4VnMrEc2kNuQm4caQgPXr78NdRoRNv2389NRHqG8Y2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038340; c=relaxed/simple;
	bh=+jpUXLmR5pSAvOQj2ANjYSi5Q2MTOLMGHwbe1u79XZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HkvUFqYEvU3YXa/rp6374N2SeOjo5LUMcFKttP8o0+H8bihrDYhWbpy7APblMgrVyGTR1y+zPt9n6Tl8J5LOeD6fITqBc9I59lbmlh6/0fYDaNyFzOlKiQ90OYyGkyjPbAfL+feqiU1lXYmyOth2SyTZiOtxHBWg7VZLa86e6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGBsSjYV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-714302e7285so1858979b3a.2;
        Fri, 30 Aug 2024 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725038339; x=1725643139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oU7Y9rgoKN0I/lBGj6nVMpMCGbyMF8VZWxC6PLhbawA=;
        b=CGBsSjYVArncMBJyv+sSG4HJ560p5pIxMaDDmtTbPlyUckG7GxnwAoUiQV0VKFnUi1
         cedFljt88OHbGVhFl67cxChHFxXL89fDk5Fwt0yUtjSqsK3AK9Xeez2qXw/PZCACYROV
         kio3UkbrxnubxELszXmcC8lnM1yB5iQ7NOchYYnqnBVb5MnaEdJ6Urhe05DxEJmwaU2V
         H3T83mQH2W0AM9ebhRyUc2aCdjQCeTto0N1OsI/19T+pI5SQVzdvulSgjW2RjAeeGVqK
         EFvU+Y5FdOYk6zVdfYvlt7Y37eKU+TBJ6HzktHFDt0ESQiQ1ipPhm0ufVpgkuYD/WmzX
         ulAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725038339; x=1725643139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oU7Y9rgoKN0I/lBGj6nVMpMCGbyMF8VZWxC6PLhbawA=;
        b=UhLQqRz/5lQ0AIOQUiKLIaPG4y7tJxHSDssMU76GgCE57CbJVK4rXiqNS82idI7mj3
         YIbmegX/XcD+xT6uQC6WEe4W6rNNVrZvzhvqxT1lf0ln95Lhz5H+4Y2iDXjm3EzRJrW7
         12794R4dT4oRfitZaiQaJpDe1xQttVZlLn25fMr9ApjcyGGgOGnODFxFANIhVZexO9fW
         6H7hAkLNVsiz4aLQ0xjgrrT/cJs89qP2SO46mVDFHsDl0o4rJHWx4Qu8lBHWq3M8xRiy
         Yuj7vu9ChLDO+leFiJloKbUJRWRV8p4twxNHlmlzCAAu3+oAlWW3rBYJ0vCtTVI+20Vm
         sBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhqr4lM+m5tU1T1NfxADMLISJiZLTunX8vK/mHK2R2FWl9y35IS9UVXlmpG6LviSEVPTq1n/uEbt4/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfci9/TxUb5Ihx5K9VKJYvjkw8Zkaah1CJ8WhbbXdcPargqhw3
	16/jt/KRnodAYvt4TmCuE7ViS57BVi/ULjLLYFm5n/e6+yZvDSKNhMMOjQ==
X-Google-Smtp-Source: AGHT+IEwynOk7MmdonDrz7jfFT5a01s6rrlgZ1wLgGtw1SUwLarImqNTp7DEpZIfN9osrXq5pTf4DA==
X-Received: by 2002:a05:6a00:234a:b0:714:1fc3:79f7 with SMTP id d2e1a72fcca58-715dfc506a0mr9081131b3a.17.1725038338533;
        Fri, 30 Aug 2024 10:18:58 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:79a1:1962:99bd:89d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569eee3sm3015156b3a.134.2024.08.30.10.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:18:58 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: trivial-devices: Document spi-cpha and spi-cpol
Date: Fri, 30 Aug 2024 14:18:49 -0300
Message-Id: <20240830171849.3750165-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Document these properties to fix the following dt-schema warnings:

rv1108-elgin-r1.dtb: display@0: 'spi-cpha', 'spi-cpol' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Add spi-cpha and spi-cpol to trivial-devices.yaml. (Conor)

 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 75a5fad08c44..f7c11eb6e5fd 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -24,6 +24,10 @@ properties:
   interrupts:
     maxItems: 1
 
+  spi-cpha: true
+
+  spi-cpol: true
+
   spi-max-frequency: true
 
   compatible:
-- 
2.34.1


