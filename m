Return-Path: <linux-spi+bounces-9979-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2A1B527B5
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 06:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05D84861E9
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 04:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC10258EFE;
	Thu, 11 Sep 2025 04:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oa0oKpGn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671D243367
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565224; cv=none; b=FYGDa5eH1+KQ+cw61dWiLsf8S6hZuzeoUVQdjyqIxYD3MLvCp4dxcowgRyrX5XxHNdy95lkWJdrzYNa+7+tOODGTAqzoR97rIjoAInEWhawtVhC9pnTmqFA+ebEk2Pxvf9rzRJCvTVET/7zMeA9fcSR0PnQ11j4JtTmOUjX0x7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565224; c=relaxed/simple;
	bh=xnmykQAcvyckgw0YxmPQiHFgobP+L6bZcjG7nwsTZ4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mt40PlfC0blIuhXRKRCN4DfYFOvkiK4SJSeHVTyontXgurwRIUAnLTf8GDkpBXRoJDtRGWKstosUckIff/sFewRLY/S7ndvHwpxBVSk8gDKrk/2ZotjysbaK1jxX8LH+VyZQ2bOFCw/UgH5uOC/MGo7Wk+WpbPxeNbCaatnmOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oa0oKpGn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IbmJ005468
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 04:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TMAgZU7buYT
	Kdw/GCsn25V+u3dQ6le/rA4xiN+RqdIk=; b=oa0oKpGnm9vX89tSlkKdzpEXM3E
	hyjU98B2SSu85jS+T0SgRLqZEeDm9X3iq0eI4N56fTtOq3fAY063usGWXh42njtZ
	fq8OSbj0E51bM+dFq1mhB3ILDIieDjJLYR+m2RjqEnJ3MEInBn0r7AbN6AXtwlIg
	MEyKCx8AgPfuvbGmSapbAtG+HNt1RtjsZpLB7tfPROGvER/EwnGrERiXYM1yB+UK
	JM3vD+iZQaKqa2rjMgraI4YyPuPmQS0k2dP9QIEAG0PYLW6hsCADk38/shHkjOj4
	l5zYZDZGhsluxXdDTgs3LNGM0nXMzgtFN75cnFoLE/6Hhz+jNf2uwyjVEUQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2a9uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 04:33:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24c99bd543aso5539285ad.3
        for <linux-spi@vger.kernel.org>; Wed, 10 Sep 2025 21:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757565220; x=1758170020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMAgZU7buYTKdw/GCsn25V+u3dQ6le/rA4xiN+RqdIk=;
        b=RmVd6l7mFq5IoguukMZ4ii3lJkErUkgCDmMMxaf1QA+j+cAV8/e5Mx5ip8ayHXuiDy
         4cdzA1HIAgQpyPYb33v6xTGOw2H2gTVGxpsg+HtnonhLraExXgx4u623BDspadr4+41g
         ArJsT0wyGJZzwFrs8rwe2ANB+5rs6CaklyIKF/ptsfqjAedV5Trmvuw3oyz929c56dr/
         Q6J50OLhIF+KCWAtCE+YtalN2rFSxFXQimmYF8nTS9zQd3icEPrqHBLwqUWAh6yqg6K9
         uE7xXK+k/Uqt81m2ho80aJYCoMw6qHL5i13C4tqB5jfsZVaHurS8ddRoITkgwTVct3UJ
         p34A==
X-Forwarded-Encrypted: i=1; AJvYcCVo2Lq5jJZHD37ePDGfXciA+adIE9gPcYFVS8jOEjxG1zygXylDcB5pfe5lpja59IHuFibFYBC4JYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtKJRCsK6YSe/4bJ0WgM6B83z10ZI9SCsYQVANH+/evFWUjQm
	Y09ClMC/6Ata3SGbkBhJiQZcuX2VBPU4ceW7ZmHgLzQ5jyTU+YUz1CyiNZL9VAaC9zzWtPcCULH
	pLaTThx4n4oV1pTJHOEYcLjfaAdkTufFyYU7CyjSVoAxRxt6koZPWAaCcw8uYSU0=
