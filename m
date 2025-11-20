Return-Path: <linux-spi+bounces-11422-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B151AC753CC
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 17:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92F8F346957
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B43612E9;
	Thu, 20 Nov 2025 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="D8wz3VpJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5FC359FAE
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654313; cv=none; b=ITKcons9Of5NE0yy9ZZ6Jjgf7STLrt/uewaNRDLexE+luGug0/+ZDGy+dkWieTJo/R4AnKkMoIqDM6rz7dhYdGP3dpmLjIBbuPPyxTcEgshSK1D22/y0+L62JH/IdPnL1R71i7JktOOofQFjLbE49tCQ1WYxdiu2egXhoxVdUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654313; c=relaxed/simple;
	bh=gowrLjtyOcvjBL4p58UCz9xf7QYOPtC7scsXBhW+jFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0BB1NH5v7w1xHaokO9VIHbIYNdchL2fLnxa986+qLXoy7G7v09IEfiMd8flR+5SkVSrRxG4NfRlqt9+tK/8gRQy4XHTy0MGDwn+mFnWLPQbiK/QUt/HT8oXaOIrwEasIV2YrXzE8CMiKOAifMY9VbFWXiyomMH6xnutypI9SnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=D8wz3VpJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47789cd2083so6708085e9.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1763654310; x=1764259110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ru2x7aLzVd5WoKQZeYoG79pGESHgaomXnpzW+QmhDU=;
        b=D8wz3VpJbNwvc47NL324mejleX2FosXoop5srqmQuFpuaw4F1Xa9GgJCYfbOZwVSaV
         icn4jciwFVWJ7Ly5WjKuBU2tRT0jVN1i7AnAAecP2GmXPlPnYj0qWpab7EBuFphMVyJc
         n0ehYARTzuFgF4HbYT3SaJ7ih3IKEsnxIzPRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654310; x=1764259110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ru2x7aLzVd5WoKQZeYoG79pGESHgaomXnpzW+QmhDU=;
        b=vNlSSrAp6AANkhmEzpgS6/sBWz43kXyP0XIaBEFnBO/eDM3nyMxIu5jwCj+qLqrnaM
         0QJY9LSnwD1PFom2whaFcKZ1i+tIKYvYb+cWe/L5QUE/3OGwDcmYA6VtMJEzBfTKG2K9
         bskx2ljtGspI1NQjQdcVrNN0szxypxPXT+LqgDZARVNMXPwL5kxYDZ+rnj+2ef/TGN1z
         xXp01vL6jy18LAvOOsW0pv2rLpWIXId9EpinQ8bdPCM5+y2DIhnG5C/U2hR4rqDuis1R
         0RXEpJQOCIrOhx/mRAJqAWTjAqnOBKiAH91pB2iAtrcrFvKJON4r0uRLbXqB7K8xh2ue
         Y3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWybDuF51RtSDajF9WZLcZT8LJ/SSdx06cgxORzWY5Dd/PERBp7TIwUut5ESVTtONFlbA6OKO9QR1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZW9iOrrap+q9R9OU3WK8a68xvKyDGQ3OqofXiqd1m+Kt1L4mn
	H9W9PRngyze/II6avxVh/lKTvol7B+IWBjlCjjsNb+gCZftew9wDJrJww3DzZF11InE=
X-Gm-Gg: ASbGncu+990MLgpoEvuR/ZT6msBcRk4gQqfcXC2Cyyk4Nm2+l58NQrISVi01OvxLfSj
	kr2ghAX8A1fnZ4JVAjHHzrm4Cg032vqPpfIbj7gY6CI0VGh6gnKJ8ZRbHcYdI+gWQ4H24KyMzcu
	i9sgSCU3v/nQTzM6mALTZ5wQ/YEvQ6six1YBjqSp/p1g5f2l3Vonm9PZoZiXIvm7wWwb+BMA2Y4
	ml1J2lYFIfs3mMogSChGAyVO+gzVfg8q+yBnnPf5+GEI96+2i/r5d8EvI7KMTlYFdmV20UNoYlO
	7ubLcNKEdoHiCM7LNbEwsSDcVva6+6th0ySXXvAl1Rzq5nGRBPROvVzAFmdrM0oBnysbanJK0QZ
	x08DOGXiP04y7661k9FMtn5T7S43KU0H+prmmMvCDRn3WMw7duhcbgTaJBftoNCHlR0G4f+qqw/
	m8xt+c/fRrRy1movtU7cXbtQM7ckZugudX0F1F0J4wvsZRga22k5oAytk=
X-Google-Smtp-Source: AGHT+IF1vyggDCykNrANwtKViOmaLZ3/x6iQowIS3JkPfpzvxSMEvUjs/y8xWlfNkK9IfscfEbzSgA==
X-Received: by 2002:a05:600c:4591:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-477b8c8dd99mr35889515e9.24.1763654309847;
        Thu, 20 Nov 2025 07:58:29 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82e8ea6sm55552185e9.8.2025.11.20.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:58:29 -0800 (PST)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
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
	m.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH v3 1/6] dt-bindings: vendor-prefixes: Add Arduino name
Date: Thu, 20 Nov 2025 16:58:20 +0100
Message-ID: <20251120155825.121483-2-r.mereu.kernel@arduino.cc>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
References: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Riccardo Mereu <r.mereu@arduino.cc>

Add entry for Arduino SRL (https://arduino.cc)

Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 42d2bc0ce027..07a285c9387e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -158,6 +158,8 @@ patternProperties:
     description: Arctic Sand
   "^arcx,.*":
     description: arcx Inc. / Archronix Inc.
+  "^arduino,.*":
+    description: Arduino SRL
   "^argon40,.*":
     description: Argon 40 Technologies Limited
   "^ariaboard,.*":
-- 
2.52.0


