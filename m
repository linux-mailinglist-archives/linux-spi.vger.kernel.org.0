Return-Path: <linux-spi+bounces-3370-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5609F903D41
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9CD287ED1
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A7817D8A3;
	Tue, 11 Jun 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WwcsRWRV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238C17D358;
	Tue, 11 Jun 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112364; cv=none; b=htS6RKCEormN41BVYecSf7or3Fqe/QW//M7eWKreBDXk2Lh8APUwnEt8XkVK9jmG05W/2cZIjya2n3Tp2bH0NyT9pE1Rzbx1j8bMgRhlTs6+pbkKZETn1xrpJTlMOZ4AHiazq2WrTaJ7AzjOBfFwwcep5h3Kl4atdZhOl1eFqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112364; c=relaxed/simple;
	bh=08k+wAcbql/lsu9rymmUxtWIFDkESLOMHf5F/uImiHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d83Bp7SwmCyJykqqDb1+7nnINRZEk0KiU6SRkwzucp+GM36hmj7oT6yfW95hCTfn0ZJ1Wm1Ys6uZq0RV9kqUGvLiT193HvDbysqO0ltWjdj7g0ZX7glOlRXbsPkkyeEDJSTtDF9p8Z0XoSM8/SqZQbL1SKoiPOIWl5uXcexO0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WwcsRWRV; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B5xVav021424;
	Tue, 11 Jun 2024 08:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=bY/YYO0JK9L565n9PzZjzHjTXNAAU0kC6wTI1GzcH0w=; b=
	WwcsRWRVwd8rPsDNmuSn+0cKb/iwfkFujmPNQUteJrI2iANNucTetADPI8eRGdyS
	WZlVnzpITd+2ttg+pWzkT/Q3+nFOZ3EC7BrHkbJK/TJFZ0Qvn6E0Og4sIda2QSVd
	E6NEe2lhDzrPlsOH9VB8gAf9i9PazdTWllcrZLuU9Z13bUiuk8OYfGjL52jCB713
	2ptSPUJYHyaGpVDQE3tKzWGLVYSmVULsanv2SzHyjT2UNcHaKCZdQJFSbG3IL6vq
	JzCRLJ3N92o0CzLYLGW+fj96TNuorC8gnX95QlE8FxCDuJu82xZaCJolvKWk85Ni
	RmQT9NmV0CtCiO9+8PT7vQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ymkqhtuva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 08:25:58 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 14:25:56 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 11 Jun 2024 14:25:56 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BDC9D82024A;
	Tue, 11 Jun 2024 13:25:56 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 3/3] ASoC: cs35l56: Attempt to read from cirrus,speaker-id device property first
Date: Tue, 11 Jun 2024 14:25:56 +0100
Message-ID: <20240611132556.1557075-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611132556.1557075-1-ckeepax@opensource.cirrus.com>
References: <20240611132556.1557075-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cOWaB2ODgemJ1AfYcaeFaYYJTdZ059-H
X-Proofpoint-ORIG-GUID: cOWaB2ODgemJ1AfYcaeFaYYJTdZ059-H
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

When cs35l56 is connected via cs42l43 there isn't an ACPI node for the
cs35l56 so all properties are under the cs42l43 ACPI node. We're adding
a property as a way for the cs42l43 driver to pass this info in via a
software node.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-shared.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 8af89a263594..e89027cd40d1 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -853,9 +853,16 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_hw_init, SND_SOC_CS35L56_SHARED);
 int cs35l56_get_speaker_id(struct cs35l56_base *cs35l56_base)
 {
 	struct gpio_descs *descs;
-	int speaker_id;
+	u32 speaker_id;
 	int i, ret;
 
+	/* Attempt to read the speaker type from a device property first */
+	ret = device_property_read_u32(cs35l56_base->dev, "cirrus,speaker-id", &speaker_id);
+	if (!ret) {
+		dev_dbg(cs35l56_base->dev, "Speaker ID = %d\n", speaker_id);
+		return speaker_id;
+	}
+
 	/* Read the speaker type qualifier from the motherboard GPIOs */
 	descs = gpiod_get_array_optional(cs35l56_base->dev, "spk-id", GPIOD_IN);
 	if (!descs) {
-- 
2.39.2


