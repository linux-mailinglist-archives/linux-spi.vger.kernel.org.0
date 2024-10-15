Return-Path: <linux-spi+bounces-5236-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0391799F28D
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 18:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956AAB20F0E
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 16:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33781714BE;
	Tue, 15 Oct 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f3hqesS/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25634158DD8;
	Tue, 15 Oct 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009173; cv=none; b=AfyebSCbzLwJ9k7foTVxnL0tFkidtJ93L+GUyO/JO0jQ12NVxzL1AtczIvZY28HNcKDkFkJ7OEae4fiuKP336dJ6MmbnFmcWvu3qn0a+8qnynl3mwHp8WtRtHxNL3fjAzf1XlMVdzx6jLdLRecygj/3KLoPtcA6ohne+Dc4+J2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009173; c=relaxed/simple;
	bh=zmA/00I/rJT/tqnmzKp6XjapkqZfWbScm/Yeourf5vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C6mOgUTgvyvCC5SjvrzSQMg6gzNBPPNF60UNZXOnEkAlukb+kzwy5S+u/gKBhxxWwTnrn5XFI4+sUMYlJrWbb2bdN6ZHkg1MPoeJV37O74zEpPzIkEw3QX1egL9bg2pz2h7FG8uHDL2Lk145N58XsrCLbxLPJ/IU+yk/pl8WOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f3hqesS/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F9qV3l027796;
	Tue, 15 Oct 2024 16:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r+FlGNemb68zVPoS1oWfgoA7NXvv0pIJi/EsE9mxPOI=; b=f3hqesS/1jiW0k2a
	MCQ4x0nu7Fx7w15w7SBwqf8PnpvQWIUe+IqSsyTpCwVvyKZS0/nkwCDtJ0LsZz3J
	KgLDgWP94jSZAqjlqHq30gw49hqhBKlpzvZb7z283emY5rOdZ7nAWVudU2P2h5Qh
	7N0PP7qpFZ56N+3qwLPBfYamIN/Ru56Q1mg91h9J+RRMN3oNy7kKXk9C/PNKLKki
	uUwB+VPdttT33x5REQ0Ek4J3Th8Il5aqbIAgZHI2jSH43KDXL1Jm8NU0GPPSTQOs
	bmgUNB8hS4Gt6NQ2CV37ybqRPILVnbLd+t6+EskiuTtlSt52R0bVD3qZaP616j69
	Dma9hA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427jd904tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 16:18:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FGIkRa005017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 16:18:46 GMT
Received: from [10.216.57.188] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 15 Oct
 2024 09:18:38 -0700
Message-ID: <382e2d4d-3bf8-d88b-29c1-37c1446a0843@quicinc.com>
Date: Tue, 15 Oct 2024 21:48:21 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v11 4/8] mtd: nand: Add qpic_common API file
To: Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel test robot
	<lkp@intel.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <arnd@arndb.de>,
        <esben@geanix.com>, <nikita.shubin@maquefel.me>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <oe-kbuild-all@lists.linux.dev>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241010070510.1504250-5-quic_mdalam@quicinc.com>
 <202410130129.M8J7VJoG-lkp@intel.com> <20241015172955.7b0b6708@xps-13>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20241015172955.7b0b6708@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8z6kBnp7XghZECOsLn3_bo8kKUAu8CXp
X-Proofpoint-ORIG-GUID: 8z6kBnp7XghZECOsLn3_bo8kKUAu8CXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=857 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150111



On 10/15/2024 8:59 PM, Miquel Raynal wrote:
> Hi,
> 
> lkp@intel.com wrote on Sun, 13 Oct 2024 01:57:12 +0800:
> 
>> Hi Md,
>>
>> kernel test robot noticed the following build errors:
> 
> The below errors seem like basic Kconfig misconfiguration. To be clear,
> I usually don't review series getting kernel test robot failures and I
> am expecting that you will fix these errors and post an updated version.
Sure Will fix this, and post next revision.
> 
> Thanks,
> Miquèl
> 

