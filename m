Return-Path: <linux-spi+bounces-7040-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3830A50C1B
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 21:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4D718951A2
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 20:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F12254841;
	Wed,  5 Mar 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mnyxGma+"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383319D06A;
	Wed,  5 Mar 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204913; cv=none; b=aZ6DytfNhtaLpp5jIkx0JysF3f1+MVZUSX5AZYgc9t0+hUWIPyEw9OIr/eKm91AJTfnNoLM5rEbaSyLxTV1GvNfTtBN+y3ZMhY0ZXqE+6k/EmMjwA+Jb5m6cCRzRwrenlI4ufIP9oHBFZIKXgzBPzUvLj2FxzsoSIS5eFSQ6y68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204913; c=relaxed/simple;
	bh=hf8aa2ASb4QxPW8iIvNly+zfUeMSRfUMJUIzaG3mmRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xw0qfv6Yhm7H4a78Nu8yVTgrvVou3UDyXkv/CK77jfCVGFlFA5Eduo+IEoh8FqSseyCjWikqKZ8/RVNUGKsFORKHQfbjnTKeEAKVL4kng1qiTP+hTBOxOvT1feHWc4+clOziNjO6FJeCprDiOPNAmBy4opLqkDKQrjOvRq28qmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mnyxGma+; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4772544546;
	Wed,  5 Mar 2025 20:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741204904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMpFJjyb+e1EB4lS6hv8vwUm6c45PBJMEPWpwdLbJvE=;
	b=mnyxGma+Jhl3+T0inJmyd9s33Z1hPuRQMwtktSebyOzbTTu/QXeUDLi1s4z7J6HdUM8o2f
	Nh/sJLVt/gO2krJa0zFjm9NLe6un92dojXQrVmuYcbsdz+DZBUZPZUmsqeN2omdFV3dEbf
	fNV3mAo9ZyKv3+oajcxMX/DQi66W6GHojMCWEGpzHQ4AyGO5QxtIXUokvGVozn9YBBnbJS
	YeaHrqQenzXo+UGma3o4zeDuWun1tTx5xYneHqPbvJGWnyhyiQlpL+cY8LxKs4QbJkRhFE
	4rhPQlV05TC5UGj8vIyuIJIbl2DfLam4eovoKharBhraZBPmzJEkIPJwKxQB0g==
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
Subject: [PATCH 1/3] spi: dt-bindings: cdns,qspi-nor: Be more descriptive regarding what this controller is
Date: Wed,  5 Mar 2025 21:01:31 +0100
Message-ID: <20250305200133.2511308-2-miquel.raynal@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvudekgfdtkeegtddvvdfgjedvffeuhefhieektdevueegieevleeugfefieehnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledvrddukeegrddutdekrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrleeipdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvrghishhhnhgrvhdrrgesthhirdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
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


