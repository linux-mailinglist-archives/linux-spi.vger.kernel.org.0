Return-Path: <linux-spi+bounces-11425-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4F0C75493
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 17:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65E204EB81D
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF73624D0;
	Thu, 20 Nov 2025 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="UqyMqJ8n"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9FA36212C
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654317; cv=none; b=GbqpLSALtCVpF+xeJquinw8zpNz2ab8DdwkIhx/kM8cHd2ZamMdnOiQe0wrOuC4wA1N4T56N6r+/4asgExR5+rMckCI8nHudGT6U3gvZxkuRItyPrp2QX6CxD9iBjG9slKRWdVJcsJT05CmJsaZkfskYy3e6RjDfUVc8v9upEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654317; c=relaxed/simple;
	bh=uefBu6hnnHu7KoVRBXBGpdQGhdbjZYZrhr6zCkuXgCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ay4ftWhAi7lxOl9uQUwHPOKtTg4VhP/HASTO5GWgBhuj6ERxSV+BJb15JmaezY174olene1fHiAF0S9XAPmTW1bkRcAAk27OEp+3O0Owj3aAkKOzuEtitIflOTtS0/uyqE9BvlerfcOY7TWSz0S2QMveGVCnuDYsUgg8/Q5X52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=UqyMqJ8n; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477563e28a3so7525205e9.1
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 07:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1763654314; x=1764259114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFLIOuElMJObR8yP1W5WYQVxR8UuBIpAgy2xBphJcsE=;
        b=UqyMqJ8nflkdM3dI8P976D+sZdRpMkdKGPe1A+m/6/WuzSpUUWDeXgyZ36yknq/IBm
         rosEt82HTsQORmUSc5Dmfv/YhTOb3EM5ZlhTV325tcVY3G02lnzRaDktdCGZUdRHgdoD
         k30RwFgkGyGSUzq7N8mt59YUsYZzDdRefXYVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654314; x=1764259114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFLIOuElMJObR8yP1W5WYQVxR8UuBIpAgy2xBphJcsE=;
        b=nOHUs+wGAmvQWFrwXGlcE5cNEbT5Sm+bOZmeOW002r2TNx6HvPs4MUdX+Z7oMqziWG
         D+4M2Q1JVtOgC1SOcvkKntWKyrOZ8GPvvNUYvfJRUNYF4n1Sfg8GSHJzKQi62Tag7faf
         3FzKUOouBBw4+QP7TyIATAleSlAtj/3islTBZJc5Ht+CsJp0f6WetE/6zS/qk3dxNPUL
         /AhZIEaAx7HAhtlYWSLbts0aUGeGVuC2g3WxLRO4CjAbVEq0cskE3/UjPpn4mHk9HFct
         pRmN1zMgGomn0puz0fq/AiXHo7vCRYW35dqyJpKrVzkmCy+jkdTTnGuLOTurgl9OyPAF
         nZJA==
X-Forwarded-Encrypted: i=1; AJvYcCVFyN+y0nDKl5cLWYFPDlbEjq5jwA0UDVGF9WII2QCAH+vZQiCM2JS5FzAbY8OKNHmwb42lzcmY8Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze2mlFQdSNcBLKnbrFhs5wM9S7ebq0ECLf1Xs+Rk0fRiAjuTEA
	3f+9cecQNHmyuyECIHshwcHoOYqh+aNfq7SoQfC4f0S1zk6boorhEXFtcS7SlCCg6wA=
X-Gm-Gg: ASbGncuQ4H+MThrBJ8KYcNz3nsObdC9H0a3puAHcJX/g23XGxV7nUzPvafAHM1cpcY2
	k7m6zQ04XpVYSSsuVwAxm6auliMqkD3bst0bKxQv8W4i8W83vpKQewx9Pig6zq45ocWguKwiYLJ
	PsU1FHHhHpD6bDVRe8rvpUZv/9c9YYGiiba7YIKDLikYVz0qPixd/92fYyLyO6QNcWkvcuthVtK
	nQxPahaOwJMKVsFq4S1IdqOyCJ5+MOvcvn9OvuVfb6PKZ5+eyvS8hFvnsllkqwaS1V8MMcOuV1x
	mhsJwjgJaIo5wcbzZ+5PpZzb8OnXo3Jki25ryxkKxDboOsuLI+RWQ5WdpCi6Dpx14erBa4Oh1zJ
	IYIjQNPrJa3ftwdyJ242svaDd+K2IP8EIlx53XraL//fB6mkQXmSeU1ry6J9G6cAs/mTn+Md3Tj
	okcdyFSgJzVIIBxJS2nXMBNhG9bCbMoy0dFYiJylzgrCTG
X-Google-Smtp-Source: AGHT+IH/asOyZmrSjJB1fGklN/UX7jTsW05xFyFBgFM0b+yCyMW2A2fV+RgZjiNoXrR2/gP6b9/Mfg==
X-Received: by 2002:a05:600c:b52:b0:475:d91d:28fb with SMTP id 5b1f17b1804b1-477b9ea35fbmr23972645e9.4.1763654313706;
        Thu, 20 Nov 2025 07:58:33 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82e8ea6sm55552185e9.8.2025.11.20.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:58:33 -0800 (PST)
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
	Riccardo Mereu <r.mereu@arduino.cc>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/6] dt-bindings: arm: qcom: Add arduino imola, UnoQ codename
Date: Thu, 20 Nov 2025 16:58:23 +0100
Message-ID: <20251120155825.121483-5-r.mereu.kernel@arduino.cc>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
References: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Riccardo Mereu <r.mereu@arduino.cc>

Document Arduino imola, UnoQ codename.
Arduino UnoQ combines Qualcomm Dragonwing™ QRB2210 microprocessor
with STMicroelectronics STM32U585 microcontroller.

Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.52.0


