Return-Path: <linux-spi+bounces-12312-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C7D14D7C
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 20:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E22B3031A05
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 19:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC88311C1B;
	Mon, 12 Jan 2026 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQl7DYCF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XucoZU2x"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041D30E825
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244506; cv=none; b=I5n/xDXMiPjd7XLl9W0rsLJmA6ENgPNZ+UsjWjMfD6NdPgkO+xeULSrHQSlHrUM2U9HxzeqVbNzXhb+sDrN5/NnIxzBC4w8/pKBJDEJvgV35xQDAd1/PRoExkLAA+GfaYrdiMTWWLqrkrK812ZoufW9yNy4GXWW4jqn4OonVQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244506; c=relaxed/simple;
	bh=z4eQr0eex10z9x3L22NaYdnJLofS5JqgIZan2urwgdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=diUOVUUtveq0E/Vm6e+Se/mqblRVa5jQvquI1Ys6R2sOz4RU/sdcIsZHj2LFbaS+FZkB0uI6TYtyAUjC90KZFiHoQ7F+U673DLuHGov43qK7+upWR5H9lYikPjdULHlN8Djvqi0wwpRXbwWQuoYGYgkEPkJyESAVI3Y7cz1Gizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQl7DYCF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XucoZU2x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CIaG631358242
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ub4EZpexSoQ29tSqpuI17Y5hs92pf2Di8Ce
	kObKFRw4=; b=TQl7DYCFoMBK4RgorI0H7fx+UMD3irgOM55hLFx0xX/H/DsCfPX
	74vrHrwiR39hGhwnXGONCTpKa+lvCe3d55b3iwwIyYNG915mZGxJsnfqGzjnI2BY
	Ln/1Tm2KQlQl/8YeC7fTnFl+reSI5FiRkB0fmIK2hyaLDpYf6rShpWszZLdImcHC
	1a/Ezy1e4a+aB/3Gp+z/cX56/rPkT5w3VnqcPlkpfPtIue7XfyCt3Wyqs/viT3pj
	iI/qfpC7emNVsUD7PlUByfPDAuZv6+HxO+Dyibk30XycEAFCWMf1arpFvXLvLnVF
	U88BSKzSUO1q9RhRVJX5t5Lf1q6xlawBKWQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6cng30b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 19:01:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a089575ab3so71816435ad.0
        for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 11:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768244503; x=1768849303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ub4EZpexSoQ29tSqpuI17Y5hs92pf2Di8CekObKFRw4=;
        b=XucoZU2xgA9l6h+B0GwyJiogftjxFOfp4eZrrt9ZWm1QpVu3Q4HbhrRmkq9sf6vhRl
         zgXls1i5cDFAWugYwry9wmuUOzX7YN3YDyxTwQDbqvoPZPtUg/vR4J8k7sC4Yv/xg63i
         6NEA/7PKcfAb0V3dsUOPeczeMJXsseqngeRop0tp5UInu8QmsVv7EmDS7f1BhX7Vvc4R
         O4XR4Hzz++KBtWNIfGC4rnVNgrhLry0SeVAFzcL6rEbt9rNxWUysxInxQZcD9NoOz2vg
         v3hyFwdLSraUEvbd1yhHkjA43yqIHPY/pcYm7z/Mjf+oixAxl5cg3QZmtt0oEYcqNICB
         PRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768244503; x=1768849303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub4EZpexSoQ29tSqpuI17Y5hs92pf2Di8CekObKFRw4=;
        b=gnIxvEvXnaWvLU1xu4nYfZ6HiAuCWyZUbf1bP8oV6/JDxOynHu2etczQFfD+Ahv/uo
         wLd7ls+HMB2pwDixkqh0PdDbkhsK3HI3ZrA+QrNW9v7RWt9IKlwARlA7oFTMvI4tHdX7
         QzQLmjimWZbJL9elHuU4Vd1HFrVtOklRQOn0C5VdefMr/FPS8w06lL1Kux9OlFMRrMBP
         RwLqroe6xjlzpwqdfbpQToQcj427xJSmKEzNjX3Q8/BWu7PprxTDQyQrciAxnQNBuS5W
         LXEss6f8kR5xo5DExerw9+r2LPU8xlSrY20Hyo5Yo5jIo7OBNhRQD9fb/rO5nSWvBAx/
         s8rg==
X-Forwarded-Encrypted: i=1; AJvYcCXaY7CKnC3C+Y7AqhWWuvDvWpYAN8p1XS1b1835/VmBdV4zpcqJDuSca3tNfGfoWYDpeHOVcG1Brgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2t6cFKwH5rMZyDZutj1m3FnsYT6rQP9eyKjEVmM1q3tJXKcR
	UcA9/NO5YosGwVChX/hzfyFJEYZn9gzg9a2YHypkMq3glP9oLEBGJV554qHuYgpg7ARGpY3MzeC
	4CZl8/R6yUYZKVy/oTqFYOVAqU8UR0V68cpSFnIusntwjL8kJStepLPaFs+BU3TA=
