Return-Path: <linux-spi+bounces-12483-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BA9D39F5A
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 08:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75674303DD39
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 07:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7602DAFD5;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFdoEsa1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016D2D6605;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806394; cv=none; b=ulZgkVBFGpHJsKdKcBc4KDYMQoltRBQd50mhPDWHC2z7iJ+YrBQ2dHOl+JMT6OgYmVsLsnSvnyceJ9M2Uqg7+uOy+UDnjYwuV6UpY2JOxCZS9lRONT52EVkmi71tpe/vc5WIWobFKjC9ko3woKsRUkH+hkzup4Z+C0uJHIMLfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806394; c=relaxed/simple;
	bh=HBqZZvttDuyVc2JsBsl5S4x97pPOmaIQnnZvUvbafxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5StuvkRTPbuHImuyQmNtL4TK8N0eRD7W/9uarYImSXMeTD8KC8skJsBuyZ3TUlQCmdv92v9JYbKPklv3HrLn1TatINQaLuqlQtbc8KfD63pxljkvPTGomRyksJ7XhZsnaTSKSBbNZ+84FvqfGU8XfkvIfPegz2PuvK+LYHaHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFdoEsa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3552AC116C6;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768806394;
	bh=HBqZZvttDuyVc2JsBsl5S4x97pPOmaIQnnZvUvbafxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OFdoEsa1eUTSjqQReNF/DNXF6nenxZgTiLeddbOqwOZIunyG1rt3VLqqbTMf0H07D
	 6OfppIZvn/gZIKWnjvL0QVyoy3XoROKy5BZaEm5os0eYcjXBxrP+D7Djzv9XeVm1Pu
	 gqPeA+HZwxqDEwgvogwfHrWcoDbiqKKSe1vwpNekNBEi6yBFgdKcSJ1Z8lX4OMIwad
	 nu3w9t853386cRA+xpfcWALBcuRMQFlxwTvNwaqhtbbWk7+4sLS8oM9s2hLVj+c3P1
	 eFLr7WNMxvzREFUM2a41wWRPP8h9cTB/8yelT8HUpJkv0MFqX9Zd5SXkSUU+nBTNxv
	 xG5qZbPaQunPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24897CA5FF1;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 19 Jan 2026 07:06:22 +0000
Subject: [PATCH v3 1/3] spi: dt-bindings: xilinx: make interrupts optional
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-spi-xilinx-v3-1-4566c33bac0d@nexthop.ai>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
In-Reply-To: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768806393; l=837;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=Rbmi4yji+D6yvwIqXdPoR0dJO1NzfG8jvbb3qwJR8Ss=;
 b=JQle1H+it+z7PYjip62TbpkcvzOoAbHLCXfpWxiR0e3EWzfcdXFENf+yN80RvCghBvCtGnzxy
 TNfS8lYEYh6BSevl/AA3QWQj6Fdsc6TRsq6Fcygb9T9ypG0L823enW0
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Both the hardware and driver already support polling mode. By removing
the mandatory IRQ requirement during probe, the driver can now fall
back to polling when an interrupt is unavailable, ensuring
compatibility with a wider range of systems.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 Documentation/devicetree/bindings/spi/spi-xilinx.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
index 4beb3af0416d..24e62530d432 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
@@ -38,7 +38,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 unevaluatedProperties: false
 

-- 
2.52.0



