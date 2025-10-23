Return-Path: <linux-spi+bounces-10783-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 634F0BFEF34
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 04:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 521754E449A
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 02:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B9211A28;
	Thu, 23 Oct 2025 02:43:58 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4719CC28;
	Thu, 23 Oct 2025 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761187438; cv=none; b=p5GMXuQul18lVjCGZv30If+AadpFOvg2wEFErEvxEgXgt7ELKg8mRakgnGKVJ/k/g1dMf1UpbNEjo8Pd5EPtMkII7D8FqapLzv9JAvb7W2L1gmEykzkWNzEROHS2BwBGqeIRNy4CCt8o3dsd+QPGbLkZx3pYZE7NIrrJ4OeYK+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761187438; c=relaxed/simple;
	bh=Pt0fKkrjc7LEFMVwCq21fD4DCTxBVk0ZNMDt3MX/GGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OUCrsIXK+OEMnF4NG26bzrWMwHaayg7pSKRblGOzrY90lppYxnEbcg9Du0iyKbpBQE+6L/as6pYD7OP7N8a9vy+jpYVEYQxsDMMl1vC35uElB98mCewL7Y6npNSba2sg9xXfVmMmzwZiklWmhi7E/lqKkPPmj+5ajMjBqQyTHes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1a04342eafba11f0a38c85956e01ac42-20251023
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:00ca4b39-025d-4e31-abdf-068a32c1f394,IP:15,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-INFO: VERSION:1.3.6,REQID:00ca4b39-025d-4e31-abdf-068a32c1f394,IP:15,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:3cb951282fcce47935ea0622d9e7e141,BulkI
	D:2510231043506L8E49MO,BulkQuantity:0,Recheck:0,SF:10|24|44|66|78|102|850,
	TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1a04342eafba11f0a38c85956e01ac42-20251023
X-User: pengcan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1718989893; Thu, 23 Oct 2025 10:43:48 +0800
From: Can Peng <pengcan@kylinos.cn>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH 1/1] spi: spi-qpic-snand: make qcom_spi_ecc_engine_ops_pipelined const
Date: Thu, 23 Oct 2025 10:42:50 +0800
Message-Id: <20251023024250.3181084-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marking the qcom_spi_ecc_engine_ops_pipelined as const provides
memory protection by preventing accidental modification of critical
function pointers at runtime. It also enables memory optimization
by placing the structure in read-only sections and improves code safety
by explicitly documenting the design intent that these operations
should not change after initialization.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 58ceea1ea8fb..7681a91d67d5 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -448,7 +448,7 @@ static int qcom_spi_ecc_finish_io_req_pipelined(struct nand_device *nand,
 		return snandc->qspi->ecc_stats.bitflips;
 }
 
-static struct nand_ecc_engine_ops qcom_spi_ecc_engine_ops_pipelined = {
+static const struct nand_ecc_engine_ops qcom_spi_ecc_engine_ops_pipelined = {
 	.init_ctx = qcom_spi_ecc_init_ctx_pipelined,
 	.cleanup_ctx = qcom_spi_ecc_cleanup_ctx_pipelined,
 	.prepare_io_req = qcom_spi_ecc_prepare_io_req_pipelined,
-- 
2.25.1


