Return-Path: <linux-spi+bounces-3704-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6069491DEDA
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 14:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F329AB22DD6
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 12:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EE314373A;
	Mon,  1 Jul 2024 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSAQDXp+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58E60BBE;
	Mon,  1 Jul 2024 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836083; cv=none; b=DxFB9/G2EnMYbJ+ls+/h5g+JXnvHz2GGJAA9/m8M/m4im2/A26mHB/5M3nVf/A+LbGQLaUgs8LaiWgyX0dF/fTmU7Yq7mDoFTivQR2J/owuzPhm7gra1uZG5OPnJeqGjrwurW5n4D6tHzrv+xKEybxFhO6NiUR2ZdPIVRbgBRSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836083; c=relaxed/simple;
	bh=vVQEBAHhv92sP2fSGRtWvh7EDXEieYCE2SACw14V0Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAOvr3Ax9gnsIKD1WyRcTFJcEeiaHOIXe/0Vh8QJrxeqbtny2985wuZ7nLKMr2EmG4uiNMKVz4B6w8VuMQtqxiCh8g2hai822tcog5o/1Opl/2RKjcSHl2XE2BBW/raCSvScDi1EQKp3Ym3c9rGdMiBZe9SRLnqTf+dTpwuMoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSAQDXp+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7276dff62b6so2846808a12.1;
        Mon, 01 Jul 2024 05:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719836081; x=1720440881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2JlVyvdXaf8wO0NkeSTlMZDCp7W3gnVU01+vdeONI4=;
        b=SSAQDXp+xwzDzYVdvYFNt/kR7txxUL40/4mt2AYYaW5PmqLjtk1bFliMF3UlK003p8
         lFHuP68qjeKAveI1MlFW0EclYKXG7EAG2QnCUb1P8AbtQCO3+ktrjUS/ppR7IXh9uXrf
         xTa8nwTQUd4CrjGD98txUeL3xRc2f08OtR9FyuvFqrufVsw2PNQ4iEoPjY9BsyjBk0MV
         zbzIevEyEZSH2J9QQ1gfBT/Etmb/hYXetZrt4msZwX9b/43OU8t+i+PqUrSPe1ku8pIO
         ZZPII3AIZCBYv26NBxAoueL/2z0hTNZxJhIempfx2PFTrPxJFsceRGoEQNfbvkS6AZWl
         wcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836081; x=1720440881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2JlVyvdXaf8wO0NkeSTlMZDCp7W3gnVU01+vdeONI4=;
        b=dIJb1bPsL0eqDem1lTa0OdyB9eS/nHUhVN9oaE5R0Fw0Kyf6k2I7BhsIZvt3dnhiWZ
         VnqaKFJawg9GYtBhFZbw3IO/lkjLlBXCZVgdBWQIbbwUs6WFDxTQPtrDa5loKlf0ZJsu
         QsH3HeptewnT+wtv5qQooeaLFi2t9dzWG7/BC1e1gPnNvlATZlvHPvN+MMIc0R1aUCbE
         VC7LRqX9zQV/1tBP6jFSnwhs7FvhzdFpvKD7wpLRNZpWHCGCllPj3+zqe78zJCu/bkRG
         XzRtDHrfII6+VwlxxbHeUw+qsvkzOyREx5R6RUTJSe08vz1iMfJN4qP62ZdNJSi3gMhH
         y6kg==
X-Forwarded-Encrypted: i=1; AJvYcCX6gJW6LZ3PZTBpPzex9+wft8pnNwGDs7dhpwkTL9buwQJ3zNyHesm2tSjCJIMD356JVVKZqd2TIxR738VQAOmO27NOLCffh9AoIzRAHBD7vqcDnkmVOzobpmRn+HlU8rfBi8X+mc2e5w7F0DYU2FKukePwtrHAOmdnD4UY0JF9hei5tg==
X-Gm-Message-State: AOJu0YzBR2w1d9AsMlN4lAwBh9ObpvDHSyBtUTVfHvi7YQrSLFV7zdyW
	6nLDJMOm/yIMLovyVWLcxR6L1NAqRhw8r3/k5bmTQ9Zs7SBpTdXcubAYFyRs
X-Google-Smtp-Source: AGHT+IH5fZqGsM7fv4aL4Hf2OsbfmuWDVI3xrdjeGta3W/nTcuTAQXHLXW/5GIXbOraLNdXwplsgNQ==
X-Received: by 2002:a17:90a:c090:b0:2c6:f5bf:5175 with SMTP id 98e67ed59e1d1-2c93d1b99b3mr8969180a91.10.1719836081239;
        Mon, 01 Jul 2024 05:14:41 -0700 (PDT)
Received: from ga401ii.. ([223.178.83.109])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17a77sm6613098a91.6.2024.07.01.05.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:14:40 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: spi: snps,dw-apb-ssi.yaml: update compatible property
Date: Mon,  1 Jul 2024 17:43:52 +0530
Message-ID: <20240701121355.262259-3-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701121355.262259-2-kanakshilledar@gmail.com>
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

updated compatible property to include "thead,th1520-spi" for the
TH1520 SoC SPI Controller.

Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
Changes in v2:
- Separated from a single patch file
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index fde3776a558b..bccd00a1ddd0 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -88,6 +88,10 @@ properties:
               - renesas,r9a06g032-spi # RZ/N1D
               - renesas,r9a06g033-spi # RZ/N1S
           - const: renesas,rzn1-spi   # RZ/N1
+      - description: T-HEAD TH1520 SoC SPI Controller
+        items:
+          - const: thead,th1520-spi
+          - const: snps,dw-apb-ssi
 
   reg:
     minItems: 1
-- 
2.45.2


