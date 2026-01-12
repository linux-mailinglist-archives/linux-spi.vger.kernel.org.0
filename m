Return-Path: <linux-spi+bounces-12315-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E58D14DA9
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 20:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E00823028DB6
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 19:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ADF31327C;
	Mon, 12 Jan 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DfV5KPmf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KEJBYiBe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B08310630
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244524; cv=none; b=nNPqKr/B/SvF/aGcA0ZbastiFoKd6OhDTWokhntUrb+SbmqKAQMOYg8ZoKqIky+eXVV79fH+XoGhDS8gbXGDjQ6SvdIyNim3cqaEK8jQvoey/87Nsn1YWrT6431ZCvKXfP1ZDHVS4+wzaaR1sJijSOg6FR51RqYOseWmAjKUnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244524; c=relaxed/simple;
	bh=kDa5gdzwglMPiLY8p2wwH3rr+hVw3k9xuDm+4u6eoVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PaWIT+eYhPMsPQocreigBMvi8tfcwSNmpUWDok5mxRGY3yygupYYSZ7mQ4WPdkOKhmIdVPBn5NyONTiadR6E85RKk6ywNRwhNoo54iJlI6E4u5RxsmLv7V5r4GWlH94M3ml5EAPvW8PjG3EcfLeLIyD52x/oM/AVtnSA1aa5yoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DfV5KPmf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KEJBYiBe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CIfwbr2249974
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aLVUs8RtcG5
	zJUJL3atY+JbM0XEXRgp9E94lpJuF/R4=; b=DfV5KPmfYMqyiT8AZkrd2e8mmfZ
	gpuj6DlXIft3Y8IAXZpIz0lIDGxuEmJrahmGSioAlCp5A46qQFvV5rvkmzs9anpc
	kMfkx/UClDR4Tg8YBs/YICyCWme+B05zBKjTjTvJWnjBqIjUru7mSP6jxsETTMZ0
	1TR1fimLsq3uBeLcXI41sgG+FbUVh+PMgd7furSa8U9/hbllU0U8Z3JCIaUlyvhk
	XsAvRnehecoOw5AkVucZb3NTz9ymt66GKUtmMQHU7LXtsYcrJT9adXREJp///96o
	GsKqfkYG+rTLNnxDCbU3gvn0J65UCpn3oA9CtUUbkGhCQscblktYCgOTgzA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6fbr2f0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:02:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0c495fc7aso71363495ad.3
        for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768244521; x=1768849321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLVUs8RtcG5zJUJL3atY+JbM0XEXRgp9E94lpJuF/R4=;
        b=KEJBYiBeSpm6QcRNHrEqG7qxgW74YSTB4/aACtv+LeYLsM8pCWDOoo/llU0s6lqewC
         wxPZtFXSmbANQRqgQtQarfVgtyz1oKq67Ry9iFw/fgWP1i0L8ff0RScbZLESDiCb1b+W
         8AkEJNFQDyz6/N5hc7SKtixvCoziFODYYgij+KWWyKfsLLdNsMEFPR7pXwuJtpgIOPat
         U4Bl0QmH+NYTqjoiX1isOjQvN8+g6sNrKxw5FXCUMZEXkAwtf1i/pw2zKe8+zJ3EuoKl
         iLbv/x1lqtePUQTfQexuZbCLn19E5MzIlUFntJypUPd3XYQyCRoANXlvGVfHAbcLxQ0W
         Zgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768244521; x=1768849321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLVUs8RtcG5zJUJL3atY+JbM0XEXRgp9E94lpJuF/R4=;
        b=DT/swYZJM1yFkpy6pK1O2gAN30eGyqoyzaJAf5Bky5WUctIEcvSZcW+miJOy9WhkLA
         c+XweU4EkIrXO01C3mx6GWYjEMMjoRxmkavWZ/c54TAev3Nyb/OB685wGdIxps+cvWVm
         B2I9KPZ1SdVfQ7aDyZz+kqgOmFp2GqXsoklDWjCiroWbevARGLH3Le3g4CzUoscoTLvC
         saoUWwaMdJkB1PmzHBNOvw5HP3+G+OlMTl21AeOEYRk+26Yq/Y0ACx/Kp94uS/rYnp63
         KP0dwuZ6D/RPyL4OeiNOCUoJPafS5VRlsp7VxvH9O0LZps/zTNeSkHjRWoDGau3Vfz+J
         3TeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfravt9D/yv8kY2upPyU3uYIIveBNoqXFlYPAwca3NQraQsa56uIXq9IDuQW9tMVJJSoYQZpc2UsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2h/JeE1Roa3z+Y9MBPQfr2qErWARCUlfLyR7ELhe6J8I6TID
	ymjtyLn1sNovD5qWdklT7QpsRNsG0xLidQt4Br7A0ifHPVMeNdWIz3o5VY/iDQxWhUYyeu6HS9y
	9DsgbS2o/qMCNTldxOv5vvVJ1dhrg7SE2IKV0sTLGCC0TM7m6TnAPDfPAViow+fE=
