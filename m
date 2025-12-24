Return-Path: <linux-spi+bounces-12122-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D61CDC115
	for <lists+linux-spi@lfdr.de>; Wed, 24 Dec 2025 12:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5309303BE1A
	for <lists+linux-spi@lfdr.de>; Wed, 24 Dec 2025 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A031BC95;
	Wed, 24 Dec 2025 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FGeIx4tr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zu9UwZtx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850672BEFF6
	for <linux-spi@vger.kernel.org>; Wed, 24 Dec 2025 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766574171; cv=none; b=BiJtFpxsAMO5Rm+cGP5ONt42d6ERzytuHBQ0OS2LNddOkQCLNN9nsRpqgMn4fgY3pcB5vMLB/6HnAlJt8XUSTthAz4prHvKE5Tuwg/+ewjxIbtmQ4dT7EQwf2yf9LDySoWqAt2PtfP59Avhp62jZ51hd8lP1GQ+jmrLKSJF+TxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766574171; c=relaxed/simple;
	bh=5F218sm+qQlP7yHAxXEdqIQktKsUCmCKkzk516EMtsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3wYAppGktgeL0fRsTCzvDh93K7jqehQDA/yW4rH+j1azFECFGdxNPL7kpcP0zTBzOO2JbTM9Ih2pbpDfsfCPS5fXIQNxSy6j6kS7pmIS1IhqBj1scCoqzzCmv7Yx23zl8R2BJfnBaEl7yyaASfD6qyW3hSqyDcFvIAgFr80TEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FGeIx4tr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zu9UwZtx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO8O2NF721269
	for <linux-spi@vger.kernel.org>; Wed, 24 Dec 2025 11:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EH6GUmUWRcaq5q8EikEeCWHKOYBZsQKMpFR
	5Ltr9ssM=; b=FGeIx4triYWalfeEtmINRT1rteWQHlJnj2sTH/5PF/0095Cpj00
	j/BppdbURftTwAIhINQfyPGOPE4QgFlXAgHw/14jVjSzbXfXT8TLar9iotUwZ9mg
	9HfFq+crHEpN2RgWFbPEohcKwdzZMe1hQXjQuxMigexyPbFknzdIGVNRcMuaspYx
	9EVpZMrGRxJboCoknrE0X7m9NQJxKtLiaRjW5B4BXYyRTQXLMYRKGhKrqDKwjfIN
	UwLwkRJKo9fUd9zIaSYEjJizfhaj9QevfUXngulkprpxEc7SGY9wKtJV+3RDqEGm
	Fj4M5nJLKWV8BgaDuXrUggv1GUoxyEhLAmg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b81mta18s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 24 Dec 2025 11:02:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b234bae2a7so1376440985a.3
        for <linux-spi@vger.kernel.org>; Wed, 24 Dec 2025 03:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766574168; x=1767178968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EH6GUmUWRcaq5q8EikEeCWHKOYBZsQKMpFR5Ltr9ssM=;
        b=Zu9UwZtx4Oe0/CBaA5NEIT6QmP0eTm+TzmncNi2c1v4vYrjSxSkGLKmhZbBt8LDF9t
         dy1Ab4UVbGBEQ9NvMSFRzZAVGcLS3lqMmnfha25qGh8/O5uAJ6Ho1blzRhO/F2MFzMSg
         pJ0faYBIfo++bF2VVyoWwL5YwakfU7LsEAg2j/xF+/kAZd2+wCI+eLUo3uufs9Q+nUmV
         9kpTa4+u5jtZe0UOUkuHJmhswc86Bzq7J98arrqngaBpag2gYij8FVF0XKXneyFounTF
         QA9zMjPoc0r4zBBJeZj5rawZR1gNRy37kHyp8nYu338KlnOHU/6dUwAqLxYhQGNepRMB
         45sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766574168; x=1767178968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EH6GUmUWRcaq5q8EikEeCWHKOYBZsQKMpFR5Ltr9ssM=;
        b=ni6qInd+W/R+JTx1+THFR/hMDUiwfe/6VfOkiE/s4ix/yZnGDWxTSJtKTLJTAJzVJA
         qseyVzJ2wPdharsp/fkXyISiA/Rri0KdqdX6Ko+xnQSVKa79Q091oN4VmdjvXo9iYn3G
         vH0DkXV7ZzINXM1Njn6Ty2IlLrP9s72n8zdDmUNjmsE8xDRLYCCaBQWePB2w6ZTH/5wm
         XTuOmVvjbRlKeafPgrFYz2b/r86JDpA5EZqxOG8FuA+Wauk73qtRY1xW63EPvpdCbfdg
         LO3h72cUrHSWlWj7qpJnCimw93feCdXGJmytxRU1y3FPOwpzRWLPTICsMNRVurNif6cj
         93Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUFav8cEdlCpjUdwo0egrvoSDVEc4wSN4MccQqPwWAzrbUweBZQUQchAd/UPmFlgTFfX4E4or2BeyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw539VVUcD8AtkxwBHEEnYJbmm3l1wihGfUiDTF6xvvlXKwzKAg
	OCXCGc5kJQHXuP/8SpzRPlcMgOXD52yhzW5/is3znxSf5Zjqq+8b7G+imXTclcbwaMn3qxnFX6w
	0pR+0TfphZBe2reSNLdCaDdKBzRT42JFGCVn9WeujCxdUEclPhxGUwWCQhzpGd/o=
