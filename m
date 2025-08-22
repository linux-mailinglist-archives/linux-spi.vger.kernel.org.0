Return-Path: <linux-spi+bounces-9593-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4824FB31057
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 09:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E27C6831B8
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 07:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EC62E88B5;
	Fri, 22 Aug 2025 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VrxRkAjY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81D2E9EAC
	for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847631; cv=none; b=p0OwWKHsN3RZ0HTO95A7ZO4yQQhbcfwe6aJDFh/E9g6NNSJBjHPjuK9enEctESMBUBqlOu5jcCPBc4k9OwClxKjsoVyRxtfozQMHv0o45kRZltuLJM4PlVAIwssLdxQgpwZV9R2eQFMK1T54Fq+nTYDwLdu4yL++SjPmxoqT9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847631; c=relaxed/simple;
	bh=CLvam64GpjkvK9z9EBex7fnXV+Xe1Yh5pbFJp8bR21M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNAhoWTwHoCekAIvr9y1gS8F0MwnrY9dMaBU/0febwrQm/Q89oieV94KCmEoQUz7v7D6N2VKQ4CmNhqtAdAc9OxkwGWo9G//1NnUIZzieruwpyJh0E+IedngzpJ6SgNyBY1h1XGnALhYhOUyFXFTlTnHy0fkFOQYJ6Jod2UDCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VrxRkAjY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uU5V027788
	for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 07:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CgYC/weqOyG
	d9M8cE9Fo8jaIsPKmSKrevJQt6OIFqZ8=; b=VrxRkAjYRFYtY1uJpVxGFOCV4i3
	Nf6fA4M3nksP5zGbPWmdbOLJ2Kj0EpKReni8pCtQCVnvyKxOj0OwBf3Paqw/6ovm
	XykPBouT9fRPG6nMwYgxFWdP9UhngEyVN/A6jbX7ltVZlruMGpLl+qlhi4rm5RZg
	U7/EYU9qmTPCSi0RNsRMD+Vh7ECVd5KcbfQjmS15uNW07d7SyBHLJQ0hg5LXHpRK
	AmlVSDjMGcv7vJ1CR7TqZHFYVv8DDoaP6A6Bb2Gbefyg5JxDRpu45bIYOVrXdSqG
	9Bv9Y950SzIhVuMf1ZEA/Ttc7emwUnmaWtyWYEBgfP7hhRDqmw61nwhg/Kw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52cr7q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 07:27:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-325017f25aaso1911141a91.2
        for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 00:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847628; x=1756452428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgYC/weqOyGd9M8cE9Fo8jaIsPKmSKrevJQt6OIFqZ8=;
        b=wpuxF8UusMNxNgHAXJcZvQVoFtksP1b3dLu2XWMK6q/MXMG0/jqMJbrGbZLq4Ev0aR
         P4BSp9cLdEBVzOLYKFu4OQ+sgpmDaqCf53v5sEPS8kdVuPyDdEAKz8gQhUEqEYAIUQ+n
         QgjzPTfYIAd2dmortF4PLw3sdy8tgsCJymv04LaNc2QADlP4m93fPS2IL0B88oI1OUwK
         9iNofsmTcXLzQDO11XDHgFMx82owRMEnpoTSDzdyaK3WRiFwAH7huG+f31R/QU1yuB4T
         yCMFDdHwS3H2bvse5251/xYOWBsIfREAm67eNfMjOjfxTmou7p9+PU29L38VYIiPTvkZ
         l0cA==
X-Forwarded-Encrypted: i=1; AJvYcCU7d/QvIaz4FFB6LAXK2LfwQ5WMVv6qHS+gt2SiQlupGN61PSdpeew/xsZ3gBcK2ZJkvSwqlm1zuM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyLRxitbxi5Gl3aVxifThbJuYzBuGsEimppWlQ+M/zGRRYZ5n
	xCtGDsjwjV9vYwi1NSMr8oo+XxhrMWb9RDebS+cxKL/1+QK6YnQ+2wSoYNZxizphtUyRJrOThvI
	yuWJM0QlHowuWbHrpoZPpu04l/3y8UPtgqv+jfFnY6PVzWCb6chg4aJSjZyG8YjA=
X-Gm-Gg: ASbGncvTXeXstTEOAAMacvStTJVlOCkbTpyaCp/voznehvr76Me8HfGWLIFvptBoXzB
	B8kD8m5FhUXyb1UzmJvnfe2pMuHr0Bub07NsS4if7WuPO5IJ3E0ByaOl28FiXpWPeJe1nKQBXfW
	EKhfbfaD9ez12ywkGFilCZyQqA/bgEJMbDtscw8YhnqmhOuFRh0egJJ0oRBnYtCnY1xUEkT9pG7
	ZLZqcbALUOWl8hRs8OSQ0w5BZIJ2AJJ2DPb48SJzBjeCeUc8gM9ME43m7GkdDVUAHInDsMftx4u
	JKS8yHTQ2d0rxNtpEyAATOga4emhD/0nd8rMOELrU4XF2QPRO/UIB5xnbcVswsk/6h8GtJUCaJz
	x
