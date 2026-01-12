Return-Path: <linux-spi+bounces-12316-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2ED14DAF
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 20:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE8A302D934
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCBA310779;
	Mon, 12 Jan 2026 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PhE4Sh/D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ASt8PtGy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FC61EEE6
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244531; cv=none; b=lNBEn9WOlvvq5wBzKQF8exrS1h+9fC0dL+eTqklYSwepYs9XUk5cEiW56HLJ8EGj5LmF+fdi5Ak+hO1+rteFvsuSbce9T/V1pAfEJSfOA7j+CGAEWej2jGHYVEcf7qRB6L335teqISjaUZbvXp3f/o0wBCp88wvn52e9a6l8Zec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244531; c=relaxed/simple;
	bh=HpbGoIkogcwd0iG8wVIE+MiE0a9C6PkDaVHj1ewp1zI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o35nmWT9Qfvgzy4CUq5lJWbAzPWancZUDviCNh5a2VXzNcWpKCIQId3KEAAJ6vWNcVoOVrM6cwN5zPrvLXAZ8rJhu9hRNto2N0F6sxUJldQZ7bqkP9msmbAFd/yhFuR9ghVlvcMo0/3RNywxDHY/O0ocwdEOAtPX49tA7Xe6yYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PhE4Sh/D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ASt8PtGy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CHfJik1912221
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yGZZacre1U/
	suA2bX1Vl5nmbutXoroFn5RuNDNr3mUY=; b=PhE4Sh/D/411rYJvRxIAcdqYT5N
	QTqFdmbhldjmWjaeJ/PYrAq2TeSZNRoH+z1btWAoHFA+dVunYeJXCRPy4yrSrac8
	b3JV4q6BO2CKjlVAeKsmwSPXgnlTFJAVjup5XDtiJpOtZkKKARi8Ugip2ym4dmiD
	MzLbTzcHFcAs9KM9a2VppDVQC1Kc4yYJhFmvf7t91KVz3gQ4Idov/Y36+MdEu4WZ
	bf6rBSnMAba77YJI29NYqi4Jothca/4rAFAFABlVdRrG6kV0iYxLETvsniAZ/MxF
	cUW70Dx+JKdIReQ+DPiaxpCqo3xlntmE2yfhK3bKRjQFnyYFULttqC+JhZQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bmvhw26cg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:02:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a377e15716so145318635ad.3
        for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768244527; x=1768849327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGZZacre1U/suA2bX1Vl5nmbutXoroFn5RuNDNr3mUY=;
        b=ASt8PtGyWZp1d9gAn1+iqbdodNGYztKsOg35AArZaorpwudsPrH/Z5F8zmKTsslYt3
         PVrRTMxVc5FCzg3gU2U/NR34qaKsLAT2RZYYSBbcByUTrigmWKGToJHZjTySna8yGkXa
         3AXtM9fskMH3NBtY7t+oZpP5y/Rx4F1C+OwKAEB1qxnwsNGp3CZb5peiSCeVe2tJHgpZ
         iGXyyvy1D8wHv954PElwIKgIBoXsIUD5MWwfLRks7jB/hKs4HY1F94ORn5h0uE3zuDpz
         emxBqiE4u7eQ4NByE2ppusjPV6aZtG3exLRboTLa8DZe1X0XALNt5bbE0FqUs3qqIWcb
         VCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768244527; x=1768849327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yGZZacre1U/suA2bX1Vl5nmbutXoroFn5RuNDNr3mUY=;
        b=l7lWjnM6LxNrB0ppwyb33VBEhY6ZOSwzin2rSQ2LBLyCW1+xbsbRVH3sN34feX1VHN
         9lg6cWN9iTKto6pZ5ClI7QBfJ415XHU/hTFVahaTrQAWR2GrminZ1r9VTkD3sQX+QXe3
         2v/ujzVGcNueLxuhkoOOsT0XmdlSummydqY+VSS4M+VSjh2nI17lLWeb/j1GruE5WseD
         i20UznosGZqeDcejCOXnNe1kIJTE6DG1VjBUFlGS3TgceYXMBh5fH4X5527c78CJE4My
         1cy1nuzjwWcHVXI4IqETi9Gg9RDaNNU0AVLllpjOLBNKad/c+5v2cQapEY+EUebVLYeZ
         JxXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyFs5SnpGgTWEP7RYfZo1F3gduyMOxzV15Phiq5kXiyf25cF/Ww3KlSULBKgViRGuhaayksc/VLI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4WGvjhJI886jqz9+XgUcBEekSfSmMoQqRdts60Wqll5Tw28D
	1Pe1gZEozt+JF/3+1aqPg8C+DsG8kAMe6T0W3/gFceEhL240SGdsSteKGDyvhYCwGILKQTtK9sm
	HR9JqJk2jOKC3raNGpX3xCtFE9wCfx/CXB+hU0Z6bgcAOCqaKhtKkWy8D1KAy0QE=
