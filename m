Return-Path: <linux-spi+bounces-7216-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7DA688B7
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 10:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE73188919F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 09:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A94253B65;
	Wed, 19 Mar 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NtiIgxOb"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4424EF9E;
	Wed, 19 Mar 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377617; cv=none; b=NYh84W98EhjGHFVShdolMKi3mK41OYCLWxs7/s5x6rMkeKeembquoKEMO0zSYWNwWO2HtLvPWZ2fA4+koR09HyAL7kyB2o4dqSJZU/d70tQUHzV1bNHBocCztfFSXUw2frc1d3XjFF5YVVRhl469wlk1IFcEcCgAIdzOk+Pudxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377617; c=relaxed/simple;
	bh=UwzeXCf04iJKw7yfzzc4qMpHFXysxG1XDLtC2ZhnBks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxvfL2h8lHVK50rrpDpwp2gbRjCWaTMNahayxOrkye0xudiycSZiaUOQiCZaW7EhHb97j7QcExbq5mMRHdzsIKdBeDWAjw86gKdQwXlg/NxoNaL7Kt8PdrA+GJOF0EJXeziA9fbyHhXSDxdNfaS9iDMz7a9nMBFq/MRaKLXTnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NtiIgxOb; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D68E43421;
	Wed, 19 Mar 2025 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742377612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p/dRiMuLiBsI8SGyE7EafALtSWMaJ/SHPwdntdyAcEA=;
	b=NtiIgxObb8rjDH3wRKkZx/XvOMefPVEbKCENdHkprymFmY/3dm41Eg1rPxmt6s6cwjyD/l
	hMXfUOE1sZVptMaEFfhf95AO43waqFg5wqczCA5XqMGHatZ/zbaz3ed/hxnfZ8u/0xx+66
	40rczf1zxOuhfLMCcDHmJIPFgVQx8ERkutJCpINAslCuqwQVYrz2VqgwLopTZjRHxLoifW
	VF52OZmErkANNBeWKKyzYullQWY3yN4U08t+mJKQ4cdm0mqXYyczLDaH5vpoxvKpt1W6tN
	4laq7B8FMyxGusX3Q7ShwznJAWruBc+CT++Lu7OS7FKwTAh5WptgxxM4ujONLA==
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
Subject: [PATCH v2 0/3] spi: dt-bindings: cdns,qspi-nor: Improve description
Date: Wed, 19 Mar 2025 10:46:48 +0100
Message-ID: <20250319094651.1290509-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeetfeduleefjeffheevleeggfdtvdduhfdugeeuieejveejiedvhfdugfettdehnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidrrddpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvg
 hgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepvhgrihhshhhnrghvrdgrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

While working with this controller I figured out a couple of small
issues which I propose to fix. They are not super impacting, but I
believe this goes into the right direction.

Changes in v2:
- Collect R-by.
- Use a non deprecated compatible in the example.
- Instead of suggesting that some of the properties are required by
  improving the example, make them really required.

Miquel Raynal (3):
  spi: dt-bindings: cdns,qspi-nor: Be more descriptive regarding what
    this controller is
  spi: dt-bindings: cdns,qspi-nor: Deprecate the Cadence compatible
    alone
  spi: dt-bindings: cdns,qspi-nor: Require some peripheral properties

 .../bindings/spi/cdns,qspi-nor.yaml           | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

-- 
2.48.1


