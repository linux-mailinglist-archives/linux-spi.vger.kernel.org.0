Return-Path: <linux-spi+bounces-5853-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 588959DB3E6
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 09:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD861B210F5
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B1214B96E;
	Thu, 28 Nov 2024 08:38:35 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B691531D2;
	Thu, 28 Nov 2024 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783115; cv=none; b=K5Y1H/X5c6POYIYcJhbOsem68vGn9zUWHdDxwk9vDV/U2Yl6wUUD5zhyxIM0+1NLNscb+Wh1vMwNbeIIpWxkH+A9sSbo2Zmw/xUTIK7Y+H/X6QNzLQWsmv3oAefBQzNpw4RdLofxFF5WudBYo/exkaFBogqqzvb/9TjW2oxTmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783115; c=relaxed/simple;
	bh=PwygZ8xo/uom8hgwVTtJN5pxQqPEFNedvWHgkIpqUls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hSyT2kVGmGt4yMf0+F1iqv3x8ifh97OGM67BeK8o2+VNQIextRxfp+++dWcJ4B31naI2NGckGjnjDtf5cxzY1GDyzgpwWJk4wnpt7/IkOjon+lgr933PvxakstmVVoPe0KcBKhQ5Nq/eDxRAqp5Ob0Jys113zEKnPVK3aJ4xx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 208830a6ad6411efa216b1d71e6e1362-20241128
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:76ada111-3939-43ff-8cb2-48de6f12cf32,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-INFO: VERSION:1.1.38,REQID:76ada111-3939-43ff-8cb2-48de6f12cf32,IP:0,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-META: VersionHash:82c5f88,CLOUDID:f36c0c66f0dfdb948bea5b9adc1895d9,BulkI
	D:241128163824DH1BYHU8,BulkQuantity:0,Recheck:0,SF:17|19|66|102,TC:nil,Con
	tent:0,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 208830a6ad6411efa216b1d71e6e1362-20241128
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 580643859; Thu, 28 Nov 2024 16:38:22 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] spi: mpc52xx: Add cancel_work_sync before module remove
Date: Thu, 28 Nov 2024 16:38:17 +0800
Message-Id: <1f16f8ae0e50ca9adb1dc849bf2ac65a40c9ceb9.1732783000.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we remove the module which will call mpc52xx_spi_remove
it will free 'ms' through spi_unregister_controller.
while the work ms->work will be used. The sequence of operations
that may lead to a UAF bug.

Fix it by ensuring that the work is canceled before proceeding with
the cleanup in mpc52xx_spi_remove.

Fixes: ca632f556697 ("spi: reorganize drivers")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-mpc52xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 036bfb7bf189..6d4dde15ac54 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -520,6 +520,7 @@ static void mpc52xx_spi_remove(struct platform_device *op)
 	struct mpc52xx_spi *ms = spi_controller_get_devdata(host);
 	int i;
 
+	cancel_work_sync(&ms->work);
 	free_irq(ms->irq0, ms);
 	free_irq(ms->irq1, ms);
 
-- 
2.34.1