X-Gm-Gg: AY/fxX5gontclvsVEnUgxCVKuGg9uacbctyBZ5Yyv+DnKrs3I3ql9/Uls5zByE2n5DQ
	6ISPrM7JZIfmFn/ojtYtgBd6VlGcXOJPFDWDd0pmIyZTavZopYFuQ6LfkTeVg+rj5P+umvSCcwx
	z0QBchjiB4z0toCtJOMhqpemAvGBXxJc1UYEgxTD7Lnu9KOGGDOVSOGjeNWSCnMoFyMZth5gbIZ
	nAZpjoTJuYWV6QIImLRuD76qxg0cw7rsGzw/my5ZTSVsIUlI3Q9VQa/SXeOArRqFumiRzsgjDdB
	ZPdPao8hTc5YjbeebE9817qS0Xt5N7ne4NABOiAMpW1Wcuy8jZ6OhJ5kzF/Xc3ews43pORwnyI1
	GqauLN30y0lCNwaWmopY7yJJ0IV1lQLQwaZoyb7nhFP8=
X-Received: by 2002:a17:902:d4cc:b0:29e:9387:f2b9 with SMTP id d9443c01a7336-2a3ee45d592mr140344525ad.24.1768244503100;
        Mon, 12 Jan 2026 11:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0tB7SChKljt23is7ptX0+WmSMRFSk9n+Hiq1vowGI0jbs+xhng5CJUxAD6UGqr31W3CTyjw==
X-Received: by 2002:a17:902:d4cc:b0:29e:9387:f2b9 with SMTP id d9443c01a7336-2a3ee45d592mr140344305ad.24.1768244502438;
        Mon, 12 Jan 2026 11:01:42 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8888sm180120595ad.76.2026.01.12.11.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:01:41 -0800 (PST)
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
Subject: [PATCH v1 0/4] Enable SPI on SA8255p Qualcomm platforms
Date: Tue, 13 Jan 2026 00:31:30 +0530
Message-Id: <20260112190134.1526646-1-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SkFxm2WCKbTZFMa_KOLCe2pd-Yqey1Ug
X-Authority-Analysis: v=2.4 cv=KK5XzVFo c=1 sm=1 tr=0 ts=69654518 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NeO65QaY_C3oiTlxhukA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: SkFxm2WCKbTZFMa_KOLCe2pd-Yqey1Ug
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE1NyBTYWx0ZWRfX3h1BEHjb6mL/
 o3L9OPN1KMlpOiF+V2r/uP/aZdmDvPhwoI3ob1rUo8MAZ5Qk2LHX72Km+8tdaHNLETyxmeLuNKF
 ZpvXEN910811zW3gbaCzui/hg/Ff2Xli2q2xsAXdLluS0U6DkVb08PKxPEAsCShcm5vPH5iVoti
 bvmOvM6uzG+GoFSFxP5d6umFsgQuiF7l7Zmyo+UBO+jdp8E4gbM3gngncbqgC6tLPQ+ql3SiyyC
 /FmH1F23DjfqhssrKPSAx9wFs8dM0r73hTHGFVN4QtymqlI442eEZas6rZt82I38N1A7Oqbv+4t
 gEdExTo/PvXK1DGRwmyOYVwcJBQa1GI0Uu/bskFB6WinK2yoSfiiV/yeBH9z2xV8TEzlxG8Ykos
 gCF+QcKxW2uVwKVxaukH2kUqB+SsPxcNs7k73FuPHfYBoL4hdupRSKf/8i0Z7myAJHrfAcN1W6P
 T+f/+pVXHPc5OuCbiWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120157

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

Dependencies:
This series depends on Enable I2C on SA8255p Qualcomm platforms
https://lore.kernel.org/all/20260112104722.591521-1-praveen.talari@oss.qualcomm.com/

Praveen Talari (4):
  spi: dt-bindings: describe SA8255p
  spi: qcom-geni: Use geni_se_resources_init() for resource
    initialization
  spi: qcom-geni: Use resources helper APIs in runtime PM functions
  spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms

 .../bindings/spi/qcom,sa8255p-geni-spi.yaml   | 63 ++++++++++++++
 drivers/spi/spi-geni-qcom.c                   | 83 ++++++++-----------
 2 files changed, 97 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml


base-commit: f417b7ffcbef7d76b0d8860518f50dae0e7e5eda
prerequisite-patch-id: 59caabe7cb91dd1cc983bcddb945a9f937f27700
prerequisite-patch-id: 8d9eae225d0a898c5543915583d181dabf22fc5e
prerequisite-patch-id: e2ce71b831c2f22b3945ba4faa9f5387857aafd6
prerequisite-patch-id: 4b4e8774d462676e04c9e14c30720ae559c90643
prerequisite-patch-id: eebfa4f5ef4f3eeef82c946f365e0500f3818125
prerequisite-patch-id: 9d5f48bd6188ace78aa1069c95899f23af2d9072
prerequisite-patch-id: ec7f320c0999d7ca947f7d3a86c4e6ecbc6694ba
prerequisite-patch-id: 59bfd0cd9f7a55a75ffd828bb8f9be94d4074e4f
prerequisite-patch-id: 24266f569d58bb78615ff4207c1c210e265912ed
prerequisite-patch-id: 4dbf9643a0e17e1c93caacec9d6ba170fcce45ed
prerequisite-patch-id: 74a1c1f32213a6e9de05765d721637d58f5baad8
prerequisite-patch-id: ef061474c4b96374ed3c935a440a8d0da830a972
-- 
2.34.1