X-Gm-Gg: AY/fxX4498VLQ4uIVjYgMKhDxl/gehObXPeEo9Lfx6rI1w8LEfjsmYcQRUvL/I0jtvA
	QM4Lkj0pPbzDDHyPMwbHq8ZanSxvy87UAe8+6nUXC/GAWmNDd1+Jot9maTEZ1W09QzAu1KPJeRR
	/fyr5vNkRIq/7PTt7lJGa9Ca+6JiRSjBiEzuS6YZIAwey+isqxIchCg8y+kQXOpWlWsOC1OGdRT
	aDgQ+m17aDZntZBaDrUl/LWFP40H8u4kx9MknrB+1fx9rGYAxQe4F4RyvGqOIV1eY6uYxWl+uKx
	xXeceQZisotfq7wnqt2bA3XXYtsWIsaUrZAG8yUQ41ZGUWgqkoMlL3jdcRfrAldUQN9ywLt2skZ
	637HHjBrmnneZl5Tx/PfgHB0P0NUxJ9575EzeinUvIq4bdHlD8TT0S0NnbqWQcUPbfFIQmg==
X-Received: by 2002:a05:622a:989:b0:4f1:ca18:a750 with SMTP id d75a77b69052e-4f4abd1c3cemr270136941cf.29.1766574167757;
        Wed, 24 Dec 2025 03:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8Xl7c2+NqPcZ2kE2MrvqPAsBIRw5hqGBWusV+MNXY1cVenBK5QfqZBN38JJqb4J3rQyIV2Q==
X-Received: by 2002:a05:622a:989:b0:4f1:ca18:a750 with SMTP id d75a77b69052e-4f4abd1c3cemr270136481cf.29.1766574167314;
        Wed, 24 Dec 2025 03:02:47 -0800 (PST)
