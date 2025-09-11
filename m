Return-Path: <linux-spi+bounces-9980-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A9CB527BC
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 06:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539441886678
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 04:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840AE25C6EE;
	Thu, 11 Sep 2025 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U/H6jqJN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185B241CB7
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565230; cv=none; b=cVMiRPYedi/5wgA2ueY/7sS+7WVtGqynhtA+NPRuKJ8DAo91J+OsoE5l9rLcxKDuq/eAwMADor1cp7IIZnAI5FE6OLDcaK4jOXXiuild2kBF6Q/SKkjOKRUAQ2C+qEpCqi+sUs7qx7GpxmQ2l4M/2IBDhqNY1klG9UsgQaf42JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565230; c=relaxed/simple;
	bh=mx4d1AM06bO2S1IONf8a/pO/zrCQyz3bPkPpHgejOOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBBCZsEkqBxPvYQrcdyS0Ra9xMdQCQUrKHhWBFn0fhOhCEPEcI1ETFztRbjlaiP01tNbgLKaZf6DNQ2pLsnA8+jWX8aCGcAGc+U3aWrU9EoUzG3XOJdGJAz9kGG4jOHnKh+XO2TYcJJU0kuvSGmgk1+z91Fc3vylyhxkzNqgI9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U/H6jqJN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2J8o2003399
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 04:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kcphrBZS8ap
	5SJ3Zmdf0DUuuF1sTIEHZQlGDR6UGNHQ=; b=U/H6jqJNTXVfBG/btaflFrby2c5
	7fuRKskqtI9rpIgBmNvsFCtvNfPhQ5mKFn0ba4eTLfDFaRuyh6Ao4AlNw5AZdP0E
	k3J1uF7NNnGizXcDrZ7q8c8t5j/7C2ySA54Ro6r2jnXz9JYMjFQrS6ORPmJC+w+U
	f8lK1Uzy0atFuwJ3TnptBSy1bgk8EvFkJeW3tN0oKxxR0Wm+0hOfz2oFpymQCU1p
	9rFjxieKXS44b5rmOjzYAgP2GbPpq2+gQV8hLzV2VxaQvIayZfVbnwvBiCLoCsUv
	Obz3BPq13zNqwh2GtYiuG6WlsyNc/RhmhMx08UXKcWiYBp+2ax0KjfUoQ5w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsedfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 04:33:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4e796ad413so524097a12.2
        for <linux-spi@vger.kernel.org>; Wed, 10 Sep 2025 21:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757565227; x=1758170027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcphrBZS8ap5SJ3Zmdf0DUuuF1sTIEHZQlGDR6UGNHQ=;
        b=wPDNEnUBkyRkBNzr8Mg/rpr2rirYt6MsUEyj6W6Qi8UBIKaCJMBaXntfchmt7Jjn0J
         E1blk39f84puyrJIASh5cTX0HdJL5tqO8sKmHTdAXdukzfCjB2ny90GMxBG4qBC+BZVP
         MAxK5QySuA7GDg9L5c6AcRzHClvW0PvalUyk3rbJAXFR2tI1n4hF7V3baXl6MVpIEQnu
         s2ZBDQcy53sb+8eYtbYT+w7Jj435oQs8iRCYHI+PzI6PR5m+EsImTnTxd4pgvfksGhyC
         T9NHjeCw72s18VGvepDs9t0mCDYa8H6OnbpzKJPRHdhu6yfAPnlexbVmR7JDhTFqPhDW
         jbSg==
X-Forwarded-Encrypted: i=1; AJvYcCVRiUPGEj6rcJ/CiWgTt1rrGqTYTh/a4GADJMs2AqXSXwPifiTZX/4H+4pv67xbtfGzNVp+qzRq/qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQTjFbAcH69rssJPa0O1Ragpfm1/HZUXkTVyhUdiHdKgB5CCFb
	OV1SyjnVcwW2pwx+aduE0dOe6JdoIqctlx21pyS7/hlCCZZ9JFvYiuyL1TGq9gLOYf6tlH78099
	b4BMsS4GA9oN3F1XYGUWtEfPDl5U+/q6IhHofFWHVhRvJ3362JnJ7sgIRJrF9Q5Y=
