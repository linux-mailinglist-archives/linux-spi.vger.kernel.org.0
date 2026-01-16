Return-Path: <linux-spi+bounces-12459-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 030CDD38A4D
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 00:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDBD930D0221
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 23:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB812D94A7;
	Fri, 16 Jan 2026 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="DYY0LWx1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B623B61E
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606562; cv=none; b=ioJE1PsfJiYWbd70rw0Lx+gxAzaNgFPYuZb4lmZzJnoUKFgfAE99sgmNpO4S+TPx2UiACn0n571lgbEaWNR/8rScHpBVhEB1Xi5QV2v8R5lGK84f+gOgW+cqwlVokJvr1BzKJ4hqklyb+P3dTOJdmOjkTEWClb3eMoxYTiGSbYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606562; c=relaxed/simple;
	bh=nZVZymdSldXHNIcZf+CY+yQTlN8hH1CJ+2nzbAKnPuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3jDH4YSDwAJwyOJR8yd97E6TYGTIBAYZy4omXIlsW3X/trQoqvAA3qhl0n8NfSALpkKORbxEqUWUYKaDc7Qj5oTwuiHtZ6YWwLJr/NmiIh9e0hrWIwKFgg9Tq4BplLLrfxazrHrZ9a/93ci5gBzFoeRoU9qQS0lHrKCzoS7MDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=DYY0LWx1; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b6a93d15ddso2225716eec.1
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768606558; x=1769211358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrErDogymc+1QBf5WlgcxlP49fo756YQqZ8IekTnlxI=;
        b=DYY0LWx19RJU3Vx6sxhKDri1StQxLbkHWvaGD1/AzogX4wnBrAcELkqn7R4TF1E4MZ
         C1Ue+gFAvtpOZfmt+kgYwfXX8S+UAwp1ArmtLgzPsbSlt/SOfvwm/IKb8ggSA7ZA6mdj
         Wcp15+ojs/z3Ba7JFmnRWUCgsMVn1kXawvrxgrqsVoAldWnJXL2lWMZGQXZBjBQX6w45
         Zic0nfqzuFQdDgBTmiYUMT/sINo6bJ9WUnOZ2cTBuYSQgsxumwozRaIFurk/UKpbcZfp
         cvVQvYqGp0PG/IEE7/wJh/Rd4B3vcYOAgXn2p2+niwH7CUi+a6Ze1JTiGrBNOPKxPMIZ
         zeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606558; x=1769211358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrErDogymc+1QBf5WlgcxlP49fo756YQqZ8IekTnlxI=;
        b=HyNNWdpdQ5AEog8wwRBpB9oPV0p6SstkQT447RVN25KJJJ4iUxH/fODqKnMxPFu2KK
         qGwva+N09Paz5dJB/HcrRE3mfy3cYfaUrc9x4KaDcOx2XJi+AS0SOQ5VMrgUyUJhJ3tK
         mqqKV7tbHsZC5nPPKpPa6S2iBlKDIDND6GJr1ZNbiz6+yKetJcpWQ+QUthAZ+GuRWx/3
         GJi4dFtDaD1IBvAtWJjPVG2gYsMehNL+0zvwNwB9SnvbR0TR7Fh52NKeQtDFB2sR4sn/
         Np5Nh+t2McXE1prwR4ZtYWHWYUE0WouGvWWvt8nnKwrVhQhU1XLpTpQNVZVWS7Cm6QCB
         VF7g==
X-Gm-Message-State: AOJu0YxC2BGs52n55mvYZRYG9BA8THR+gU4V2iX+gdjk6SiDt3+X8nDZ
	peRrWU4sr2tmoyoDB4A0ObvFgdUlynSzJia41eF32Tu/Q3iQmC9D2LDkTL9G9Ac+OGE=
X-Gm-Gg: AY/fxX5qWdk2gEsbscjDZnItBKVb+RTXtdnwrk3OlYGUgAlQp+smEOAI53nWecbkPFz
	kIE1x8rBe7fO5QMWExk+nTJQ2zvVm3uNtzBYxepDiriZyrVHt62X3y4BiLHN8u5Fj7VZIlV/0uD
	l/TEbbxkSxk/No2SUmazKQIAe8g2rLKwDWW1tOQH7QyWDnl/oRyqS3YHW6+k76mEFoFWZoVtDMr
	XfclKktk8Rzsiwl7HlXEMW08CvfIzZymyPDo6aWVam9fLOUI6X0I2f/ZUtyL7R75dlMEnkonf2w
	MZ4ae2ysu6KzZk7fzjVLeny2RBNurmJUcvN/oYdb/LAj/Ec7X0sCzA/M0BIwVfsPpzTZmvXMA+Y
	hIiCZKAzBhCJYIX/b1aCIdm64IfaLIB6p/oWlTcAUSLpZi7wwPpJa0w2HOj/Q5mzInx1VKeAZD6
	snCzKwLNz5U0A=
X-Received: by 2002:a05:7300:5712:b0:2ac:1506:c781 with SMTP id 5a478bee46e88-2b6b3ef90a8mr2941587eec.10.1768606557892;
        Fri, 16 Jan 2026 15:35:57 -0800 (PST)
Received: from localhost ([50.145.100.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6beeb4b9csm3269419eec.30.2026.01.16.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:35:57 -0800 (PST)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH 3/3] spi: dt-bindings: xilinx: make interrupts optional
Date: Fri, 16 Jan 2026 23:35:35 +0000
Message-ID: <20260116233535.260114-3-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116233535.260114-1-abdurrahman@nexthop.ai>
References: <20260116233535.260114-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes the driver work on platforms where interrupts are either not
provided or broken.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 Documentation/devicetree/bindings/spi/spi-xilinx.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
index 4beb3af0416d..8296edde61b0 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
@@ -23,7 +23,7 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    maxItems: 1 # optional
 
   xlnx,num-ss-bits:
     description: Number of chip selects used.
@@ -38,7 +38,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 unevaluatedProperties: false
 
-- 
2.52.0


