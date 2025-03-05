Return-Path: <linux-spi+bounces-7042-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5789A50C21
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 21:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF8067A8F4C
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7CE255222;
	Wed,  5 Mar 2025 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pP4/uXFX"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0619D06A;
	Wed,  5 Mar 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204916; cv=none; b=HiMQHy9pAvI6gNHYcDOBuCaGnPHHn5m0c+JevBZssOY71D1p81xKsf/KTxDYVtPqVdXTpxsl4jkn4vfw1HvU6GTE1HppDEFLQyLfGFUpqaf8jDvqiJvIw5a9u+anAlUt3Rpwz24AQwDMV0PuOG6KtqsBM7BdTwPgw560wn68BrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204916; c=relaxed/simple;
	bh=6Ir8q1SPIieyKF1q4q1Q0j76nQWax1Eujczf3C8RYI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgHs9bwAa26/yD3XUelmNM7EmFWQJCaThFdOAbNtLzGfd6vRuqH2FlQbO5OIThQyScWeGMbJ47q3qlYqiIlRVLvMnHhA3RgetEZDSRRIVwkfRW/nifbktbxe0biREX2v6tPbpuokxljASBKQ326mecJWhCaEWHf4+kvv1ahsdzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pP4/uXFX; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F03E44548;
	Wed,  5 Mar 2025 20:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741204907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NseaCwlTcgL+jlUr7YdenTe7ZaMIt3XQQddwYRw6aw=;
	b=pP4/uXFXrh7Jj9DtXTDZDShZUlnACoIUXZCpCgXtdo8BOPaIoH9je1x2ANCDsigxe5BLRf
	AKLF1eOqEzAfDo3PHYg7lfzCMgluxvRv8Ex8ezTlyoJJRcgnd+s+YKTTZfVOPJMP9SAFtE
	H4als5ZAgcJQt4+K2/U0z2aFxcN97WLQAeFLYxXYiMJgi/yYc6SqdW36iRzaUv0YplbzWf
	Y+uJM6hN/FHVgp/yHQVj1tLINE6EPymq/bF73fPi0EwIJcm8QVIY47ZHINwEj3HdjxMBVx
	XUd1lwkjOIWmvgb7ltIewj4qrPu5vxQT1dlb7NEQD7lzdxOUSzzqqtbnWzWeEw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/3] spi: dt-bindings: cdns,qspi-nor: Make the example real
Date: Wed,  5 Mar 2025 21:01:33 +0100
Message-ID: <20250305200133.2511308-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305200133.2511308-1-miquel.raynal@bootlin.com>
References: <20250305200133.2511308-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueffgeevteevkeegkeehleetteffhffffefgleeuleevjedtgeelgeeutdekgeelnecukfhppeelvddrudekgedruddtkedrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrdeliedphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgp
 dhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhgrihhshhhnrghvrdgrsehtihdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Add several properties to the example. They are actually mandatory from
a description point of view. Unfortunately, because of some YAML
limitations, they are just listed in a file showing the peripheral
properties that "can" be used for this specific controller without
marking them "required" explicitly.

At least mention these properties in the example to hint people they
exist.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 0104cc5283db..a22752806ae1 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -177,5 +177,10 @@ examples:
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


