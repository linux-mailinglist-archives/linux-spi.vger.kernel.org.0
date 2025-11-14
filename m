Return-Path: <linux-spi+bounces-11208-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2EC5D164
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 13:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A259734DE5E
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 12:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C7F31B82E;
	Fri, 14 Nov 2025 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="I933hu1d"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC917C21B
	for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122754; cv=none; b=D8jAgH35+P/MDDlqX3c5sre/4a/2XBBYXOUqfjSKMyAhVLuN5zh8bGVw5VmaxpUTe8tOxuql2Oy32nb5ProPl4nZNjN6sJxw0Uph08xipZHsDxUx9XuBCa22P8e4D4zbcYuYk1FQ3ZbabcrfNBLC8UlXjL19iQHrk3d04dL3VMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122754; c=relaxed/simple;
	bh=C/tgHBEMS7lC54F1l05FDdUUbx+i2inD9Tlr30ZzFM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBNzSxLy7VMLhatDIyepCevNZRisSZaRu7nK5yPpil95ax7GRC/FU5QWflVtX25WI9dGkw8EQBJ5GXOFenEDqoXNnzjVDAKz/ULSNSFOvzk5oWIoMAtGnb4xlVNS+UJ76Jzkiw/F/tGS6ZBEmQXRS8wtatly38IczddzNmZrtOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=I933hu1d; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b73161849e1so322246366b.2
        for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 04:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1763122750; x=1763727550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u90NAsdBNasBuoFf1cybakUudwJYTlK8TE/NRm955hs=;
        b=I933hu1dNu1pyIZy/RwkNPSps7v6epasv+it/29ZixigwcZAx+zxbbmfic6xQrJh/D
         0gJ3B/6wNYvKWzEEGhbYN1DEs/aZM563f1nuearQxLsE06VrRCiIo1k8YHG9ijarYOkc
         7waHNXWGXIgNAV9ByJxICSh6Hm2ZCz8zM9LwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122750; x=1763727550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u90NAsdBNasBuoFf1cybakUudwJYTlK8TE/NRm955hs=;
        b=RxUEQJ008XAMBKRoYwN9MOZdEaOBUR6eh2uZxillW7JM8lAlAmX186KQ27KoQfRicV
         rN7gpqewIsU/9dsg6War6ZmOkvER2LyGUPvla5dSourLehkGUrPh6tUJL9iAC1UDxKrc
         5v21bWNItPGV96CMxuEJO1bn6iaqCh1kkXRAWurwi+9iMcOrHyhfMKG/5adLn/nEYBym
         hFosIYcThhjNg+MHcTtG71EWpXruuB6oP1yIkItLLb8saO98/9dvdeklqyZbVFvsly2M
         gYqfckp7BZ+tEsmrJec0WOAY2iUW6B50cRozGxEly5c66g0XHFk2tLRP8+VXp24Z28XV
         hvUg==
X-Forwarded-Encrypted: i=1; AJvYcCUk8SJRT0UDIKB/04MgnNEchYp/lCrPEztXyZhWbUB5IsPRcWK9XcpIRDW16CDDlTxFQ1wEDiBNK88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPX7iaC7hGclE4BAjFRNotRQ8TXJkhLisgfk1Bj8TUaoPHgvff
	1maGCCBRv9WcnvH/hjY+8obvrAkcKZEkkzBKn+17F+p7Wgy731P2rhZ1b4rP0Ky3cd8=
X-Gm-Gg: ASbGncvkSqRFiw+ZEZrQVaO4KLmr2lTmsAENyCQck6SPD0YdzwuWHDZyde2CgzyBRpu
	q6YgKfdw7+hH7lN1UXb1gaklWLvyBE2YqsCE4iYcSOwQ4I0Cmj9cbCOCTKSq1Zue007NAUhj5Ku
	JR63KxKBVu18aXoPEDZN/Xa4F3NhLoNvGFT4OzLAg5G0kxky5tgjZn63D5POkM5Ul2uMOm6H5tC
	EuADbQrrr+vM7GnrCT4r8Z4rlYsrii7Ch4c1I56jjlFt4zVz93/QGNrnyLGzPk6sVcAj0joLUcb
	zmBYbA9DEFrC5oLPQYhBNUh7r/fZWEtLaG0KWMfiED67PAbc3C+IXmb0I2cpWj8qrSzmeCHzuak
	leB6yQeLVl4YtUwZyrJNX2p9Z1lBOkz2reuSq7WKjEoQ5azEc3Nc+Xi4fEst130/pT24Ay7PYq1
	jSPfT8kntHif2uePsAQNYT7zoo9KhlCTuK5pg6hVcfRgmW8pRmiS/m8t4D7Q6gDaFOdRc4o2nNu
	AE8KRVN
X-Google-Smtp-Source: AGHT+IGsHmnSIhpWtHLoB35t9TtSGdohvRhU+DpPgTHUuRWxKlnSUCRa6zD2ZLZYgRuc/phSInmncA==
X-Received: by 2002:a17:907:7f09:b0:b73:64e4:2046 with SMTP id a640c23a62f3a-b73678f4734mr288988966b.33.1763122750026;
        Fri, 14 Nov 2025 04:19:10 -0800 (PST)
Received: from riccardo-work.fritz.box (host-82-52-164-74.retail.telecomitalia.it. [82.52.164.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fed6315sm375295666b.64.2025.11.14.04.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:19:09 -0800 (PST)
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
Subject: [PATCH v2 4/6] dt-bindings: arm: qcom: Add arduino imola, UnoQ codename
Date: Fri, 14 Nov 2025 13:18:51 +0100
Message-ID: <20251114121853.16472-5-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114121853.16472-1-r.mereu@arduino.cc>
References: <20251114121853.16472-1-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document Arduino imola, UnoQ codename.
Arduino UnoQ combines Qualcomm Dragonwing™ QRB2210 microprocessor
with STMicroelectronics STM32U585 microcontroller.

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


