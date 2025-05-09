Return-Path: <linux-spi+bounces-8029-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E408AB121D
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49673B21855
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA13228FFF0;
	Fri,  9 May 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pIDfMFGg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C077128FFDF
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789703; cv=none; b=oMUdpG4Mn1PPoRHzNF7aAUrqTznzQ++w2UrJ/ihZ3iF5YxOJMawAd6VU/e0dlIGqjfaO3GQyXI3wHMU1oAflUX+ulLlRTF5maKu+H+iCTOi3RlV9ppsDCYVTSESEbgUVqOPSC+NBnKjZd1+OafXAIasXlLc6Iq4BPN/qzZ2NblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789703; c=relaxed/simple;
	bh=0BuO/miu0FNdGeIwKI4Igcv8UGoaQFfIol3GnMmPqqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekPPzkf76Jz0VM1hYakjyeKWm1MjJG8BJ4THg8D0sm9VfDmobte4cvOoIf7p1XekMj2nC9fxSULSAHSEmcJYq0mkM97wkGCpNp4Q8tlxq+j69vqc75yY0XSDl5sETsyfXfFZhCm2Wj+eo+EPU7b9BqHjn3aGj3x0Z74C9c9r9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pIDfMFGg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d4ff56136so1880555e9.3
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746789700; x=1747394500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zvaxLdQ0qhtC7Jg6xocbXcJy/vEo+u7LRWPS1JM5/o=;
        b=pIDfMFGgO0Hrlt8MMl0kZ9RISa2qcjnwC3tO8RCk6eDiBXdZUcw+0Ar+QyClfzjjZy
         q7rcmL7awLcC34ICwfPrZeq/wiwJaHqDPX6H/ajLjV466tOFN9TNhpAiOdW3yCwMdSr2
         rOh36bgF1jWPEXBP+kcLn+mrYhM/1fGrb9R+UQBfyssoShzTwB9LV2LMet077oelBZnP
         M7ievaT+a/NedGigYAbg8JbMIz2iNJvbcTjP7MJTQ6dWQ4zHRxOecc6PvWo1/s30197N
         rIQY7W3sO/zbL6+WbkWpVsr3TBrPlskz6WJWPSNjiMYQ/bum8QWKus1rFmZlGJcagngz
         Av8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746789700; x=1747394500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zvaxLdQ0qhtC7Jg6xocbXcJy/vEo+u7LRWPS1JM5/o=;
        b=Oi2S6oB3LqSWagxogIj9Y3ANqu6EHfyvbwF0/7N25Y91G4ia3GcnzpBh/TqbVb3rYd
         H3kZdhtT2KEMUCfzVx0Y093eoMIuSYQs+nryJvL+xiq0kulxZGsL2vzcYXr6K+UFGkhc
         TZog3wSeFpxIakLK3uv2xXyhizYhxLkcHAq+IolmSWQyVVhAhTgeQAm6kQ+bgH+fYyeZ
         QCINoDoZbhUkbpdkdWKzL+3cQV976jqRYpjOtXiVPk9e0nGQXKBbZr+W7pSsw0eOHoXe
         UUT0on5dQMFEqafRJ3waJfjn3AjGpbD77d4ByZHiedodXpdKCo+9JHCtDBY28XS5qQQd
         5jQw==
X-Forwarded-Encrypted: i=1; AJvYcCV+MMy7h32U85GzcG5EFK91PJfx0CaczqAmPbLe7DnLJ4a2IphOuBjLMXNXMC2XjM3Y75tStJ7whHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKR1sEQA7pYZoUC7t1jn/X5euVq0uBPggfJH9hWKlU0ra1Bewk
	J+2/Y49qxHSQlK5p2uMJ8r+SNclEP/AaYrQpfjFcxoj6dYUPZClyYg6Oqj0qDnY=