X-Received: by 2002:a17:90b:3b8d:b0:321:c4f9:e5b5 with SMTP id 98e67ed59e1d1-32515eda512mr2721211a91.28.1755847627824;
        Fri, 22 Aug 2025 00:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPXSm6bqwkB+lq/+CeeHKNmwDCs1TpmePhgenu74kzGX2ngcV6qC7lpHpf4+TyFgCMwrYB2w==
X-Received: by 2002:a17:90b:3b8d:b0:321:c4f9:e5b5 with SMTP id 98e67ed59e1d1-32515eda512mr2721181a91.28.1755847627235;
        Fri, 22 Aug 2025 00:27:07 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe3047sm6416367a12.17.2025.08.22.00.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:27:06 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, broonie@kernel.org,
        johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/6] dt-bindings: qcom: se-common: Add QUP Peripheral-specific properties for I2C, SPI, and SERIAL bus
Date: Fri, 22 Aug 2025 12:56:46 +0530
Message-Id: <20250822072651.510027-2-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-GUID: 6wd2DpPoPv0mEGsDSDEFuDvMgAr9hkWz
X-Proofpoint-ORIG-GUID: 6wd2DpPoPv0mEGsDSDEFuDvMgAr9hkWz
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a81bcc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=M1Du_JTgEIh7wHf307cA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxbBISC7W8uKK
 Gc4SPhf7txpz0ZOWXMv7cBP89oTHnNpm692VOzaIKTrAWVaizW9PR7fOz/F0BiiFi9q66ibasZ0
 KfG1YLn94zFd6jtw6ehGITfuHwxyelaH8r33l/3+IYSz5Rrzk0RIpM4QD8LMyTDxVj384EPp50n
 U+wU/sUL5v63gmyx+9LJo5Mc578vWBXu/z5FtzIUCEeF6sUwZZwEVo6V5MY0O00sD7l21GLjJPz
 gcW0wSOacvZ1uLM9Ar3MyFnQWmIRLdGQqsQTY9lZ8luHKdmv5n81jaaMkutIzTh6VZQngLBIMAL
 qfvA6+yA8cVOVDG6TcO/9TcM5kiJFLfZJGK6bKcik2LQ8Xbrg/YSTAjCFgTl1K392OvAgub0XFM
 3i3oQQ5rEI5XjLkOrnVP8mNWLdqmNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Introduce a new YAML schema for QUP-supported peripherals. Define common
properties used across QUP-supported peripherals.

Add property `qcom,enable-gsi-dma` to configure the Serial Engine (SE) for
QCOM GPI DMA mode.

Reference the common schema YAML in the GENI I2C, SPI, and SERIAL YAML
files.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
v5 -> v6:

- No change.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-2-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Add Reviewed-by tag.
- Update the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-2-quic_vdadhani@quicinc.com/

v3 -> v4:

- Update qcom,gsi-dma-allowed property name to qcom,enable-gsi-dma.
- Remove full stop form title.
- Add reference of common schema YAML in the I2C, SPI, and SERIAL YAML files.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-3-quic_vdadhani@quicinc.com/
---
---
 .../bindings/i2c/qcom,i2c-geni-qcom.yaml      |  1 +
 .../serial/qcom,serial-geni-qcom.yaml         |  1 +
 .../soc/qcom/qcom,se-common-props.yaml        | 26 +++++++++++++++++++
 .../bindings/spi/qcom,spi-geni-qcom.yaml      |  1 +
 4 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,se-common-props.yaml

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
index 9f66a3bb1f80..51534953a69c 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
@@ -75,6 +75,7 @@ required:
 
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml#
+  - $ref: /schemas/soc/qcom/qcom,se-common-props.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
index dd33794b3534..ed7b3909d87d 100644
--- a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
@@ -12,6 +12,7 @@ maintainers:
 
 allOf:
   - $ref: /schemas/serial/serial.yaml#
+  - $ref: /schemas/soc/qcom/qcom,se-common-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,se-common-props.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,se-common-props.yaml
new file mode 100644
index 000000000000..6a34f05a07e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,se-common-props.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,se-common-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QUP Peripheral-specific properties for I2C, SPI and SERIAL bus
+
+description:
+  The Generic Interface (GENI) based Qualcomm Universal Peripheral (QUP) is
+  a programmable module that supports a wide range of serial interfaces
+  such as UART, SPI, I2C, I3C, etc. This defines the common properties used
+  across QUP-supported peripherals.
+
+maintainers:
+  - Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
+  - Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
+
+properties:
+  qcom,enable-gsi-dma:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Configure the Serial Engine (SE) to transfer data in QCOM GPI DMA mode.
+      By default, FIFO mode (PIO/CPU DMA) will be selected.
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index 2e20ca313ec1..d12c5a060ed0 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -25,6 +25,7 @@ description:
 
 allOf:
   - $ref: /schemas/spi/spi-controller.yaml#
+  - $ref: /schemas/soc/qcom/qcom,se-common-props.yaml#
 
 properties:
   compatible:
-- 
2.34.1


