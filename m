Return-Path: <linux-spi+bounces-9594-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3620B3105A
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 09:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE90AC2ABD
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 07:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2332EA490;
	Fri, 22 Aug 2025 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JZTLG8Ud"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F232EA478
	for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847636; cv=none; b=CSKyJagcyRwltAHQ2JWj+AdmfsvYs4AATIQx98AZyg6A4Ujtp9PB5VbjyJ1CqgpDXDi92sWmlt6vaFZw6thoNcRrfmaFkxZDvPyxj8MLTCnO5aL8UsAGOKX85S705mTPqgrqIjRbjYQ6q5Z/DcIs35XdFW295J0aErbvnMpaSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847636; c=relaxed/simple;
	bh=zRF/SWKg7J8zSJMhgoR7B0BpUTYTZqskWOwFGNr7t0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmNMMvAUr1YTOF0GX9MWBiKR6aLLMwnA9eb6FcsRu4PB9uM1KXOtur7z0DpZA2xZKF0AxLcakjT10Pl89Qg294qrag07n9IqODu3hFa821TkVIZ7oZ8vCyl7ColoXAwTRxb3VKEpNTIR1NdFgAorGVyYp+GCXUUM9f4ssWBt4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JZTLG8Ud; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uQ00021384
	for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 07:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sLkMtTr2Bn5
	K4bQdcvBu5RXJWEJPuqmisraPjRoHi84=; b=JZTLG8UdvEGhrXgafJghaE6AEqz
	KW55gyrCFst3Dkb30kMhwcH2RTRQBMGwO0Q0CrIdytViNa+cqappP4w8mfH/g4gz
	OYsIHDJKMKlLpthKIAkopTa17fT73C3AhTYieIIOsUTbocIzF0aFN9Ivl03r2KDS
	ofUNn/USOsRMASyUIfFkMPssqSyiD6EpEvHNHisce3+0WYn71xvR3lsx5kqCxVER
	kzanZv7iwaX+SC4iJJwSgJfHIIFwMNhDqpVesbZ7izj/VdwnrTkYQzJ2acB/1TNC
	J7bDrHlWCMr2BohPQm092sV+aP3P8ILA7x/g/MPWeNNDSu2jNvC7azY8EnQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a89pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 07:27:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-324e349ef5fso2095732a91.3
        for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 00:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847633; x=1756452433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLkMtTr2Bn5K4bQdcvBu5RXJWEJPuqmisraPjRoHi84=;
        b=NWSZynMFZ4ROdxLTfhrVXUQwc3nsaU2Rhos0r1DD4WVIMx0dfCT9mmTwrByuPIWJti
         LOCqI6i5uXwPITiaBpbu/VBB6dZP2Bv9omGN3uR9SprlgBQMvc7QnvokxwVsO5BvbfEI
         5nABEvqiyh6TV1Q0FsEiGJgGjfVT/WyeLd+yeyx6wdfUKRk3CL6UTFgpDSYjHlg6PaD+
         wgGz04BuZVnfbeecpAzNgJT7kEpxx5mppRRgAEMxUB2nSQVcWYlVJ8wbJowypIVNhdu3
         673EGi3t5dW4ShPVg7t32Sp+Yiyn+w0h0AZN6GdtAf2iyUOZtONzgS8CHgjBVpE1l+I9
         PVPw==
X-Forwarded-Encrypted: i=1; AJvYcCUwF+exPnM6+9BbMkEZ3X+sIwwHv9yDFO2XiceIBq8P0mzVzptZZapCPZZ1Nv6nTN+yHyj0ttbTAng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFyNFZx9cIRHqemrrsbAO1kErVhxbUzP/pFJoS+m4m/zA6cIsp
	dDyaemdGNXQWzcvZG7SDzsl7GJ9X9eG6ry4GC1AlLeFHVFDqacxnT399A4L73XrKSy1xwrwaMrk
	cPVIztiRmWideHqjJbFVug80H8NnJ5NQjlaEel3jFbD8tU08rROpC3lVGZBdlbJc=