X-Gm-Gg: ASbGnculqP70TdguFN1NVP8fEwF5LN3YIZ8ID3DfVsQdkjy7EHIreGWEkXFHyh5FGKt
	FrACi6hQCq0PZsPOq0tQmIj41q4vnnmHIbq58kL+L23wqi3nKUCFEBNxr/QwPDvnbNbL4c+fkuR
	urTqiSGXDfhhhy/0bdD4umS3xwien18mq2Gkha9LqXF6Xbzm5bx7vWCGc3rc0NWV1jdMxsnCNuj
	wvYROF6FUEKz2ldlELeTEpuy+M9cApXrBPjoxLUeyg6DSeQr1Yp0+1jUXgkmJ8wUIECyMTJ16Bs
	rWwaR38jOSzJ0xthC54Q7X7wuCWPqNDffWkPnJf31eUhHmUqqsv4OYkUw6RInJ2H071YfCfZSga
	A
X-Received: by 2002:a17:902:e843:b0:24c:7f2f:d9e6 with SMTP id d9443c01a7336-2516d81a032mr222003895ad.10.1757565220547;
        Wed, 10 Sep 2025 21:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELSjPwhaKp6l0XXdzH3iIcNWUNMNNrVth7UkdZKu33009b6miMEtFPBuSlwEwOyhB4Px9PPA==
X-Received: by 2002:a17:902:e843:b0:24c:7f2f:d9e6 with SMTP id d9443c01a7336-2516d81a032mr222003575ad.10.1757565220099;
        Wed, 10 Sep 2025 21:33:40 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm4323975ad.91.2025.09.10.21.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:33:39 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, broonie@kernel.org,
        johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v7 5/6] spi: geni-qcom: Load spi qup Firmware from linux side
Date: Thu, 11 Sep 2025 10:02:55 +0530
Message-Id: <20250911043256.3523057-6-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c25126 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=zIdmu9zckVospZd7ahEA:9 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _3wk-UsXT2KeAp0tIRtIZ7JPc56qjmeZ
X-Proofpoint-GUID: _3wk-UsXT2KeAp0tIRtIZ7JPc56qjmeZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfXxxq31o9gjL9W
 2fIIRgGn5azIeFV7r5DPuVOgkgHGC4hBQwRouO4S4igVULeqHRhPKD+ZhVxC6sp6T/iq6Ok10f9
 yBbnIX/UUCcLMrt1RuPEZjN0p9NZ1WivjnpdsZpfor+Vfe8KoXtuC41EdEjhQncje5TTKOXUL0Y
 7QdWF58zdR5/KtK5tvL61BN1V0rqeFtZdhpMQ28xzekJJGurJbAMGEMTkJOlmoW4BhZbSIEbSsh
 m+4O5R/SONvv2P1hBqXmPj5UCzoqI+PTtvpihxk2BrPT4s1wlFSLIR7afte7YzNENyPIq3fxB8s
 Hhjnj5sgM/CYltOU9059vkhEsEdldAiSn60Vc6PYZEN7WdFhrehfrUIDUTC9nKFa6lRT7Tga86b
 zqGPgHk8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

Add provision to load firmware of Serial engine for SPI protocol from
Linux Execution Environment on running on APPS processor.

Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Dependencies:

This patch depends on patch 3 of this series.

v6 -> v7:

- No change.

v6 Link: https://lore.kernel.org/all/20250822072651.510027-6-viken.dadhaniya@oss.qualcomm.com/

v5 -> v6:

- No change.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-5-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Updated the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-5-quic_vdadhani@quicinc.com/

v3 -> v4:

- Add a patch dependency note.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-9-quic_vdadhani@quicinc.com/

v2 -> v3:

- Load firmware only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-arm-msm/20250124105309.295769-8-quic_vdadhani@quicinc.com/

v1 -> v2:

- No change.

v1 Link: https://lore.kernel.org/linux-arm-msm/20241204150326.1470749-7-quic_vdadhani@quicinc.com/
---
---
 drivers/spi/spi-geni-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 768d7482102a..a0d8d3425c6c 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -671,6 +671,12 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			goto out_pm;
 		}
 		spi_slv_setup(mas);
+	} else if (proto == GENI_SE_INVALID_PROTO) {
+		ret = geni_load_se_firmware(se, GENI_SE_SPI);
+		if (ret) {
+			dev_err(mas->dev, "spi master firmware load failed ret: %d\n", ret);
+			goto out_pm;
+		}
 	} else if (proto != GENI_SE_SPI) {
 		dev_err(mas->dev, "Invalid proto %d\n", proto);
 		goto out_pm;
-- 
2.34.1


