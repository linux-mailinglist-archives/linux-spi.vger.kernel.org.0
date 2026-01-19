Return-Path: <linux-spi+bounces-12480-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C9D39F53
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 08:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 453A4303A1B4
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F972D9EC8;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKaEAnEz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800226A33B;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806394; cv=none; b=d2qW0onfrIA0xmxEoI9fr6tKaZGyjuiXW5TBNhgPPtPvB+leAocAc71EkyOEK3fD5ZAvC619bcMATCJYehNN7b1VgsXEQdUL8vJWpUl2Ixb9P+/dqRnQeImoVs8s8Auu251ga0RoVXHOruxCLZWMjv4r/cG1kdluRg4/NDlQHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806394; c=relaxed/simple;
	bh=CBGg3x/vucOg+TkQQF7Y4KAwGgR2HgDde7MgFS6bYuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i4Ykmd6PO5FCk031568NiD/knYUJHxl1gt0roTQZOoUbMHIW+Ymt1LC7jTeWddrgcg+xnjNY8nTUtqv33oJfMOIueDQdNrOjX17QY6aVlBdDmGW++gbtJwBBtyGXmubiS4AD6tkMhzpG0Ljwd/2m5xsAFOu6y+fwX460lAFR/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKaEAnEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41A10C19425;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768806394;
	bh=CBGg3x/vucOg+TkQQF7Y4KAwGgR2HgDde7MgFS6bYuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GKaEAnEzMyE//jpsjeXOcE6qOtEjh43DlkPb5Oe5wx1PBj9OqvR9phWxtx1J4q9Ne
	 BjmC9oYHA1u25xgWaj2+W0ca9rSJbCfvOdNrn3Cr5DzAUVCyLFgKFD2+qmmqktSEGx
	 qBFX3DF8Hkm2Sy0an6lUuLNjFpK5M8bOuTDwmL2m+O5x+nao3y60a4keuF31roDt8Q
	 FcfMElVJqUyYm4wHmTKrfjjaDpDZbGm9L4Wmy0fz+KiDVmyD5rvSQ6hXmU8st1cLQ9
	 7Xbs+ApJDEbxwfhucvvKigqXIABH7sc2IasZaPT1gvSSqMABpo8A7L49svLShS44Rz
	 WXXKsOnZDaqcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331D1CA5FF5;
	Mon, 19 Jan 2026 07:06:34 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 19 Jan 2026 07:06:23 +0000
Subject: [PATCH v3 2/3] spi: xilinx: make irq optional
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-spi-xilinx-v3-2-4566c33bac0d@nexthop.ai>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
In-Reply-To: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768806393; l=964;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=PBkRm5i7Y71sKWBVU/SvixzOItjnO8vO5sXpyGOffJs=;
 b=t9iSVOWCuMCe/7ZCazYCqmZGC83AcNhDLXOidgKbHtDmZUNA4H01/V6Cssev3nPLdV91x4NKb
 dHwdG/Wva74CZjpS75S7uc1856hxqJ4fpb/I9gkcrFRmn7CmUsyzhWw
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
 drivers/spi/spi-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index c86dc56f38b4..4aa67fc61cb6 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -471,7 +471,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	xspi->bytes_per_word = bits_per_word / 8;
 	xspi->buffer_size = xilinx_spi_find_buffer_size(xspi);
 
-	xspi->irq = platform_get_irq(pdev, 0);
+	xspi->irq = platform_get_irq_optional(pdev, 0);
 	if (xspi->irq < 0 && xspi->irq != -ENXIO) {
 		return xspi->irq;
 	} else if (xspi->irq >= 0) {

-- 
2.52.0