X-Gm-Gg: ASbGncv256cbEkemTJtS7zvppJlY7aBDsX8ygJgwgwC58QT2ue69ujYT/vbAaeyp/8f
	/0VNVh2uipiaSRLxfMOP3nGZgiEikPa2IObILz4GDB4I495ZSP25n9udY9bj61deOVECIfjPiWr
	j7ufrgsYnELvs4j5an/GcxBYxo8E8u2v5pL0Fyzf6CnpvF7fJxxNzfAuVYiGX7sTJwUI0d23bfD
	zvWJeIKmTPJHroY5qM7S+gspjHRCENLVNXPqaRL2CJfEJpQRagVLfxPR1zphaZExi+aYDOVnP4l
	Iz5Pr1TIx/jsh+iI2s143YS5FO76JnwhsFfNgyl15BQ92SmfeZ8K/VLrmeQgapAHF2A1LOIpGD7
	E
X-Received: by 2002:a17:90b:55c7:b0:321:1680:e056 with SMTP id 98e67ed59e1d1-32515e36b50mr2995190a91.9.1755847633541;
        Fri, 22 Aug 2025 00:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsnvfjM+sJnS56KF2zpncH91f2aO5DeQUnn9KXd7VBs1w3xVslfyycQjtQYddBs5i+aAOL0g==
X-Received: by 2002:a17:90b:55c7:b0:321:1680:e056 with SMTP id 98e67ed59e1d1-32515e36b50mr2995158a91.9.1755847632922;
        Fri, 22 Aug 2025 00:27:12 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe3047sm6416367a12.17.2025.08.22.00.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:27:12 -0700 (PDT)
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
Subject: [PATCH v6 2/6] soc: qcom: geni-se: Cleanup register defines and update copyright
Date: Fri, 22 Aug 2025 12:56:47 +0530
Message-Id: <20250822072651.510027-3-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822072651.510027-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250822072651.510027-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a81bd2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=cWaLTDLleWsxmrQceUoA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: mlTxwwff-TdOd4t43_FZDQIzavrBdhif
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX5Lz5cas7PIrE
 HouonEBDMh8lRjiBkhqJQ/bAKWeT+HQ+v+XAJPKVBzwo7rqa4mYi94rgZHZ9iXPkpUu2CXgf0Ja
 d6GEdawoqt6hHlZQqbq9gVKxZ1QT2lALBbIl9v7iRbbeGPfhC5Uo8TpLsz10DVpjzMT65ybRTFw
 Jsh1ZxHEb5iOnocD2EHVkWNHSMzqw1GvyDc57fpJD0KPafqLlf1XbGWT6yAO/3gAC/rB44NALgf
 TLvRSsTT89BQCVfUmBZdN4Z9TIZuuC79iEyCvc3nNLqvgATLrRxUMCpJLdIJMu9HOcgJT/GWl17
 9t6nALQeMKZXg1qbBj8tOH9iLpGRFop36bNlybfjCwg+cvduUMuZgaMP7Uiq/41bCmz1rHn0uWo
 V8OfkFgK2AbTYQ6uclQDsh+q+0OI9Q==
X-Proofpoint-GUID: mlTxwwff-TdOd4t43_FZDQIzavrBdhif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Refactor register macros for consistency and clarity and remove redundant
definitions and update naming for better alignment.
Update copyright to include Qualcomm Technologies, Inc.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 3c3b796333a6..e8ab2833815e 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+/*
+ *  Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
 
 /* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
 #define __DISABLE_TRACE_MMIO__
@@ -110,22 +113,20 @@ struct geni_se_desc {
 static const char * const icc_path_names[] = {"qup-core", "qup-config",
 						"qup-memory"};
 
-#define QUP_HW_VER_REG			0x4
+/* Common QUPV3 registers */
+#define QUPV3_HW_VER_REG		0x4
 
 /* Common SE registers */
