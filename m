Return-Path: <linux-spi+bounces-7027-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58088A4E280
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 16:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C33884DBA
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF9E209F33;
	Tue,  4 Mar 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bIi1zgf0"
X-Original-To: linux-spi@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA07207A27
	for <linux-spi@vger.kernel.org>; Tue,  4 Mar 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099992; cv=fail; b=dYzKjUDysIW7dVf6gt4GFWD77DLgmyWfa5YUrI4Ynz8ToCasvhpKGg3dlhnIuHhEaR1p8a9TcEQLiAakRhQULUXEnuequy2r3O9zrzbWvabFO2Yte0FBRlFx2vzIFXBh3x1x7iv3jNfxKlDG4b1Z4Af1lcsW7wOHZwdQsHBZ3Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099992; c=relaxed/simple;
	bh=1wWLqFg+ZyNjFPCGyIlupF+qKBORmMv346TSXZEK9lM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UsYEPca85dKRqlntlu5WfD0/IoiVu+2S+oYCC6KJxpsXqBL2YCNWFXj7EuFllyh6WV1+c8k/xb8f0G3tal8YFL3GlRk/SkTQ0TaL6pt8G4ubjsC4pTDPCQznVxxPYjFRAgwU+kjfTx9jxnuooVjM3w/4znN+c58gCYqjCWDVdf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bIi1zgf0 reason="signature verification failed"; arc=none smtp.client-ip=205.220.180.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 1B3CE40D0508
	for <linux-spi@vger.kernel.org>; Tue,  4 Mar 2025 17:53:09 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=quicinc.com header.i=@quicinc.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bIi1zgf0
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dsC3mVfzFxd4
	for <linux-spi@vger.kernel.org>; Tue,  4 Mar 2025 17:50:39 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9345442726; Tue,  4 Mar 2025 17:50:27 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bIi1zgf0
X-Envelope-From: <linux-kernel+bounces-541719-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bIi1zgf0
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 3808341F6A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:44:25 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id C3CA9305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:44:24 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC203AC499
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4A520F09F;
	Mon,  3 Mar 2025 12:44:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4520370D;
	Mon,  3 Mar 2025 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005842; cv=none; b=BfeV5lXJOkPebDbyCfbVwp58NAumw2u32k7Gdp49aXMPQvnjc8vk3YoA3RW4IM08+3hHRQABjNpuDSx2+UHx0Amxeq2Nkx9JD7SHHHa8fwxx6DXZueatMzdzu9ynrjj2IORBkFRyuYjHiZmkeF+k3058/3LZencVuxGENjAFFm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005842; c=relaxed/simple;
	bh=z0vKUUCdNa2rmQq2Z2iFgz2YDU2r+7vSZIUk6XA/E9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rMsK9+BH4r1iLWsIZ4nAPLNE6Q1DZRpzcpAUupzc9OZsoIVjyC31KNCZDwuvIsttRyEaekwoV4Ki+wfSy7CGTDBW6m6yHVWWp55vWGeZyvIeLek6JFX6tuw6G/Mc857BgEtDzP3tDcHv167SR3PcSwmd+XxYLjkxIpZeAcv0yzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bIi1zgf0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523AWrUY032012;
	Mon, 3 Mar 2025 12:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=MK0vw10NOYxKduj5K3PP71gYo/6Fn4XUgQa
	fNDnU340=; b=bIi1zgf0IKHuDffXqJe+BTNnjIpMa/oXpmZ6UFYmpbpCdVTQO6N
	0/7UuYEf48fTK5ILMVA6eYUgufadlKKzsSME2xSdNJVi57rPkxg8AQZQETI0cW/t
	tBoXYru+qcdKZenh41FWmA+Dau0mdm+qttww5hXG6Gdm1uk2KtRp0Qn3eEV08a2C
	NrgEqaV6e08w2+AIVPivVhgtcxRd2bMYwEdebTK3gsLU+46uVhHg/L9mvcttFjpI
	SPzh+ad2p/MtmYRRz6PUMNNCs0gZ168VfEBs+PmHHeIDlybywP9iWNSTmIEr9GOo
	Zr0gATLBJFAFrLNwQj2EYw/HZB238oQqA6w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t95vxvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 12:43:55 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 523Chqat015065;
	Mon, 3 Mar 2025 12:43:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 453uakx542-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 12:43:52 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 523Chqgu015058;
	Mon, 3 Mar 2025 12:43:52 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com ([10.213.97.252])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 523ChpGF015057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 12:43:52 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4047106)
	id 368F653B; Mon,  3 Mar 2025 18:13:51 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org,
        johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v3 0/9] Add support to load QUP SE firmware from
