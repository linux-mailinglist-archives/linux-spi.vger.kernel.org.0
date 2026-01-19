Return-Path: <linux-spi+bounces-12482-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08163D39F58
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 08:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CBBB303D153
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 07:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A863A2DAFA4;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3dFhBK4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801032C326F;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806394; cv=none; b=DIbHU3pQPcPUD6TvJvnjCiqpzCIOzHHcTi4IwCojxfZQL/T7KN1I8VMlKQfA4FyaBsXUS/7jmecXFDM02zTmqIFGJ4RkdrHWkFM/36BHr0fh2vAaaHSETbo5QZWTcu6vV6whUvDBlZcBZ5BY/cP/UAWbJ5kNJR4jHwhykvAjUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806394; c=relaxed/simple;
	bh=tpnfYEEUGGCcAt473upHUWl8HqVkQmGsCrvb4CiklBI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BRf6aY/URhxWzdU2udoiPjL5bgbXmmFnk3eBLrQykTZSEJuUVxg09D+V3BJO09NIQsCEScc3TbhSGw3Ev/E59DIRDtpDNxXzJqx7c7eSkX3+vctKh5QQWXJ0Cs9RYnJ47o9OeRGzak/jbLVqt8/w5S2heT3skiCerQ1aqOaUC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3dFhBK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2180DC16AAE;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768806394;
	bh=tpnfYEEUGGCcAt473upHUWl8HqVkQmGsCrvb4CiklBI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=n3dFhBK4rAnsMU8QW5/B1/mluc329pUD+nH+7GdZqz5Bui/GG3sMWdYUeC/qjNeUA
	 ASF3jbcDrA8aLy010xZuZz2fED+ieZuVq2OLIomiC444VWqk73VZ4+SMWFUxzsQYf+
	 1uzxsLCe+7v+eUXaL6qatYn4WjHPg7FnG4DoOMTpCfdfGcBLJTjaMfDlOoRsJzYrFb
	 LEqTeYTzgW99xrRqgMYWqEi9gaRcoKSTztqRTVlrNJewdeEa3MOfYh2x0V1h4FTCt9
	 jHh0yOY4L5UwnkDCRZHI4/oHRGeDOAT5zLnzXbDHbBYO8ByC+0GiJ5Fb2M36UkhR/G
	 1Q7t3KBiwMVhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B81CA5FE4;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Subject: [PATCH v3 0/3] spi: xilinx: switch to device properties and make
 IRQs optional
Date: Mon, 19 Jan 2026 07:06:21 +0000
Message-Id: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO3XbWkC/03MQQ6CMBBA0auQWTukU6SiK+9hXBQZ7CRSyBRNE
 8LdbVy5fIv/N0iswgku1QbKH0kyx4LmUMEj+PhklKEYrLHOEHWYFsEsL4kZqe+649D2rqUzlGB
 RHiX/Zrd78ajzhGtQ9v+LkyFLjauta601SOj74a3qw+TjNXJew7zUXmDfv27egTSdAAAA
X-Change-ID: 20260118-spi-xilinx-1b884d5b6519
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768806393; l=1190;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=tpnfYEEUGGCcAt473upHUWl8HqVkQmGsCrvb4CiklBI=;
 b=YHnrC+P6MuDz85zvTkEdBwOIu0gWm/BLsiWVugyfCbkuGtF2+tNjvrjF4b2AXibOgorGlYwPo
 CCRNsI8TXKmBOhUslCDbZIkLbruGmnpr1r+tXRbtA+X0vDTpRR7CdX/
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

Transition the driver to use the generic device property API.

Additionally, make interrupts optional to allow the driver to fall back
to its existing polling mode on systems where interrupts are either missing
or broken.

Abdurrahman Hussain (3):
  spi: xilinx: use device property accessors.
  spi: xilinx: make irq optional
  spi: dt-bindings: xilinx: make interrupts optional

 .../devicetree/bindings/spi/spi-xilinx.yaml          |  1 -
 drivers/spi/spi-xilinx.c                             | 12 ++++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

--
2.52.0

base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
---
Abdurrahman Hussain (3):
      spi: dt-bindings: xilinx: make interrupts optional
      spi: xilinx: make irq optional
      spi: xilinx: use device property accessors.

 Documentation/devicetree/bindings/spi/spi-xilinx.yaml |  1 -
 drivers/spi/spi-xilinx.c                              | 12 ++++++------
 2 files changed, 6 insertions(+), 7 deletions(-)
---
base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
change-id: 20260118-spi-xilinx-1b884d5b6519

Best regards,
-- 
Abdurrahman Hussain <abdurrahman@nexthop.ai>



