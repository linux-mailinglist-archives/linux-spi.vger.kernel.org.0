Return-Path: <linux-spi+bounces-7218-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00803A688BA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 10:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A341189B260
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151D62505C3;
	Wed, 19 Mar 2025 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GPuYt+yx"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81C20C46A;
	Wed, 19 Mar 2025 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377618; cv=none; b=B3mRwrRvCK/nnPIHW/Q6PLQyI0YJ+1/ypKYoB8t7qBYDGvbgpCt99tbPULA76fHtAbIJvn294QOHt491ALcdZo79ny/h5ZLD/MgerEN7n2Q1yIDLt4fZs6eHR6g1K6t3nO0C6+W5q1aOGJnuf9alM1ZxDmT+PHYdtCb94+BWJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377618; c=relaxed/simple;
	bh=9ebwuk88cbMzqm7Ixyid1aTO3Lh4ISnAsGbjbZFF0Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=At7WYr9ANvB1ISmKynxP7X16YH0QuTzRLWCjElCQjgJCoDswAErfxFzrZOmLmZtMeFImUfPs5Eg5Hk3efX5+fT+azcBiXfThBj+QJOW5Wjgaw3stLOCMbJYo36eYO28AFEL2qWkcLyhqaNPAJ0xPT5CzWhlPc/UE/LOlimxBeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GPuYt+yx; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8AC54341E;
	Wed, 19 Mar 2025 09:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742377614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HD/ttrhBkOeCWKNJN7qmCfOGIcFc49e8XnOMUezmGaY=;
	b=GPuYt+yxN+SuKya+8gYh6O1dQvrpzWSjHiTqhAgAiyA/ezBAOt2Ve+K2eRxGKJ89b1W1Jw
	mIaWGM8Xjx3kotUG9Fr1nyyV4sJ5u7EhMs7WKLzwwLiQciSgDuwYVBaVPn8Kyvm8YBDRFX
	J5Nn9U/XbHaubgwzFs7L9V4FZF5Z8r10UL/mJ6EMLNconrmSY7Zv+WBSs2MowynnIMkg6n
	JQSz8oBvij1/4LqgB1HSKDNcmvmiqT7ikiTRn3rYdh20A+eyKqXOgwhOhJqMMzyJ0+Ovby
	U1CWC2EM3PRnEDpIC+RwR73Hq40BsiLeFDy5oQXkxwy2NDQ0AsmlMsTf9XbzgA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 3/3] spi: dt-bindings: cdns,qspi-nor: Require some peripheral properties
Date: Wed, 19 Mar 2025 10:46:51 +0100
Message-ID: <20250319094651.1290509-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319094651.1290509-1-miquel.raynal@bootlin.com>
References: <20250319094651.1290509-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueffgeevteevkeegkeehleetteffhffffefgleeuleevjedtgeelgeeutdekgeelnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidrrddpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvs
 ehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepvhgrihhshhhnrghvrdgrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

There are 5 mandatory peripheral properties. They are described in a
separate binding but not explicitly required. Make sure they are
correctly marked required and update the example to reflect this.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index c6705ad846dd..53a52fb8b819 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -146,6 +146,18 @@ properties:
     items:
       enum: [ qspi, qspi-ocp, rstc_ref ]
 
+patternProperties:
+  "^flash@[0-9a-f]+$":
+    type: object
+    $ref: cdns,qspi-nor-peripheral-props.yaml
+    additionalProperties: true
+    required:
+      - cdns,read-delay
+      - cdns,tshsl-ns
+      - cdns,tsd2d-ns
+      - cdns,tchsh-ns
+      - cdns,tslch-ns
+
 required:
   - compatible
   - reg
@@ -177,5 +189,10 @@ examples:
         flash@0 {
             compatible = "jedec,spi-nor";
             reg = <0x0>;
+            cdns,read-delay = <4>;
+            cdns,tshsl-ns = <60>;
+            cdns,tsd2d-ns = <60>;
+            cdns,tchsh-ns = <60>;
+            cdns,tslch-ns = <60>;
         };
     };
-- 
2.48.1


