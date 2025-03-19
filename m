Return-Path: <linux-spi+bounces-7217-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6CEA6889E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 10:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2697A5553
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2AA253F2A;
	Wed, 19 Mar 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W29Gd0kn"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1172505C3;
	Wed, 19 Mar 2025 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377617; cv=none; b=tHP94K49Bp4ln3KcGQY2ZbYhpObZklR0Mg0YkhjQzhfZke1YaK/GwSoaLNE46CGL0VEQ9T4A6ZcWOqxCtrhqDAa7wSDlJ99uFTJUTThaqQXwG0BcSk65vp2tTv2lbnzHEVchnKPb5dBTLHVj2sSW3ycSgwaCg0QyocgHxX2kmU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377617; c=relaxed/simple;
	bh=+WrU3WQdOuYOcEqj8yUEzPjkGFhWHEBuNRJaqmHONoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JygTnwQPlRVOWpeXF8Xb9oqNHML7AnAt7SI/r3T39U1/eOp2eJUfHsq4DRiEqxEdDraVfgB/OfXdm/rjebr1GMBJ9V9LRgGMJtGQbjm51aCd6/HXuY2rPqVXEhVvGg2A2QatUnVHG+TVb9zncUwTxfYwZsm9KU1l8Ln5bK7I9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W29Gd0kn; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 415CC42FF4;
	Wed, 19 Mar 2025 09:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742377613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnhoNgYXgP7dt8f43khvREUPrg8BRdM4d2ODNIWP+EA=;
	b=W29Gd0knMFGMymffkS9JJetLGDsI5goZMCUkxHGCyEWyMjR0Tt5K/6O4J+Zu4rm4WY5NMf
	Gqgtak+iRZPa7qneU8iYz6OFkpKHpXNs742LLWlh9Hs7vMV5pMP7dAiHm3igGDRGcKF8qu
	lz5RCRJP4MXo/piTlKO9tLTRN1Fjlwk6XrT014yIH0o7AZPXOQnJ6TBsxQJXKHBXcqhu57
	wfsEYSzgPRrIb+OXtLyRHDDTwX4vlcQEJP3q64nGWl+CI6Huz7P27nWQJNprBmx7217vJe
	wF+7uDx2kedfyPGK0pq6qeUvh1I4dPMpr2ssgHKnV/tAeIo/ekj49CBw4GyIhA==
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
Subject: [PATCH v2 2/3] spi: dt-bindings: cdns,qspi-nor: Deprecate the Cadence compatible alone
Date: Wed, 19 Mar 2025 10:46:50 +0100
Message-ID: <20250319094651.1290509-3-miquel.raynal@bootlin.com>
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

The initial SPI controller IP from Cadence has always been implemented
into controllers from various hardware manufacturers and because of
that, it has always been (rightfully) doubled with a more specific
compatible. There are likely no reasons to keep this compatible
legitimate, alone. Make sure people do not get mislead by officially
deprecating this compatible.

While at deprecating, let's update the examples to avoid documenting
deprecated properties.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
It happens that there is a single in tree DT node named spi@ff705000,
so use the same second compatible to match a real life example.
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index c4315b2e04f2..c6705ad846dd 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -81,6 +81,7 @@ properties:
           # ie. also NAND flashes, not only NOR flashes.
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
+        deprecated: true
 
   reg:
     items:
@@ -160,7 +161,7 @@ unevaluatedProperties: false
 examples:
   - |
     qspi: spi@ff705000 {
-        compatible = "cdns,qspi-nor";
+        compatible = "intel,socfpga-qspi", "cdns,qspi-nor";
         #address-cells = <1>;
         #size-cells = <0>;
         reg = <0xff705000 0x1000>,
-- 
2.48.1


