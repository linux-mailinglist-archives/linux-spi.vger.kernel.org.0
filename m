Return-Path: <linux-spi+bounces-12127-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0274CDDA6D
	for <lists+linux-spi@lfdr.de>; Thu, 25 Dec 2025 11:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4502430036F3
	for <lists+linux-spi@lfdr.de>; Thu, 25 Dec 2025 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8702FC881;
	Thu, 25 Dec 2025 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZWoElh4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C1314B7D
	for <linux-spi@vger.kernel.org>; Thu, 25 Dec 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766658380; cv=none; b=CiMYA3xmLfaLkALWnD+YfgALZem3AcFC9m725Au94vkGLuHXv+AA4AllIXTD7A637yJXiTHJKVH62x6v5Rg81hlWteHigF6cueNvfWANQtSs1+jiR9WLtsFDdPQa0oLNpECm8ryduulhCEznn57xSjslUd+5y8xibTiJrU5cGdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766658380; c=relaxed/simple;
	bh=E5s5dAa0VTQdMXpF2lnAVWKinAqcZz1UaWRSxHODcwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmlxWfQsnwnAROZ3Rfss4ufPdNds52evqVGKZc+yAdEmEdwX4R1GvvVTNV6o+XfE6dDAc9wVphgZXFJoPuIhdG6dMvmoDyXbBRDmyxs7LjsJgd45MEZ0t+RvmtDf7VQglwBTansIPk8i5zGTChWKMFBq5Mrw9Qg5SnHqGHarkg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZWoElh4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b728a43e410so1206175666b.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Dec 2025 02:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766658375; x=1767263175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIaCuy0Yr5csM4hT0NvBc9MsbJrznZV2wGR+tUVj03k=;
        b=HZWoElh4UJ+ufUhtfwiNswtX2iLcH7BnPCkzs/s4OntDcqFfyfCqlHmrP8GIBz3sK2
         /UFgAf0oErVO+tjsPSYZTnaDCj4uZ07wktkGeHqxmFEy5FsBiBCYr6CXApnTUWlIqCdr
         Im3kImTlJ4u3nkjgNSvB0DHgD16QNkvJl50KlXluiEZsmXGeANzyrYXbw2rKKu+Y0Stu
         /0sEQpdfpgxKCcMjnRNawxN9lEYYjVWpCi9WwfnsS4gRydmNnTC1uWRmJwzFdSkNs73H
         aGJyzl9SqOd6Jow+e07bWKnaApO9Wf6xYtwxOlg3VIrwNmHFtib93lT2eM0ivxsEEhkt
         3wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766658375; x=1767263175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JIaCuy0Yr5csM4hT0NvBc9MsbJrznZV2wGR+tUVj03k=;
        b=ECtnL+26XOiV5AA/lPzZm7murSJVCtGMiURr6+3T59hWLhQ5Gtd2eWShS2tLfRrF+J
         CT69aQLjkfF1qI5YfOU5sWAj4lFfbBF0YKmBu7doHsRIcnuB9yW7HnoiZrpon9TxB5FC
         wsWbqK8iTby0lsoRPQT14wDrGtjWSD2IOzBS8sAKHzJtAipV9L9AndPUlq7tvl06h+zL
         /RnS15UjJPfmzbSD0e2jSPhNA+95b2KSr5YvoCnFb3sd7bQR04RG2XrKVBLNJhf5R01k
         gyCREgDJkRrRSje75zrJrO74bGY+wVsoelBQVIXjdMi6+L2aMadiDN9hs4YtieO9zB4Y
         /eEA==
X-Forwarded-Encrypted: i=1; AJvYcCU5eZVce90Bdnamzmc6HeEfZAX3FWyMxRkGChB5MnJxEJyLrrIn2l3FBtSANm5/BULoFrzwEdHr6XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMlKTslgsK6tFANaqYfo94w2hTgeYOnHQct3gmve4oD5D6Bd5x
	6sXQ/yZpYVoO+ra++S6ljxaz1HADJcvVFpnPztxSt8J3TxGsg+p/3QFn
X-Gm-Gg: AY/fxX6vWBzYdmmhJWx6ea6QCI002MH4IqKBxrUiewJnPHapvOkCo2dhnWBgICGjYi2
	D2r1q3ZbuCbHww7XcX+k8bnhisveAnnxIjOGUTPy8HFyJcFm8BBaEe9wpa6rcQLvG5CI4dDp+ef
	yPaOBfLmQive5UDLCTEpJRmnTCpbtZfWN6gRCqF4pQuwtqhDC+uEwU9PyNBOlcsN9IKBsvX8/OR
	liS6sLreb4Ks1wTMlZF693/qVd6yHwkyRaRb4qAQa/x4SRIG/doPn/rzvc5rFFqz4QDHitZkbh5
	4pUSywNweNdd6GTr7i2M5Ya8/0y8VP6ljn39QrlO7AbGhkrc9S6dB5zycL8DLgeMM26LkZ32Z05
	jQg7tuHgMmTist+dXNUQvdeoyxeMvrzzaoayu4JjX2FJVpAf4dPABnrrU16nLIRTsvJolCvguR3
	lNhAuIEBgUNwudw5KjfUzmwYkrG/PHggUICvh4xAUHpArSCGWe2lmf1o7PFz7iNZ/n2fU=
X-Google-Smtp-Source: AGHT+IGTq+3+tIFc9OrOssc41kCs1BnvDhuOWslkFodTOLZK9xgo+B67Du+bLzTqEF27zfk+DrePnA==
X-Received: by 2002:a17:907:6093:b0:b83:246c:c857 with SMTP id a640c23a62f3a-b83246ccc94mr173915466b.17.1766658375320;
        Thu, 25 Dec 2025 02:26:15 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8056ff4925sm1570885166b.31.2025.12.25.02.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 02:26:14 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Kamal Dasu <kamal.dasu@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: brcm,spi-bcm-qspi: allow hif_mspi as alternative for mspi
Date: Thu, 25 Dec 2025 11:25:30 +0100
Message-ID: <20251225102533.30772-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251225102533.30772-1-jonas.gorski@gmail.com>
References: <20251225102533.30772-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "hif_mspi" as an alternative reg-name for brcm,spi-bcm-qspi, as
it is in use by BCM7xxx (BMIPS) device trees.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
index 45975f40d943..ffe8d7f8dd4a 100644
--- a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
@@ -57,7 +57,7 @@ properties:
   reg-names:
     minItems: 1
     items:
-      - const: mspi
+      - enum: [ hif_mspi, mspi ]
       - const: bspi
       - enum: [ intr_regs, intr_status_reg, cs_reg ]
       - enum: [ intr_regs, intr_status_reg, cs_reg ]
-- 
2.43.0


