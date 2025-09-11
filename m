Return-Path: <linux-spi+bounces-9975-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC5BB5279D
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 06:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6553E484136
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 04:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8523A994;
	Thu, 11 Sep 2025 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TG60qSEf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9A1E32B7
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 04:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565197; cv=none; b=GYhw6b1dWMqq5G1AgZNXnoFb9GYqkcV904ekZxNuJxLVDF1HI8fg9R1YDY2MzWFQhQ9bxrhc/9BK/lAhsFzRVy/yrtfCGwD3DHuC3vzXVzaZQzcpiYU1q1MCvtTQgs/nHb+GywDq/Y0vOniPBWuvYB1igYcjGiY9RsI1yMqOoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565197; c=relaxed/simple;
	bh=u7L/ieaGhg4FYoxkoZgFlr/WX/CxQuv2qx3g+1jNhws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GI4EWbYyaPjzVjKeoQC5NcQAnmv+QZ2keC1E2G9lmO/9CnnFe5eRsXl1iHiIzqR78YglOhSs6K5ZjarUlbwAE6Q0qYRsy9T0Pa1S3IVbdrJtr70eZxOBJ13qcko1GwUNX/BlGbj9BHASCADXJjo2FYg1PhOXbJvku1dH2ewTdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TG60qSEf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2Iufs015939
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 04:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DURBzBBWh6H
	a/g16FF3Bk+BqdvbZOIe8eGRq/1RrkqA=; b=TG60qSEfMGTnbcblhWQlKtVl3w2
	Zt863BcUs6nCudlRypR73atLy36H3MyvP56cOJDC+pO0cICzA1g7yI53aKhpM7JP
	gW0D1ijnB3zyXYMgcxqhVH6vq9ER+ez5uqvS6xPGLtR/+LWvLRYA32SiXS21ds3C
	06Ua0T1G1vmkVEYc6e0snyZ3SVi++9rFquwPMuknPD9Laj+l0SPjtzfK4jgRXpAQ
	wCPjrhL3X7/PrbnoB2VwaeU00y1dF1f5I0RYNcOOA3MFX8Fa9MzVHhgql0dPkgpL
	3KT9KQjX1Y1dsngulspklBL5q6Mr2n08HjEXeqmOxX5YViFx4fjgrFEnsGQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m652k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 04:33:15 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4f8e079bc1so275348a12.3
        for <linux-spi@vger.kernel.org>; Wed, 10 Sep 2025 21:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757565194; x=1758169994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DURBzBBWh6Ha/g16FF3Bk+BqdvbZOIe8eGRq/1RrkqA=;
        b=FcVGGwJjq1wCZqJa6c4f6SJeGwk1xDkQ/h68ygClK1Iz0hEsXxBJ/1NsxdP62+AYqI
         rIXpdaPvCB+XcFNgRGPvUamMVaNbo4VrxB7dfvzYv8m78DztzZmKy2Hy3DJou6XODoU0
         Qb4Z7BUGz5NzYgleYoOZO9dqSJprumtq534DV4Tv3ZxSeWjrV2P2wPhyFQMJc0DA2liv
         P2msbvAVVXUQhLpgH6QdzJApphjy58v85VCkE6ygvH9V0T3W6BWYLoLl6OEwpf+Zsuj3
         TGh51EiKz0T9LOIuxXn515bs/6a68cAboxxUnfLjy6zhVS9pbASoKaZezcohqzLdbmMO
         Bdkw==
X-Forwarded-Encrypted: i=1; AJvYcCW2xhOX8Vq0dthzVywdRFLNKc684KqZuHjFbmcBwbp569pG6bFMfn3JOftgpFS2UchBzlm1ulDzxIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpoO1KbNe/4yb0pf4fXwQpOZn5f1aFTEKSzt97Zz60roR1vWh
	SyJ2BuMTciFj7Q+lG2YW74LYYW5yVhwK2eu8QdMSJH/wlBEKCGg3yroeFr9k7lXyt/v70QvqNZH
	qY9hHKeNoSna3x5C8RGNlwo6hcLy/0A6TsMHUUG4EqWGpP91NY4t/OSyJiqBpA6c=
X-Gm-Gg: ASbGncugP+lOSuyfKrF15AAI0mOaZmEU4v8Tzu/GXnhv9hA5G/E37odG2rH0+pX1JJa
	oLY/nRVIz4mRyoD4Or7WRRxrJqAxJygvx70uUrLfwEyU0PH76MJlFprhacoeJr3SKFMyEoxvJyr
	PdO+TyX/ekQi9X7x6HuPnimAs5FQK9ce0EIvZeJnhim4kRVRPBn18qK1WVAbqhWMb0m2NcgdYQP
	G8D55/tLw1G+c1xAc6rZyhBPVk5MEDxA3DzibBoLLDz98dnUCRswx5Zyz39CMl61yXtf1SUF/E4
	3qEdMdCcgsMwf5Hc2+7L3GQs4mBgQBmXJL4qXeRQs/E+n4caexQjU1uwahp8dX5t9EMNXT0qRYP
	/
X-Received: by 2002:a17:903:1a30:b0:24e:2b3d:bb08 with SMTP id d9443c01a7336-2516fbdd4c2mr215944715ad.20.1757565194005;
        Wed, 10 Sep 2025 21:33:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtCrX3AKAjoCMmmGRU8ktHUd/jdfd6KhBt3qxvC7mXIES1EQNisq1Z7vaS59E64uyx449xpA==
X-Received: by 2002:a17:903:1a30:b0:24e:2b3d:bb08 with SMTP id d9443c01a7336-2516fbdd4c2mr215944275ad.20.1757565193511;
        Wed, 10 Sep 2025 21:33:13 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm4323975ad.91.2025.09.10.21.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:33:13 -0700 (PDT)
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
Subject: [PATCH v7 1/6] dt-bindings: qcom: se-common: Add QUP Peripheral-specific properties for I2C, SPI, and SERIAL bus
Date: Thu, 11 Sep 2025 10:02:51 +0530
Message-Id: <20250911043256.3523057-2-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX2DzOETO2iA7s
 r6mjKKNJraB5HW7BseQaEbJNs2p+cP+Lv6XPDEUX+T7uP5ZbHO6JZd2qKuHDAQTrvtge1Dn70vz
 GNvpvFFmm7vlIMNbsG/6KQlLcpEA6L+YagnXadCM3486WOtUZbR2IoMo1xghXfMAab/v2TYzmPB
 lByPyxAMrnSEC+O0MIL2/nW8dYtaPI2mhkNRFwsDflyQYoB6CDX7CaMvKUvnH1CG2ku749aJKhP
 kwcf5cPWvRdrnLATEmDPDcYsSIMKjJbDM5z/sc+TzqeRMf9QTqlRaEGHiK0DCILSzfMQqQ3qwrp
 Kfxo/JlmtPO4/qx+baU3Ubv1ESR5ntphOJI6H6HrZjTaFSuVYeckytTL+y+lIvgo7quHV+egfuD
 qP0ZwSm9
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c2510b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=M1Du_JTgEIh7wHf307cA:9
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: G0zF2TZ5yiuOUoQG8uGDuDh3rgm_x46K
X-Proofpoint-ORIG-GUID: G0zF2TZ5yiuOUoQG8uGDuDh3rgm_x46K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

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
v6 -> v7:

- No change.

v6 Link: https://lore.kernel.org/all/20250822072651.510027-2-viken.dadhaniya@oss.qualcomm.com/

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