-#define GENI_INIT_CFG_REVISION		0x0
-#define GENI_S_INIT_CFG_REVISION	0x4
-#define GENI_OUTPUT_CTRL		0x24
-#define GENI_CGC_CTRL			0x28
-#define GENI_CLK_CTRL_RO		0x60
-#define GENI_FW_S_REVISION_RO		0x6c
+#define SE_GENI_INIT_CFG_REVISION	0x0
+#define SE_GENI_S_INIT_CFG_REVISION	0x4
+#define SE_GENI_CGC_CTRL		0x28
+#define SE_GENI_CLK_CTRL_RO		0x60
+#define SE_GENI_FW_S_REVISION_RO	0x6c
 #define SE_GENI_BYTE_GRAN		0x254
 #define SE_GENI_TX_PACKING_CFG0		0x260
 #define SE_GENI_TX_PACKING_CFG1		0x264
 #define SE_GENI_RX_PACKING_CFG0		0x284
 #define SE_GENI_RX_PACKING_CFG1		0x288
-#define SE_GENI_M_GP_LENGTH		0x910
-#define SE_GENI_S_GP_LENGTH		0x914
 #define SE_DMA_TX_PTR_L			0xc30
 #define SE_DMA_TX_PTR_H			0xc34
 #define SE_DMA_TX_ATTR			0xc38
@@ -142,7 +143,6 @@ static const char * const icc_path_names[] = {"qup-core", "qup-config",
 #define SE_DMA_RX_IRQ_EN		0xd48
 #define SE_DMA_RX_IRQ_EN_SET		0xd4c
 #define SE_DMA_RX_IRQ_EN_CLR		0xd50
-#define SE_DMA_RX_LEN_IN		0xd54
 #define SE_DMA_RX_MAX_BURST		0xd5c
 #define SE_DMA_RX_FLUSH			0xd60
 #define SE_GSI_EVENT_EN			0xe18
@@ -179,7 +179,7 @@ static const char * const icc_path_names[] = {"qup-core", "qup-config",
 /* SE_DMA_GENERAL_CFG */
 #define DMA_RX_CLK_CGC_ON		BIT(0)
 #define DMA_TX_CLK_CGC_ON		BIT(1)
-#define DMA_AHB_SLV_CFG_ON		BIT(2)
+#define DMA_AHB_SLV_CLK_CGC_ON		BIT(2)
 #define AHB_SEC_SLV_CLK_CGC_ON		BIT(3)
 #define DUMMY_RX_NON_BUFFERABLE		BIT(4)
 #define RX_DMA_ZERO_PADDING_EN		BIT(5)
@@ -196,7 +196,7 @@ u32 geni_se_get_qup_hw_version(struct geni_se *se)
 {
 	struct geni_wrapper *wrapper = se->wrapper;
 
-	return readl_relaxed(wrapper->base + QUP_HW_VER_REG);
+	return readl_relaxed(wrapper->base + QUPV3_HW_VER_REG);
 }
 EXPORT_SYMBOL_GPL(geni_se_get_qup_hw_version);
 
@@ -220,12 +220,12 @@ static void geni_se_io_init(void __iomem *base)
 {
 	u32 val;
 
-	val = readl_relaxed(base + GENI_CGC_CTRL);
+	val = readl_relaxed(base + SE_GENI_CGC_CTRL);
 	val |= DEFAULT_CGC_EN;
-	writel_relaxed(val, base + GENI_CGC_CTRL);
+	writel_relaxed(val, base + SE_GENI_CGC_CTRL);
 
 	val = readl_relaxed(base + SE_DMA_GENERAL_CFG);
-	val |= AHB_SEC_SLV_CLK_CGC_ON | DMA_AHB_SLV_CFG_ON;
+	val |= AHB_SEC_SLV_CLK_CGC_ON | DMA_AHB_SLV_CLK_CGC_ON;
 	val |= DMA_TX_CLK_CGC_ON | DMA_RX_CLK_CGC_ON;
 	writel_relaxed(val, base + SE_DMA_GENERAL_CFG);
 
-- 
2.34.1


