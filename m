Return-Path: <linux-spi+bounces-7041-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBFDA50C1E
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 21:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5503A3666
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 20:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D719254AFD;
	Wed,  5 Mar 2025 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QDljwYI6"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE4254AE8;
	Wed,  5 Mar 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204916; cv=none; b=f1UzeTUv5Ia+Myp98eCNS6Vw2o1gjYPfdFhPh8ZZRpvAYkwGSKtjKPXVS26Aw0ZChgpTXIBu9wA643588Q/dkBjUkThPXZDVtVtle2Cg9QnFbtDYu5SMRdLKmTGvlP6A/w+7TSMfzz1IzMgSZtmzMNw70F/2zrzFuQxCwkbWk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204916; c=relaxed/simple;
	bh=/CW8ntebprtHcmzIMELyIRJ7IbeisnAogMNfL95PUEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mc4awCyV1p+MJ29Vusn6aZ7iRRl5MjYnnzlF52eHFKI4JZn7ubf+ardVAesCS+u+TGKiPmW6/cL/01tv69ukEnunzYDWKQQvGOqbMyZnH0PLnbohDd2ON423X9QJvrz9Es9cBPYe0GSCzDOoOBc3jMrpL+wuylFxQO9WIA5E73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QDljwYI6; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0CBC433C9;
	Wed,  5 Mar 2025 20:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741204905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06hyfSVLTwdodHs8LE0wUaUFOncfZjOw3BJhpi28dtw=;
	b=QDljwYI6T+sC22ueVUB8nQMPnJdCbBMsnIxN6H3ofRCcQSBdJM83js4+tcS4sL21SEnjCS
	axqMrY19qjXWAwe/x2ADpcL/BOZMVkQmIxrzJWqJt/vxPl+ijD6cPTIhoA+O/Ylge0+hMj
	avKyOBkmHtmuKAuyjRbEd6OtCzslSq9Ne8NmV9mlYi+f9tEvBlxwYUwwcCAw7jPKAdvubI
	L45kS6cPPM0teCkCGpQ1kkpsRTETPs1eR51GhfD2zauGJtMem5hzzkPoXm9FVZAnrWBukJ
	tXwrPqcDC0juHcrLq/sXMJ1r24MMCJ2zUlKIZg+cLC7sfzb/LS01nlx1XA4xcg==
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
Subject: [PATCH 2/3] spi: dt-bindings: cdns,qspi-nor: Deprecate the Cadence compatible alone
Date: Wed,  5 Mar 2025 21:01:32 +0100
Message-ID: <20250305200133.2511308-3-miquel.raynal@bootlin.com>
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

The initial SPI controller IP from Cadence has always been implemented
into controllers from various hardware manufacturers and because of
that, it has always been (rightfully) doubled with a more specific
compatible. There are likely no reasons to keep this compatible
legitimate, alone. Make sure people do not get mislead by officially
deprecating this compatible.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index c4315b2e04f2..0104cc5283db 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -81,6 +81,7 @@ properties:
           # ie. also NAND flashes, not only NOR flashes.
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
+        deprecated: true
 
   reg:
     items:
-- 
2.48.1


