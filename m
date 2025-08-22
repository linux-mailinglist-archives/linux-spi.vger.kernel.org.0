Return-Path: <linux-spi+bounces-9596-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 153D2B3106B
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 09:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2649B1CE486F
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D956B2EB5A6;
	Fri, 22 Aug 2025 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YXeN0NDY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3CB2EA74C
	for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847648; cv=none; b=lZFdqjgfcBpc9ORiXlBDgfJtMn6uB3pTtxEX4I06Azj5dwyJ7EJNKg14nDANQPKZxUmgrMU5Elb9olqN4EoQ9QfmPiKY54JuO+UfHpMYbyvxLfF8TPScA4iqfCntz8W+xQWZllyGvkbjrgczH+Wwz+NoPqBynzyZzM+91zsJBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847648; c=relaxed/simple;
	bh=2PNVuXq+ZYwaLuZ7rUo4rH3IJfNSTpQ7FJZqxFzNtv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eyu0kTlykQ4RrM/ZCROEasknRRWBVfnfkKrALxBqn1VygXSneJ6Vq+aFg10zaGXEOBIbKGS7f2EkfAYh7N0E4e9zgKt7SV9F24KVasfnDC2l9mb0/5/dSy/YlJYOjXAk++aSpxTy/k8WqEqmyOFjM/MbiJoD0G7TEArqHTG8Wr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YXeN0NDY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uRmt008405
	for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 07:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BrYCSYr4l+R
	GAx5Rr4vA8mbuZgqIc3xnPF8sQ/ZYbOc=; b=YXeN0NDY23TjYc6Osb4Xc1Snjgy
	cWTy4GYkEnPkHjchJKge2Sz0jG7nTeCOy70pMQrr9Xp5ngFMyoTOKKEqpNFMLrWU
	+Hh7gzzMZ1JJxEgsxzwyARvkSxpcb7Equ5PZUGYGhFJigEh9BKK+JNdbhG8GIFWd
	2LySOA+KYlrqq1aO3SUb+I3Nu8FsuB1BKSAi5+ZW+w1Y9G6Xcuu8kM+uFkbX0lQJ
	cqPRABd+ES97dCcMVTESy3/V5JtLtXUPI01lwRclIX/pxN2Ooe+SeryRSO+sVYI4
	oZg40WJ87TbQNk12k/FDljGYu1Kbx6b6dfXpmhsaULWMzyJS+K3AquXllGQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n529077p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 07:27:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so2122371b3a.3
        for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 00:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847645; x=1756452445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrYCSYr4l+RGAx5Rr4vA8mbuZgqIc3xnPF8sQ/ZYbOc=;
        b=diXLE9/1Z3ablywqK1WVH3V5xrXF7z3AyoyNQniY0qVuJ46qEa7H3K7kMtPQm3rpBc
         +Uv04ego5iPeWJW8voF7kT0lKSv3YTNQYaqFOUGpIFUEE5v2KC57cDWpLc1WGIFuZrWd
         Uqp+7lueh+n00J6wHE9+unrYOdThW0BC60I8g9nsBqLsUDbmPeVt1BWuYfS9hsr25aI4
         2R4FXjCqtLkf3MVcebBZkM9TaufF9ki1V05fOubXhg1mX3pH/ThfwXu0k/q6xfheqYst
         L+wKdr+vNso2P8nUu1EhpNnDqxYjSU3e+sK1YsynLbb5PmzUHHeqPMHFKLyyaFTU5iPk
         RSPg==
X-Forwarded-Encrypted: i=1; AJvYcCUjCp9uPP2FHFzJWcUQ1g9/8TmOkV/mqQM3mbHHApGx/hntiS2nuFwBXudo/+UVttqwgh7po/rK2l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1nyh9KmqC20x13SNXu26ZCNYxxAx52zPDvpgKAkJfjhnS/cB
	wt7Oq2skVWKdI6WkO9ZRyY1TRFjWSGyFNR+RFbrZnGDduQBbenQ78xs4u0LCszU++M8aM5ojVP6
	lbNGhfKvIdNUIdBNN8osVQfzOxI/C4+ICg/qng2iX20n9aM1Hh6VaVedXy/yiL18=
