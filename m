Return-Path: <linux-spi+bounces-7219-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50348A688D8
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 10:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31FA883315
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD63253F23;
	Wed, 19 Mar 2025 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wzq37Lt3"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A189253B45;
	Wed, 19 Mar 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377618; cv=none; b=utNJHIcc4JJzW11ZxCxHOPmg832ESyjtesfLmLt4O9a7pVkiJA/A5Go4VKTlpcpX0mO714AmowyG2bG4o0a4XKY/PYcsdpm6tRAHL0QuZwI5MUsHx98Rm3Gq0j5sHrVrMeqOV+OxAqlQomsY/Yd8D+Nk/hcwZjADnUWZ/vHUQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377618; c=relaxed/simple;
	bh=quD0/F2SX9nwG3fRBT1+ertBsAlxDl0EGiWEwUWCBjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9m0DtkxLsyqpvpymSEvDsNBErWeqX8Wvm0JkLUe5sRG6M5Rllg/6ApkWJrmLIPCov+k/sLKV2T/deaSUPaoLisr9hct03+4KrUvRzyAFl360XN9hZ5fbi7GrfuNLa74pn6IcfgQku6y6ELXMu4XAC1t8u7NmW1mM4m/WWQffnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wzq37Lt3; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B5780433F6;
	Wed, 19 Mar 2025 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742377613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qi0auDf79m7JW2NdDjt+zR/OJYqCk0GPHJTRARp/P8c=;
	b=Wzq37Lt3H0lAbgs4FD3RwrrfmIxqQWCOLz6/12nYLgad/HbSUTtWBQdDM4F0ITGsfvSA7D
	vYNF5joTe06QVyorwfwWwsLc9kz64Zq/8FjE7prZ3cSc1Nav9R84NwRsHxZCZlX+/Qxotq
	ZikDBLZDjlOAv/YhGoIsXTVeFxesurh7oWErOlRvTwMcXKy3n0BbXl2D/hz+INq6wCuNRH
	86xy04RsHi36IjP09N3aPM1cuY/ic6cv6i/YrthRG6q5L7w44A7z+5hWfJO3rsuMl2JOGx
	wMBpJangVTHH0qJDVfr82KrsrDVCK4ysSzsNKrtt9jvlJiJQQ+kOvQfNms37PQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] spi: dt-bindings: cdns,qspi-nor: Be more descriptive regarding what this controller is
Date: Wed, 19 Mar 2025 10:46:49 +0100
Message-ID: <20250319094651.1290509-2-miquel.raynal@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvudekgfdtkeegtddvvdfgjedvffeuhefhieektdevueegieevleeugfefieehnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhifrddrpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepvhgrihhshhhnrghvrdgrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Despite being very common in commit logs, SPI NOR controllers simply do
not exist. At least, they are not as specific as the name implies. There
are SPI memory controllers which are indeed "specialized" and optimized
for handling "memories", but most of them are just generic and accept
almost any kind of opcode, address, dummy and data cycles, making them
as suitable for NANDs than NORs.

Furthermore, this controller supports any kind of bus, from single to
octal NAND, so make it clear.

Also add a comment to mention that the initial compatible naming is too
specific (but obviously kept for backward compatibility reasons).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index b6bc71d19286..c4315b2e04f2 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/spi/cdns,qspi-nor.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Cadence Quad SPI controller
+title: Cadence Quad/Octal SPI controller
 
 maintainers:
   - Vaishnav Achath <vaishnav.a@ti.com>
@@ -76,6 +76,9 @@ properties:
               - ti,am654-ospi
               - ti,k2g-qspi
               - xlnx,versal-ospi-1.0
+          # The compatible is qspi-nor for historical reasons but such
+          # controllers are meant to be used with flashes of all kinds,
+          # ie. also NAND flashes, not only NOR flashes.
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
 
-- 
2.48.1