X-Gm-Gg: ASbGncuJJjEYRDJ1CElQNmd26z0t9XeRnVVudQzQ6Zx35pd3j8CfeEuWg17G1urOSjm
	NF2F8wBXBOXTToX0bCkiJtJoP/uZWnhGVGF5zVwbi36hP+N4TWDoJXHd/T/NLkUtZYT0C9rcs+e
	zGoL8vW0uqD6MvQ37yLwFGSFn0IgkHkdk0oYWnPeJyS3ty5XK1MU+EBpPm2qxmMtah5zq5IqnoC
	uOHfSf2TtS5j2CjDEZlPfum3mG2XwSjPsfVRLRmLfbE4u4G9WQuaDAqE9zyKNrgE4PTmIOFeaE+
	D3oFDTXNwtF9tVguKHgoRfYk6y1eVE4EdMgQoltB57UvyYlgAXmYMYPX/+/RwVRTKlwZ6bryPeb
	u
X-Received: by 2002:a17:902:db0d:b0:25c:2ed4:fd7f with SMTP id d9443c01a7336-25c2ed50044mr8373265ad.42.1757565227069;
        Wed, 10 Sep 2025 21:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJSDLFBIfEII/dWtZuLvluQE5OM8yus/jL1cVR398t46tsI0mtRTv1Sd8hk0JJ82ColwGboA==
X-Received: by 2002:a17:902:db0d:b0:25c:2ed4:fd7f with SMTP id d9443c01a7336-25c2ed50044mr8372875ad.42.1757565226545;
        Wed, 10 Sep 2025 21:33:46 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm4323975ad.91.2025.09.10.21.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:33:46 -0700 (PDT)
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
Subject: [PATCH v7 6/6] serial: qcom-geni: Load UART qup Firmware from linux side
Date: Thu, 11 Sep 2025 10:02:56 +0530
Message-Id: <20250911043256.3523057-7-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: vetWY6q_lzN_CA6vqGbfOgNF76bGUij7
X-Proofpoint-GUID: vetWY6q_lzN_CA6vqGbfOgNF76bGUij7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfXxGcKH8eGjIro
 6SkYZO5qzZe+dPPzkf7pBpNsvST7cSj2wMrQdF6lMx1ITbrTcI9jyeJQwnEeba9EC5s/4++KKkz
 6mKrbFFAT/ktVlDbRFcZcaJVM1+q+xVq+HnAJfTnm3rz7VaTOl7YoRwWWXzmtG7JwBhczX1YVeU
 0Vy1PwhraXbNFBih24IUtTwq8yJYlSfR5F34DO/yrVMVsPezoVvbBbmpkQghHnSc5DtzSv9SYBf
 FVPMuj7GXDKBy+TngNnuz8gxpoSl5d+ou23IWl2VyVxRMfjsuwWLlKhHmk0B3I0mAMsFIkNrpPh
 azRHrbJBwiWjcOG+lly6Wz80jR65ciL3AuBz6U3eOxtsTkhWpDbJSdtVddwcMTpC12jqmD06I1x
 YtnGPBgb
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c2512c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=9JGZuxy38fRfBSF6gCkA:9 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Add provision to load firmware of Serial engine for UART protocol from
Linux Execution Environment on running on APPS processor.

Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Dependencies:

This patch depends on patch 3 of this series.

v6 -> v7:

- No change.

v6 Link: https://lore.kernel.org/all/20250822072651.510027-7-viken.dadhaniya@oss.qualcomm.com/

v5 -> v6:

- No change.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-6-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Updated the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-6-quic_vdadhani@quicinc.com/

v3 -> v4:

- Add a patch dependency note.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-10-quic_vdadhani@quicinc.com/

v2 -> v3:

- Load firmware only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-arm-msm/20250124105309.295769-9-quic_vdadhani@quicinc.com/

v1 -> v2:

- No change.

v1 Link: https://lore.kernel.org/linux-arm-msm/20241204150326.1470749-8-quic_vdadhani@quicinc.com/
---
---
 drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 0fdda3a1e70b..ce5cb97d60a7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1184,7 +1184,13 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	int ret;
 
 	proto = geni_se_read_proto(&port->se);
-	if (proto != GENI_SE_UART) {
+	if (proto == GENI_SE_INVALID_PROTO) {
+		ret = geni_load_se_firmware(&port->se, GENI_SE_UART);
+		if (ret) {
+			dev_err(uport->dev, "UART firmware load failed ret: %d\n", ret);
+			return ret;
+		}
+	} else if (proto != GENI_SE_UART) {
 		dev_err(uport->dev, "Invalid FW loaded, proto: %d\n", proto);
 		return -ENXIO;
 	}
-- 
2.34.1


