Return-Path: <linux-spi+bounces-11811-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7B4CABD55
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 03:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD015305D393
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 02:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1D12C21C7;
	Mon,  8 Dec 2025 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bFYKzZAI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kL5GidKa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3172C21DE
	for <linux-spi@vger.kernel.org>; Mon,  8 Dec 2025 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159722; cv=none; b=fcpM4Ru2Cw1LNutaEM2MTQ915XEz9uY6uBrupozpq14rLCycN7FG3S1mcwq2bWBriAEXMw6JUOLBR7muqQSScp2z+LQiFIRbTTtt8hjCniYcuEEg7NQP5nmr8zagepPxQWoUlr8gfIkYGeySmQLCBKp9CaC4l2/xStXn9UxkScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159722; c=relaxed/simple;
	bh=bYbtRNJ146aC3TMQ8IfFXUbxO5W12g8YSi8uv7SMoh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RaFZ7eUdAh3qZTXIbp+/Fxl67BO4UpHUu21u5MKbsF3NMxeu52Ej6h4N2KDicZlSJck4Qe+f66MpSAqMUso14knECdvOccfG++3zHsAeGPYY4sRq+xrXwuYlurI8D9mRWsAAuqtLxcX2GJc8b3TJ7q953JRzztzoEs2ixf6YpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bFYKzZAI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kL5GidKa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7MpBAI3416185
	for <linux-spi@vger.kernel.org>; Mon, 8 Dec 2025 02:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2CpbeJ+C4anMYVxEHfQh4qSBUe7MaqTj+bc
	fxqoQ/vY=; b=bFYKzZAII+9IPC9cDmTe3CL+5j1hBTMXnsFTVvvocwHERVZPzzE
	B7ut+SM49EogVJxmGHt7IJ74HMiWsQc0xCCyBQ9ZE8avP0iILPjCxhXEFWFwIk3K
	Ezm2RfCA9z0Q5WMZr+nc2i1zO7b58V9M7AErtpQUQ3p9wh9sDSyaKF6Cy8S7e0SB
	ri9+MxmeZLlwr+tsXLr6RRH/F/vC5welCyZqGMaPZ/yOPOxCBtiAc4ldCcOhcwwW
	1azyh4aUD6I72/Fo7IIjXtOKEVL9WJ0KCtXQTMHsKjhfAu69xDkKPRVlN/5D/ZOV
	MhEXDI6RfcMQRbirR9V2bHo8K1dplWQ4dyQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avcv837jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 08 Dec 2025 02:08:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-349a2f509acso2711627a91.1
        for <linux-spi@vger.kernel.org>; Sun, 07 Dec 2025 18:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765159718; x=1765764518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2CpbeJ+C4anMYVxEHfQh4qSBUe7MaqTj+bcfxqoQ/vY=;
        b=kL5GidKaw1FFxKfYN/Wbkg8NGfgLRHxtI6CTPeSEWXSvjXbvCz0aNWSJ6mya1pmg9N
         i1rI2sYKbNaWnij+BEnpPHPUEoJtZxUzLNUFhNC5RPr6MCdY6g8HyB8cFv28Mj/D7uJ8
         liPPeJYDYkqub9LGlK0L7inOZR+24+69un1brIgbtfSpdP0270rqJ2vpSr/l5FfCX6WS
         W6DfelNx2EEplm1snjQWqy3Nlw3RIZPp1eyoD/4v1uN5LX5PgTKS/6pz4rnSsEVMnw52
         lkR3+NXSRZElBlVwxMZhtfzZvldmGgyug1RnCI6EpHjLYmuNdCBT3CcGbnyzqvdGNdsV
         e2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159718; x=1765764518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CpbeJ+C4anMYVxEHfQh4qSBUe7MaqTj+bcfxqoQ/vY=;
        b=IRxw0m3ZCIchfZyAOZsvtuEx054CLvrm3H/zFqrr9LnKxoz5rJ6VqjKTwhLuZd/sUt
         pzvzky3Jo3BzY45bpmcp042//7nNWByoJ+lIl06Cs2uF8/WetQ9Y596ibLhXulnW2Hjv
         EbCm29Emu3TlixNmA+/d9hYFHTizzvAeUIt7lNqazOwch6YOocaYG2kka2aDsRDSqmd2
         PzQrL1uDP6Vap1qXF4JwmRmNNsfWzhPFAJeFW1OxLKP4gRrLe0E9yGnriR5OqmadPFyc
         uRDUesjGafEHp7e4zSWa3w/c+/BYTyXwAASq7M67jG/AfrFh/KvOTYABDWXOo6Eu1d0h
         X3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX5YZLjW+ApGdwP4htmRnydrCUF9EXLMJw+M3gZj2NvdBOsdu3XMZFxBdIi2f9wUI/XzPPFDzAHe7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPDA/NW3DTcH6zg+ykvNmXapv5JK9rZc3u8GMVAbxq/dkKz7R
	ZZdPJDwKDI8ZDvV6L7htOlP8z99Oun5I18uRZIKle1QiZ85zCpvmoeugEfaHssGR37esQuGBr2P
	WOiQcyDw2ER5lQzOB7cxoWeu8MbjgrJe9b9U49AfArNCcy+i+dVLBgawll4Gu2hs=