Date: Mon,  3 Mar 2025 18:13:40 +0530
Message-Id: <20250303124349.3474185-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: syYd2GGAT3Kb_houxUQJ1SvMwz4CEISA
X-Proofpoint-GUID: syYd2GGAT3Kb_houxUQJ1SvMwz4CEISA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030098
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dsC3mVfzFxd4
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704682.01501@S6VOHVo0wepBAVhTq2KwvQ
X-ITU-MailScanner-SpamCheck: not spam

In Qualcomm SoCs, firmware loading for Serial Engines (SE) in the QUP
hardware has traditionally been managed by TrustZone (TZ). This setup
handled Serial Engines(SE) assignments and access control permissions,
ensuring a high level of security but limiting flexibility and
accessibility.
=20
This limitation poses a significant challenge for developers who need mor=
e
flexibility to enable any protocol on any of the SEs within the QUP
hardware.
=20
To address this, we are introducing a change that opens the firmware
loading mechanism to the Linux environment. This enhancement increases
flexibility and allows for more streamlined and efficient management. We
can now handle SE assignments and access control permissions directly
within Linux, eliminating the dependency on TZ.
=20
We propose an alternative method for firmware loading and SE
ownership/transfer mode configuration based on device tree configuration.
This method does not rely on other execution environments, making it
accessible to all developers.
=20
For SEs used prior to the kernel, their firmware will be loaded by the
respective image drivers (e.g., Debug UART, Secure or trusted SE).
Additionally, the GSI firmware, which is common to all SEs per QUPV3 core=
,
will not be loaded by Linux driver but TZ only. At the kernel level, only
the SE protocol driver should load the respective protocol firmware.
---
v2 -> v3:

- Add a new YAML file for QUP peripheral-specific properties for I2C, SPI=
, and SERIAL buses.
- Drop the 'qcom,xfer-mode' property and add the 'qcom,gsi-dma-allowed' p=
roperty in protocol-specific YAML.
- Add a reference for the QUP peripheral shared YAML to protocol-specific=
 YAML.
- Enhance error handling and remove redundant if conditions in the qcom-g=
eni-se.c driver.
- Remove the ternary operator in the qup_fw_load function.
- Update function descriptions and use imperative mood in qcom-geni-se.c
- Load firmware during probe only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-kernel/20250124105309.295769-1-qui=
c_vdadhani@quicinc.com/=20
=20
v1 -> v2:

- Drop the qcom,load-firmware property.
- Remove the fixed firmware path.
- Add the 'firmware-name' property in the QUP common driver.
- Add logic to read the firmware path from the device tree.
- Resolve kernel test robot warnings.
- Update the 'qcom,xfer-mode' property description.

v1 Link: https://lore.kernel.org/linux-kernel/20241204150326.1470749-1-qu=
ic_vdadhani@quicinc.com/=20
---
Viken Dadhaniya (9):
  dt-bindings: qcom: geni-se: Add 'firmware-name' property for firmware
    loading
  dt-bindings: qcom: se-common: Add QUP Peripheral-specific properties
    for I2C, SPI, and SERIAL bus
  dt-bindings: i2c: qcom,i2c-geni: document qcom,gsi-dma-allowed
  spi: dt-bindings: document qcom,gsi-dma-allowed
  dt-bindings: serial: document qcom,gsi-dma-allowed
  soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux
    subsystem
  i2c: qcom-geni: Load i2c qup Firmware from linux side
  spi: geni-qcom: Load spi qup Firmware from linux side
  serial: qcom-geni: Load UART qup Firmware from linux side

 .../bindings/i2c/qcom,i2c-geni-qcom.yaml      |   3 +
 .../serial/qcom,serial-geni-qcom.yaml         |   3 +
 .../bindings/soc/qcom/qcom,geni-se.yaml       |   5 +
 .../soc/qcom/qcom,se-common-props.yaml        |  26 ++
 .../bindings/spi/qcom,spi-geni-qcom.yaml      |   3 +
 drivers/i2c/busses/i2c-qcom-geni.c            |   8 +-
 drivers/soc/qcom/qcom-geni-se.c               | 423 ++++++++++++++++++
 drivers/spi/spi-geni-qcom.c                   |   6 +
 drivers/tty/serial/qcom_geni_serial.c         |   8 +-
 include/linux/soc/qcom/geni-se.h              |  18 +
 include/linux/soc/qcom/qup-fw-load.h          | 179 ++++++++
 11 files changed, 680 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,se-co=
mmon-props.yaml
 create mode 100644 include/linux/soc/qcom/qup-fw-load.h

--=20
2.34.1



