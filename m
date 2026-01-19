Return-Path: <linux-spi+bounces-12481-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC48D39F51
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 08:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C556A3008144
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 07:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F182D6E64;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw3yHfoT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008A289811;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806394; cv=none; b=Sh9lXIq/yvhG2GwAf6aLF3gLoRAJvl+tGhcgDUZsKAUuIvpaUm0CVxLu0JQoc/29G54UmU3yM3uI5OpXYvHJMQPi0wNzgInYfRnWZ2O6mkXOcE4e/pXhwADOuOhOmv2d9SjpTOvh7+HS53aptHoWGFc0ZNH/Kth11tUMlGsNvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806394; c=relaxed/simple;
	bh=u3K96sn3kaP5ZMu4Inbphv8OWU2bjFbfkLD6u/MxeC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ud6BEL6v/WizPR3MCi6MUIeU1bSR93+xej3eHTyO9lgD8Q4QmtvtEpedPwu5qMzCWZddnDBgItEOYxOoX1SAJohjBHqNOrr/J0A6nyVAkOi7RojRHW+GHa9omvcnf2GDMRV6YjwZGBSR/MY4DOyZmWG2aOGyxoN9UGnFfrNrvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw3yHfoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CD08C2BC87;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768806394;
	bh=u3K96sn3kaP5ZMu4Inbphv8OWU2bjFbfkLD6u/MxeC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gw3yHfoTaTPrAyMvnzd1S/99WaaupLVOWze2HSvrDL4JJLbfS0XdP4bNwVwprQCIH
	 akDLUMOpG/TuA7XVdSsbgdLydSSm+JULAgHADdZH+Tkr8x3QMfB1L2ZPPoU7fDcHIf
	 qOTNngttO7Weo3TXir/tj5LeqYUqbLPKSrjcM/oYduFieXA6JZhERiqX6RIG3XlUYW
	 a0KHWDIkwuasI8u/Hap3SjHIzEP5IG+4H8O+pf/yRf4o8k5x1y39yk/v2uV71mFrv3
	 gdWbdRjNj2XMJuPBvX+ynOuEQTi9OKa1lajQi8BXbUdwAL8Y0pxOctn7rIISqFqgD6
	 gzbcLg/PSG0BA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44547CA5FF7;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 19 Jan 2026 07:06:24 +0000
Subject: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
In-Reply-To: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768806393; l=996;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=5Z9Lfw4Ms5TcSIWQwUqr5lvpEWwq7CP+Bn9jodMd2/I=;
 b=b2d156WBDJn95t3Soo/2/DM72vaW8XXHo3TSPZhHT46rJH8In8ygdUXGPL58qNn052PIiR7/E
 eygipSy8BSwAJaNyL3HRid4K04WCK1lspGGY5DooTVfKb1F+Pks67El
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Make the driver work on non-OF platforms.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/spi/spi-xilinx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 4aa67fc61cb6..9fb1da2fcce4 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -405,11 +405,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		bits_per_word = pdata->bits_per_word;
 		force_irq = pdata->force_irq;
 	} else {
-		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
-					  &num_cs);
-		ret = of_property_read_u32(pdev->dev.of_node,
-					   "xlnx,num-transfer-bits",
-					   &bits_per_word);
+		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
+					 &num_cs);
+		ret = device_property_read_u32(&pdev->dev,
+					       "xlnx,num-transfer-bits",
+					       &bits_per_word);
 		if (ret)
 			bits_per_word = 8;
 	}

-- 
2.52.0