X-Gm-Gg: ASbGncsyoaEd+No9LCp0lWPOdgrS5Rs2S9qbiLlytV5TQAHQ/w0vxkB9zF9MWLUqVtE
	mYyrMiJQnUz9ssiTbc55Uhlj/J/94ZAcQCCCBiGt7/oYe/hBz52NrNRw6NGXVmyVFecfKGup6Lk
	HqF0lvpzjZnXKU0SeQWmXbGdBvHvq0e47wp3z3FbMvxFvPyIZG0KuZ6KvYYIJxfFccK5QYEpY8A
	cBZZ5SFesrdQqtqpkLxhPAcT4AiG0/nVtLhZFsoM8ufhixKUzMfGbk+TiJ/EsB0DpywrTm/+Jum
	Coi6T4v+lZ/QVM7YiUKUotQuaHxvR/1364ZQEpC+cnmSHi/lWA==
X-Google-Smtp-Source: AGHT+IEuDuBg93OxIQQoW+nylcXuRFPBeBathaUSkxBNEQ4jD3mR42Jzx1DI1Z0ON8bFZOIloNRtJQ==
X-Received: by 2002:a05:600c:1382:b0:439:a30f:2e49 with SMTP id 5b1f17b1804b1-442d6dd5413mr8885805e9.5.1746789699803;
        Fri, 09 May 2025 04:21:39 -0700 (PDT)
Received: from kuoka.. ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd328455sm69946945e9.2.2025.05.09.04.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:21:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Frank Li <Frank.Li@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Drop unrelated nodes from DTS example
Date: Fri,  9 May 2025 13:21:32 +0200
Message-ID: <20250509112130.123462-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250509112130.123462-3-krzysztof.kozlowski@linaro.org>
References: <20250509112130.123462-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=0BuO/miu0FNdGeIwKI4Igcv8UGoaQFfIol3GnMmPqqQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoHeU9Raekbf2tG03zWC6ko3skitxMRci9RwRJu
 8slhDM2iNaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaB3lPQAKCRDBN2bmhouD
 14v3D/9iuwKe4zn277rUfVsmgt/II8fADdf1u/LFF8b+e1VT3f1aiSpH7QsV6sp6QMDJZT/Sjan
 EA5EpUVZRySb6x1OoQPqh9geb8YTnuzu+1mWMxtmBwBzSqNa/ip2dEhYZIkq+zUlobn5dkMP6/N
 z0P5+VQc/vFc6uFcTHXE4h3Ngj/l7NEMSlEJzaV5zdlAJh6LqF1L7x04TAc9S7KqAEwToyaJENd
 LX0+FVaiwpPNKbElXgizKP16egYtBw+RTrZjsUxgOfIccAbaCPDSWQbw5Dd2tsfLhlD56fuQ//U
 bkTV252AgvsA0CBs5BFD1CN7zHWsKzQF6SYkq+LlHWC8dTO8IViLSn09zJnknFgQCsUiYh8y5jE
 xav332eHokzZ/JmqqM1BjdCrVPnlsxrvgaHLhJLu8h3bW4bucGZCs3LNUC+U2deDOeYbrAXE6D6
 5jqPWdMYxx5FLKVIJkMSJyDtTPV0YiXrqDmFsPJKYUNJAnIZFKGpN0Wpk6VYWZ9rDtepU0781rB
 oO3zGPlWD4Snadvawz9PIqeEAueNplqWUjDezYjF3SvujhiPpmZpXkQ+Q1jV4stqNtnVPNXh3HW
 nSGGYwfk/aaVVWfKANaOQqz0C69xQIXbDORTrC1Ts5aDxeQa4LgzFEkrxuJ4aZyTW7vw1Crk4AP WWtlsOiCaLqiCxg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Binding example should not contain other nodes, including other
providers like syscon, because this is redundant and only adds
unnecessary bloat.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml         | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
index 4e0d391e1d69..c97bf48b56b4 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
+++ b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
@@ -59,8 +59,3 @@ examples:
         reg = <0>;
       };
     };
-
-    shm: syscon@c8001000 {
-      compatible = "nuvoton,wpcm450-shm", "syscon";
-      reg = <0xc8001000 0x1000>;
-    };
-- 
2.45.2