X-Gm-Gg: ASbGncvXw3IaAJfZdLqsiIYGDaiz9b6Vnxq7rsnB9BmTBIMnTKKC0rG1gjEzNtH8ThM
	Q1Jmq+0zYGSUyjhdwe6MAjxO+1F18/CoYXi65lEA3iTSRsBTj0ohfu200ehr2SeaeyZCKp2LGDE
	3zcjgoc/b4K2ZJLjgOpvz/+dOP+xd2ysEKjUEv/h/bv5Q2FRKa7PbvdRr8sTEqRREVl9Q+YhCZX
	2fl0UJXNnkG4Y0k+wkcKTZD9P/K3BmrOqqhraT1URs2eYeX5n+erJ+i66cgwGb5cDhksbvbNVpU
	r49zp7mBcugb0hPgZWq19HKD916CfZcHtgNyoUzZUc7iWZte48DujzRZ3AJdYxWRa6ECL/Up25y
	XDHLGhI/0rOS2sdb+eVeJRJpsk7Ths09z0+o+ZhsnS+V/64ERqVXffmqE
X-Received: by 2002:a17:90b:224c:b0:341:8c15:959e with SMTP id 98e67ed59e1d1-349a2599aedmr5351025a91.17.1765159718109;
        Sun, 07 Dec 2025 18:08:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZG8yf/Ns1EegSTFE0Rpw5twCPlKcZgHeZqg7GH4TQfQZXerKNzs/OlugiBcRykEiG2Lkmng==
X-Received: by 2002:a17:90b:224c:b0:341:8c15:959e with SMTP id 98e67ed59e1d1-349a2599aedmr5350993a91.17.1765159717551;
        Sun, 07 Dec 2025 18:08:37 -0800 (PST)
