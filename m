Return-Path: <linux-spi+bounces-10660-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C01FBDD2C8
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 09:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D65CF501D5C
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AAA2BDC23;
	Wed, 15 Oct 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+m+TnsX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE8C233D85;
	Wed, 15 Oct 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513829; cv=none; b=iQN1O1hylsanD9gQem0rNLXPO1zZojNc2cPlyZrPUAWmfjQapFatdoLDdQsUf5cKH2QTIKgp1phavzkvUTbhrNu1YfnksyA8pNGhaBwosVaPdvmzJ2ikYEcXpqkLN1ST8U+1/j7zF7zIgwpKTR1C6KjtA4WkqMzJ4Z+7qR57ubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513829; c=relaxed/simple;
	bh=H0wf87Ra86CLHS1tXo0mSuHmiuFU4bbwc5VHjWQQnD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PgiRaZE1pTpCPAknz+gEg9cR8tOByJ4fDM4wi0cO0Rvn7ftOk+JzIxJJBa4GwIJDW/HElqZuUwxFuG4gDmsigtElsfGH0AF+bdT43MLTSpp2sVwUJmCgevGdLKMhN1hW6GOCQ06fN8JI4oDonEbxKB3I+PBmFZgl7u1wuDTb/Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+m+TnsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44F2DC4CEF8;
	Wed, 15 Oct 2025 07:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760513829;
	bh=H0wf87Ra86CLHS1tXo0mSuHmiuFU4bbwc5VHjWQQnD4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=p+m+TnsXXJ66DCzZc1D/hV0pjHsH2oa++FULr4MBYdpv2V6vr9UOwcBpG1BYV2fb8
	 vnzqoG1WdYmEpC6NYqbv+J2N4m50BH7cng5ucx1RuZVH/N6g729ney+F4IOLZ3gfMv
	 kR5TKJfOUSnhlo2RVaIKkhSZ9FD4BRHgkH6uBDuziAuscMUy0raQQo1S1oR1B4TFtg
	 Y4eOcBsIjT0FF8vilFC1stXQQSf39phAtM+VEYO2iWg3wRXEv44NO6bEO2XMbbAtEz
	 BKAH0zKMu3k0IWqN2PojRMLxaAGUASkDZvUOTaur3Jjp/zVGXOoJ0pNUn2FwFA537W
	 UAbkWEd7p+j3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3035ECCD190;
	Wed, 15 Oct 2025 07:37:09 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 15 Oct 2025 15:36:59 +0800
Subject: [PATCH] spi: amlogic: fix spifc build error
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-fix-spifc-a4-v1-1-08e0900e5b7e@amlogic.com>
X-B4-Tracking: v=1; b=H4sIABpP72gC/x2MQQqAMAzAvjJ6ttBOHeJXxINo1V5UVhBB9neLx
 xCSF0yyikEfXshyq+l5OHAVYN6nYxPUxRkixZaJW1z1Qbt0nXFqkLo6ifBClBJ4cmVx/++GsZQ
 PwDhbkl4AAAA=
To: Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760513827; l=1872;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=ib4K3AKweceHACtvQk2qAu1Cu/KOa08Hppl4rd6zBYY=;
 b=8MdBsfApJXW2O9AH4npOlocTZ3FbpagtH4/ZTFZY9aaslApccjLdZcT/BXHUPBJGo1s0YlV/W
 lFZuormMTOvBtGgqksRN9YUyQZCgOPpnnO2bEryepLQwFmbybNKJmvI
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

There is an error building when
Compiler version: gcc (GCC) 14.3.0
Assembler version: GNU assembler (GNU Binutils) 2.44
"
 Error log:
 WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o
 ERROR: modpost: "__ffsdi2" [drivers/spi/spi-amlogic-spifc-a4.ko] undefined!
"

Use __ffs API instead of __bf_shf to be safer.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net/
Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Fix build err for spifc.
---
 drivers/spi/spi-amlogic-spifc-a4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 4338d00e56a6..35a7c4965e11 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -286,7 +286,7 @@ static int aml_sfc_set_bus_width(struct aml_sfc *sfc, u8 buswidth, u32 mask)
 
 	for (i = 0; i <= LANE_MAX; i++) {
 		if (buswidth == 1 << i) {
-			conf = i << __bf_shf(mask);
+			conf = i << __ffs(mask);
 			return regmap_update_bits(sfc->regmap_base, SFC_SPI_CFG,
 						  mask, conf);
 		}
@@ -566,7 +566,7 @@ static int aml_sfc_raw_io_op(struct aml_sfc *sfc, const struct spi_mem_op *op)
 	if (!op->data.nbytes)
 		goto end_xfer;
 
-	conf = (op->data.nbytes >> RAW_SIZE_BW) << __bf_shf(RAW_EXT_SIZE);
+	conf = (op->data.nbytes >> RAW_SIZE_BW) << __ffs(RAW_EXT_SIZE);
 	ret = regmap_update_bits(sfc->regmap_base, SFC_SPI_CFG, RAW_EXT_SIZE, conf);
 	if (ret)
 		goto err_out;

---
base-commit: 4412ab501677606436e5c49e41151a1e6eac7ac0
change-id: 20251015-fix-spifc-a4-0836ee1d0066

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