Received: from quoll.home (83.5.187.232.ipv4.supernova.orange.pl. [83.5.187.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53b21sm16487502a12.5.2025.12.24.03.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 03:02:46 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Eddie James <eajames@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] spi: fsi: Simplify with scoped for each OF child loop
Date: Wed, 24 Dec 2025 12:02:41 +0100
Message-ID: <20251224110240.56803-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=5F218sm+qQlP7yHAxXEdqIQktKsUCmCKkzk516EMtsk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpS8hQsSBacFCDVHbOQLmpN+DuBmLx7rdvJMzYI
 +/bx9PFHjaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUvIUAAKCRDBN2bmhouD
 1/RxD/9x7/ynkZkl4/FTKwfYgjScNv9QnkDLo9qCoO4nr9fJTgAc8fi5o0o5dyNgXSvWkQgPH5r
 s7FLhb5L9nx6A4BNeuluUjv1uM5M/lL4O5Fv0afr0+W7ArkfeQfiftMsf7YgubGYQ0IskveHPVA
 PkVawq6+DKmD2R+maEzp4hgHHPLY5IkOcILjegNEnGqoaJ4LLJ9DkQ+29LT7BWCuMoPmBbi0gRC
 wkPonRwSU6taPJhJqj1v/4O/EBRJfNEJQRprpmNJb3Jt2NKB7QsVvRT40l06V8CDgmuM18Tue7m
 UGBC+N/LqMyxzxTUskWk27rc9nJthnX1P/leqPSnhhmFzfOUj/+xyVH5IctmZjdMqyIV/EPBnr+
 EW0yje+uwOUCDCJ+YGKi0ApInDjlalk4FOJ18Lz48QJYIrkxVxOgxEhOszhY+e055hDNH/bzx17
 wRIA99I0X/jvt/q8EJXwL4EH0/QNxY2USZ2Khf8ej8eeiUjeqapyMzXUpqaS8t8o7yv9+iKT6HD
 qYua4GLpBtwZjRPfHDKLTnC39ZMHLf2BpcdRhfmEpAVS3+DoJ5KJlGjDw6p07qLUUKFwGa5pa76
 ysjNxHN0qQ5SJwyEltkud9aTCcj6Pf6acN3yZ6RbfrvWteTN/8/MNGQstTp8R3nQneCzj8TcWZx DtsOmO1UTEQUbUw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e/ILiKp/ c=1 sm=1 tr=0 ts=694bc858 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=urQ9wjG1USoGuMoDBEOPbA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=sOCyxprP-onh64r9Gm0A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: IOaFTyOxKZUZFgyzogks3IEo7EwUdeau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA5NSBTYWx0ZWRfX9S2ERy/AOPEJ
 RywQ0klmCOwA9UbhzmxaBPMww19d0nadK+F+/vFx9Y4fOJ1jxgoemWDv4HVVhPCe6dnKYWzGvtc
 hZ3/TdwXRxsz/SNXSl0dTHkDgFogTc1WKmjY0lzbcpNEE6gynbreaksgcTDPIbHTdriADp8LxcB
 gjAJbJi3tr7Vvo7dsKAaq33WrddoAHU/Y4Ze1z6sOpvzgDJG5lJF/zFjrlqjVB2x+M14aJ4AHtE
 uE8/INX/+uVaEmWuVPtDpsDUcs3NMHCwdDEWSKUcqmkEaU5lJYV0X6rrBoFHNSkWFlx6owsK3p8
 dWOMc728Jm2LKIqln2MqX/RVqFx/EeSeDnn3ebE6LShTOJ8DD5K7Oic2eNDGyuDBqu7EdD/H8YS
 YDjSeFRLRXD1HTeVlAQW71cJxlqazlTWbkx6qwwyD2aBk5SfCFzxXDEeELNbUUAGP7QU04Gnlbt
 PooTYJArzpSk0LFKKIQ==
X-Proofpoint-ORIG-GUID: IOaFTyOxKZUZFgyzogks3IEo7EwUdeau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512240095

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/spi/spi-fsi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index e01c63d23b64..68276d195917 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -531,7 +531,6 @@ static size_t fsi_spi_max_transfer_size(struct spi_device *spi)
 static int fsi_spi_probe(struct device *dev)
 {
 	int rc;
-	struct device_node *np;
 	int num_controllers_registered = 0;
 	struct fsi2spi *bridge;
 	struct fsi_device *fsi = to_fsi_dev(dev);
@@ -547,7 +546,7 @@ static int fsi_spi_probe(struct device *dev)
 	bridge->fsi = fsi;
 	mutex_init(&bridge->lock);
 
-	for_each_available_child_of_node(dev->of_node, np) {
+	for_each_available_child_of_node_scoped(dev->of_node, np) {
 		u32 base;
 		struct fsi_spi *ctx;
 		struct spi_controller *ctlr;
@@ -556,10 +555,8 @@ static int fsi_spi_probe(struct device *dev)
 			continue;
 
 		ctlr = spi_alloc_host(dev, sizeof(*ctx));
-		if (!ctlr) {
-			of_node_put(np);
+		if (!ctlr)
 			break;
-		}
 
 		ctlr->dev.of_node = np;
 		ctlr->num_chipselect = of_get_available_child_count(np) ?: 1;
-- 
2.51.0


