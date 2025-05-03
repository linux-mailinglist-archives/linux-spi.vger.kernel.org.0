Return-Path: <linux-spi+bounces-7872-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA0AA806B
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E99517EB98
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334461EB1AE;
	Sat,  3 May 2025 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gAFPu/kV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38EF1DED42
	for <linux-spi@vger.kernel.org>; Sat,  3 May 2025 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746271247; cv=none; b=qqzr2xFXqzXGnveV+cUMcywLhB4BkK+bD0MuF+vQirfsEOSdXO74A/dCRtbMfh3nO4K6MAHV3E/n17k4fupXuO90CJ21rwUQT2nFoCFCFZ91V/0oo+YQm+BzTlcoiKA7vCHvVGocMUls60fhylkwE7ewedtPr9sl2zXKh516WI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746271247; c=relaxed/simple;
	bh=ZZwm4+3kqdZaoUrJVAZp3I6AuMg2MOE7m9ADXt1bIrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhGSiGavA11SMG3aIB205ivl9/mO3BwkC/4pdIpGASNBSe0+ngUxugYaQZNz76PnPccLgq1OYBzIFzunWRaaZlbfIa1O1v7dNLZYAQF1DngdFvYlBU5QnpA4B/8OESBHmgh+QzrCRYBHUiI90qa3ottYSKHSkzHQWXCdo3uCmv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gAFPu/kV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5435GK0g015491
	for <linux-spi@vger.kernel.org>; Sat, 3 May 2025 11:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZZwm4+3kqdZaoUrJVAZp3I6AuMg2MOE7m9ADXt1bIrY=; b=gAFPu/kVSF7z2zpw
	JsmfR/Fl+CYVrdezpvlE9Fu9Thwz3L0nnxqf/tRBEO/Ponq0O360EE6/9Eyn2msj
	aN5xZI/IJvtfIQKnoT9wC++Yqfxw6cbxJ8EIqvKRLZhA3OmQFtOIqUDx3POo2wHO
	5SRfa6/5SeaagKEdvoKuOpBK3MVqirzm4OA6waCPv6MOnRz+xM9jBzGr/Xd8LvTT
	BTfNHC/Fmxm0sNv4L9QIcovlumy6c3UbVcNy0/0Pa4yd02Ol5XV3o9SHOzyU0xnV
	tXDGEPFAYJfPtV3jIOUp/cJrx/ikbgPWrmIy10uFoO3TSiHDr0D7s7qwquKrsUpW
	Jlf3gw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbh78geb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 03 May 2025 11:20:44 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8f3c21043so6750426d6.1
        for <linux-spi@vger.kernel.org>; Sat, 03 May 2025 04:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746271244; x=1746876044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZwm4+3kqdZaoUrJVAZp3I6AuMg2MOE7m9ADXt1bIrY=;
        b=f0iVSA/8fEAXEC8SahPIEiwOskMFVKvdCRDAKtohic3GIWxke4T/mU2FtYlolgALIj
         u9J0gTxiSD2uRCFIpIiw3Ij+NNrrNAJUUu/0GDAeqTliNOWestkIFwZA/L/AOhB/vSXB
         P2tM/orpLqy/fwvUa3AxIZkFi4BzX1BOfra/DkxZhzy+j6RbaNPGGql7e0iseRlRdCWk
         iGP8WWpn76q3RvPBaOWGhjeJY4xIDS7tDq4ZE41+Gwz/9FlRKMBi45b/y5l+3Vdmtyg6
         Wma5/5J++lmpOmVv3t0K3eyi+y2Exo77XLTKpvaCBWsp/ycA+1+rt6hz3GpiCDW2caU1
         k2kw==
X-Forwarded-Encrypted: i=1; AJvYcCVwJdU3reu0ijXMZaQgYmoIsF0Y2IZDb18VWBmABe3ma8lJW4m6hdw9Aap44IwpRDPhMoM8LyvGohQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWf05jX05bRNuUPdvFc6kKGRBoje+dXv9IJuose1Z7BDsLJThQ
	xMSS7o+Bnepq9U5/Z4lxFmRixyGTgmxElLuC2mNWnEzu/woSvg1ozAy+sisF+Sr/MA7t+8XqA/8
	wSySrF06niZBQzn1qAbQ0usktAD8s3Gdcp1ia23PS0TPcWJY5afa7mrqysHE=