X-Gm-Gg: AY/fxX6gI8heavXe4T1rByyBXffbot4VnVB82y9li+lKyIVAe5v/eAqKYwcVUDfS32F
	UBPZRkU2MOf15ZV7LsWELKPub9ngi2y6sf4JNT1etJdPBwdR0Cxmns7Uh4htMV0EfEi157IhMKB
	qUfmte78R2AIbGWW6mmIBZM8EnmAaodacSF5NgzZhSJTyO9Ig/V3Z5+y0h2kH1w6UJq6DQVaqHF
	LJ8H8FzSEbMBKPfMpjEWLD6hXE3tC8kjnPOV2Y9PaMuqtQu6+TFF2EvytkmStxOYUZzLdpCVBNY
	+ydDhFjKoRHJEQszZgFRpC79NyFG0u8kWKOSbv0txZc8kcxnRoA0FBMRqvwh//0rBGfuWw2M62U
	JV/kRKxbbyzyuTGjSnuWNVdECyKgUZ0sf0cD6Bt6BTEQ=
X-Received: by 2002:a17:903:1212:b0:2a0:d7f6:e030 with SMTP id d9443c01a7336-2a3ee491f16mr180468715ad.29.1768244527201;
        Mon, 12 Jan 2026 11:02:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmiDNFtkSX+gdc8APgOAohwdzPlMrNsXNHoZaQFIeeIjQE6AU64CBhIdfiGbE6LeXLymnlCw==
X-Received: by 2002:a17:903:1212:b0:2a0:d7f6:e030 with SMTP id d9443c01a7336-2a3ee491f16mr180468295ad.29.1768244526553;
        Mon, 12 Jan 2026 11:02:06 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8888sm180120595ad.76.2026.01.12.11.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:02:06 -0800 (PST)
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
Subject: [PATCH v1 4/4] spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms
Date: Tue, 13 Jan 2026 00:31:34 +0530
Message-Id: <20260112190134.1526646-5-praveen.talari@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE1NyBTYWx0ZWRfX52/95rUKVY20
 rgGtXW6y5nQRTW3FpmTYx7v1YHVYrwZWCYfX7BFvyL48TxCE5uNSPq+SieCw0jwzicsTdp4TN5G
 VYkJuO7eUMyPwnzPCvQ2hxbgxGtFedpXqM1J5EaNM6v3IDalISxboh7HWaWZXwjUx6djh1K0Qk6
 dqPtTrjP2dS0XD2GwAZOpAK9yOBWKTxTZm4z2LFngswC9Qi5Azn/J4f9kAPHMlV1dCj2Tk9rOcg
 JDEhdcIc1NfSE1Qo+Q/HlBTos6DeoxOP74fkxlfsRI7TinXZ7KfqMASzIkmX5wRLJsPRVTKuho0
 9hEGLAoLcvR62wePSjAZvU3DzFcAhYoIrSNDlNJcinZvqM6uSwIQrbY8z6PSJB1zMzkTw+nJQFJ
 mMw78PPKwY80CfomUdn35h3cGbWH2swx13xTbyx2CdSWzGatrhnccnTZ1pa89qV3+jeLc/xVu8w
 cuWMC0kMxmadYaXD9CA==
X-Authority-Analysis: v=2.4 cv=JP02csKb c=1 sm=1 tr=0 ts=69654530 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=pXSUDizEog3tsSCmG3cA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: SpZNmseIhqzEvgZq2aBxrNmhe-9yGGsR
X-Proofpoint-ORIG-GUID: SpZNmseIhqzEvgZq2aBxrNmhe-9yGGsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120157

The Qualcomm automotive SA8255p SoC relies on firmware to configure
platform resources, including clocks, interconnects and TLMM.
The driver requests resources operations over SCMI using power
and performance protocols.

