Return-Path: <linux-spi+bounces-6000-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28669EC3E6
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 05:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93A21612EE
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 04:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893A1A0BC9;
	Wed, 11 Dec 2024 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UEQ4SN63"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DE22451C0;
	Wed, 11 Dec 2024 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733890384; cv=none; b=YpIVGHXZYhJsRL/HUU8t6xti+HlhY+UoalBYJXM0NMuRi8/XK++HTsCTzccGMeISqSD0TI9MiWJw8JLLz/b7roSvx9QGgbfGZYhuvp0PmjamCiFkEfpmrV4t4IBzWVXiArJixvRLrgFernfckK5Mi/VBW4JpfVoP+X5Aw/lks00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733890384; c=relaxed/simple;
	bh=E2F3b1bQJkzdomVIs5BF/wCw/gPcD0biRlPDlHZopJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tdIqWw1/4fzjXd6Vy/g1Al53Rnu3oNkmM09tpSQ9MERPb0mbOvD6KrN4+R6nOhCzu+JsSXTBjS7AmsuLWhs2zfGAQ4IxQ3ZC48Tozh45pW0T18doqIFBip6peSOjX51oOQCt2e3E+Was07Er1ChMMlxOSwbzRZsaIdwcrRVNqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UEQ4SN63; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB1fJCB014853;
	Wed, 11 Dec 2024 04:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VTpfjSUW2xCgCg4eQchraixMNAcSxEXEtSGNOTf6gD0=; b=UEQ4SN63Ra89HNob
	U/ivYuG2ulugKRfSr1/8tZLMQIn80Yl6PY0lzVfMWmyNqSQOqopJea0njQkXcbhP
	j+ZbC+p7gIKG81xZn5w5BjwkJBEgVKftP532JDCU0eNIL2MYtCp1JQvNMGvWFMFs
	MyCvnaC5mGYzbBRwJY+owX6VYZOJc+9qBJMK8wHiGxonCfcMS8dIpiLXjREBWPGq
	t4jOtY9p5MP4uuZ4lY7fwXoRkYGPFGqCIhyGRRn/CYcmKrWlmzJ0kjkesaijHB1X
	1ZzMpWLaxF/+QAm2FOuaoKvmEix4FXNgwtgQ46knKc21Z3NC7YdrxWyt11hrFM5H
	pFAOIw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ee3nbq41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 04:12:43 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BB4Cgch008458
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 04:12:43 GMT
Received: from [10.50.34.16] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Dec
 2024 20:12:41 -0800
Message-ID: <fc015f10-9780-4e2a-9dcf-de7e4b253be2@quicinc.com>
Date: Wed, 11 Dec 2024 09:42:33 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] spi: Unify and simplify fwnode related checks
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown
	<broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241208195635.1271656-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20241208195635.1271656-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0doB6mXiz3dB1c952m0FRPTHlAw6xiDu
X-Proofpoint-ORIG-GUID: 0doB6mXiz3dB1c952m0FRPTHlAw6xiDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=647 lowpriorityscore=0 adultscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110029



On 12/8/2024 9:33 PM, Andy Shevchenko wrote:
> couple of cleanups on top of recently added change.
please add what exactly cleanups done ? Recently added change is not 
that something someone would check as part of this patch.
Description would be helpful.