X-Gm-Gg: ASbGnctMa1fj5mLcv53wdI2O8g6S8mAy/uqdR5NCAgg8wT4cx1NJaWRfGKESewIZO34
	vjYDJ6zkS0jFYtsDtSGc2vFYZPCN7P3sus9Aj3W8qZZLWT5yu7OA0lSn/cq4rHXGTJjXNr6x/wC
	bLwSbm4092bBFvu4vryJvwlTvFekS+klWWjd/09Tp54qqPCZRGRLpKE907ev4Si/BHaMOdq/iiS
	cOEk6VpqTHR+8hzid+Kiop8X5Y+8NKl2pWeknWE7QFMv8SeS3FBuz0ymSCZk8laGvWr/VdTApsv
	xWpTGLDAxWlQJ/Ll8q8X1BBzawm4akvHsJiMa3++O+q2Y/PykpAROw7xfa/kfyWQa8CXi5nJZbe
	m
X-Received: by 2002:a05:6a20:6a06:b0:23d:7b87:2c88 with SMTP id adf61e73a8af0-24340b7c7dbmr2399227637.9.1755847644812;
        Fri, 22 Aug 2025 00:27:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGueuQAtbJyunfN/7SGGX9fsHuG9nFd0VIDf06IMkL0qz8ftPZLBXEwTTKRWnxH8rIeBR3Ihw==
X-Received: by 2002:a05:6a20:6a06:b0:23d:7b87:2c88 with SMTP id adf61e73a8af0-24340b7c7dbmr2399187637.9.1755847644346;
        Fri, 22 Aug 2025 00:27:24 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe3047sm6416367a12.17.2025.08.22.00.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:27:24 -0700 (PDT)
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
Subject: [PATCH v6 4/6] i2c: qcom-geni: Load i2c qup Firmware from linux side
Date: Fri, 22 Aug 2025 12:56:49 +0530
Message-Id: <20250822072651.510027-5-viken.dadhaniya@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a81bde cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=9JGZuxy38fRfBSF6gCkA:9 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _IRBgwFfOpB_roObGvKM6mX1PgT_iynu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX8wUENUJN/9oJ
 oeivPgZFYadGnpXczewK/nvEzub07hNlBumIy9gmUyGsoiRqd6/70682gLy4dpyHgDxv37RY+LR
 z9Fqspopm5L4pqy5JyQb06nBUExIl7r7oK3KFczwV0fQEwW0gmgaTTkOrje55qO+SuMNxGNHQ2J
 CyfNcnFiQlALeUYR9zJJ2g5zROQz/S/uV0LAttsUic+8BbNghYwKpS84PMcUVdVVZDIZP4H6uWR
 pA8JSO0/KKDpSv3GRwqHx6H1XBTIvvgV9EZQS7W8xWqlIgtiys9kiod2AjrBTNVzIMBZowk9EHA
 GrnTKOjFaxk9HT/Iod30gAKSW6RGSEf1mcME9m3YasNCgALXKD7r77xCNrG/oO/DSkB8+uQUJlW
 OZ6MLuoHciBO3QLtq2a7RV16Gh0bJw==
X-Proofpoint-ORIG-GUID: _IRBgwFfOpB_roObGvKM6mX1PgT_iynu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add provision to load firmware of Serial engine for I2C protocol from
Linux Execution Environment on running on APPS processor.

Acked-by: Andi Shyti <andi.shyti@kernel.org>
Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Dependencies:

This patch depends on patch 3 of this series.

v5 -> v6:

- Added Acked-by tag.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-4-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Updated the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-4-quic_vdadhani@quicinc.com/

v3 - >v4:

- Add a patch dependency note.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-8-quic_vdadhani@quicinc.com/

v2 -> v3:

- Load firmware only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-arm-msm/20250124105309.295769-7-quic_vdadhani@quicinc.com/

v1 -> v2:

- No change.

v1 Link: https://lore.kernel.org/linux-arm-msm/20241204150326.1470749-6-quic_vdadhani@quicinc.com/
---
---
 drivers/i2c/busses/i2c-qcom-geni.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index ff2289b52c84..95a577764d5c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -870,7 +870,13 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 	proto = geni_se_read_proto(&gi2c->se);
-	if (proto != GENI_SE_I2C) {
+	if (proto == GENI_SE_INVALID_PROTO) {
+		ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
+		if (ret) {
+			dev_err_probe(dev, ret, "i2c firmware load failed ret: %d\n", ret);
+			goto err_resources;
+		}
+	} else if (proto != GENI_SE_I2C) {
 		ret = dev_err_probe(dev, -ENXIO, "Invalid proto %d\n", proto);
 		goto err_resources;
 	}
-- 
2.34.1


