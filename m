Return-Path: <linux-spi+bounces-3234-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B078FC810
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 11:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF58E283B08
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F21418FDBD;
	Wed,  5 Jun 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0HzS5iW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677B1946C6
	for <linux-spi@vger.kernel.org>; Wed,  5 Jun 2024 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580270; cv=none; b=S8qL5WkMhjdCCgna4pJeJROZBLc/0xUFk8ALtMf3UcH7NxVMRn2R0f5iAJumPHdAKqyINjCLNkr28H/i5jqU2xkzhHpx2JfWVAlOQDa0oR+PtDFtPjUiqnCYNC53oCYz5waWlGew4wxH7SRIgFE/sfcMqTBAQNRhFcvK5toIlkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580270; c=relaxed/simple;
	bh=TB3JA6ZvEyeS8046HuU7GYKNLrMTuZv4b+KVhLZq218=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lJRMOsCRO+Gz18z8qyKW+YRPqUoRfz82zYPZTM4C8otc6o2atFgOMM3owU6Wq1pSKsKYCeMvuPM3pRy7XavYjld6hux6YiXuk4+fkung5M+VhkqVNaa2oW5v3OdziqRYC2UX4oAM722cEDiLCpr4bOJ3YYLxGr6tf3SBy+8QexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z0HzS5iW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42139c66027so19153375e9.3
        for <linux-spi@vger.kernel.org>; Wed, 05 Jun 2024 02:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717580267; x=1718185067; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9UDuIwQTR/S1924+XzE4bGO35VI/onCdeMFV83CfnZ8=;
        b=Z0HzS5iWTtr4CVan+dnzQVemEq4Ev6Sw/5GGQGVvhIFcBTuXWA6yrI0ynKxJ5Xz6pf
         D1foAn4fimnmLSB7e6yyBnkDZmVioR0UfYaHPgMkoCVSUHq+SBQUYLaCvPPcZcEgzm7f
         KPtNmmA1jszxQD/aiMIn9yPPhEsioYe4TcL8hVHrb+G4h0Bo/RtMpKg54bFJWoYwG4yn
         KtEONlX2flnVYddsrop0R9CCWFYX68gUuZXR5jyZNKRP9BJRqdOwEjXJQixh4yWzl2cT
         ZXW8mdtc8jmtJuhMurz7Tes/2qo/TYx5B9aEr9TTaaBCEqWbLc+oaRlg1vCffgN7o6OW
         eVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717580267; x=1718185067;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UDuIwQTR/S1924+XzE4bGO35VI/onCdeMFV83CfnZ8=;
        b=a0qVQP7s1G6fKMyM8RXiOuA+reR0PjkYgIqZS6CNXAU3Ni0h8vxtW+JC6qcnQGGS3U
         lQ6+A5iLRa7TC+1vkTGsaNmWFDK/O1pmwpPjaadYm2084jz4ujcyH0vQ3CCOJLXox6MM
         +YlmQvb9GojpzaXg1bEDKP3RAMQKVbk6XFCLCSsA4ti83L/JMruh6TEjFiE0uyfNRm7u
         wyGszhPtkcEu+IgXdeR6jXBSqVO7MQnfsgIJECuLwWnRHFLlh2KIkHVqcFOzOdHSgekI
         vgD3ISKyaj+00TiFEenrZUZ6+B+dAIFaMbdNlMSUMcKsSu8trpgrrIsQ6sl6p76CLzEI
         vuYw==
X-Gm-Message-State: AOJu0YwSXF4jM6RTtsRbTIukKeOmxYZkPvowmNnE2v2ukrcRCSHzHaZ8
	vrscASk81I4K9P2aaizMQXYxzbNtVFzvPfRqyV8yN7Q+YZor012icIrOsGsgea8=
X-Google-Smtp-Source: AGHT+IGZWjxExEKirLkZF9fJHoxk/GrGMLcD6n+LyacYfcqrKzOmN3aSA3Fd9wjOsvob4rhR62Aq2Q==
X-Received: by 2002:a05:600c:5492:b0:418:fe93:22d0 with SMTP id 5b1f17b1804b1-421562cf4dcmr16780935e9.11.1717580266816;
        Wed, 05 Jun 2024 02:37:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421581016ebsm14499765e9.1.2024.06.05.02.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:37:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 05 Jun 2024 11:37:45 +0200
Subject: [PATCH] dt-bindings: spi: amlogic,a1-spifc: add missing
 power-domains
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-spifc-v1-1-380f29ba4a16@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOgxYGYC/x2MywrCMBAAf6Xs2YU0Nh78FfGwJpu4YB5kWxVK/
 93gaRgYZgflLqxwnXbo/BaVWobMpwn8k0pilDAcrLGLuRiHa23ikfKrpsGt6dqZMj6kBClJMcq
 XFVv9cMdQM0lR1CbRo50XchRNPBsH4986/+Oxv92P4wf+rnYwiwAAAA==
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=948;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=TB3JA6ZvEyeS8046HuU7GYKNLrMTuZv4b+KVhLZq218=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYDHpIgwhti1Z4aLeLnfruuUzZpiOjch2nvQUsnQu
 M5Nli3+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmAx6QAKCRB33NvayMhJ0dQFD/
 9qeC/RVvztNtInVJg8ctwjzQkc1eF0iMF7o0mCBvlZDbT3Y9NY6K2DT726lFQMHO90wkuYTK6hxCKa
 1e/zM04hNrrYN4av0C1Kri4e0AddadOadIZzVL/6Fw5DnLabN4c53n/ueYwQN898XsiWaalE21z4ai
 rMuSjvaqSgeer1uxGGuF1UYJS1SiK+fn87mjWJH0Lkff9AwVFR34ATkUngjGB38HHb7UlwZ/szkLsz
 uyrl6HBkFw5ZOIVYZA+EeSz5iTuGSO0s0Xw2xDqlgRpgkC+AbJ9fS53jGRZehRNkAmMSf7+Wt/mieR
 0RLhtonNpf0JOUh/wjY0QHTs6WL6/sDFw7J8gPECsj7/uAnywiWGtn7NTrJKTaDJdpSjoXUZlOU0wS
 RdYb9IbXKNHu3KkjQ1Roh1eOcdgrnSVl8oKFwHWtWFfzYjBSo8uGvLpP+28QFvhAy1r3XT/kyPOWQ4
 dlacdzFFppy4c1qKEibvlZFvHFzDyW5+phhRY0O1hk36yxCgPMOcOSPTL1uvY+RdA7t5mcyzkGmk1v
 Pq4T0ocqpbJWEWK9YvZJ+VMA6H6IRI0H25GT3tpY39ZftUPmn6SBlhbIrEjdxlES1VrPMQNQVsqvNo
 Gjax8smxfLWYdoB79cMew43rv2QhsVLkeeQ/AFQlLJ+w15RL67r6hwyMyl8Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

On the Amlogic A1, the SPI FC controller can require a power-domain to
operate, add it as optional.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml
index ea47d30eef43..043879b434ac 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml
@@ -23,6 +23,9 @@ properties:
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg

---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240605-topic-amlogic-upstream-bindings-fixes-power-domains-spifc-214a5af0f305

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