X-Gm-Gg: ASbGncvqMwzB2zSSkZLP8Ei2fHYaeqfHE9ensKDRTgSTDGN/Najrt8+tuvTJCc7RPeO
	KFHgU5Xkzd6GcGi9SJHJM3Our7YfZj/MGSM2euO9Rs87AEazKx3zePpMnrHMh0+rPICuO32r9a2
	6smUez23L5BJoG9kz07rUf9OmfapjlpN3bmPnRSrs9YtFpqx8UkEsKuHkaOm2z40LDo1gc57Wbb
	skvJDEF5v9H7d/DojtI2OLWrSU+S5et5sVXn7IrSGxJjuZpqfpCM2Igf5XY1RhSlUD8zzG8ugGw
	gay3ZVgoTRPWwQt1AHkNgShg0UdJ5SH1onmKN7U+Uh2EHi0+Yb95VS6Izfymm807WVE=
X-Received: by 2002:a05:620a:190f:b0:7c5:687f:d79d with SMTP id af79cd13be357-7cad5b4a71cmr328840485a.8.1746271243642;
        Sat, 03 May 2025 04:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPb7K6LSDWBZT1Dho5YFFLrfHITP13o2fAlVZXPwohh1JHtEdiAWbk/ZWvd2Xrvglqu4P/0g==
X-Received: by 2002:a05:620a:190f:b0:7c5:687f:d79d with SMTP id af79cd13be357-7cad5b4a71cmr328839085a.8.1746271243159;
        Sat, 03 May 2025 04:20:43 -0700 (PDT)
Received: from [192.168.65.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189540d6esm179999466b.185.2025.05.03.04.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 May 2025 04:20:42 -0700 (PDT)
Message-ID: <64268903-fec1-4418-95ac-665738435366@oss.qualcomm.com>
Date: Sat, 3 May 2025 13:20:39 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Add support to load QUP SE firmware from
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or,
        andersson@kernel.org, konradybcio@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
References: <20250503111029.3583807-1-quic_vdadhani@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250503111029.3583807-1-quic_vdadhani@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fMY53Yae c=1 sm=1 tr=0 ts=6815fc0c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EGseXkZT_eIdJ_7nNB0A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: _ApoDuR85cIkzoJ_JAcYwz4J7m5vIFkw
X-Proofpoint-ORIG-GUID: _ApoDuR85cIkzoJ_JAcYwz4J7m5vIFkw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAzMDEwMSBTYWx0ZWRfX8O5+KW+47OcK
 O7T64sO96f7GdktEeh3kEwoj6VagIw781EsjwpDsMzQ4mNcyXldFcCn8C7OnvoJo76xno5WXqmM
 3vbv3DBetQVgx6UDeWKIEUGhpbxdHCk3PPvh4swP5qlbwUybmtJctFTpvlmjrspXgQQaGywF5c0
 NOR2+9FLjKbTT3PKeCgRg29h8deBSc0ZxfBuZoy14V5RksB1sa4E/pPM4WORFZUsvXUBPtg3Jci
 wI4OzhB5kBbdXfiBpKwgq7sKs24CjyAVW8kKuYmoUpIIdwcxUS9xKq2KF4aPWngyUFdx7jPHS8q
 3FNbXbmjbgydP5OqTYTtC7OEsGGBZd1qdhv/BnooWITc+5wn0oh7DhbjIYtBVNRt3GoVVaQRHx/
 RhKlc3ugfS+dwMe99FXMokiGXfa5MYWW3qymr9FFjjGu8k3goSX9My+WBVFhJcF0dIk8Hgsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-03_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505030101

On 5/3/25 1:10 PM, Viken Dadhaniya wrote:

You sent this series at 1:10 PM and replied to review comments on the
previous revision at 1:11 PM - please refrain from doing that, as
you're effectively stalling your submission because of lingering
unsolved problems that ultimately still need to be solved before
the patches are merged.

Konrad

