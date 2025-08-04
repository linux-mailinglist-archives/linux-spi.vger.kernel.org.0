Return-Path: <linux-spi+bounces-9273-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6FB19F03
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D07B1889695
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB4F238C08;
	Mon,  4 Aug 2025 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D1p9Cxrs"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7EA23ABBD
	for <linux-spi@vger.kernel.org>; Mon,  4 Aug 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301033; cv=none; b=aQib64CmyTM/KNfQ80AH0RTfcSt1JQBBVDn5wHSvb3XEjwUkPql+YlH+ovF5bGIBrLOCKEtDrNI22hdx2WE4Sh2em9NCIIc5fVyBB61wSOe2PdM02KRrsQei+xlfifrOEx5GwSk3HqH+oXvBPTsBoiB3wiDu7Pnzn2v819I3g+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301033; c=relaxed/simple;
	bh=fTBfvwHSHSUTDccOMr5cZSJF2cDDQiKTeQ5/hXjznsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S5NbF09Mxq/U+fi2hNL6tvpABvbrRm33RfsYlIwiibDfV3TJVnOAsnv+ryxugWU9P1UeCyZ39IlSoWvG+5j/UmdgIDQ+MbGui+9G3ToqPQmR+c9SuvSQoTY4YU4xyf6XCD7BaEA/wiuhlavX5sIPRXR7o3xMYWRcI4xVJnt8UCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D1p9Cxrs; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A11F24316E;
	Mon,  4 Aug 2025 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754301023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8AkJ02wQGHu9WLLvikIeP8n7YbchB7CGIHF+YdxDHjQ=;
	b=D1p9CxrsEl1CUCUMSbtxC8EKmXr9o73gjm65vRliWugsVReFRmE2QfhDGEUecoA2u9HPDg
	j/nEJxvZoi7pnG//jhTwmaM/VTZJvsKps3jwE0L5PaElt7HZispORtPklE8e6EQiLvQQma
	+aO/p4rKQdys/WJdxwzi380+GCSnFFrk3+MehH4JAAQU52mReOAc6bRmGOGWyp1zAfmB7t
	xxYkY7tgqsGVx4jDU9xN7+oj58jRxF0dHGwb8HG4NgBZ696A+HceZFR/NnJSKnuxAOKtyh
	FQb8whwNNzkklUri6Qu0sUHRFQUCWmxasVyqL+G5BfrQR89GgbzAtXBrQImJ0A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: spi-mem: Add missing kdoc argument
Date: Mon,  4 Aug 2025 11:50:13 +0200
Message-ID: <20250804095013.409700-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueeileelteeggffhfeevhfeihfeffedvtddvgfelvdejleejveelueeggeevleehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhifpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpt
 hhtohepphhrrghthihushhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlseifrghllhgvrdgttgdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

The "*mem" pointer has been added without description, describe it in
the kdoc comment in order to fix the following W=1 warning:

Warning: drivers/spi/spi-mem.c:594 function parameter 'mem' not
described in 'spi_mem_calc_op_duration'

Fixes: a11a51896572 ("spi: spi-mem: Take into account the actual maximum frequency")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507310409.fnuQ21qb-lkp@intel.com/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index d3b7e857b377..841b0995c8ea 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -577,6 +577,7 @@ EXPORT_SYMBOL_GPL(spi_mem_adjust_op_freq);
  * spi_mem_calc_op_duration() - Derives the theoretical length (in ns) of an
  *			        operation. This helps finding the best variant
  *			        among a list of possible choices.
+ * @mem: the SPI memory
  * @op: the operation to benchmark
  *
  * Some chips have per-op frequency limitations, PCBs usually have their own
-- 
2.50.1