X-Gm-Gg: AY/fxX5Wwsrl+mkRP2E40xMyHCJjEUQxVeV9kdX7JczxBJXTQST0poQdUQOWhfwgJhH
	9GdbhoVFIrJnHQaWK3NADaz5IPe8htJMIvdep6kiFMTdxSU3Rd3gqiepbkvPXe0FaBR/D+Rs6Qv
	NUkFS0GYHaZ+EEsICSQeNx9bMLiTrCUixLaAFf9jtaKy1MaFasq1ZTyAIhdqff3FVyBYrX5pIKv
	UNq5QiPkE/EcJsZ4zxyUoGFTRSr8SsAjEMY4uOAqlj5f7PGS1+aCDQwrKvbXdnz5/ymy6GKOOSp
	Co1fyG9jxcVrNwKzMAvUEHQ+7MMqnMGzqk8YvQ+1fopo8w+hdaoHd3QXSWKd4bMmntxuTeT6KiU
	5svxCGRKGU0VQzaLTPWLNPdMyIHOKwH2JxKVh1DXZHZw=
X-Received: by 2002:a17:903:2f89:b0:2a0:89b8:4686 with SMTP id d9443c01a7336-2a3ee4c0e8cmr158030635ad.46.1768244521308;
        Mon, 12 Jan 2026 11:02:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf6hADt7tppLQS5Q1tjaUNG9MMWiX1tIFBn8NgzXU6c4qcr/XwpH5W5RUFOvj6GRH0/C6sKQ==
X-Received: by 2002:a17:903:2f89:b0:2a0:89b8:4686 with SMTP id d9443c01a7336-2a3ee4c0e8cmr158030075ad.46.1768244520655;
        Mon, 12 Jan 2026 11:02:00 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8888sm180120595ad.76.2026.01.12.11.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:02:00 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org, dmitry.baryshkov@oss.qualcomm.com,
        andersson@kernel.org, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com
Subject: [PATCH v1 3/4] spi: qcom-geni: Use resources helper APIs in runtime PM functions
Date: Tue, 13 Jan 2026 00:31:33 +0530
Message-Id: <20260112190134.1526646-4-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112190134.1526646-1-praveen.talari@oss.qualcomm.com>
References: <20260112190134.1526646-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE1NyBTYWx0ZWRfXx6iLtA2EW2Cc
 YDZ+Y/vsYfNlSUXGjSocIRucd2PoghSpq05+sswu1oZjmsmXKgWeWTdBAB4H5/+DZcw+oGt6EZN
 ofLLP0QSmanGN1KWvCY5VU1cYWpN96NRnUiIzbCtc7lydPHdnbycQXQB51qxSM9Z2aVzusGUtAL
 09r2ZS9ScOdyu9Mx+0xHUPCvwF1+IAmWgQLvQJVLooDV3HdWK1X8zIy0bZSWc1/KFY+BAY1Sjzs
 tkfjjANxSUZoICtT4CGCNZfa5nuZ91uFXdRbQ4ZU3qpx7ndvWLtlyMZox7W8uY1owmliTf0MpxN
 x/SURMBUOlTUgdxei2uKW9d7cS518EAjnoyxJ78rOn8VZpUHbJVjBNY3thhG0YlbzsXLqg1b12V
 XxMIvlNzU5ONbxVYaLUsckKtd/xM5o19u7u6N3EEBmxyCd7IWSdfYVubuCNn0VNs6kX+UsbuGl7
 cbrq+W+4VP3EzpRofPQ==
X-Proofpoint-GUID: NIZnFNrS3SnaY15UKNtFGBydFy9RDA9h
X-Authority-Analysis: v=2.4 cv=ZrLg6t7G c=1 sm=1 tr=0 ts=6965452a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=i7xoKaWEWnc8ZE6DH4sA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: NIZnFNrS3SnaY15UKNtFGBydFy9RDA9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120157

To manage GENI serial engine resources during runtime power management,
drivers currently need to call functions for ICC, clock, and
SE resource operations in both suspend and resume paths, resulting in
code duplication across drivers.

The new geni_se_resources_activate() and geni_se_resources_deactivate()
helper APIs addresses this issue by providing a streamlined method to
enable or disable all resources based, thereby eliminating redundancy
across drivers.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 7d047ae9c874..bf2b3d88693c 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1096,33 +1096,16 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
-	int ret;
-
-	/* Drop the performance state vote */
-	dev_pm_opp_set_rate(dev, 0);
-
-	ret = geni_se_resources_off(&mas->se);
-	if (ret)
-		return ret;
 
-	return geni_icc_disable(&mas->se);
+	return geni_se_resources_deactivate(&mas->se);
 }
 
 static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
-	int ret;
-
-	ret = geni_icc_enable(&mas->se);
-	if (ret)
-		return ret;
-
-	ret = geni_se_resources_on(&mas->se);
-	if (ret)
-		return ret;
 
-	return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
+	return geni_se_resources_activate(&mas->se);
 }
 
 static int __maybe_unused spi_geni_suspend(struct device *dev)
-- 
2.34.1


