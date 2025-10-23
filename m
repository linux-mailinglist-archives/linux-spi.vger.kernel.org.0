Return-Path: <linux-spi+bounces-10788-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F107C02D09
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EF41A67A21
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4BA34B408;
	Thu, 23 Oct 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Q5vqRvnx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4334B404
	for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242369; cv=none; b=mhrVTWMM8mGVdNHZ3f/UuUITgW7CXw7L3Lf/LdGpBuy1br2qPSVUoaM3CXu/AKe6DN5AYzFc5QwSITwYjG1OA5YS5QQYPCoQqjkyYzlqIz3nBaEEN1TIxDjagY/0J5qb1PoAPSzBsBXIotWDAc2/tjQgNCfyICOH+5Fmm+vjG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242369; c=relaxed/simple;
	bh=49BNiaivaAVSLxOrAbQ3jcqUXbd5xtLUlvJhC8tkIpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eI1GMvPpks/ifaNp0y5Fg55NBwUDLeVjDwl0A6fkEHoH4mgukRZl/MJxjiE6jFQfBx2gu8Gq03kw2Zt71upZXOsX/4UA4SfjJw7U3xRqpAQYFSgyMYCnjnWKxaCcn2CeyNa2ltgp+0OkxTWI1VRzXwT64uCvr7LqulBsL9SvNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Q5vqRvnx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27c369f898fso17228315ad.3
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242368; x=1761847168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSMHyHNn/1vbJ7NUSylLHrrY4cYCxvOBtERxkVz+doQ=;
        b=Q5vqRvnxe78EEJ3Jn2Q5tadBFK/svJNie6NHVNHg8rd6aTxQ3H6mO4gQYglFD8aniS
         NkvhN7b35uCIKrmHPfB1DJBmd8adehDxG2LR9BFs6KfaaKv6h2UedqzI88QIqqlH7y80
         aLDTyVj5Q5P69axYdQ85yKcl88Ti3Qf3gXZi52zaCSn6OfSX6JOwTqbjvc2D++vbSC65
         JwHe/NWv8cL1yZKrGJF8QbkYYMDccJ67CPsrJYlLlQY4QAnw3ciKofRudL7X1CdCfqZm
         mfqrwPxzuFl16elx+QOltpt/4Y32S05QH+9vldJIGfoD+rzWyuzK5ODMdqQIu1Svp2NE
         rH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242368; x=1761847168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSMHyHNn/1vbJ7NUSylLHrrY4cYCxvOBtERxkVz+doQ=;
        b=LppZJrBD4Z6++v+/yMzq+Bc5H6wn+7S0Ngl5AUrrhE8q5GjwN3jH+S+asFJM/XgMnR
         KMO2iG6aTop5JPTDj8sk2PpVAm52BgQaCsV7VZMMbwnf9UgWX93Z2u4Iz5Yu7mRJ2bkZ
         is6v9RfsNHVCG3Q1MEz6fWDhsmMhDcrs0T+RgpwVfBnZER3p7A66NjwQ++4Whzb0hojU
         MZQX6VZnIEInYIMp79Vb0/IVPxA7URBnb/3Gsd1BjMD34FwiZ85pf4jor5LNm9LABM64
         f7EKqCdVPuelCGkrYHWNTIS9xIl+qY6D5uMxtAeUaeGZLDxn+DhpBFE7HSjaF1AalYWI
         bEFw==
X-Forwarded-Encrypted: i=1; AJvYcCUXE3szVXS+SGZIDBo6j8SlBQ11WoRmqKFRMJB9xsVg+8KhZqVfoRD0jV7hBdoOjANyI9LSkzj58zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2JzxzH4Mb2jTMe9oNIp5kmOWZYV53VUXmm0eJrHTquJgexC73
	TZ15iv40cdY4dLlhO29eQEmAE1MzNHcdd/5Jrnd8DXaYnBYQDhICzDdGm6heNNOb3bXGCr7WRhA
	aHhjFFdE=
X-Gm-Gg: ASbGncsdZlJCB7uvOqnAqlICJCF10us4OAWyL/sSQzekyecMAUM5MR2tid5qfbnv7rf
	NMhNo3TsBDOoPTBIlzYDphrlynZpk6EcOwBy96V/YGRcIsU/vv1h4S13GI0u2m7/8lthkQCluH5
	XTber1X1y3GSRVGBA/c7O8CSHxyUIDfSy1C/j7fzzpUZPNPpbdICrK3O17YalMnOGlxMnJR/TjJ
	S3Vo+4iBjipXMK9MtR2R1gKYuFREhfuGOH4csS7Pvv2xi75lPyRLDdmNX8bFmj7PP5Nw1Ozch1o
	5MO42HUOMubrswtgEXg7/pGWqakDp0DhA10KAPtvkYsJsjvF2trf8LkqDOUo3zB1UI8hLswhkFr
	JMc9TtCVg4GGx1tOKSr10fESCEAAhH9BOqJbd0i95c9YepHjOza2XQzMvzEYRvYA+RlZbKFnYMP
	XbDChi1Fp74O8AvikLstqaK+bynUnv/qwWsQ==
X-Google-Smtp-Source: AGHT+IG5ODtZ8NpgnPdL8N4UrnSSIWOWkDsOvPyVBDaaByRktns1SQuJqvUf+UP737qEBLe07B5fFg==
X-Received: by 2002:a17:903:440c:b0:264:8a8d:92dd with SMTP id d9443c01a7336-290c9cb8b95mr329120295ad.20.1761242367696;
        Thu, 23 Oct 2025 10:59:27 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:27 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] dt-bindings: spi: fsl-qspi: add optional resets
Date: Thu, 23 Oct 2025 12:59:14 -0500
Message-ID: <20251023175922.528868-3-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow two resets to be defined to support the SpacemiT K1 SoC QSPI IP.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - The "reset" property now only applies to spacemit,k1-qspi compatible

 .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index 5e6aff1bc2ed3..edd3158a6f2e8 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -55,6 +55,21 @@ properties:
       - const: qspi_en
       - const: qspi
 
+  resets:
+    items:
+      - description: SoC QSPI reset
+      - description: SoC QSPI bus reset
+
+if:
+  properties:
+    compatible:
+      not:
+        contains:
+          const: spacemit,k1-qspi
+then:
+  properties:
+    resets: false
+
 required:
   - compatible
   - reg
-- 
2.43.0