Received: from quoll (fs98a57d9d.tkyc007.ap.nuro.jp. [152.165.125.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cfcfasm104991325ad.41.2025.12.07.18.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:08:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>,
        virtualization@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] spi: virtio: Fix confusing cleanup.h syntax
Date: Mon,  8 Dec 2025 03:08:31 +0100
Message-ID: <20251208020830.5225-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=bYbtRNJ146aC3TMQ8IfFXUbxO5W12g8YSi8uv7SMoh8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpNjMe0DvQW5czVU9hlSRb6igUPfFufx99kUMHy
 zulbG8OXYCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaTYzHgAKCRDBN2bmhouD
 15AED/sGzg5QlPKWdXtKqMXjKN8gqP5QezAXVEFPO/7jfwTrbHUhGjN1jV9Q9DZxUCUMFbN604D
 ZWGlEzAzP2zBLLdv3cx4gZZbSZGGr3V12/2cst/Gj/s3WEpRkaQZeRLmeNCaqb5TZtoytwn24Is
 10hkKayTWO0z4lmmPGutLSess7wBB6iEMs8bnKZKrJPq4DN+LU0SyOHlqdtTXAXTghoyd0YKgiZ
 RtXtTIOGbsaAUDpw8lFA56EaExiEPWxIntBkG14EQISPOApqlArLYTigF6ivD6x8OmaA1N6Zfx9
 YUDr0uH41XMq4GShO9fZ9q+8uAFmBzXjJGdFJjO2Pz0AXZ3BCGwZksHt2vb8pBc8BrBf6KEMSgR
 ujzIORfuXgqOoPAnQVzyz9rvqMo638Q5VNEdv9uzhjRA4vbiHdX05iq4mOjHAeB0pABTDx/Y7i+
 gHkny3X0/Vo6OqwzPNdB4eumQ27dwbcbYhIlUCFO53TMsbOpZUrtb9e7aeEnOB1SjNzvkbqKJnj
 //B7JxcyqaUD91jSmCTDE3Daa54VnH0NRUjEWM6jexeWYHIrQ/jAUlpKUgbZTi10ze4KLZscXE5
 UkmNS0rNAHywTgPm7j3L5L6NJJozACXaalQQw1VqNWRGpyo3IAa5IHYA7hOVm8V2m0+7Vvcubxp gVxAh8a/px1ySxQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SxXGUo6_OnWpDBO4q6Utmapt5V23cg0I
X-Authority-Analysis: v=2.4 cv=KL9XzVFo c=1 sm=1 tr=0 ts=69363327 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=vTE1kzb4AqIx7XBf0Bkr0A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=5GyS9ht9Ox2oK99QZPgA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDAxNiBTYWx0ZWRfX7Mjy0cOP90b4
 aIj0lPXUc1MgMdEFBpcEa+F2e3nW9qEyHiGeJ4/iAYQz+Cnl0QbJzzrzcde5vjcr3xYP8pc9wvn
 kVlWcTv8K0+FMql7cs7jy0vGP1jYx2e7hnYyeIp7P718XsfGPay6C6lWQ+2X6tRS/kmSQFLGkom
 7wYV+Rem6EaoIwYLHATs6mTQcdXnZAczXKadbL0JHKj99cwOoyn8/UOgEla4yloWYGGRYCiWcph
 OSrsCzL54Z3ifs/YYn+Y1HP3J1KSEk0GsLGKDte+i+oVw29ioBfWevQxeeRUB9IAEdhPChE/JSH
 FKJILKoYOIZhkaKVYhEut+GVokZ2qJLJ2FxZa6/TXdoF3WwkwubMpAn37+8ldy3AtsN0aOsPz+K
 Wt3QjYz8raprRJFUgo3KjkLwWgYw0w==
X-Proofpoint-GUID: SxXGUo6_OnWpDBO4q6Utmapt5V23cg0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080016

Initializing automatic __free variables to NULL without need (e.g.
branches with different allocations), followed by actual allocation is
in contrary to explicit coding rules guiding cleanup.h:

"Given that the "__free(...) = NULL" pattern for variables defined at
the top of the function poses this potential interdependency problem the
recommendation is to always define and assign variables in one statement
and not group variable definitions at the top of the function when
__free() is used."

Code does not have a bug, but is less readable and uses discouraged
coding practice, so fix that by moving declaration to the place of
assignment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/spi/spi-virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index 2acb929b2c69..6aad9f1fd016 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -150,7 +150,6 @@ static int virtio_spi_transfer_one(struct spi_controller *ctrl,
 				   struct spi_transfer *xfer)
 {
 	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
-	struct virtio_spi_req *spi_req __free(kfree) = NULL;
 	struct spi_transfer_head *th;
 	struct scatterlist sg_out_head, sg_out_payload;
 	struct scatterlist sg_in_result, sg_in_payload;
@@ -159,7 +158,8 @@ static int virtio_spi_transfer_one(struct spi_controller *ctrl,
 	unsigned int incnt = 0;
 	int ret;
 
-	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
+	struct virtio_spi_req *spi_req __free(kfree) = kzalloc(sizeof(*spi_req),
+							       GFP_KERNEL);
 	if (!spi_req)
 		return -ENOMEM;
 
-- 
2.51.0


