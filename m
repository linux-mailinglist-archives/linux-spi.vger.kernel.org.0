Return-Path: <linux-spi+bounces-12314-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE4D14D9D
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 20:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B9D430B602C
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81CD311C22;
	Mon, 12 Jan 2026 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j8xAR0Kn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gghVYMfC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA28313271
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244523; cv=none; b=cpX/yGSYR5w7Stsbh0bk9PJ7+55W38Nacm1ttsaUDDn8DB7LaGVJeSWStPu0PtobHKYloYVO/ZDmzcm0Hl7Q/efYgKxft1Bi6aiARJTFsOPoHVrrxwBPaI+0oX8C111+UXh6dRUugCaq8lXKttiFdE8uINui3fH/Yz9DDQT2gCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244523; c=relaxed/simple;
	bh=pfeLOwuV5tNEGHquY+BElAmY8n4IFgbScPUapFuaNyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xvy6SE6yZ3N4fky9bvnW7CAExBdpavqA/JU3FIOghgkKKQDhx0JHXaQBFGrGXO/DXvDjy6v/nNhMXE9HHDgjrsQg+AKI4i1qm1LktaXODgXOHkRQ4EB3de2b1fi3YTWcOXnXhvsfzc7a6+Kt/5tiz7Zu2QQ67iHYV+zrlEdCBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j8xAR0Kn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gghVYMfC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CHfSRh2371925
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uPDjxnyIvH6
	EuQa8qYzLtg8+o6G0UI+SqbdnqVH1a/A=; b=j8xAR0KnlQbuR+kAFXJJdgxvQLO
	3xF97ZVby5/Ki1VwyrZHjp/WnNNShU43ykYNqQJ233v9LzzoF8spllzL3PAJYHfX
	Wn9W84LmWOJYM8LyDW84AlsUUyTg3RKmicxzmI0k6nLGHkN0F8vE0OG2a5z97twT
	DsQpUmxMpnfu08WD2SyNln/jr9Y6hnu1YatpWzb7Qp6tftGTIpFtR63Kbz6Jow+k
	a04UA+cvGXKyJLl8GDODLS5kjn8KbW3JlldRpUGVOHSd4XMCLKta4nMZt+JbYc5u
	i5MP4W2MaZ3vIvz80690mlxsOodqpXQ/Y7ik4HNs0LlOhQRpEBkZzCJxyLA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bmxwv1msr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:01:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f8e6a5de4so67738945ad.2
        for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768244516; x=1768849316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPDjxnyIvH6EuQa8qYzLtg8+o6G0UI+SqbdnqVH1a/A=;
        b=gghVYMfCDqQPRz69+S7Gx24q9WkkfyFowlpccMKo8Ctn/uC2OLfiP9dC6jklj62rsL
         oBB7hdNlkpWg/8RoMhrP8n3UifK6LludSJQac9KjprMvuWRn0oLEuguADAyn75qneKwz
         S/J7M8jrCna8MULs2dzixHZkGFIibqQwU6dx1dN+O73AQrvZCMZmVESUUDyVvMvO0WE1
         YSON6WCK/LBqmPst9yqS1Xc4FVTP6TkgOqENRHw74YMguSsF3R6CW2neuyyD7R5LbXjS
         lCN2rpBaVdSRaXM2u+DZJCk0t0b5zyqwJaM49qEmprtb8SHKCkUUBucMLAe9t+qTpcq1
         CGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768244516; x=1768849316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPDjxnyIvH6EuQa8qYzLtg8+o6G0UI+SqbdnqVH1a/A=;
        b=c+nWUa0KkKj2ld53EldnQ98lWq4WgF2nL0sEvRTNjXAMAOm8aevGgb2J98Bu8DWMpE
         q9gkqib5Ou+ZkmaMzKtPqfR12OkVGr25Uhqh0bNrCacP82k95cSBoVls3L4BZyLXFo3G
         4Kow38e0mBJAU5p7NCl5U54+ERRaFDxX4BAbj0hO7IvF6xkJjrF3aOY0F8++UhKYkAUu
         3z6z5NbklIuvptCwlVkJG+1bNaxmXNAtxEphsJ398mMnwbVRo8DpC/s5rMizh7WlB3Hd
         BkS0esIin8MEPRML+hftY4HCatn9tBM6ocRGBeuoRFDKTOUw8vujbP1qtB7wf9FG7Nbr
         UU1w==
X-Forwarded-Encrypted: i=1; AJvYcCVIO56vhDjSVxK+271fHBTYpSPbbqaWH5K+id7W/VQKU5S+JlTNecDgu+C81iZ9fsDWjPOHqHK3Ano=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQ3QoA0F66f1KVL7Sqgn++ryT0fSkolkQrcnCqQOcnk688xbH
	VIC2uu5tRtr1IvunTbEl8E1teaGow697vp97jmpRUASzC3ic7+3RHOOmV/EqTn4e7G9v9UOv8uK
	F3Dg8m+JnoLDwCSE0vaDMRlpHKDk9LZPUYe16bWxXdjVna/wfkdbqF056pITvj9g=
