Return-Path: <linux-spi+bounces-8028-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1237BAB1226
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1763A226D
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6DC28FFE1;
	Fri,  9 May 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwwOJdTm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C728FAA7
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789702; cv=none; b=P4rT+5hDEImIGGqeTYbYMaVHlimkTi/pFArAksjgmJ8VhA6axjaiEvBnWfxNnk8Hylt1Jqj66lZvu54/kDJETm3ZQK9DnvnZtT9RtYBK3XKc0L4rdigMh/M2YZOX1Z3+x+rg8aiNTt6SAyjicI9OnMRPBIzPJUGhtHSG97KIfyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789702; c=relaxed/simple;
	bh=s66Afxw8a3xMB/SBhQiPMSJcaB2YeSJGVtDWMjyFv0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXfT4X1tFPV0ulJzVs0AdR5Kew/kFhFEKD6cSkF4dies8aHyZR38qjgEDkTPmfKzrAwupBjdMaTQVSoZAs+lYXwxr6nrwH9Y6pOsGz5koWKLasWrZZGdDhe9rZA8YDF4XEWNAq9OZG/Ed07zKiMI3FCdOMG+X5wtZRVZkejukA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NwwOJdTm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43e9ccaa1ebso571975e9.1
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746789698; x=1747394498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKYrxiUxy0npi+Mk4ryYuieCR3b8bkKwTBnIOJMWofc=;
        b=NwwOJdTmQxq/VG/dYTC6cSfE8YTviK5PrmwmJzCW1NZROf2OE48QjwMWKPgZWESYTZ
         2v94o0+zRGE0j8nAl5mDBsKSVq5Sz5EoMyXhU6UozDovNhyZLLK/gtm2kvkj5fMZRYGR
         nJLKKz0JNbkN22Zn5YBdsvAgJzi3AhX6fGrtCfOYUHjxjiSyU1r16zcoWW7FnNinGxrq
         ro+fW5Hr9Pa+UP6d2F9V+Vg7GmeJwXQ3LHTscGcEGWfT/QBRcfnzDFWZV0O8dgI9bsG4
         3aA/WZWOkUybS58A+huGulskl9Snz0fTx8qiMFeCG+U+noPqMoo85C/LXQ2ol5hGkkyB
         sjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746789698; x=1747394498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKYrxiUxy0npi+Mk4ryYuieCR3b8bkKwTBnIOJMWofc=;
        b=kYWch4usRqRaEinnch8VwUR2uDfX1wjh9kZSlKGtffXPzcjjvjrFVdeglkkp0hjYCA
         8MfihfyW9wFeD1YMwe9PYVLOMqUXPiWPGUYqmC/TND6WDQV/ZzF57x5W1YbtZB9OXK41
         acsYmSiP8U+7eJOTHJXwYAKjuDBqUuHqY7vZcLb+qjyu/A0Awf0MHwB3Tr5RQEj+TK5P
         MnLV34H99HR+h+zzPMqEL4/pRHcpm5jNfdZs7ql1VbEzHWFhTGWz43xOHbmKJ0wPS7CW
         zFeiQ9Kvl40552aAd8m+LZCbNd37m1BGuQm6HSUpcjaUOxR6gAVlm8+ul519w5/ounXC
         j1dw==
X-Forwarded-Encrypted: i=1; AJvYcCUc76MPP0pHg9kzUQUCzLZhFIT0n6NQS+qT9pXwVXtulclPpfnJ3jza2oYpZQohiwE2LUtnzBb31G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAeKFtROAUFA5eJYFZHDrtJGyGbenclSukfa0ApIXPgmCewnV
	FeM2osLHTePpZO5Qjlm1zzufGsWXBr1yxbcBEzk6K232bs/m5OP/AxGqSQKvR/w=
