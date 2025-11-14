Return-Path: <linux-spi+bounces-11205-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF79C5D15E
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 13:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FE5D4EAC44
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 12:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F64314D15;
	Fri, 14 Nov 2025 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="PWE/AiHx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907EB22F386
	for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122748; cv=none; b=L0TP6LbtcONH5HfYE2J/nt+QPHE/AI8chsfo31Fi9qFrw6irxpQX/14ejYOW8tY2J8pxynEV4DUPrmsojyFlDpfjgUJTbvl6jocP2UiZ250TF6sw5AP2lWymLHl/zIC//39gPisqcWWTce7T5qmL73+abk9KtkJU5YEGIxtV3fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122748; c=relaxed/simple;
	bh=8hJpcHQrq1WlSpHUFoerPHpeHijwN2l3PQGmvu2ZaR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSUsEjOE2d33HYK3/tipLDpv4axvuaBScE7TPV4xko6aT6ecI/4w65cGcOloC9mqivyeduPtEERLrT+c2hRFH0bjhB3Pv92BAOE5YYJPoDZgjQ9MYeyOHaNuGPKPWyrS1DwijTIINZ9rYKrba1/hILTU55duG73UUXtVnefQPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=PWE/AiHx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b736fca06ceso60662366b.1
        for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 04:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1763122745; x=1763727545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V+ZvIG5EFfPVUmOq4TzkXuM/WpB4BMHn3sJtW2UJNE=;
        b=PWE/AiHxm0RMBWRHYKmHKsRdAjDKNN5eOJWAgm0uu0lr5dmtJ+ECZ2Cdf3Jvnb/QS4
         4zEOxYe4XG/gEiqiW/Z4qXFeUXk2Ko01HAB+wEde3Hiu2rTro/S53kn991czB2oM5lIy
         g0oa0BcXjzE47OltYUnNXmZZgDrhJipKsTpVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122745; x=1763727545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+V+ZvIG5EFfPVUmOq4TzkXuM/WpB4BMHn3sJtW2UJNE=;
        b=fWnK4n+gzGmh5M7XYrPQsLdD7BOOj8+yw4b34Qwkw2aT1rdkni8oqUTaYT8tNay2gq
         /pdBpXZ2Zpz1QK0OK9nEzfkmliK9FIgDIt1CRYqsMFID2pUIci3cJ658jB6Be1u4n2GH
         SEFxfGY1uKezsJZSlM2ifbWa8HBlzleRTRKDjj9h3wBK1TShTEdJA1NeMK5B5DwtbAhV
         oYFM6rqkGVx5YjzHYpEz+OfL/Ic2okyUiy1H6PqPgqEdxjMh1ObuJDbpxVTc59bYf2qj
         yW2QUKJ7Gu7C9u59rZWnVgq3Ntpq7J3+/c/BfdCxTlJK6PiUv8mpbqnl69d6Ha1TxFLU
         p3hA==
X-Forwarded-Encrypted: i=1; AJvYcCVCMLMsN1fScowgPV7HvVSQOfUWfb4mNW7M5baJ/zovZ/G4gFORvvCKz2gmIDeVQpmaSkwmNig7/LE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2O0DgcItaillAaHlMn+NjwbeBXB2oApnNLfld0NFaY+jr3sVM
	fXWin7QJ4+DYkuv5p0k8EQzdBRtm2PsYUCQQKOPAgpvx9AyhG4mY5CUakze0wZpuBnQ=
X-Gm-Gg: ASbGncsOpSAlzbw200kJy94MRzVRrQKIh+FUMSWWv3cRRIniOkMF2mgQQk+jHbvelAd
	ta/89mRl6nZF6rHUhs5unfPPfwm0buhiUcs0QLdRecREb6UbkoUYzgkHXj3APud0dvMQxyEkUfc
	eu0ickIVHr1rBKmtPFQXbdFtSYF4Xrrg+QHObXc/j1ecoBlGXokUafQnsSN+O7pwfdUyiang7P3
	OF3BwUeAw3W3RmzzP+4YOepyVfriXND3ASol2v50P+6SgKASzll0G5UAknQxtnPuvRkDYSzBaYS
	i+/uMULJNMhpgGzhBOeHL1MZET37goIUx3qscjxFCfgQzDTqnU55UAM68pG4GlEvtyFKWKnO95T
	Qgll/J9X0BrvvxRuvnAqylIE5azZ7cq+SHVQ6WgY2hyJhX8QZKkVeqoWlH3/6g4s4AHvAn+kpeM
	+GiRPQvj0VLb5UqSqbYo0fbq6v5jlbexAuLunJK8faABseeBARMwf+nSSIUqc=
X-Google-Smtp-Source: AGHT+IGp6/yIo5H99FIs0TSP0/qTcse3avxJmiIaDDcLjedaK2Z/WFNPRyyMTJ5VxQzJ1aHlVnlu8A==
X-Received: by 2002:a17:906:4885:b0:b73:6e0d:4f6b with SMTP id a640c23a62f3a-b736e0d5e13mr114394966b.36.1763122744938;
        Fri, 14 Nov 2025 04:19:04 -0800 (PST)
Received: from riccardo-work.fritz.box (host-82-52-164-74.retail.telecomitalia.it. [82.52.164.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fed6315sm375295666b.64.2025.11.14.04.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:19:04 -0800 (PST)
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
	m.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH v2 1/6] dt-bindings: vendor-prefixes: Add Arduino name
Date: Fri, 14 Nov 2025 13:18:48 +0100
Message-ID: <20251114121853.16472-2-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114121853.16472-1-r.mereu@arduino.cc>
References: <20251114121853.16472-1-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add entry for Arduino Srl (https://arduino.cc)

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
2.51.2


