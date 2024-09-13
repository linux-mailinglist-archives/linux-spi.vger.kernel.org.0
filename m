Return-Path: <linux-spi+bounces-4813-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89174978A6E
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 23:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09DB1C2210F
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165831474B2;
	Fri, 13 Sep 2024 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5xqBXgs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C29126C01
	for <linux-spi@vger.kernel.org>; Fri, 13 Sep 2024 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261661; cv=none; b=A+/JWR7bG1XpL2CFqbht3EeTXFjf7hf+UO87KWAgmDEoQEpabHgnRvMMN+3vYoY5yt6jLPlVCZ2YHa95s/gX1srXF3OYDjG2XufEzfTxQric3FYHa8p+yXoxEt4QTz1ZxWK7knOCJsaiWJLr1wvxgrDwgMZxXgUvW6w7p1MhxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261661; c=relaxed/simple;
	bh=+TB9oObE8jFM8lByBhuspz+4OeFWOAzD//N1khf/Abo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+li2OP4GJAeQMSFMkU5uAbRefPqe4+B+a803zeeQ0Uu1F4D+R5YQMX+GgPBcWJlgfNB25EMbt9HgWY/cW/Oq2xLBa9hf3gQrQM+L/xrukFn5UsR8V+r8M0itYUcKLX2KdElw4N3MveOudrpWwntu65/6c0xxQZjD+nMms2pFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5xqBXgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ACDC4CEC0;
	Fri, 13 Sep 2024 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726261660;
	bh=+TB9oObE8jFM8lByBhuspz+4OeFWOAzD//N1khf/Abo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X5xqBXgsgcd9ObFakEuqbRgwvTe06H77CeQAVaw1UF/fofsX0aj6XVRFKSAqYM+l6
	 mAWT5alixveEBy+s/HG05AWEUX1/rV9vRYPrh8ORVADjDrGwrMI3gEwrECKYsF282L
	 SgaY9kC81rA0Yr7Lab4J4RPcvJuiBU8eLcigE47fi4W8u5gm0ggebbzSB90io2MOp9
	 mBFPI/K2pA7kTFbHEAhwGQj4XI8WzR0C5p0rK2qrYdm7CBhGHMri3fnf83ZrjyZaGj
	 5/FAQblwIfGmyeK1wkfpNn6uCKHIXLkzSvFcdUD9o10dVQQIQK5xzrqk2cF3zt7Pk1
	 7E/NgLSjKa/lw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 13 Sep 2024 23:07:14 +0200
Subject: [PATCH 2/4] spi: airoha: fix airoha_snand_{write,read}_data
 data_len estimation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-airoha-spi-fixes-v1-2-de2e74ed4664@kernel.org>
References: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
In-Reply-To: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Mark Brown <broonie@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.1

Fix data length written and read in airoha_snand_write_data and
airoha_snand_read_data routines respectively if it is bigger than
SPI_MAX_TRANSFER_SIZE.

Fixes: a403997c1201 ("spi: airoha: add SPI-NAND Flash controller driver")
Tested-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index be3e4ac42153..c71be702cf6f 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -405,7 +405,7 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
-		data_len = min(len, SPI_MAX_TRANSFER_SIZE);
+		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
 		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
 		if (err)
 			return err;
@@ -427,7 +427,7 @@ static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
-		data_len = min(len, SPI_MAX_TRANSFER_SIZE);
+		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
 		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
 		if (err)
 			return err;

-- 
2.46.0