X-Gm-Gg: ASbGnctcg4dGqf9jkbLpopx0qpvR3ohm3J76tEfB0H4pF3MgeghOQv8EXwOuNtW42Fr
	iV7XOtcc752b3+wg3WPutTdjVta+43YT6z2+dt7MtRGv/yKRFNaJ2Odm07TpEHOmtXBwEDHUkZ5
	5rcsaNgkywVypPH64b8zxYUVeYk+nKqHuoZ3gSGMv0382fzT3s69e9LKVn4X48N/cMmEtV8XyUJ
	6NPU7JYjqr6WuFPetHLKom4D83yHw4LqBuaZhlh0UwP7EJn3HmGyLeWzmuBKSveHyJdVVKSimsS
	TfhKP0Q0T4r8QxmcexxKbtyNMsSe1EkJ1Tp0TWmWsM7HywWnpuI00K2iGCcu
X-Google-Smtp-Source: AGHT+IFlbI/ktfksQQOpGjeIwbwt/o9L6Xz+ipgRzNOoWeXM2S9UxEpNqGKoq6dMD0VJeqXmsLSN+g==
X-Received: by 2002:a05:600c:4451:b0:43b:c0fa:f9c4 with SMTP id 5b1f17b1804b1-442d6dc7d2dmr9532715e9.4.1746789698392;
        Fri, 09 May 2025 04:21:38 -0700 (PDT)
Received: from kuoka.. ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd328455sm69946945e9.2.2025.05.09.04.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:21:37 -0700 (PDT)
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
Subject: [PATCH 1/2] spi: dt-bindings: fsl,dspi: Fix example indentation
Date: Fri,  9 May 2025 13:21:31 +0200
Message-ID: <20250509112130.123462-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=s66Afxw8a3xMB/SBhQiPMSJcaB2YeSJGVtDWMjyFv0E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoHeU66+RBLo+l0lSwvGSnhzCY2cPM9tZGuIQ2p
 wsaUNeN9bOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaB3lOgAKCRDBN2bmhouD
 17OnD/wKNyvGnBHJUSNZxdQlvkRO2cr4Gton4WSAWbZ2wKtlwLfNMdH+g91UdqFkXbytN2611vW
 RcWUGYGRpoCMqelb2OjY+fLEfn5HIJi2Wpxaxyx8h8fzjCUKngY7dfgLJDqbaFa/hLkmkCcimnG
 g3sFRdTXd+scm6fQHI++SP+ovsyGOHo/zHC60TCcusbm8CL8lweGzKuzVt+jdkbd3KYoSWsBH7X
 paH2jYlUqunABAf3g0XH6ay4Ib2CnW2dO9fdfN18DuiOl972ClrhYBKBcYYnEyaW1xSOl0fhaDD
 dVgvsd2JoQd0OC9ccfzCTSX9kQFZbR0zE0lTP5IBahHEut7bhUbr5tvGdnxYQK0XQvSMUHIXhNZ
 X8wfIDUGWRuygCbj0BdrLv6+m0OKJBOJjhjJo38KGkOW3LpqwmAd+47ottvB9ofZQoHfmg7DBvA
 HtyZ7r8C2siQqDa+N0Z2XYWKyB/ugPh4pw22tAOfJG+kZ72V8RksiGAFEIwuqzGt8ddNm6DE9SI
 BeSDarp7Jaqomm5eoDAYnxgff9GlYokHuol19yq9RDrFM37tvykY1ArwU2VTFPXs6vyf6MXUO1l
 xaSpQNs56nhvSp/MYbpZ7JfQo5ml5GGRp7mktfDKpWKJazgMpdteFiS5DRQwZpXgnPhC3L+e5oX iiM4xKX/3xOH2bg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces, so
correct a mixture of different styles to keep consistent 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

No functional changes here, but saves some comments during reviews of
new patches built on existing code.
---
 .../devicetree/bindings/spi/fsl,dspi.yaml          | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
index 7ca8fceda717..bf9cce53c48d 100644
--- a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
@@ -105,12 +105,12 @@ examples:
         big-endian;
 
         flash@0 {
-                compatible = "jedec,spi-nor";
-                reg = <0>;
-                spi-max-frequency = <16000000>;
-                spi-cpol;
-                spi-cpha;
-                spi-cs-setup-delay-ns = <100>;
-                spi-cs-hold-delay-ns = <50>;
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+            spi-max-frequency = <16000000>;
+            spi-cpol;
+            spi-cpha;
+            spi-cs-setup-delay-ns = <100>;
+            spi-cs-hold-delay-ns = <50>;
         };
     };
-- 
2.45.2