X-Gm-Gg: AY/fxX4khI1TDCBiSNV9KF2oLBYIjt6JGTpw8rVcWWi8SdysiJlNMkcJ21PHtF3i6ji
	ChSvpDqE5PYQ0f38QGf/QA9jvjDwr0cmbjx2PMhxI6fMF+70yXOlwflx/XrXOs5V5lOwatEgzMv
	Fmsndhd33occLqzMjQf7NWZclGA/iXmFYC9b4z3TbnFlZVySg/XY14qmKklkMKYEJ1Wu97dGOIB
	mU27y8pPUEaeNBGxZTp2b/z5fSOKtdqS7HOblskBMdjCA4NzuxQDv09Qa2P0hhigAomv5pJz+mh
	aElGAyqtE6OtqqCbdSNH0LC20MQjuFIEOPhkTcrNcjWEUkeDEFYuxx8opqTHtMcHZx+6Qb28DA8
	EMxiDmz5KZXLanT1WedE9Cw4cztYY9kkMAWMiIAGIWAQ=
X-Received: by 2002:a17:903:37c3:b0:29f:2734:6ffb with SMTP id d9443c01a7336-2a3ee434de2mr165519785ad.22.1768244515454;
        Mon, 12 Jan 2026 11:01:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwEXg2WbEK0kcjSo9QlXVzcQp789a1loIB7VqV7j6g3wpJFM++BTLFba+1EthzjPpfOZoS3Q==
X-Received: by 2002:a17:903:37c3:b0:29f:2734:6ffb with SMTP id d9443c01a7336-2a3ee434de2mr165519135ad.22.1768244514744;
        Mon, 12 Jan 2026 11:01:54 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8888sm180120595ad.76.2026.01.12.11.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:01:54 -0800 (PST)
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
        chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH v1 2/4] spi: qcom-geni: Use geni_se_resources_init() for resource initialization
Date: Tue, 13 Jan 2026 00:31:32 +0530
Message-Id: <20260112190134.1526646-3-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-GUID: Am0nIxKNeAytEaNyJDWnHGRynKhkjrtG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE1NyBTYWx0ZWRfXwxLMBmHxOTvx
 9LF6bewcZMwCuKZjA/0tELA+V9UoNV75sc8elc9p8CqUWTJZ+IhxRPgbNF0vToo+ZunA4WYEYWs
 QJyz+QdZDvmRdkohsR2CBc8GZH+WXmGm1l8WXTrcvXk73r+vocBr6MI2eax4PjMN73dLA9K82AY
 tQLwoGa0Im9pp25YsUd5vMjIEhMrqa1+7T+s8OrRoC7iewqRz7m3TtGJhQ/ogkzaxT9gwgKY9vy
 zXnTvXDrquC7JIJE5AsngzcvvwdFN8pVu7yiXGWZdjMjsrs0I4+sLqjX7hror6cjns5PsJenBhM
 ICKmlAInxTIL6nMN/jxDfwtysT96RSm9irQ9EHJuKz4a8SawA+PMqthiAaKVC4KvwNqYI5NuE3Q
 34Q401rKTuZkLGFTvCYDXwuPmBehU9DUThkhWcuHsU11DlL2xs0egIWK032/GhOb3NLbEI89V3y
 yKQkiYlcygyBzbGI9zw==
X-Proofpoint-ORIG-GUID: Am0nIxKNeAytEaNyJDWnHGRynKhkjrtG
X-Authority-Analysis: v=2.4 cv=C/XkCAP+ c=1 sm=1 tr=0 ts=69654524 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=TXo2QnZ9t29hVJcr6pMA:9 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120157

From: Praveen Talari <quic_ptalari@quicinc.com>

Replace resources initialization such as clocks, ICC path and OPP with the
common geni_se_resources_init() function to avoid code duplication across
all drivers.

The geni_se_resources_init() function handles all these resources
internally, reducing code duplication and ensuring consistent resource
management across GENI SE drivers.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
 drivers/spi/spi-geni-qcom.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 5cca356cb673..7d047ae9c874 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1014,7 +1014,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	struct spi_controller *spi;
 	struct spi_geni_master *mas;
 	void __iomem *base;
-	struct clk *clk;
 	struct device *dev = &pdev->dev;
 
 	irq = platform_get_irq(pdev, 0);
@@ -1029,10 +1028,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(dev, "se");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
 	spi = devm_spi_alloc_host(dev, sizeof(*mas));
 	if (!spi)
 		return -ENOMEM;
@@ -1044,17 +1039,10 @@ static int spi_geni_probe(struct platform_device *pdev)
 	mas->se.dev = dev;
 	mas->se.wrapper = dev_get_drvdata(dev->parent);
 	mas->se.base = base;
-	mas->se.clk = clk;
 
-	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	ret = geni_se_resources_init(&mas->se);
 	if (ret)
 		return ret;
-	/* OPP table is optional */
-	ret = devm_pm_opp_of_add_table(&pdev->dev);
-	if (ret && ret != -ENODEV) {
-		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
-		return ret;
-	}
 
 	spi->bus_num = -1;
 	spi->dev.of_node = dev->of_node;
@@ -1078,10 +1066,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	init_completion(&mas->rx_reset_done);
 	spin_lock_init(&mas->lock);
 
-	ret = geni_icc_get(&mas->se, NULL);
-	if (ret)
-		return ret;
-
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
 	ret = devm_pm_runtime_enable(dev);
@@ -1091,14 +1075,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (device_property_read_bool(&pdev->dev, "spi-slave"))
 		spi->target = true;
 
-	/* Set the bus quota to a reasonable value for register access */
-	mas->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
-	mas->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
-
-	ret = geni_icc_set_bw(&mas->se);
-	if (ret)
-		return ret;
-
 	ret = spi_geni_init(mas);
 	if (ret)
 		return ret;
-- 
2.34.1


