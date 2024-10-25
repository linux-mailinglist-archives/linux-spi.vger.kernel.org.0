Return-Path: <linux-spi+bounces-5498-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB19B0CEF
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 20:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655B6B21572
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B82218F2F6;
	Fri, 25 Oct 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="erk4/iaR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2941B18DF7E
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880065; cv=none; b=Dt0PAx5lEkpZWFmOvgscm8pWTceYt+um9HwbxBuDPZwZuBtP/ujpt9JgLHpRH6+EmjRsikmLSHsS8Ad6nNODXGWfRWv1toFtLDmC0P2UcjOpHGGLTcAyto+U7ishUEysaWOBE6+hODuiQlFpUZofmYg9IUHPvxJX9oRQ3zfjagI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880065; c=relaxed/simple;
	bh=+D8EOBHbCUHNS8MlsDOj9MvEyvLWhiBdxbjFoUH3pOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nP/kHAH2/0t87f3WxXmwdu1W8NPiGTOs8EMvK2XdoP8sgZWVfLwTONreU9roygHafMKu8pIDWQBdrnVjift24kicS1wgYinoEGpWnmRHJ4i3lE02AmmevCMrd5jZLdX9/w/xtkhjN9vyiT1O70dN+1sq0VFin2bHbFozmJPS1CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=erk4/iaR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCJmIN028685
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 18:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qrmL14AEOznY4BwbvXypNlUpeH4TrifR/CEAuIy6fto=; b=erk4/iaRuHTcy+02
	jGCbVFUGsnmWbbgibLC3TSXMeqNMBukwzEGnpGm7SrwSm2Nn8hVkZnPir3Z3uaYN
	GLTIqEV7rL8C06WcTAQPzqSCopbTjCUE8INWvRt+EtyA46/Z6Mh/1KPhBcjf4ips
	tzKeOV2fIM9og34eoPsvJ+yBpuYcE2bLqJEuf3i4uPhCrqpH1o+u+jIldDeCCk6w
	sQGZpa5c3tJKRJrkJF/nO5fI7pNBAZ7/QkSiKJJiFYqEzMLHQqzR8QE4WcvwAcCO
	FzW7beAUJzunVvfxGGRObKBIrF9XhLnEL25xRnaSQ0jfIwYtJJ6isr+xlBY4P0Xk
	VkIAIA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fdtxnvmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 18:14:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbe40565feso6235986d6.1
        for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 11:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880061; x=1730484861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrmL14AEOznY4BwbvXypNlUpeH4TrifR/CEAuIy6fto=;
        b=s709rrMIesAzJrn8jzSgasFquA33Y1YaErBG2eVK6b3XL1uV+3A6tr16hLEc0fv/Qf
         n5NkL2rIDEQud4NXzXELrdSVuPEJOzV4v3IeSa+CPDX5AW0W5t2QsUnYh9Z8bBmhXcbE
         eZYP1zFH3jq1B3B4LKSs0IUutHZUdnR70OiQzaBeI3Y7dR/Rhw6uCyW34+Si5ZM3Tp25
         3d6g7BztRGP1xlBA1ofEhG2VoHC7KxgCYB3qeFVD/xxQmibxjvuXDhwvDQ2kIQ8MilwX
         A5ohTtvq5r242Z+bFjVQycJrDtG2p0ADaoMjJlTDwsiKNghAnMl6hgI0t6JCDv+jd95b
         weNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+AFaPjSIh8rhbftZxGTQ/gko+iAdZqMsml7dmNiZDIIFvhrGlVA3qQMl/d+srjHywIdh1xN71aps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8IfmBlPSEgDh4kDq1vdjjoMOJvH7kVv4pn3sxmFhEzc/Pfnfc
	l0AD8WaB9N4bBiOmGSoixpRtZw4g2gTtiNSPxmk/5WZSKIGH7K8We4Y+aOuM5yWIUho40jx1z4Q
	QRQdnQe8bJbQSiUTy1Md8bRpbVWsEcAY4mwX4qfetzLhAEgOWBacZG5lsUq4=
X-Received: by 2002:a05:6214:1d0b:b0:6cb:e981:d7dc with SMTP id 6a1803df08f44-6d185862e6emr1909186d6.12.1729880061498;
        Fri, 25 Oct 2024 11:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXzk3TSC3Xw8NDVKHFxS1ilkakzcOocvD+KuNE8wkBN6jCTi7n2E4Li6yt8CN+Jb53ACok5A==
X-Received: by 2002:a05:6214:1d0b:b0:6cb:e981:d7dc with SMTP id 6a1803df08f44-6d185862e6emr1908896d6.12.1729880061187;
        Fri, 25 Oct 2024 11:14:21 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb634737fsm850633a12.82.2024.10.25.11.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:14:20 -0700 (PDT)
Message-ID: <5a98076f-f5ce-4400-b554-6593d51de9f2@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:14:17 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash
 Interface
To: kernel test robot <lkp@intel.com>,
        Md Sadre Alam
 <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
References: <20241021115620.1616617-7-quic_mdalam@quicinc.com>
 <202410252355.ZofaMeku-lkp@intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <202410252355.ZofaMeku-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: APjSoX9Lw4UPh4mpAx0paYYoK8YAfpal
X-Proofpoint-ORIG-GUID: APjSoX9Lw4UPh4mpAx0paYYoK8YAfpal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250139

On 25.10.2024 6:08 PM, kernel test robot wrote:
> Hi Md,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on mtd/nand/next]
> [also build test WARNING on broonie-spi/for-next robh/for-next linus/master v6.12-rc4 next-20241025]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20241021-200849
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
> patch link:    https://lore.kernel.org/r/20241021115620.1616617-7-quic_mdalam%40quicinc.com
> patch subject: [PATCH v12 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
> config: sparc64-randconfig-r073-20241023 (https://download.01.org/0day-ci/archive/20241025/202410252355.ZofaMeku-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 14.1.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410252355.ZofaMeku-lkp@intel.com/
> 
> smatch warnings:
> drivers/spi/spi-qpic-snand.c:1260 qcom_spi_write_page() warn: unsigned 'cmd' is never less than zero.
> drivers/spi/spi-qpic-snand.c:1279 qcom_spi_send_cmdaddr() warn: unsigned 'cmd' is never less than zero.
> 
> vim +/cmd +1260 drivers/spi/spi-qpic-snand.c
> 
>   1252	
>   1253	static int qcom_spi_write_page(struct qcom_nand_controller *snandc,
>   1254				       const struct spi_mem_op *op)
>   1255	{
>   1256		struct qpic_snand_op s_op = {};
>   1257		u32 cmd;
>   1258	
>   1259		cmd = qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
>> 1260		if (cmd < 0)
>   1261			return cmd;

The robot is right, qcom_spi_cmd_mapping() should return an int, as you
return a negative errno upon failure

Konrad

