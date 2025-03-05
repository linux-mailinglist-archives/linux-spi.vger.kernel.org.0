Return-Path: <linux-spi+bounces-7039-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55974A50C1C
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 21:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22BD7A8C09
	for <lists+linux-spi@lfdr.de>; Wed,  5 Mar 2025 20:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A452517A6;
	Wed,  5 Mar 2025 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hurTjPTa"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141C191F6D;
	Wed,  5 Mar 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204912; cv=none; b=X2HmdpL5jbbCBZKY4iookDSqpO/ncYN0UoyRLKWf7mQ21g2lMy29LVxahq1pOpJsqvbtfJYC2CB/qpj5LJJJS6g2p6qX+1UlQgAos/YZ2q49O2wlQ84B/kAdY75or/DEJknzpxEa7lDsiFbMk6CKos/jub9+AGK8VGjn6AyzM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204912; c=relaxed/simple;
	bh=BnMavypeBEQlZQk/AkwCuPTzMyyMu2rChHocq53U7cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=im49fLEz+DQMZIt/uKrIfICiscKv8il2fgnOQMyiA5egTtvER8qZi9GxEwD5ENkEB1QRQZwjfleovTc1VLGlo5BC4T+NLCEX7MeKoNSniUE/U2dwcycP2Q7RuWBzY8kbKcm233T/WO6pqUJ0oyziMt3vcQVEn1w5Q2Rwlz/GBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hurTjPTa; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9B2044538;
	Wed,  5 Mar 2025 20:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741204903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H5UKS5m0L150U3LxN4gLnZ2WtRoZ6BkNuSVrYMYzyO8=;
	b=hurTjPTaQhN38R8xPy8uxSUgOrkD09I1RynMtCNVOBrKBvM5Z6tBEi9QZWMgiV88Vlevrv
	aQSHEF4YVrAmk/8nrUmYm+cmBnmkDwhASsOqw6NfItktEclVh028bWhEmJBn/ifrQjR+TT
	zfivKywWvIVh0IIfnyaTCnz+GZfuj5Aev85rKcKhs247Yq82r1kw3jWQVKbIRHHoPZlEAR
	LiHcRzyR/s/SaXrpYmjOlBr2TDSdqNIHRN4StdIIEfFFi/MnNTfqKBE5d49Ii8mFr3dw6U
	2hLMsZLwzAxNoWpH40iKVP4vAMGF3Gcz9qT7fPgKdPW2iWg8RUOpwug0j53Jcg==
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
Subject: [PATCH 0/3] spi: dt-bindings: cdns,qspi-nor: Improve description
Date: Wed,  5 Mar 2025 21:01:30 +0100
Message-ID: <20250305200133.2511308-1-miquel.raynal@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeetfeduleefjeffheevleeggfdtvdduhfdugeeuieejveejiedvhfdugfettdehnecukfhppeelvddrudekgedruddtkedrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrdeliedphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhgrihhshhhnrghvrdgrsehtihdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

While working with this controller I figured out a couple of small
issues which I propose to fix. They are not super impacting, but I
believe this goes into the right direction.

Miquel Raynal (3):
  spi: dt-bindings: cdns,qspi-nor: Be more descriptive regarding what
    this controller is
  spi: dt-bindings: cdns,qspi-nor: Deprecate the Cadence compatible
    alone
  spi: dt-bindings: cdns,qspi-nor: Make the example real

 .../devicetree/bindings/spi/cdns,qspi-nor.yaml        | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.48.1