The SCMI power protocol enables or disables resources like clocks,
interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
such as resume/suspend, to control power states(on/off).

The SCMI performance protocol manages SPI frequency, with each
frequency rate represented by a performance level. The driver uses
geni_se_set_perf_opp() API to request the desired frequency rate.

As part of geni_se_set_perf_opp(), the OPP for the requested frequency
is obtained using dev_pm_opp_find_freq_floor() and the performance
level is set using dev_pm_opp_set_opp().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 42 ++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index bf2b3d88693c..b1b41218f452 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -75,6 +75,13 @@
 #define GSI_CPHA		BIT(4)
 #define GSI_CPOL		BIT(5)
 
+struct geni_spi_desc {
+	int (*resources_init)(struct geni_se *se);
+	int (*set_rate)(struct geni_se *se, unsigned long clk_freq);
+	int (*power_on)(struct geni_se *se);
+	int (*power_off)(struct geni_se *se);
+};
+
 struct spi_geni_master {
 	struct geni_se se;
 	struct device *dev;
@@ -102,6 +109,7 @@ struct spi_geni_master {
 	struct dma_chan *tx;
 	struct dma_chan *rx;
 	int cur_xfer_mode;
+	const struct geni_spi_desc *dev_data;
 };
 
 static void spi_slv_setup(struct spi_geni_master *mas)
@@ -307,11 +315,12 @@ static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
 	writel(word_len, se->base + SE_SPI_WORD_LEN);
 }
 
-static int geni_spi_set_clock_and_bw(struct spi_geni_master *mas,
-					unsigned long clk_hz)
+static int geni_spi_set_clock_and_bw(struct geni_se *se,
+				     unsigned long clk_hz)
 {
+	struct spi_controller *spi = dev_get_drvdata(se->dev);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	u32 clk_sel, m_clk_cfg, idx, div;
-	struct geni_se *se = &mas->se;
 	int ret;
 
 	if (clk_hz == mas->cur_speed_hz)
@@ -816,7 +825,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 	}
 
 	/* Speed and bits per word can be overridden per transfer */
-	ret = geni_spi_set_clock_and_bw(mas, xfer->speed_hz);
+	ret = mas->dev_data->set_rate(&mas->se, xfer->speed_hz);
 	if (ret)
 		return ret;
 
@@ -1040,7 +1049,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 	mas->se.wrapper = dev_get_drvdata(dev->parent);
 	mas->se.base = base;
 
-	ret = geni_se_resources_init(&mas->se);
+	mas->dev_data = device_get_match_data(&pdev->dev);
+
+	ret = mas->dev_data->resources_init(&mas->se);
 	if (ret)
 		return ret;
 
@@ -1097,7 +1108,8 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
-	return geni_se_resources_deactivate(&mas->se);
+	return mas->dev_data->power_off ?
+	       mas->dev_data->power_off(&mas->se) : 0;
 }
 
 static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
@@ -1105,7 +1117,8 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
-	return geni_se_resources_activate(&mas->se);
+	return mas->dev_data->power_on ?
+	       mas->dev_data->power_on(&mas->se) : 0;
 }
 
 static int __maybe_unused spi_geni_suspend(struct device *dev)
@@ -1146,8 +1159,21 @@ static const struct dev_pm_ops spi_geni_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(spi_geni_suspend, spi_geni_resume)
 };
 
+static const struct geni_spi_desc geni_spi = {
+	.resources_init = geni_se_resources_init,
+	.set_rate = geni_spi_set_clock_and_bw,
+	.power_on = geni_se_resources_activate,
+	.power_off = geni_se_resources_deactivate,
+};
+
+static const struct geni_spi_desc sa8255p_geni_spi = {
+	.resources_init = geni_se_domain_attach,
+	.set_rate = geni_se_set_perf_opp,
+};
+
 static const struct of_device_id spi_geni_dt_match[] = {
-	{ .compatible = "qcom,geni-spi" },
+	{ .compatible = "qcom,geni-spi", .data = &geni_spi },
+	{ .compatible = "qcom,sa8255p-geni-spi", .data = &sa8255p_geni_spi },
 	{}
 };
 MODULE_DEVICE_TABLE(of, spi_geni_dt_match);
-- 
2.34.1


